# Myanmar
This repository contains my scripts pertaining to remote sensing image classification, land use change analysis, and scenario modeling of geospatial data in Myanmar. It also contains my working notes during workflow development and scripting.

## Land Cover Change Analysis
This study explored the synergy of optical and SAR data for mapping and monitoring land/forest cover change in Myanmar. Landsat (5/8) and L-band SAR (JERS1/PALSAR2) data were combined to generate land cover maps at two time points, specifcally 1995 and 2015. Image processing and classification were carried out mainly in Google Earth Engine, as well as other platforms including ESA SNAP Toolbox and Quantum GIS for pre-processing SAR data. A Random Forest algorithm was used to classify the image datasets using a combination of ground-truth data and high-resolution images for training and validating the results.

### Tasks

#### Image statistics

1. Image statistics were extracted from all regions of interest and exported from the Google Earth Engine platform as csv files, which were subsequently imported in R for visualisation and analysis. 
2. Box-whisker plots were generated to visualise the distribution of SAR backscatter and Landsat TOA reflectance values for each predictor variable consisting of the image channels/bands, derived indices, and texture measures.
3. The plots show land cover types (x-axis) against backscatter/reflectance/index values (y-axis) for each predictor variable.

#### Decision tree
1. Using the image statistics extracted from the regions of interest, a decision tree classification was implemented to determine thresholds for specific channels/bands that can discriminate between land cover classes. (Note: this was done to produce a mask layer that can be used for delineating regions of interest in the 1995 dataset, specifically for oil palm and rubber.)
2. The specific channels/bands were chosen based on a visual assessment of box-whisker plots showing distributions of land cover types for each predictor variable.
3. The specific channels/bands selected were as follows (from 2015 image statistics using Landsat-8/PALSAR-2):
    + HH: vegetation; non-vegetation
    + B4: shrubs/orchards; mangroves/rubber/oil palm; forest
    + B5: oil palm/rubber; mangroves
    + HH/B6: rubber; oil palm

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

