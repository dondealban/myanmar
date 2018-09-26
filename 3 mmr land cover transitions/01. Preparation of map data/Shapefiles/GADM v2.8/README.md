### Choosing GADM v2.8 (over v3.4) Shapefiles

**Creator:** J Johanness

**Date:** 18-09-2018


**Purpose:**

This folder contains the Shapefiles at all administrative unit levels within Myanmar, sourced from [Database of Global Administrative Areas (GADM)](https://gadm.org/index.html). However, this version of the Shapefiles (**which was sourced in mid-2017 to mid-2018**) is no longer downloadable from GADM. Instead, the map data within GADM is actually to a more updated [GADM Version 3.4](https://gadm.org/download_country_v3.html). 

~ ~ ~ ~ ~

#### **Correction**

*The GADM v2.8 can still be downloaded from GADM at [LINK](https://gadm.org/download_country_v2.html).* 

~ ~ ~ ~ ~

For some reason, using the GADM v3.4 Shapefiles caused some unknown errors when we attempted to use the QGIS 2.18.15/3.2.1 [Semi-automatic Classification Plugin (SCP)](https://media.readthedocs.org/pdf/semiautomaticclassificationmanual-v5/latest/semiautomaticclassificationmanual-v5.pdf), specifically when using the Land Cover Change (LCC) function. The change maps generated using the GADM v3.6 had negative values within the raster pixels, and preliminary quality-checking of the Land Cover Change Reports (LCCRs) which were generated as .csv outputs from the plugin revealed that for all changes that were documented between Land Use Land Cover (LULC) categories all indicated 0 (i.e. zero) pixels consistently in all changes in all .csv's. The maps could also not be seen within QGIS, suggesting another Spatial Reference System, however, checks revealed that the SRS was indeed WGS1984, therefore compromising our ability to proceed further using these set of change maps created using the GADM v3.6 Shapefiles.

Upon further investigation by repeating the QGIS SCP LCC function as a single process and as a batch process, we observed the following error message within the QGIS Console : *"Error [46] Error reading raster. Possibly bands are not aligned"*. It is difficult to make sense of the error message as (1) each raster map for each domain were single-band, and (2) for a single domain, all three raster maps (at the national level) were subsetted to their domain using the same GADM v3.6 Shapefile. Despite that being so, there is only one other incident by other QGIS SCP users who have encountered this problem [(LINK)](https://www.facebook.com/groups/SemiAutomaticClassificationPlugin/permalink/1012657092163822/), and to date, there are no accounts of users facing this problem in the [QGIS SCP Google+ group](https://plus.google.com/communities/107833394986612468374/s/Error%20%5B46%5D).

However, after repeating the process from subsetting of rasters per domain per timepoint and subsequent generation of the change maps via QGIS SCP LCC (**this time with GADM v2.8**), the outputs were correct and error-free. Therefore, we decided to operate using GADM v2.8 instead.


**Note:**

There is a polygon inversion in Kayah State within the GADM v2.8, which restricts the QGIS algorithm 'Extract Raster by Mask Layer'. This issue can be rectified via multiple ways, however the one that was most efficient was through using QGIS 3.2.1 'Fix Geometries', which operates similarly to a function in Post-GIS. For more information on this error and its solution, visit the following [GIS Stack Exchange Thread](https://gis.stackexchange.com/questions/292368/fixing-invalid-geometry-self-intersection). It may be important to also note that the MMR_adm0 and MMR_adm1 Shapefiles from GADM v2.8 were all '*Invalid*' when tested using the QGIS algorithm "Check Validity", but this issue was not observed in the GADM v3.4 Shapefiles, which only returned '*Valid*' outputs when checking its validity. Even so, the previous error in using the QGIS SCP LCC Error [46] occured only when using the GADM v3.4 Shapefiles.


**End**
