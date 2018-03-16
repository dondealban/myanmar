# Script Description ----------------------
# This R script generates barplots using ggplot2 package to visualise the transition level
# intensity analysis of changes between 6 land cover types derived from ESA CCI land
# cover data (1992-2015) covering Tanintharyi, Myanmar. The original land cover classes
# were reclassified/aggregated into six classes: Forest (FOR), Mosaic Vegetation (MOS),
# Shrubland (SHB), Other Vegetation (OTH), Cropland (CRP), and Non-Vegetation (NON). 
# Intensity analysis was calculated using an Excel spreadsheet with a VBA macro (see 
# https://sites.google.com/site/intensityanalysis/) and the 24 annual ESA CCI land cover
# data layers. The domain of the analysis is thelandscape extent within the Tanintharyi
# Region, Myanmar.
#
# Specifically, the land cover transitions of interest are: loss from forest into all 
# other classes, and gain of these other individual classes from forest.
#
# Script By:      Jose Don T De Alban
# Date Created:   13 Mar 2018
# Last Modified:  16 Mar 2018

# Set Working Directory -------------------

setwd("/Users/dondealban/Dropbox/Research/myanmar/intensity analysis/barplots/esa cci/tanintharyi/set 01 again/")

# Load Libraries --------------------------

library(tidyverse)
library(ggplot2)
library(readxl)

# Read Input Data -------------------------

# 1. Read specific Excel sheets for transition level intensity analysis
xlsxFOR <- read_excel("TNI_IntensityAnalysis_TransitionLevel.xlsx", sheet="FROM_FOR")
xlsxMOS <- read_excel("TNI_IntensityAnalysis_TransitionLevel.xlsx", sheet="TO_MOS")
xlsxSHB <- read_excel("TNI_IntensityAnalysis_TransitionLevel.xlsx", sheet="TO_SHB")
xlsxOTH <- read_excel("TNI_IntensityAnalysis_TransitionLevel.xlsx", sheet="TO_OTH")
xlsxCRP <- read_excel("TNI_IntensityAnalysis_TransitionLevel.xlsx", sheet="TO_CRP")
xlsxNON <- read_excel("TNI_IntensityAnalysis_TransitionLevel.xlsx", sheet="TO_NON")

# 2. Write dataframes to CSV files... 
write.csv(xlsxFOR, "Transition_Level_FROM_FOR.csv")
write.csv(xlsxMOS, "Transition_Level_TO_MOS.csv")
write.csv(xlsxSHB, "Transition_Level_TO_SHB.csv")
write.csv(xlsxOTH, "Transition_Level_TO_OTH.csv")
write.csv(xlsxCRP, "Transition_Level_TO_CRP.csv")
write.csv(xlsxNON, "Transition_Level_TO_NON.csv")

# 3 ...and then read CSV files into variables
csvFOR <- read.csv(file="Transition_Level_FROM_FOR.csv", header=TRUE, sep=",")
csvMOS <- read.csv(file="Transition_Level_TO_MOS.csv", header=TRUE, sep=",")
csvSHB <- read.csv(file="Transition_Level_TO_SHB.csv", header=TRUE, sep=",")
csvOTH <- read.csv(file="Transition_Level_TO_OTH.csv", header=TRUE, sep=",")
csvCRP <- read.csv(file="Transition_Level_TO_CRP.csv", header=TRUE, sep=",")
csvNON <- read.csv(file="Transition_Level_TO_NON.csv", header=TRUE, sep=",")

# Clean and Subset Data -------------------

# 1. Select columns: include all columns except first column
dfFOR <- subset(csvFOR, select=c(2:12))
dfMOS <- subset(csvMOS, select=c(2:12))
dfSHB <- subset(csvSHB, select=c(2:12))
dfOTH <- subset(csvOTH, select=c(2:12))
dfCRP <- subset(csvCRP, select=c(2:12))
dfNON <- subset(csvNON, select=c(2:12))

# 2. Replace character in Time Interval column
dfFOR$Interval. <- gsub('_', '-', dfFOR$Interval.)
dfMOS$Interval. <- gsub('_', '-', dfMOS$Interval.)
dfSHB$Interval. <- gsub('_', '-', dfSHB$Interval.)
dfOTH$Interval. <- gsub('_', '-', dfOTH$Interval.)
dfCRP$Interval. <- gsub('_', '-', dfCRP$Interval.)
dfNON$Interval. <- gsub('_', '-', dfNON$Interval.)

# 3. Reorder columns of 'TO class' transitions before renaming
dfMOS <- dfMOS[,c(1,3,2,4:11)]
dfSHB <- dfSHB[,c(1,3,2,4:11)]
dfOTH <- dfOTH[,c(1,3,2,4:11)]
dfCRP <- dfCRP[,c(1,3,2,4:11)]
dfNON <- dfNON[,c(1,3,2,4:11)]

# 4. Change column names for easier reference

# Note the following description of category level column names
# ColA - Years of Time Interval
# ColB - Category Name From
# ColC - Category Name To
# ColD - Observed Annual Transition [number of elements]
# ColE - Transition Intensity [percent of t1/t2 category]
# ColF - Uniform Intensity [percent of t1/t2 non-category]
# ColG - Uniform Annual Transition [number of elements]
# ColH - Hypothesized Annual Error [number of elements]
# ColI - Commission Intensity [percent of transition]
# ColJ - Omission Intensity [percent of transition]
# ColK - Hypothesized t1/t2 Error [percent of interval domain]

list <- c("ColA","ColB","ColC","ColD","ColE","ColF","ColG","ColH","ColI","ColJ","ColK")
colnames(dfFOR) <- c(list)
colnames(dfMOS) <- c(list)
colnames(dfSHB) <- c(list)
colnames(dfOTH) <- c(list)
colnames(dfCRP) <- c(list)
colnames(dfNON) <- c(list)

# Generate Plots ------------------------

# Plot 1: FROM FOREST transition level
plotFOR <- ggplot() + geom_bar(data=dfFOR, aes(x=ColC, y=ColE, fill="#c6c3bf"), stat="identity")
plotCAT <- plotCAT  + geom_hline(data=dfCAT, aes(yintercept=ColG, colour="#000000"), linetype="dashed") # Uniform line
plotCAT <- plotCAT  + facet_wrap(~ColB)
plotCAT <- plotCAT  + labs(x="Category", y="Category Intensity (% of Category)")
plotCAT <- plotCAT  + scale_x_discrete(labels=c("CRP","FOR","MOS","NON","OTH","SHB"))
plotCAT <- plotCAT  + scale_fill_manual(values=c("#b43507","#8acd66"), labels=c("Loss Intensity","Gain Intensity"))
plotCAT <- plotCAT  + scale_colour_manual(values=c("#000000"), labels=c("Uniform Line"))
plotCAT <- plotCAT  + theme(panel.grid.minor=element_blank())
plotCAT <- plotCAT  + theme(legend.title=element_blank(), legend.position=c(0.8,0.1), legend.box="horizontal")

# Plot 2: Loss Intensity only
plotL <- ggplot() + geom_bar(data=dfL, aes(x=ColC, y=ColF, fill=ColD), stat="identity")
plotL <- plotL + geom_hline(data=dfL, aes(yintercept=ColG, colour="#000000"), linetype="dashed") # Uniform line
plotL <- plotL + facet_wrap(~ColB)
plotL <- plotL + labs(x="Category", y="Category Intensity (% of Category)")
plotL <- plotL + scale_x_discrete(labels=c("CRP","FOR","MOS","NON","OTH","SHB"))
plotL <- plotL + scale_fill_manual(values=c("#b43507"), name="", labels=c("Loss Intensity"))
plotL <- plotL + scale_colour_manual(values=c("#000000"), name="", labels=c("Uniform Line"))
plotL <- plotL + theme(panel.grid.minor=element_blank(), legend.position=c(0.8,0.1), legend.box="horizontal")

# Plot 3: Gain Intensity only
plotG <- ggplot() + geom_bar(data=dfG, aes(x=ColC, y=ColF, fill=ColD), stat="identity")
plotG <- plotG + geom_hline(data=dfG, aes(yintercept=ColG, colour="#000000"), linetype="dashed") # Uniform line
plotG <- plotG + facet_wrap(~ColB)
plotG <- plotG + labs(x="Category", y="Category Intensity (% of Category)")
plotG <- plotG + scale_x_discrete(labels=c("CRP","FOR","MOS","NON","OTH","SHB"))
plotG <- plotG + scale_fill_manual(values=c("#8acd66"), name="", labels=c("Gain Intensity"))
plotG <- plotG + scale_colour_manual(values=c("#000000"), name="", labels=c("Uniform Line"))
plotG <- plotG + theme(panel.grid.minor=element_blank(), legend.position=c(0.8,0.1), legend.box="horizontal")

# Save Outputs --------------------------

# Output boxplots to a PDF file
ggsave(plotCAT, file="IntensityAnalysis-Category-LossGain.pdf", width=29.89, height=25, units="cm", dpi=300)
ggsave(plotL,   file="IntensityAnalysis-Category-Loss.pdf", width=29.89, height=25, units="cm", dpi=300)
ggsave(plotG,   file="IntensityAnalysis-Category-Gain.pdf", width=29.89, height=25, units="cm", dpi=300)

# Export dataframe to CSV file
write.csv(dfCAT, file="Category_Level.csv")
