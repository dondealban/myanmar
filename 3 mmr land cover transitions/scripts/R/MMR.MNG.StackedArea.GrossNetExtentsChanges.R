# Script Description --------------------
# This R script generates split stacked area plots to visualise gross+net extents and
# changes of mangroves in Myanmar and in each sub-national administrative unit.
#
# Script By:      Jose Don T De Alban
# Date Created:   10 May 2019
# Last Modified:  

# Set Working Directory -------------------
setwd("/Users/dondealban/Dropbox/Research/myanmar/3 mmr land cover transitions/mangroves/gross and net/")

# Load Libraries --------------------------
library(reshape2)
library(dplyr)

# Read Input Data -------------------------
dfRAW <- read.csv(file="ForR_Data_Split-Stacked-Area-Plots.csv", header=TRUE, sep=",")

# Reorganise Data -------------------------
mDATA <- melt(dfRAW, id=c('TimePoint','Change')) # requires reshape2 package
colnames(mDATA) <- c("TimePoint","Change","Region","AreaSqKm2")

# Subset Data -----------------------------
# pipes require dplyr package
dfMMR <- mDATA %>% filter(Region %in% "Myanmar")
dfAYE <- mDATA %>% filter(Region %in% "Ayeyarwady")
dfBAG <- mDATA %>% filter(Region %in% "Bago")
dfMON <- mDATA %>% filter(Region %in% "Mon")
dfRAK <- mDATA %>% filter(Region %in% "Rakhine")
dfTNI <- mDATA %>% filter(Region %in% "Tanintharyi")
dfYGN <- mDATA %>% filter(Region %in% "Yangon")
