# This script implements a land cover change analysis workflow using the Intensity 
# Analysis framework via the intensity.analysis R package (Pontius & Khallaghi 2019).
# The script uses land cover image datasets from one of my land cover change studies
# investigating land-cover regime shifts in Tanintharyi Region, Myanmar, published 
# in Sustainability journal (https://doi.org/10.3390/su11041139).
# 
# Script modified by: Jose Don T. De Alban
# Date created:       30 May 2019
# Date modified:      16 Apr 2020   


# ----------------------------------------
# SET WORKING DIRECTORY
# ----------------------------------------
setwd("/Users/dondealban/Tanintharyi/")

# ----------------------------------------
# LOAD LIBRARIES
# ----------------------------------------
library(raster)
library(intensity.analysis)

# ----------------------------------------
# LOAD RASTER DATA
# ----------------------------------------
setwd("/Users/dondealban/Tanintharyi/land cover/")
r1996 <- raster('TNI_LC_1996_9cl_150px_masked_utm.tif')
r2007 <- raster('TNI_LC_2007_9cl_150px_masked_utm.tif')
r2016 <- raster('TNI_LC_2016_9cl_150px_masked_utm.tif')

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
categories <- c("Bare Ground",
                "Built-up Area",
                "Forest",
                "Mangrove",
                "Oil Palm",
                "Rice Paddy",
                "Rubber",
                "Shrub/Orchard",
                "Water Body") # Create character vector of land cover categories

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
# SAVE OUTPUT PNG FILES
# ----------------------------------------
plots.dir.path <- list.files(tempdir(), pattern="rs-graphics", full.names = TRUE)
plots.png.paths <- list.files(plots.dir.path, pattern=".png", full.names = TRUE)
file.copy(from=plots.png.paths, to="/Users/dondealban/Tanintharyi/outputs/")

plots.png.detials <- file.info(plots.png.paths)
plots.png.detials <- plots.png.detials[order(plots.png.detials$mtime),]
sorted.png.names <- gsub(plots.dir.path, "/Users/dondealban/Tanintharyi/outputs/", row.names(plots.png.detials), fixed=TRUE)
numbered.png.names <- paste0("/Users/dondealban/Tanintharyi/outputs/", 1:length(sorted.png.names), ".png")
file.rename(from=sorted.png.names, to=numbered.png.names)

# ----------------------------------------
# SAVE OUTPUT CSV FILES
# ----------------------------------------
setwd("/Users/dondealban/Tanintharyi/outputs/")
IIAname <- file.path(normalizePath(getwd()), "IIA.csv")
IIA2csv(IIA.output, time.points, IIAname)
CIAname <- file.path(normalizePath(getwd()), "CIA.csv")
CIA2csv(CIA.output, time.points, categories, CIAname)
TIAname <- file.path(normalizePath(getwd()), "TIA.csv")
TIA2csv(TIA.output, time.points, categories, TIAname)

# Save the cross-tabulation matrices
setwd("/Users/dondealban/Tanintharyi/outputs/")
crosstab_1 <- crosstabulation[[1]] #1996-2007
write.csv(crosstab_1, "CrossTab_I1.csv")
crosstab_2 <- crosstabulation[[2]] #2007-2016
write.csv(crosstab_2, "CrossTab_I2.csv")
