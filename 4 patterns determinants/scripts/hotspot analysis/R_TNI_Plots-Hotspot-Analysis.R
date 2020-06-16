# This script generates plots from the results of the Getis-Ord Gi statistic or Hotspot
# analysis implemented in ArcGIS (Emerging Hotspots Toolbox) to assess the spatial 
# associations and distribution of the different gain transitions of major agricultural
# crop commodities (i.e., oil palm, rubber, rice) in Tanintharyi Region, Myanmar.
# 
# Script by:      Jose Don T. De Alban
# Date created:   16 Jun 2020
# Date modified:  


# Load Libraries -------------------------
library(tidyverse)

# Set Working Directories ----------------
DirMAIN <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/"
DirDATA <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/hotspot analysis/"
DirOPM  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/hotspot analysis/csv opm/"
DirRBR  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/hotspot analysis/csv rbr/"
DirRPD  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/hotspot analysis/csv rpd/"

# Read Data Files ------------------------
# Getis-Ord gi statistics data for hotspots of oil palm gain transitions
setwd(DirOPM)
csvFORtoOPMi1 <- read.csv(file="Hotspot_I1_FOR_to_OPM_3km.csv", header=TRUE, sep=",")
csvMNGtoOPMi1 <- read.csv(file="Hotspot_I1_MNG_to_OPM_3km.csv", header=TRUE, sep=",")
csvRPDtoOPMi1 <- read.csv(file="Hotspot_I1_RPD_to_OPM_3km.csv", header=TRUE, sep=",")
csvRBRtoOPMi1 <- read.csv(file="Hotspot_I1_RBR_to_OPM_3km.csv", header=TRUE, sep=",")
csvSHBtoOPMi1 <- read.csv(file="Hotspot_I1_SHB_to_OPM_3km.csv", header=TRUE, sep=",")
csvFORtoOPMi2 <- read.csv(file="Hotspot_I2_FOR_to_OPM_3km.csv", header=TRUE, sep=",")
csvMNGtoOPMi2 <- read.csv(file="Hotspot_I2_MNG_to_OPM_3km.csv", header=TRUE, sep=",")
csvRPDtoOPMi2 <- read.csv(file="Hotspot_I2_RPD_to_OPM_3km.csv", header=TRUE, sep=",")
csvRBRtoOPMi2 <- read.csv(file="Hotspot_I2_RBR_to_OPM_3km.csv", header=TRUE, sep=",")
csvSHBtoOPMi2 <- read.csv(file="Hotspot_I2_SHB_to_OPM_3km.csv", header=TRUE, sep=",")

# Data Wrangling -------------------------

# Insert column for source land cover types for OPM gain transitions
Source <- rep("FOR", nrow(csvFORtoOPMi1))   # Time-interval: 1996-2007
dfFORtoOPMi1 <- cbind(csvFORtoOPMi1, Source)
Source <- rep("MNG", nrow(csvMNGtoOPMi1))
dfMNGtoOPMi1 <- cbind(csvMNGtoOPMi1, Source)
Source <- rep("RPD", nrow(csvRPDtoOPMi1))
dfRPDtoOPMi1 <- cbind(csvRPDtoOPMi1, Source)
Source <- rep("RBR", nrow(csvRBRtoOPMi1))
dfRBRtoOPMi1 <- cbind(csvRBRtoOPMi1, Source)
Source <- rep("SHB", nrow(csvSHBtoOPMi1))
dfSHBtoOPMi1 <- cbind(csvSHBtoOPMi1, Source)
Source <- rep("FOR", nrow(csvFORtoOPMi2))   # Time-interval: 1996-2007
dfFORtoOPMi2 <- cbind(csvFORtoOPMi2, Source)
Source <- rep("MNG", nrow(csvMNGtoOPMi2))
dfMNGtoOPMi2 <- cbind(csvMNGtoOPMi2, Source)
Source <- rep("RPD", nrow(csvRPDtoOPMi2))
dfRPDtoOPMi2 <- cbind(csvRPDtoOPMi2, Source)
Source <- rep("RBR", nrow(csvRBRtoOPMi2))
dfRBRtoOPMi2 <- cbind(csvRBRtoOPMi2, Source)
Source <- rep("SHB", nrow(csvSHBtoOPMi2))
dfSHBtoOPMi2 <- cbind(csvSHBtoOPMi2, Source)

# Combine dataframes per time-interval
dfOPMi1 <- rbind(dfFORtoOPMi1, dfMNGtoOPMi1, dfRPDtoOPMi1, dfRBRtoOPMi1, dfSHBtoOPMi1)
dfOPMi2 <- rbind(dfFORtoOPMi2, dfMNGtoOPMi2, dfRPDtoOPMi2, dfRBRtoOPMi2, dfSHBtoOPMi2)

# Insert column for time-intervals
Time_Interval <- rep("1996-2007", nrow(dfOPMi1))
dfOPMi1 <- cbind(dfOPMi1, Time_Interval)
Time_Interval <- rep("2007-2016", nrow(dfOPMi2))
dfOPMi2 <- cbind(dfOPMi2, Time_Interval)

# Combine dataframes for OPM gain transitions
dfOPM <- rbind(dfOPMi1, dfOPMi2)
GridCount <- rep(1, nrow(dfOPM))
dfOPMall <- cbind(dfOPM, GridCount)

# Generate Plots -------------------------

plotOPM <- ggplot() + geom_bar(data=dfOPMall, aes(x=Source, y=GridCount, fill=Gi_Bin))





