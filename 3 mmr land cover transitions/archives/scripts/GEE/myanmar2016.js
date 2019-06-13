var myanmar_2016 = ee.FeatureCollection("ft:18ChEel3bP_Uka-UDuw07hBDBSl25jBNyF_cD4L5w");
// This version includes additional points for oilpalm, rubber, mangrove, ice/snow and builtup
// columns of aspect/elevation/slope removed
// grassland and orchard classes removed because of the lack of groudtruth data (small sample size) and high error in error matrix
// additional barren_ground points & water

/* 
 * This script executes an image classification procedure on a 2015 image stack consisting of the following datasets:
 *
 * Landsat-8, comprised of 7 bands and 5 indices (total = 12)
 * ALOS/PALSAR-2, comprised of 1 polarisation and 8 GLCM texture measures (total = 9)
 *
 * Note that the Landsat images consist of a cloud-masked 2015-2016 composite. The PALSAR mosaic tiles were pre-
 * processed using ESA SNAP Toolbox software, which included mosaciking individual tiles into a regional mosaic, speckle
 * filtering, and calculating normalised radar cross-section.
 *
 * The GLCM texture measures were computed from the HH sigma0 channel of the PALSAR images (to match with HH channel
 * of JERS-1 data. For the single polarisation channel, 8 texture measures were computed using a 3x3 kernel (note:
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
 * In addition, indices from the raw dual-polarised PALSAR images were computed including: HH/HV ratio, HV/HH ratio,
 * average, difference, normalised difference index, and NL index.
 *
 * A total of 21 layers were classified using Random Forest (RF) algorithm with 9 land cover types found in
 * Tanintharyi, Myanmar. Accuracy assessments were done, of which overall accuracy, the error matrix, Kappa statistic,
 * consumer's and producer's accuracies, and F1 score were computed. 
 *
 */

/*******************************
  DEFINE RANDOM SEED
********************************/

var seed = 2016;


/*******************************
  DEFINE EXTENT AND VIEW
********************************/

// Set center of map view
Map.setCenter(98.64212,12.40975, 7); // Zoom in and center display to Myanmar

// Define and display box extents covering Myanmar
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
var bands2016 = ['B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'B10'];
var landsat2016 = ee.ImageCollection('LANDSAT/LC08/C01/T1_TOA').filterDate('2015-01-01', '2017-12-30').select(bands2016);

var median2016 = landsat2016.median();
var clip2016 = median2016.clip(box);

// Calculate indices from Landsat bands
var ndvi2016 = clip2016.normalizedDifference(['B5', 'B4']); // Normalised Difference Vegetation Index (NDVI)
var lswi2016 = clip2016.normalizedDifference(['B5', 'B6']); // Land Surface Water Index (LSWI)
var ndti2016 = clip2016.normalizedDifference(['B6', 'B7']); // Normalised Difference Till Index (NDTI)
var stvi2016 = clip2016.expression('((b("B6") - b("B4")) / (b("B6") + b("B4") + 0.1)) * (1.1 - (b("B7") / 2))'); // Soil-Adjusted Total Vegetation Index (SATVI)
var evi2016  = clip2016.expression('2.5 * ((b("B5") - b("B4")) / (b("B5") + 6 * b("B4") - 7.5 * b("B2") + 1))'); // Enhanced Vegetation Index

var landsat2016RGB = clip2016.select(['B4','B3','B2']);
//Map.addLayer(landsat2016RGB, visualization, '2016 L8 True color', true);


// ALOS/PALSAR

// Load PALSAR image assets

var hh_2016_18 = ee.Image('users/donwong9918/2016_HH_mosiac_til18_Spk_norm');
var hh_2016_24to30 = ee.Image('users/donwong9918/2016_HH_mosiac_24to30_Spk_norm');
var hh_2016_19to23 = ee.Image('users/donwong9918/2016_HH_mosiac_19to23_Spk_norm');
var hh_2016_shan = ee.Image('users/donwong9918/2016_HH_Shan_21to23_Spk_norm');

var hh2016s = ee.ImageCollection([hh_2016_18, hh_2016_24to30, hh_2016_19to23, hh_2016_shan]).mosaic()
                                      .select([0],['b1']);


// Rescale floating point to integer
var scaledhh2016 = hh2016s.expression('1000*b("b1")').int32();

// Rename rescaled Sigma0 channels
scaledhh2016 = scaledhh2016.rename('HH');

// Calculate GLCM texture measures
var textureMeasures = ['HH_asm', 'HH_contrast', 'HH_corr', 'HH_var', 'HH_idm', 'HH_savg', 'HH_ent', 'HH_diss'];
var glcm2016 = scaledhh2016.glcmTexture({size: 1, average: true }).select(textureMeasures);  // 3x3 kernel


/*******************************
  CREATE COMPOSITE STACK
********************************/

// Rename band filenames in metadata
ndvi2016 = ndvi2016.rename('NDVI');
lswi2016 = lswi2016.rename('LSWI');
ndti2016 = ndti2016.rename('NDTI');
stvi2016 = stvi2016.rename('SATVI');
evi2016 = evi2016.rename('EVI');
hh2016s = hh2016s.rename('HH');


// Create image collection from images
var stackCombined2016 = clip2016.addBands(ndvi2016).addBands(lswi2016).addBands(ndti2016).addBands(stvi2016).addBands(evi2016)
                                     .addBands(hh2016s).addBands(glcm2016).addBands(demclip);
var bandsCombined = ['B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'B10', 'NDVI', 'LSWI', 'NDTI', 'SATVI', 'EVI',
                     'HH', 'HH_asm', 'HH_contrast', 'HH_corr', 'HH_var', 'HH_idm', 'HH_savg', 'HH_ent', 'HH_diss',
                     'elevation'];


/*******************************
  DEFINE REGIONS OF INTEREST
********************************/
// Initialise random column and values for ROI feature collection 
myanmar_2016 = myanmar_2016.randomColumn('random1', seed);

var train = myanmar_2016.filter(ee.Filter.lte('random1', 0.7));
var test  = myanmar_2016.filter(ee.Filter.gt('random1', 0.7));

//Map.addLayer(train, {'color': '000000'}, 'ROI Train', true); 
//Map.addLayer(test,  {'color': 'FF0000'}, 'ROI Test', true); 

// Initialise random column and values for ROI feature collection 
train = train.randomColumn('random', seed);
test  = test.randomColumn('random', seed);

// Create training and testing regions of interest from the image dataset
// scale represents pixels at 30mx30m level
var trainroiCombined = stackCombined2016.select(bandsCombined).sampleRegions({
	collection: train,
	properties: ['Class', 'random'],
	scale: 30
});

var testroiCombined = stackCombined2016.select(bandsCombined).sampleRegions({
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
  features: trainingCombined.select(['B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'B10', 'NDVI', 'LSWI', 'NDTI', 'SATVI', 'EVI',
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
var classifiedCombined = stackCombined2016.select(bandsCombined).classify(classifierCombined);


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

//Map.addLayer(clip2016, {bands: ['B5', 'B4', 'B3'], min: 0, max: 0.3}, 'RGB 2016 Landsat', false);
//Map.addLayer(hh2016s, {min: [-24.6232], max: [2.6885]}, 'HH 2016 PALSAR', false);

////////////////
///////////////
///////
//////////
/////////
////
///
///


/*******************************
  DISPLAY CLASSIFICATION 
********************************/

// Create a palette for displaying the classified images
var palette = ['b15928', '6a3d9a', '33a02c', 'a6cee3', 'e31a1c', 'ff7f00', 'ffff99','fdbf6f','fb9a99','1f78b4'];

// Display classified image
//Map.addLayer(classifiedCombined, {min: 0, max: 11, palette: palette}, '2016 Classification, Combined', true);

// Display classified mode image
///Map.addLayer(filteredCombined,  {min: 0, max: 11, palette: palette}, '2016 Mode, Combined', false);

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
/*
Export.image(classifiedCombined.uint8(), 'Classification_2016_LP_30m_RF_9CL', {
  region: classifiedCombined.geometry(),
  scale: 30,
  maxPixels: 3000000000,
  });
*/


Export.image.toDrive({
  image: classifiedCombined.uint8(),
  description: 'Classification_2016_LP_30m_RF_9CL',
  scale: 30,
  region: box,
  maxPixels: 8031230934,
});


/*
Export.image(filteredCombined.uint8(), 'Classification_Mode_Kernel2_2016_LP_30m_RF_9CL', {
  region: filteredCombined.geometry(),
  scale: 30,
  maxPixels: 30000000000,
  });
*/

Export.table.toDrive(trainroiCombined, 'Table_Myanmar_2016_LP_30m_RF', 'Google Earth Engine');
//Export.table.toDrive(validationCombined, 'Validation_Myanmar_2016_LP_30m_RF', 'Google Earth Engine');

Export.image.toDrive({
    image: landsat2016RGB,
    description: 'landsat2016RGB',
    scale: 100,
    region: box,
    maxPixels: 8031230934,
});

Export.image.toDrive({
    image: hh2016s,
    description: 'hh2016s',
    scale: 100,
    region: box,
    maxPixels: 8031230934,
});

Export.table.toDrive({
  collection: myanmar_2016,
  description:'vectorsToDriveExample',
  fileFormat: 'KML'
});


/*
var vectors = classifiedCombined.reduceToVectors({
  geometry: box,
  crs: classifiedCombined.projection(),
  scale: 30,
  geometryType: 'polygon',
  eightConnected: false,
  labelProperty: 'class',
  reducer: ee.Reducer.mean()
});

// Make a display image for the vectors, add it to the map.
var display = ee.Image(0).updateMask(0).paint(vectors, '000000', 12);
Map.addLayer(display, {palette: '000000'}, 'vectors');
*/