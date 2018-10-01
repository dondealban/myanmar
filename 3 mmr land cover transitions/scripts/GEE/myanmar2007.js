var myanmar_2007 = ee.FeatureCollection("ft:1TAJ4TRoraZOlJPRfDPpFUTHh7-sBYapt7jmQH950");
// Date range for L5 imagery increased from 1 year to 3 /// 6Mar
// This version includes additional points for oilpalm, rubber, mangrove, ice/snow and builtup
// columns of aspect/elevation/slope removed
// grassland and orchard classes removed because of the lack of groudtruth data (small sample size) and high error in error matrix
// additional barren_ground points & water

/* has oil palm and rubber with only 1 roi each 
var myanmar_2007 = ee.FeatureCollection("ft:1qSEmSjtICfqfp5Uaj8q20kWxDw08SBOhVr-QYbgV");
*/
// var myanmar_2007 = ee.FeatureCollection("ft:15iS6awQk_CALMJrYZpT7xFbF6zBr0SFkxxgPbj4R"); didnt work cos kml code was wrong

/*
 * This script executes an image classification procedure on a 1995 image stack consisting of the following datasets:
 *
 * Landsat-5, comprised of 7 bands and 5 indices (total = 12)
 * JERS-1, comprised of 1 polarisation and 8 GLCM texture measures (total = 9)
 *
 * Note that the Landsat images consist of a cloud-masked 1994-1995 composite. The JERS-1 mosaic tiles were pre-
 * processed using ESA SNAP Toolbox software, which included mosaciking individual tiles into a regional mosaic, speckle
 * filtering, and calculating normalised radar cross-section.
 * 
 * The GLCM texture measures were computed from the HH sigma0 channel of the JERS-1 images (to match with HH channel
 * of PALSAR data. For the single polarisation channel, 8 texture measures were computed using a 3x3 kernel (note:
 * kernel size=1 was used to facilitate computation in Google Earth Engine). The list of texture measures that were
 * computed include:
 *
 * ASM: angular second moment
 * CONTRAST: contrast
 * CORR: correlation
 * DISS: dissimilarity
 * ENT: entropy
 * IDM: inverse difference moment (or homogeneity)
 * SAVG: sum average
 * VAR: variance
 *
 * A total of 21 layers were classified using Random Forest (RF) algorithm with 9 land cover types found in
 * Tanintharyi, Myanmar. Accuracy assessments were done, of which overall accuracy, the error matrix, Kappa statistic,
 * consumer's and producer's accuracies, and F1 score were computed. 
 *
 */

/*******************************
  DEFINE RANDOM SEED
********************************/

var seed = 7;


/*******************************
  DEFINE EXTENT AND VIEW
********************************/

// Set center of map view
Map.setCenter(98.64212,12.40975, 7); // Zoom in and center display to Tanintharyi Region, Myanmar

// Define and display box extents covering Tanintharyi region
var box = ee.Geometry.Rectangle(91.187,29.42, 101.87, 8.15);

// Load a Fusion Table of state boundaries and filter.
//var geometry = ee.FeatureCollection('ft:1tdSwUL7MVpOauSgRzqVTOwdfy17KDbw-1d9omPw')
//    .filter(ee.Filter.eq('Country', 'Myanmar (Burma)'));
/*******************************
  LOAD DATASETS
********************************/
// DEM
var demclip = dem.clip(box);

// LANDSAT


// Load Landsat image assets
var bands2007 = ['B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7'];
var landsat2007 = ee.ImageCollection('LANDSAT/LT05/C01/T1_TOA').filterDate('2006-01-01', '2008-12-30').select(bands2007);
var median2007 = landsat2007.median();
var clip2007 = median2007.clip(box);

// Calculate indices from Landsat bands
var ndvi2007 = clip2007.normalizedDifference(['B4', 'B3']); // Normalised Difference Vegetation Index (NDVI)
var lswi2007 = clip2007.normalizedDifference(['B4', 'B5']); // Land Surface Water Index (LSWI)
var ndti2007 = clip2007.normalizedDifference(['B5', 'B7']); // Normalised Difference Till Index (NDTI)
var stvi2007 = clip2007.expression('((b("B5") - b("B3")) / (b("B5") + b("B3") + 0.1)) * (1.1 - (b("B7") / 2))'); // Soil-Adjusted Total Vegetation Index (SATVI)
var evi2007  = clip2007.expression('2.5 * ((b("B4") - b("B3")) / (b("B4") + 6 * b("B3") - 7.5 * b("B1") + 1))'); // Enhanced Vegetation Index

var landsat2007RGB = clip2007.select(['B3','B2','B1']);
//Map.addLayer(landsat2007RGB, visualization, '2007 L5 True color', true);

// Palsar

// Load Palsar image assets
var hh_2007_18 = ee.Image('users/donwong9918/2007_HH_mosiac_til18_Spk_norm');
var hh_2007_24to30 = ee.Image('users/donwong9918/2007_HH_mosiac_24to30_Spk_norm');
var hh_2007_19to23 = ee.Image('users/donwong9918/2007_HH_mosiac_19to23_Spk_norm');
var hh_2007_shan = ee.Image('users/donwong9918/2007_HH_Shan_21to23_Spk_norm');

var hh2007s = ee.ImageCollection([hh_2007_18, hh_2007_24to30, hh_2007_19to23, hh_2007_shan]).mosaic()
                                      .select([0],['b1']);
                                      
// Rescale floating point to integer
var scaledhh2007 = hh2007s.expression('1000*b("b1")').int32();

// Rename rescaled Sigma0 channels
scaledhh2007 = scaledhh2007.rename('HH');

// Calculate GLCM texture measures
var textureMeasures = ['HH_asm', 'HH_contrast', 'HH_corr', 'HH_var', 'HH_idm', 'HH_savg', 'HH_ent', 'HH_diss'];
var glcm2007 = scaledhh2007.glcmTexture({size: 1, average: true }).select(textureMeasures);  // 3x3 kernel

/*******************************
  CREATE COMPOSITE STACK
********************************/

// Rename band filenames in metadata
ndvi2007 = ndvi2007.rename('NDVI');
lswi2007 = lswi2007.rename('LSWI');
ndti2007 = ndti2007.rename('NDTI');
stvi2007 = stvi2007.rename('SATVI');
evi2007 = evi2007.rename('EVI');
hh2007s = hh2007s.rename('HH');

// Create image collection from images
var stackCombined2007 = clip2007.addBands(ndvi2007).addBands(lswi2007).addBands(ndti2007).addBands(stvi2007).addBands(evi2007)
                                .addBands(hh2007s).addBands(glcm2007).addBands(demclip);
var bandsCombined = ['B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'NDVI', 'LSWI', 'NDTI', 'SATVI', 'EVI',
                     'HH', 'HH_asm', 'HH_contrast', 'HH_corr', 'HH_var', 'HH_idm', 'HH_savg', 'HH_ent', 'HH_diss',
                     'elevation'];

/*******************************
  DEFINE REGIONS OF INTEREST
********************************/
myanmar_2007 = myanmar_2007.randomColumn('random1', seed);

var train = myanmar_2007.filter(ee.Filter.lte('random1', 0.7));
var test  = myanmar_2007.filter(ee.Filter.gt('random1', 0.7));

//Map.addLayer(train, {'color': '000000'}, 'ROI Train', true); 
//Map.addLayer(test,  {'color': 'FF0000'}, 'ROI Test', true); 

// Initialise random column and values for ROI feature collection 
train = train.randomColumn('random', seed);
test  = test.randomColumn('random', seed);

// Create training and testing regions of interest from the image dataset
var trainroiCombined = stackCombined2007.select(bandsCombined).sampleRegions({
	collection: train,
	properties: ['Class', 'random'],
	scale: 30
});

var testroiCombined = stackCombined2007.select(bandsCombined).sampleRegions({
	collection: test,
	properties: ['Class', 'random'],
	scale: 30
});

// Partition the regions of interest into training and testing areas
var trainingCombined = trainroiCombined.filter(ee.Filter.lte('random', 0.7));
var testingCombined = testroiCombined.filter(ee.Filter.lte('random', 0.7));

// Print number of regions of interest for training and testing at the console 
print('Training, Combined, n =', trainingCombined.aggregate_count('.all'));
print('Testing, Combined, n =', testingCombined.aggregate_count('.all'));
/*******************************
  EXECUTE CLASSIFICATION
********************************/

// COMBINED LANDSAT+SAR 

// Classification using Random Forest algorithm
var classifierCombined = ee.Classifier.randomForest(100,0,10,0.5,false,seed).train({
  features: trainingCombined.select(['B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'NDVI', 'LSWI', 'NDTI', 'SATVI', 'EVI',
                                     'HH', 'HH_asm', 'HH_contrast', 'HH_corr', 'HH_var', 'HH_idm', 'HH_savg', 'HH_ent', 'HH_diss', 'elevation',
                                     'Class']),
  classProperty: 'Class', 
  inputProperties: bandsCombined
});

// Classify the validation data
var validationCombined = testingCombined.classify(classifierCombined);

// Calculate accuracy metrics
var emC = validationCombined.errorMatrix('Class', 'classification'); // Error matrix
var oaC = emC.accuracy(); // Overall accuracy
var ksC = emC.kappa(); // Kappa statistic
var uaC = emC.consumersAccuracy().project([1]); // Consumer's accuracy
var paC = emC.producersAccuracy().project([0]); // Producer's accuracy
var f1C = (uaC.multiply(paC).multiply(2.0)).divide(uaC.add(paC)); // F1-statistic

print('Error Matrix, Combined: ', emC);
print('Overall Accuracy, Combined: ', oaC);
print('Kappa Statistic, Combined: ', ksC);
print('User\'s Accuracy (rows), Combined:', uaC);
print('Producer\'s Accuracy (cols), Combined:', paC);
print('F1 Score, Combined: ', f1C);

// Classify the image Random Forest algorithm
var classifiedCombined = stackCombined2007.select(bandsCombined).classify(classifierCombined);

/*******************************
  FILTER CLASSIFICATION
********************************/

// Perform a mode filter on the classified image
var filteredCombined = classifiedCombined.reduceNeighborhood({
  reducer: ee.Reducer.mode(),
  kernel: ee.Kernel.square(2),
});

/*******************************
  DISPLAY RGB COMPOSITES
********************************/

//Map.addLayer(clip2007, {bands: ['B4', 'B3', 'B2'], min: 0, max: 0.3}, 'RGB 2007 Landsat', false);
//Map.addLayer(hh2007s, {min: -25.3076, max: -1.54051}, 'HH 2007 PALSAR', false);

/*******************************
  DISPLAY CLASSIFICATION 
********************************/

// Create a palette for displaying the classified images
var palette = ['b15928', '6a3d9a', '33a02c', 'a6cee3', 'e31a1c', 'ff7f00', 'ffff99','fdbf6f','fb9a99','1f78b4'];
// Display classified image
//Map.addLayer(classifiedCombined, {min: 0, max: 9, palette: palette}, '2007 Classification, Combined', true);

// Display classified mode image
///Map.addLayer(filteredCombined,  {min: 0, max: 9, palette: palette}, '2007 Mode, Combined', false);

// Define classification legend
var colors = ['b15928', '6a3d9a', '33a02c', 'a6cee3', 'e31a1c', 'ff7f00', 'ffff99','fdbf6f','fb9a99','1f78b4'];
var names = ["Barren_Ground",
             "Builtup",
             "Forest",
             "Ice_Snow",
             "Mangrove",
             "OilPalm",
             "RicePaddy",
             "Rubber",
             "Shrubland",
             "Water"];
var legend = ui.Panel({style: {position: 'bottom-left'}});
legend.add(ui.Label({
  value: "Land Cover Classification",
  style: {
    fontWeight: 'bold',
    fontSize: '16px',
    margin: '0 0 9px 0',
    padding: '0px'
  }
}));

// Iterate classification legend entries
var entry;
for (var x = 0; x<10; x++){
  entry = [
    ui.Label({style:{color:colors[x],margin: '0 0 4px 0'}, value: '██'}),
    ui.Label({
      value: names[x],
      style: {
        margin: '0 0 4px 4px'
      }
    })
  ];
  legend.add(ui.Panel(entry, ui.Panel.Layout.Flow('horizontal')));
}

// Display classification legend
Map.add(legend);

Export.table.toDrive(trainroiCombined, 'Table_Myanmar_2007_LP_30m_RF', 'Google Earth Engine');
//Export.table.toDrive(validationCombined, 'Validation_Myanmar_2007_LP_30m_RF', 'Google Earth Engine');


//the right one /////////
Export.image.toDrive({
  image: classifiedCombined.uint8(),
  description: 'Classification_2007_LP_30m_RF_9CL',
  scale: 30,
  region: box,
  maxPixels: 8031230934,
});

Export.image.toDrive({
    image: landsat2007RGB,
    description: 'landsat2007RGB',
    scale: 100,
    region: box,
    maxPixels: 8031230934,
});

Export.image.toDrive({
    image: hh2007s,
    description: 'hh2007s',
    scale: 100,
    region: box,
    maxPixels: 8031230934,
});

Export.table.toDrive({
  collection: myanmar_2007,
  description:'vectorsToDriveExample',
  fileFormat: 'KML'
});

