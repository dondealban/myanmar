# Myanmar
This repository contains my scripts pertaining to remote sensing image classification, land use change analysis, and scenario modeling of geospatial data in Myanmar. It also contains my working notes during workflow development and scripting.

## Land Cover Change Analysis
This study explored the synergy of optical and SAR data for mapping and monitoring land/forest cover change in Myanmar. Landsat (5/8) and L-band SAR (JERS1/PALSAR2) data were combined to generate land cover maps at two time points, specifcally 1995 and 2015. Image processing and classification were carried out mainly in [Google Earth Engine](https://earthengine.google.com), as well as other platforms including [ESA SNAP Toolbox](https://earthengine.google.com) and [Quantum GIS](http://www.qgis.org) for pre-processing SAR data. A Random Forest algorithm was used to classify the image datasets using a combination of ground-truth data and high-resolution images for training and validating the results.

### Tasks

#### Image statistics
1. Image statistics were extracted from all regions of interest and exported from the Google Earth Engine platform as csv files, which were subsequently imported in R for visualisation and analysis. 
2. Box-whisker plots were generated to visualise the distribution of SAR backscatter and Landsat TOA reflectance values for each predictor variable consisting of the image channels/bands, derived indices, and texture measures.
3. The plots show land cover types (x-axis) against backscatter/reflectance/index values (y-axis) for each predictor variable.

#### Decision tree
1. Using the image statistics extracted from the regions of interest, a [decision tree classification](https://en.wikipedia.org/wiki/Decision_tree_learning) was implemented to determine thresholds for specific channels/bands that can discriminate between land cover classes. (Note: this was done to produce a mask layer that can be used for delineating regions of interest in the 1995 dataset, specifically for oil palm and rubber.)
2. The specific channels/bands were chosen based on a visual assessment of box-whisker plots showing distributions of land cover types for each predictor variable.
3. The specific channels/bands selected were as follows (from 2015 image statistics using Landsat-8/PALSAR-2):
    + HH: vegetation; non-vegetation
    + B4: shrubs/orchards; mangroves/rubber/oil palm; forest
    + B5: oil palm/rubber; mangroves
    + B6: rubber; oil palm

#### Variable importance
1. The variable importance from a [Random Forest](https://en.wikipedia.org/wiki/Random_forest) classification was assessed to determine the relative contribution of variables to the performance of the model. From this, variables will be excluded to improve model performance.
2. Variable importance and selection was tested and computed using three packages, of which VSURF was the final package used:
    + [randomForest](https://cran.r-project.org/web/packages/randomForest/index.html) package: variable importance was calculated using both mean decrease in accuracy (permutation importance) and mean decrease in impurity (Gini index).
    + [party](https://cran.r-project.org/web/packages/party/index.html) package: conditional permutation importance was calculated through conditional inference trees to address biased variable selection and to account for correlated variables, both of which are limitations in the randomForest package. However, cforest is computationally intensive and results in errors and crashes, once conditional settings are set to true, perhaps due to the huge set of predictor variables, tree depth, and random variables to permute.
    + [VSURF](https://cran.r-project.org/web/packages/VSURF/) package: an automatic stepwise calculation of variable selection and assessment of variable importance was implemented consisting of thresholding, interpretation, and prediction. The process results in the selection of the most parsimonious variables that contribute to the model performance (lowest error) based on permutation-based score of importance.

#### McNemar's test
1. The [McNemar's test](https://en.wikipedia.org/wiki/McNemar's_test) is used to compare proportions between two groups of paired categorical data and to evaluate hypothesis about the data.
2. The McNemar's test statistic was computed to compare the proportions of misclassifications between two classified data and to test whether they are similar or not. Three groups were compared: (a) classifications between Landsat and combined Landsat+SAR data with all predictor variables; (b) classifications between selected and all variables using combined Landsat+SAR data; and (c) classifications between Landsat using all variables and Landsat+SAR data using selected variables.
3. Three tests were computed: with continuity correction, without continuity correction, and the exact 2x2 test with central confidence intervals. These were assessed at three critical values: alpha = 0.01, 0.05, and 0.10. For the exact 2x2 test, only the critical value at 0.05 (95% confidence intervals) was used.

#### Intensity analysis
1. The [Intensity Analysis](https://sites.google.com/site/intensityanalysis/home) framework was employed to compute land cover transition matrices, which will inform the development of land use transition rules for simulation modeling.
2. A cross-tabulation matrix was computed using the Quantum GIS [Semi-Automatic Classification Plugin](https://plugins.qgis.org/plugins/SemiAutomaticClassificationPlugin/) with the 1995 and 2015 land cover rasters as inputs.

### Acronyms

#### Land Cover Types
The following land cover types were identified based on available ground-truth data and ancillary maps, and subsequently adopted as the land cover classification scheme.

Acronym | Land Cover Type
------- | ----------------
FOR     | Forest
MNG     | Mangrove
OPM     | Oil Palm Mature
OPY     | Oil Palm Young
RBM     | Rubber Mature
RBY     | Rubber Young
RBN     | Rubber New
SHB     | Shrub/Orchard
RPD     | Rice Paddy
BUA     | Built-Up Area
BSG     | Bare Soil/Ground
WTR     | Water

The final land cover categories used consist of nine classes including: FOR, MNG, OPM, RBM, SHB, RPD, BUA, BSG, and WTR.

#### Predictor Variables
Predictor variables consist mainly of Landsat bands and L-band SAR polarisation channels. Additional predictors were calculated from the main bands/channels, specifically indices and texture measures (see below). SAR indices indicated by an asterisk (*).

Acronym | Index
------- | ----------------
EVI     | Enhanced Vegetation Index
LSWI    | Land Surface Water Index
NDVI    | Normalised Difference Vegetation Index 
NDTI    | Normalised Till Index
SATVI   | Soil-Adjusted Vegetation Index
AVE     | Average*
DIF     | Difference*
NDI     | Normalised Difference Index*
NLI     | NL Index*
RT1     | HH/HV Ratio*
RT2     | HV/HH Ratio*

#### Texture Measures
Grey-level co-occurrence matrices were computed from the HH and HV polarisation channels of the SAR data. The following Haralick texture measures were computed:

Acronym | Texture Measure
------- | ----------------
ASM     | Angular Second Moment 
CON     | Contrast
COR     | Correlation
DIS     | Dissimilarity
ENT     | Entropy
IDM     | Homogeneity
SVG     | Mean
VAR     | Variance
