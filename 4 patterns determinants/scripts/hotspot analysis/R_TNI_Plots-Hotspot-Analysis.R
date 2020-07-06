# This script generates plots from the results of the Getis-Ord Gi statistic or Hotspot
# analysis implemented in ArcGIS (Emerging Hotspots Toolbox) to assess the spatial 
# associations and distribution of the different gain transitions of major agricultural
# crop commodities (i.e., oil palm, rubber, rice) in Tanintharyi Region, Myanmar.
# 
# Script by:      Jose Don T. De Alban
# Date created:   16 Jun 2020
# Date modified:  06 Jul 2020


# Load Libraries -------------------------
library(tidyverse)

# Set Working Directories ----------------
DirMAIN <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/"
DirPLOT <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/hotspot analysis/plots/"
DirOPM  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/hotspot analysis/csv opm/"
DirRBR  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/hotspot analysis/csv rbr/"
DirRPD  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/hotspot analysis/csv rpd/"

# Read Data Files ------------------------
# Getis-Ord gi statistics data for hotspots of oil palm gain transitions
setwd(DirOPM)
csvFORtoOPMi1 <- read.csv(file="Hotspot_I1_FOR_OPM_3km.csv", header=TRUE, sep=",")
csvMNGtoOPMi1 <- read.csv(file="Hotspot_I1_MNG_OPM_3km.csv", header=TRUE, sep=",")
csvRPDtoOPMi1 <- read.csv(file="Hotspot_I1_RPD_OPM_3km.csv", header=TRUE, sep=",")
csvRBRtoOPMi1 <- read.csv(file="Hotspot_I1_RBR_OPM_3km.csv", header=TRUE, sep=",")
csvSHBtoOPMi1 <- read.csv(file="Hotspot_I1_SHB_OPM_3km.csv", header=TRUE, sep=",")
csvFORtoOPMi2 <- read.csv(file="Hotspot_I2_FOR_OPM_3km.csv", header=TRUE, sep=",")
csvMNGtoOPMi2 <- read.csv(file="Hotspot_I2_MNG_OPM_3km.csv", header=TRUE, sep=",")
csvRPDtoOPMi2 <- read.csv(file="Hotspot_I2_RPD_OPM_3km.csv", header=TRUE, sep=",")
csvRBRtoOPMi2 <- read.csv(file="Hotspot_I2_RBR_OPM_3km.csv", header=TRUE, sep=",")
csvSHBtoOPMi2 <- read.csv(file="Hotspot_I2_SHB_OPM_3km.csv", header=TRUE, sep=",")
# Getis-Ord gi statistics data for hotspots of rubber gain transitions
setwd(DirRBR)
csvFORtoRBRi1 <- read.csv(file="Hotspot_I1_FOR_RBR_3km.csv", header=TRUE, sep=",")
csvMNGtoRBRi1 <- read.csv(file="Hotspot_I1_MNG_RBR_3km.csv", header=TRUE, sep=",")
csvOPMtoRBRi1 <- read.csv(file="Hotspot_I1_OPM_RBR_3km.csv", header=TRUE, sep=",")
csvRPDtoRBRi1 <- read.csv(file="Hotspot_I1_RPD_RBR_3km.csv", header=TRUE, sep=",")
csvSHBtoRBRi1 <- read.csv(file="Hotspot_I1_SHB_RBR_3km.csv", header=TRUE, sep=",")
csvFORtoRBRi2 <- read.csv(file="Hotspot_I2_FOR_RBR_3km.csv", header=TRUE, sep=",")
csvMNGtoRBRi2 <- read.csv(file="Hotspot_I2_MNG_RBR_3km.csv", header=TRUE, sep=",")
csvOPMtoRBRi2 <- read.csv(file="Hotspot_I2_OPm_RBR_3km.csv", header=TRUE, sep=",")
csvRPDtoRBRi2 <- read.csv(file="Hotspot_I2_RPD_RBR_3km.csv", header=TRUE, sep=",")
csvSHBtoRBRi2 <- read.csv(file="Hotspot_I2_SHB_RBR_3km.csv", header=TRUE, sep=",")
# Getis-Ord gi statistics data for hotspots of rice paddy gain transitions
setwd(DirRPD)
csvFORtoRPDi1 <- read.csv(file="Hotspot_I1_FOR_RPD_3km.csv", header=TRUE, sep=",")
csvMNGtoRPDi1 <- read.csv(file="Hotspot_I1_MNG_RPD_3km.csv", header=TRUE, sep=",")
csvOPMtoRPDi1 <- read.csv(file="Hotspot_I1_OPM_RPD_3km.csv", header=TRUE, sep=",")
csvRBRtoRPDi1 <- read.csv(file="Hotspot_I1_RBr_RPD_3km.csv", header=TRUE, sep=",")
csvSHBtoRPDi1 <- read.csv(file="Hotspot_I1_SHB_RPD_3km.csv", header=TRUE, sep=",")
csvFORtoRPDi2 <- read.csv(file="Hotspot_I2_FOR_RPD_3km.csv", header=TRUE, sep=",")
csvMNGtoRPDi2 <- read.csv(file="Hotspot_I2_MNG_RPD_3km.csv", header=TRUE, sep=",")
csvOPMtoRPDi2 <- read.csv(file="Hotspot_I2_OPm_RPD_3km.csv", header=TRUE, sep=",")
csvRBRtoRPDi2 <- read.csv(file="Hotspot_I2_RBR_RPD_3km.csv", header=TRUE, sep=",")
csvSHBtoRPDi2 <- read.csv(file="Hotspot_I2_SHB_RPD_3km.csv", header=TRUE, sep=",")

# Data Wrangling [Oil Palm] --------------
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

# Data Wrangling [Rubber] ----------------
# Insert column for source land cover types for RBR gain transitions
Source <- rep("FOR", nrow(csvFORtoRBRi1))   # Time-interval: 1996-2007
dfFORtoRBRi1 <- cbind(csvFORtoRBRi1, Source)
Source <- rep("MNG", nrow(csvMNGtoRBRi1))
dfMNGtoRBRi1 <- cbind(csvMNGtoRBRi1, Source)
Source <- rep("OPM", nrow(csvOPMtoRBRi1))
dfOPMtoRBRi1 <- cbind(csvOPMtoRBRi1, Source)
Source <- rep("RPD", nrow(csvRPDtoRBRi1))
dfRPDtoRBRi1 <- cbind(csvRPDtoRBRi1, Source)
Source <- rep("SHB", nrow(csvSHBtoRBRi1))
dfSHBtoRBRi1 <- cbind(csvSHBtoRBRi1, Source)
Source <- rep("FOR", nrow(csvFORtoRBRi2))   # Time-interval: 1996-2007
dfFORtoRBRi2 <- cbind(csvFORtoRBRi2, Source)
Source <- rep("MNG", nrow(csvMNGtoRBRi2))
dfMNGtoRBRi2 <- cbind(csvMNGtoRBRi2, Source)
Source <- rep("OPM", nrow(csvOPMtoRBRi2))
dfOPMtoRBRi2 <- cbind(csvOPMtoRBRi2, Source)
Source <- rep("RPD", nrow(csvRPDtoRBRi2))
dfRPDtoRBRi2 <- cbind(csvRPDtoRBRi2, Source)
Source <- rep("SHB", nrow(csvSHBtoRBRi2))
dfSHBtoRBRi2 <- cbind(csvSHBtoRBRi2, Source)

# Combine dataframes per time-interval
dfRBRi1 <- rbind(dfFORtoRBRi1, dfMNGtoRBRi1, dfOPMtoRBRi1, dfRPDtoRBRi1, dfSHBtoRBRi1)
dfRBRi2 <- rbind(dfFORtoRBRi2, dfMNGtoRBRi2, dfOPMtoRBRi2, dfRPDtoRBRi2, dfSHBtoRBRi2)

# Insert column for time-intervals
Time_Interval <- rep("1996-2007", nrow(dfRBRi1))
dfRBRi1 <- cbind(dfRBRi1, Time_Interval)
Time_Interval <- rep("2007-2016", nrow(dfRBRi2))
dfRBRi2 <- cbind(dfRBRi2, Time_Interval)

# Combine dataframes for RBR gain transitions
dfRBR <- rbind(dfRBRi1, dfRBRi2)
GridCount <- rep(1, nrow(dfRBR))
dfRBRall <- cbind(dfRBR, GridCount)

# Data Wrangling [Rice Paddy] ------------
# Insert column for source land cover types for RPD gain transitions
Source <- rep("FOR", nrow(csvFORtoRPDi1))   # Time-interval: 1996-2007
dfFORtoRPDi1 <- cbind(csvFORtoRPDi1, Source)
Source <- rep("MNG", nrow(csvMNGtoRPDi1))
dfMNGtoRPDi1 <- cbind(csvMNGtoRPDi1, Source)
Source <- rep("OPM", nrow(csvOPMtoRPDi1))
dfOPMtoRPDi1 <- cbind(csvOPMtoRPDi1, Source)
Source <- rep("RBR", nrow(csvRBRtoRPDi1))
dfRBRtoRPDi1 <- cbind(csvRBRtoRPDi1, Source)
Source <- rep("SHB", nrow(csvSHBtoRPDi1))
dfSHBtoRPDi1 <- cbind(csvSHBtoRPDi1, Source)
Source <- rep("FOR", nrow(csvFORtoRPDi2))   # Time-interval: 1996-2007
dfFORtoRPDi2 <- cbind(csvFORtoRPDi2, Source)
Source <- rep("MNG", nrow(csvMNGtoRPDi2))
dfMNGtoRPDi2 <- cbind(csvMNGtoRPDi2, Source)
Source <- rep("OPM", nrow(csvOPMtoRPDi2))
dfOPMtoRPDi2 <- cbind(csvOPMtoRPDi2, Source)
Source <- rep("RBR", nrow(csvRBRtoRPDi2))
dfRBRtoRPDi2 <- cbind(csvRBRtoRPDi2, Source)
Source <- rep("SHB", nrow(csvSHBtoRPDi2))
dfSHBtoRPDi2 <- cbind(csvSHBtoRPDi2, Source)

# Combine dataframes per time-interval
dfRPDi1 <- rbind(dfFORtoRPDi1, dfMNGtoRPDi1, dfOPMtoRPDi1, dfRBRtoRPDi1, dfSHBtoRPDi1)
dfRPDi2 <- rbind(dfFORtoRPDi2, dfMNGtoRPDi2, dfOPMtoRPDi2, dfRBRtoRPDi2, dfSHBtoRPDi2)

# Insert column for time-intervals
Time_Interval <- rep("1996-2007", nrow(dfRPDi1))
dfRPDi1 <- cbind(dfRPDi1, Time_Interval)
Time_Interval <- rep("2007-2016", nrow(dfRPDi2))
dfRPDi2 <- cbind(dfRPDi2, Time_Interval)

# Combine dataframes for RPD gain transitions
dfRPD <- rbind(dfRPDi1, dfRPDi2)
GridCount <- rep(1, nrow(dfRPD))
dfRPDall <- cbind(dfRPD, GridCount)

# Combine All Dataframes -----------------
# Insert column for commodity type
Commodity <- rep("OPM", nrow(dfOPMall))
dfOPMall <- cbind(dfOPMall, Commodity)
Commodity <- rep("RBR", nrow(dfRBRall))
dfRBRall <- cbind(dfRBRall, Commodity)
Commodity <- rep("RPD", nrow(dfRPDall))
dfRPDall <- cbind(dfRPDall, Commodity)

# Combine all dataframe per commodities into omnibus dataframe
dfALL <- rbind(dfOPMall, dfRBRall, dfRPDall)

# Generate Plots -------------------------

# Oil palm transitions; regional scale
plotOPM <- ggplot() + geom_bar(data=dfOPMall, aes(x=Source, fill=forcats::fct_rev(as.factor(Gi_Bin))))
plotOPM <- plotOPM + facet_grid(~Time_Interval)
plotOPM <- plotOPM + labs(title="Hotspots/Coldspots of Oil Palm Gain Transitions",
                          x="Source Land Cover Type", y="Number of Hexagon Grids")
plotOPM <- plotOPM + scale_fill_manual(name="Gi Bin",
                                       values=c("#d7191c","#f17c4a","#fec980","#ffffff","#c7e9ad","#80bfac","#2b83ba"),
                                       labels=c("99% hotspot","95% hotspot","90% hotspot","No clustering","90% coldspot","95% coldspot","99% coldspot"))

# Rubber transitions; regional scale
plotRBR <- ggplot() + geom_bar(data=dfRBRall, aes(x=Source, fill=forcats::fct_rev(as.factor(Gi_Bin))))
plotRBR <- plotRBR + facet_grid(~Time_Interval)
plotRBR <- plotRBR + labs(title="Hotspots/Coldspots of Rubber Gain Transitions",
                          x="Source Land Cover Type", y="Number of Hexagon Grids")
plotRBR <- plotRBR + scale_fill_manual(name="Gi Bin",
                                       values=c("#d7191c","#f17c4a","#fec980","#ffffff","#c7e9ad","#80bfac","#2b83ba"),
                                       labels=c("99% hotspot","95% hotspot","90% hotspot","No clustering","90% coldspot","95% coldspot","99% coldspot"))

# Rice paddy transitions; regional scale
plotRPD <- ggplot() + geom_bar(data=dfRPDall, aes(x=Source, fill=forcats::fct_rev(as.factor(Gi_Bin))))
plotRPD <- plotRPD + facet_grid(~Time_Interval)
plotRPD <- plotRPD + labs(title="Hotspots/Coldspots of Rice Paddy Gain Transitions",
                          x="Source Land Cover Type", y="Number of Hexagon Grids")
plotRPD <- plotRPD + scale_fill_manual(name="Gi Bin",
                                       values=c("#d7191c","#f17c4a","#fec980","#ffffff","#c7e9ad","#80bfac","#2b83ba"),
                                       labels=c("99% hotspot","95% hotspot","90% hotspot","No clustering","90% coldspot","95% coldspot","99% coldspot"))

# Gain transitions for all commodities; regional scale
plotALL <- ggplot() + geom_bar(data=dfALL, aes(x=Source, fill=forcats::fct_rev(as.factor(Gi_Bin))))
plotALL <- plotALL + facet_grid(Commodity ~ Time_Interval, scales="free_x")
plotALL <- plotALL + labs(title="Hotspots/Coldspots of Agricultural Commodity Gain Transitions",
                          subtitle="Tanintharyi Region, Myanmar", 
                          x="Source Land Cover Type", y="Number of Hexagon Grids")
plotALL <- plotALL + scale_fill_manual(name="Gi Bin",
                                       values=c("#d7191c","#f17c4a","#fec980","#ffffff","#c7e9ad","#80bfac","#2b83ba"),
                                       labels=c("99% hotspot","95% hotspot","90% hotspot","No clustering","90% coldspot","95% coldspot","99% coldspot"))



# Save Output Plots ----------------------
setwd(DirPLOT)
ggsave(plotOPM, file="TNI_HotspotAnalysis_OPMGain.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(plotRBR, file="TNI_HotspotAnalysis_RBRGain.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(plotRPD, file="TNI_HotspotAnalysis_RPDGain.pdf", width=30, height=20, units="cm", dpi=300)

ggsave(plotALL, file="TNI_HotspotAnalysis_AllCommodities.pdf", width=30, height=20, units="cm", dpi=300)

