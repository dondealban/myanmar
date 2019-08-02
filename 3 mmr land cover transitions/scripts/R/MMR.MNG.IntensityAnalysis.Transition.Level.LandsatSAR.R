# Script Description --------------------
# This R script generates barplots using ggplot2 package to visualise the transition-level
# intensity analysis of mangrove cover changes in selected coastal regions of Myanmar,
# derived from land cover classification of combined Landsat and L-band SAR data for two
# time-intervals: 1996-2007 and 2007-2016. Intensity analysis was calculated using an 
# Excel spreadsheet with a VBA macro (see https://sites.google.com/site/intensityanalysis/).
#
# Script By:      Jose Don T De Alban
# Date Created:   13 Mar 2018
# Last Modified:  02 Aug 2019

# Set Working Directory -------------------
setwd("/Users/dondealban/Dropbox/Research/myanmar/3 mmr land cover transitions/mangroves/intensity analysis/macros/")

# Load Libraries --------------------------
library(tidyverse)
library(readxl)

# Read Input Data -------------------------

# Read transition level XLSX data file, convert to data frame, and store into variable
rawG <- as.data.frame(read_excel("Transition_Level_Intensity_Analysis.xlsx", sheet="MNG_Gain"))
rawL <- as.data.frame(read_excel("Transition_Level_Intensity_Analysis.xlsx", sheet="MNG_Loss"))

# Clean and Subset Data -------------------

# 1. Add Change Type column
type1 <- rep("Gain", nrow(rawG))
type2 <- rep("Loss", nrow(rawL))
dfG <- cbind(rawG, type1)
dfL <- cbind(rawL, type2)

# 2. Reorder columns before renaming
dfGain <- dfG[,c(1:2,12,3:11)]
dfLoss <- dfL[,c(1:2,12,3:11)]

# 3. Change column names for easier reference
# Note the following description of category level column names
# ColA - Years of Time Interval
# ColB - Study Area/Site
# ColC - Change Type
# ColD - Category Name
# ColE - Observed Annual Loss/Gain [number of elements]
# ColF - Loss/Gain Intensity [percent of t1/t2 category]
# ColG - Uniform Intensity [percent of t1/t2 to/from category]
# ColH - Uniform Annual Loss/Gain [number of elements]
# ColI - Hypothesized Annual Error [number of elements]
# ColJ - Commission Intensity [percent of t1/t2 transition]
# ColK - Omission Intensity [percent of t1/t2 transition]
# ColL - Hypothesized t1/t2 Error [percent of interval domain]

list <- c("ColA","ColB","ColC","ColD","ColE","ColF","ColG","ColH","ColI","ColJ","ColK","ColL")
colnames(dfGain) <- c(list)
colnames(dfLoss) <- c(list)

# Generate Plots ------------------------

# Plot 1: To N (Gain Transition)
plotG <- ggplot() + geom_bar(data=dfGain, aes(x=ColD, y=ColF, fill=ColC), stat="identity", position=position_dodge())
plotG <- plotG + geom_hline(data=dfGain, aes(yintercept=ColG, colour="#000000"), linetype="dashed") # Uniform line
plotG <- plotG + facet_grid(ColB ~ ColA, scales="free_y")
plotG <- plotG + labs(x="Losing Category", y="Annual Transition Intensity (% of Category at Initial Time)")
plotG <- plotG + scale_fill_manual(values=c("#4472c4"), labels=c("Gain Intensity"))
plotG <- plotG + scale_colour_manual(values=c("#000000"), labels=c("Uniform Intensity"))
plotG <- plotG + theme(panel.grid.minor=element_blank())
plotG <- plotG + theme(legend.position="bottom", legend.box="horizontal", legend.title=element_blank())

# Plot 2: From M (Loss Transition)
plotL <- ggplot() + geom_bar(data=dfLoss, aes(x=ColD, y=ColF, fill=ColC), stat="identity", position=position_dodge())
plotL <- plotL + geom_hline(data=dfLoss, aes(yintercept=ColG, colour="#000000"), linetype="dashed") # Uniform line
plotL <- plotL + facet_grid(ColB ~ ColA, scales="free_y")
plotL <- plotL + labs(x="Gaining Category", y="Annual Transition Intensity (% of Category at Final Time)")
plotL <- plotL + scale_fill_manual(values=c("#4472c4"), labels=c("Loss Intensity"))
plotL <- plotL + scale_colour_manual(values=c("#000000"), labels=c("Uniform Intensity"))
plotL <- plotL + theme(panel.grid.minor=element_blank())
plotL <- plotL + theme(legend.position="bottom", legend.box="horizontal", legend.title=element_blank())

# Save Outputs --------------------------

# Output boxplots to a PDF file
ggsave(plotG, file="Transition-Level-Intensity-Analysis-Mangroves-Gain.pdf", width=20, height=25, units="cm", dpi=300)
ggsave(plotL, file="Transition-Level-Intensity-Analysis-Mangroves-Loss.pdf", width=20, height=25, units="cm", dpi=300)
