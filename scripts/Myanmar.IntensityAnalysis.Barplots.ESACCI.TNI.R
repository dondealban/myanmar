# Script Description --------------------
# This R script generates barlots using ggplot2 package to visualise the results of
# intensity analysis of changes between 4 land cover types derived from ESA CCI land
# cover data (1992-2015) covering Tanintharyi, Myanmar. The original land cover classes
# were reclassified into four bespoke classes: Forest (FOR), Other Vegetation (VEG),
# Cropland (CRP), and Non-Forest (NON).
#
# Intensity analysis was calculated using Dinamica EGO platform using the 24 annual 
# ESA CCI land cover data layers. The domain of the analysis is the landscape extent
# within the following coordinates: 97 to 100 deg E longitude; 9 to 16 deg N latitude.
#
# Script By:      Jose Don T De Alban
# Date Created:   25 Apr 2017
# Last Modified:  23 Nov 2017


# Set Working Directory -----------------
setwd("/Users/dondealban/Dropbox/Research/myanmar/intensity analysis/barplots/esa cci/tanintharyi/")

# Load Libraries ------------------------
library(dplyr)
library(ggplot2)
library(plyr)
library(reshape2)
library(tidyr)


# Interval Level ------------------------

# Read CSV data file
dataINT <- read.csv(file="Interval_level.csv", header=TRUE, sep=",")

# Select columns: interval number, annual change rate, uniform change rate
df <- subset(dataINT, select=c(1:2,4:5))
colnames(df) <- c("Interval","Int.Length","Ann.Change","Uni.Change") # Rename column names

# Insert rows for missing intervals (Note: 1992 to 2015 = 24 years)

# Using tidyr
tmin = 1
tmax = 24
dfINT <- complete(df, nesting(Int.Length), Interval=seq(min(tmin), max(tmax), 1L))
dfINT <- replace_na(dfINT, list(Ann.Change=0, Uni.Change=dfINT[3,4]))


