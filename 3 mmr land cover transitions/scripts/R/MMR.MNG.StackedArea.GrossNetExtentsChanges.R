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
library(ggplot2)

# Read Input Data -------------------------
dfRAW <- read.csv(file="ForR_Data_Split-Stacked-Area-Plots.csv", header=TRUE, sep=",")

# Reorganise Data -------------------------
mDATA <- melt(dfRAW, id=c('TimePoint','Change')) # requires reshape2 package
colnames(mDATA) <- c("TimePoint","Change","Region","AreaSqKm")

# Subset Data -----------------------------
# pipes require dplyr package
dfMMR <- mDATA %>% filter(Region %in% "Myanmar")
dfAYE <- mDATA %>% filter(Region %in% "Ayeyarwady")
dfBAG <- mDATA %>% filter(Region %in% "Bago")
dfMON <- mDATA %>% filter(Region %in% "Mon")
dfRAK <- mDATA %>% filter(Region %in% "Rakhine")
dfTNI <- mDATA %>% filter(Region %in% "Tanintharyi")
dfYGN <- mDATA %>% filter(Region %in% "Yangon")

# Define Plots ----------------------------

# Plot #1: Myanmar
plot1 <- ggplot() + geom_area(aes(x=TimePoint, y=AreaSqKm, fill=factor(Change,
                                  labels=c("Persistence",
                                           "Gross Loss",
                                           "Gross Gain",
                                           "Net Loss"))), 
                                  data=dfMMR)
plot1 <- plot1 + labs(title="Myanmar", x="Year", y="Area (sq.km)")
plot1 <- plot1 + guides(fill=guide_legend(ncol=1))
plot1 <- plot1 + theme_bw()
plot1 <- plot1 + scale_fill_manual(values=c("#ff0000","#246a24","#a6cee3","#6666ff"))
plot1 <- plot1 + scale_x_continuous(breaks=c(1996,2007,2016))