# This script implements a land cover change analysis workflow using the Intensity 
# Analysis framework via the intensity.analysis R package (Pontius & Khallaghi 2019).
# The script uses land cover maps of Myanmar developed using combined Landsat and
# L-band SAR datasets over three time-points: 1996, 2007, and 2016.
# 
# Script modified by: Jose Don T. De Alban
# Date created:       30 May 2019
# Date modified:      09 Jul 2019   


# ----------------------------------------
# SET WORKING DIRECTORY
# ----------------------------------------
setwd("/Users/dondealban/Dropbox/Research/myanmar/3 mmr land cover transitions/mangroves/intensity analysis/2_bago")

# ----------------------------------------
# LOAD LIBRARIES
# ----------------------------------------
library(raster)
library(intensity.analysis)

# ----------------------------------------
# LOAD RASTER DATA
# ----------------------------------------
r1996 <- raster('MMR_1996_AYE_RCL.tif')
r2007 <- raster('MMR_2007_AYE_RCL.tif')
r2016 <- raster('MMR_2016_AYE_RCL.tif')

# Copy raster data into new variables
lc1996 <- r1996
lc2007 <- r2007
lc2016 <- r2016

# Set 0 pixel values ('No Data') of raster data copies to NA
lc1996[lc1996 <= 0] <- NA
lc2007[lc2007 <= 0] <- NA
lc2016[lc2016 <= 0] <- NA

# ----------------------------------------
# CREATE LISTS AND VECTORS
# ----------------------------------------
raster.layers <- list(lc1996, lc2007, lc2016) # Create a list of raster data
time.points <- c("1996","2007","2016") # Create character vector of time-points
categories <- c("BRG","BUA","FOR","MNG",
                "OPM","RPD","RBR","SHB","WTR") # Create character vector of land cover categories

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

IIAname <- file.path(normalizePath(getwd()), "IntensityAnalysis_AYE_IIA.csv")
IIA2csv(IIA.output, time.points, IIAname)
CIAname <- file.path(normalizePath(getwd()), "IntensityAnalysis_AYE_CIA.csv")
CIA2csv(CIA.output, time.points, categories, CIAname)
TIAname <- file.path(normalizePath(getwd()), "IntensityAnalysis_AYE_TIA.csv")
TIA2csv(TIA.output, time.points, categories, TIAname)

# Save the cross-tabulation matrices
crosstab_1 <- crosstabulation[[1]] #1996-2007
write.csv(crosstab_1, "IntensityAnalysis_AYE_CrossTab_I1.csv")
crosstab_2 <- crosstabulation[[2]] #2007-2016
write.csv(crosstab_2, "IntensityAnalysis_AYE_CrossTab_I2.csv")
