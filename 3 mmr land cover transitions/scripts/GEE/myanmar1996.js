var myanmar_1996 = ee.FeatureCollection("ft:1F0efJrgdfHTaF8C6Qe-nB9GgOMwHruxmSmodGgb-");

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

var seed = 2018;


/*******************************
  DEFINE EXTENT AND VIEW
********************************/

// Set center of map view
Map.setCenter(98.64212,12.40975, 7); // Zoom in and center display to Tanintharyi Region, Myanmar

// Define and display box extents covering Tanintharyi region
var box = ee.Geometry.Rectangle(91.187,29.42, 101.87, 8.15);

// Load a Fusion Table of state boundaries and filter. DOESNT WORK COS SOME GROUND TRUTH IN THAILAND -> ALL Oil & Rubber
//var geometry = ee.FeatureCollection('ft:1tdSwUL7MVpOauSgRzqVTOwdfy17KDbw-1d9omPw')
//    .filter(ee.Filter.eq('Country', 'Myanmar (Burma)'));
/*******************************
  LOAD DATASETS
********************************/
// DEM
var demclip = dem.clip(box);
// LANDSAT


// Load Landsat image assets
var bands1996 = ['B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7'];
var landsat1996 = ee.ImageCollection('LANDSAT/LT05/C01/T1_TOA').filterDate('1995-01-01', '1997-12-30').select(bands1996);
var median1996 = landsat1996.median();
var clip1996 = median1996.clip(box);

// Calculate indices from Landsat bands
var ndvi1996 = clip1996.normalizedDifference(['B4', 'B3']); // Normalised Difference Vegetation Index (NDVI)
var lswi1996 = clip1996.normalizedDifference(['B4', 'B5']); // Land Surface Water Index (LSWI)
var ndti1996 = clip1996.normalizedDifference(['B5', 'B7']); // Normalised Difference Till Index (NDTI)
var stvi1996 = clip1996.expression('((b("B5") - b("B3")) / (b("B5") + b("B3") + 0.1)) * (1.1 - (b("B7") / 2))'); // Soil-Adjusted Total Vegetation Index (SATVI)
var evi1996  = clip1996.expression('2.5 * ((b("B4") - b("B3")) / (b("B4") + 6 * b("B3") - 7.5 * b("B1") + 1))'); // Enhanced Vegetation Index

var landsat1996RGB = clip1996.select(['B3','B2','B1']);
//Map.addLayer(landsat1996RGB, visualization, '1996 L5 True color', true);

// JERS-1

// Load JERS-1 image assets
var hh_1996_18 = ee.Image('users/donwong9918/1996_HH_mosiac_til18_Spk_norm');
var hh_1996_24to30 = ee.Image('users/donwong9918/1996_HH_mosiac_24to30_Spk_norm');
var hh_1996_19to23 = ee.Image('users/donwong9918/1996_HH_mosiac_19to23_Spk_norm');
var hh_1996_shan = ee.Image('users/donwong9918/1996_HH_Shan_21to23_Spk_norm');

var hh1996s = ee.ImageCollection([hh_1996_18, hh_1996_24to30, hh_1996_19to23, hh_1996_shan]).mosaic()
                                      .select([0],['b1']);

// Rescale floating point to integer
var scaledhh1996 = hh1996s.expression('1000*b("b1")').int32();

// Rename rescaled Sigma0 channels
scaledhh1996 = scaledhh1996.rename('HH');

// Calculate GLCM texture measures
var textureMeasures = ['HH_asm', 'HH_contrast', 'HH_corr', 'HH_var', 'HH_idm', 'HH_savg', 'HH_ent', 'HH_diss'];
var glcm1996 = scaledhh1996.glcmTexture({size: 1, average: true }).select(textureMeasures);  // 3x3 kernel

/*******************************
  CREATE COMPOSITE STACK
********************************/

// Rename band filenames in metadata
ndvi1996 = ndvi1996.rename('NDVI');
lswi1996 = lswi1996.rename('LSWI');
ndti1996 = ndti1996.rename('NDTI');
stvi1996 = stvi1996.rename('SATVI');
evi1996 = evi1996.rename('EVI');
hh1996s = hh1996s.rename('HH');

// Create image collection from images
var stackCombined1996 = clip1996.addBands(ndvi1996).addBands(lswi1996).addBands(ndti1996).addBands(stvi1996).addBands(evi1996)
                                .addBands(hh1996s).addBands(glcm1996).addBands(demclip);
var bandsCombined = ['B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'NDVI', 'LSWI', 'NDTI', 'SATVI', 'EVI',
                     'HH', 'HH_asm', 'HH_contrast', 'HH_corr', 'HH_var', 'HH_idm', 'HH_savg', 'HH_ent', 'HH_diss', 'elevation'];

/*******************************
  DEFINE REGIONS OF INTEREST
********************************/
myanmar_1996 = myanmar_1996.randomColumn('random1', seed);

var train = myanmar_1996.filter(ee.Filter.lte('random1', 0.7));
var test  = myanmar_1996.filter(ee.Filter.gt('random1', 0.7));

//Map.addLayer(train, {'color': '000000'}, 'ROI Train', true); 
//Map.addLayer(test,  {'color': 'FF0000'}, 'ROI Test', true); 

// Initialise random column and values for ROI feature collection 
train = train.randomColumn('random', seed);
test  = test.randomColumn('random', seed);

// Create training and testing regions of interest from the image dataset
var trainroiCombined = stackCombined1996.select(bandsCombined).sampleRegions({
	collection: train,
	properties: ['Class', 'random'],
	scale: 30
});

var testroiCombined = stackCombined1996.select(bandsCombined).sampleRegions({
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
  EXECUTE CLASSIFICATIONr
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
var classifiedCombined = stackCombined1996.select(bandsCombined).classify(classifierCombined);

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

Map.addLayer(clip1996, {bands: ['B4', 'B3', 'B2'], min: 0, max: 0.3}, 'RGB 1996 Landsat', false);
Map.addLayer(hh1996s, {min: -18.0971, max: -0.970651}, 'HH 1996 JERS-1', false);

/*******************************
  DISPLAY CLASSIFICATION 
********************************/

// Create a palette for displaying the classified images
var palette = ['b15928', '6a3d9a', '33a02c', 'a6cee3', 'e31a1c', 'ff7f00', 'ffff99','fdbf6f','fb9a99','1f78b4'];

// Display classified image
//Map.addLayer(classifiedCombined, {min: 0, max: 10, palette: palette}, '1996 Classification, Combined', true);

// Display classified mode image
///Map.addLayer(filteredCombined,  {min: 0, max: 10, palette: palette}, '2016 Mode, Combined', false);

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

Export.table.toDrive(trainroiCombined, 'Table_Myanmar_1996_LJ_30m_RF', 'Google Earth Engine');
//Export.table.toDrive(validationCombined, 'Validation_Myanmar_1996_LJ_30m_RF', 'Google Earth Engine');


Export.image.toDrive({
  image: classifiedCombined.uint8(),
  description: 'Classification_1996_LP_30m_RF_9CL',
  scale: 30,
  region: box,
  maxPixels: 8031230934,
});
// 3021230934

Export.image.toDrive({
    image: landsat1996RGB,
    description: 'landsat1996RGB',
    scale: 100,
    region: box,
    maxPixels: 8031230934,
});

Export.image.toDrive({
    image: hh1996s,
    description: 'hh1996s',
    scale: 100,
    region: box,
    maxPixels: 8031230934,
});

Export.table.toDrive({
  collection: myanmar_1996,
  description:'vectorsToDriveExample',
  fileFormat: 'KML'
});