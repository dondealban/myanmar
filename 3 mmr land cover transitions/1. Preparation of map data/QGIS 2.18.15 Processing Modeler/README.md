### Using the QGIS 2.18.15 Processing Modeler

**Creator:** J Johanness

**Date:** 18-09-2018

**Purpose:**

This folder contains the final QGIS Processing Modeler used to subset the classified raster maps at each of the 3 timepoints to each of the 16 domains within Myanmar. Essentially, this simple Processing Modeler utilises the [Extract by Mask Layer](https://docs.qgis.org/2.18/en/docs/user_manual/processing_algs/gdalogr/gdal_extraction.html) function by the [Geospatial Data Abstraction Library (GDAL) plugin](https://docs.qgis.org/2.8/en/docs/user_manual/plugins/plugins_gdaltools.html) which has been incorporated into QGIS default/local algorithms from QGIS Version 2 onwards.

**Note:**

The Processing Modeler for 3 timepoints for 16 domains took 1 day + to run in QGIS 2.18.15. Alternatively, there exist ways to achieve the same outputs using the [Google Earth Engine (GEE)](https://code.earthengine.google.com/) scripting environment, in a expected-to-be considerably shorter duration.

Also, the .model files that represent these Modelers in QGIS 2.18.15 do not (at this point) seem to be able to be loaded into the databse in QGIS 3.2.1 which uses the .model3 extension instead. Further investigations into the backwards compatibility for these .model files will have to be conducted to assess its use in QGIS 3.2.1.

**End**
