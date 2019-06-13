# This script implements a land cover change analysis workflow using the Intensity 
# Analysis framework via the intensity.analysis R package (Pontius & Khallaghi 2019).
# The script uses land cover maps of Myanmar developed using combined Landsat and
# L-band SAR datasets over three time-points: 1996, 2007, and 2016.
# 
# Script modified by: Jose Don T. De Alban
# Date created:       30 May 2019
# Date modified:      13 Jun 2019   


# ----------------------------------------
# SET WORKING DIRECTORY
# ----------------------------------------
setwd("/Users/dondealban/Dropbox/Research/myanmar/3 mmr land cover transitions/mangroves/")

# ----------------------------------------
# LOAD LIBRARIES
# ----------------------------------------
library(raster)
library(intensity.analysis)

# ----------------------------------------
# LOAD RASTER DATA
# ----------------------------------------
setwd("/Users/dondealban/Dropbox/Research/learning-intensity-analysis/raster data/")
r1992 <- raster('Landscape_1992.tif')
r1997 <- raster('Landscape_1997.tif')
r2004 <- raster('Landscape_2004.tif')
r2015 <- raster('Landscape_2015.tif')

# Copy raster data into new variables
lc1992 <- r1992
lc1997 <- r1997
lc2004 <- r2004
lc2015 <- r2015

# Set 0 pixel values ('No Data') of raster data copies to NA
lc1992[lc1992 <= 0] <- NA
lc1997[lc1997 <= 0] <- NA
lc2004[lc2004 <= 0] <- NA
lc2015[lc2015 <= 0] <- NA

# ----------------------------------------
# CREATE LISTS AND VECTORS
# ----------------------------------------
raster.layers <- list(lc1992, lc1997, lc2004, lc2015) # Create a list of raster data
time.points <- c("1992","1997","2004","2015") # Create character vector of time-points
categories <- c("Forest",
                "Mosaic Vegetation",
                "Shrubland",
                "Other Vegetation",
                "Cropland",
                "Non-Vegetation") # Create character vector of land cover categories

# ----------------------------------------
# CROSS-TABULATION
# ----------------------------------------
crosstabulation <- multicrosstab(raster.layers, time.points, categories)

# ----------------------------------------
# INTENSITY ANALYSIS
# ----------------------------------------

# Interval-level Intensity Analysis
IIA.output <- IIA(crosstabulation, time.points)

# Category-level Intensity Analysis
CIA.output <- CIA(crosstabulation, time.points, categories)

# Transition-level Intensity Analysis
TIA.output <- TIA(crosstabulation, time.points, categories)

# ----------------------------------------
# SAVE OUTPUT CSV FILES
# ----------------------------------------
setwd("/Users/dondealban/Dropbox/Research/learning-intensity-analysis/outputs/")
IIAname <- file.path(normalizePath(getwd()), "IIA.csv")
IIA2csv(IIA.output, time.points, IIAname)
CIAname <- file.path(normalizePath(getwd()), "CIA.csv")
CIA2csv(CIA.output, time.points, categories, CIAname)
TIAname <- file.path(normalizePath(getwd()), "TIA.csv")
TIA2csv(TIA.output, time.points, categories, TIAname)

# Save the cross-tabulation matrices
setwd("/Users/dondealban/Dropbox/Research/learning-intensity-analysis/outputs/")
crosstab_1 <- crosstabulation[[1]] #1992-1997
write.csv(crosstab_1, "CrossTab_I1.csv")
crosstab_2 <- crosstabulation[[2]] #1997-2004
write.csv(crosstab_2, "CrossTab_I2.csv")
crosstab_3 <- crosstabulation[[3]] #2004-2015
write.csv(crosstab_3, "CrossTab_I3.csv")
