# Script Description --------------------
# This R script generates barplots using ggplot2 package to visualise the interval-level
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

# Read interval level XLSX data file, convert to data frame, and store into variable
dfAYEg <- as.data.frame(read_excel("Category_Level_Intensity_Analysis.xlsx", sheet="Gain_AYE"))
dfAYEl <- as.data.frame(read_excel("Category_Level_Intensity_Analysis.xlsx", sheet="Loss_AYE"))
dfBAGg <- as.data.frame(read_excel("Category_Level_Intensity_Analysis.xlsx", sheet="Gain_BAG"))
dfBAGl <- as.data.frame(read_excel("Category_Level_Intensity_Analysis.xlsx", sheet="Loss_BAG"))
dfMONg <- as.data.frame(read_excel("Category_Level_Intensity_Analysis.xlsx", sheet="Gain_MON"))
dfMONl <- as.data.frame(read_excel("Category_Level_Intensity_Analysis.xlsx", sheet="Loss_MON"))
dfRAKg <- as.data.frame(read_excel("Category_Level_Intensity_Analysis.xlsx", sheet="Gain_RAK"))
dfRAKl <- as.data.frame(read_excel("Category_Level_Intensity_Analysis.xlsx", sheet="Loss_RAK"))
dfTNIg <- as.data.frame(read_excel("Category_Level_Intensity_Analysis.xlsx", sheet="Gain_TNI"))
dfTNIl <- as.data.frame(read_excel("Category_Level_Intensity_Analysis.xlsx", sheet="Loss_TNI"))
dfYGNg <- as.data.frame(read_excel("Category_Level_Intensity_Analysis.xlsx", sheet="Gain_YGN"))
dfYGNl <- as.data.frame(read_excel("Category_Level_Intensity_Analysis.xlsx", sheet="Loss_YGN"))

# Clean and Subset Data -------------------

# 1. Select columns: include all columns except Category ID
subAYEg <- subset(dfAYEg, select=c(1,3:11))
subAYEl <- subset(dfAYEl, select=c(1,3:11))
subBAGg <- subset(dfBAGg, select=c(1,3:11))
subBAGl <- subset(dfBAGl, select=c(1,3:11))
subMONg <- subset(dfMONg, select=c(1,3:11)) 
subMONl <- subset(dfMONl, select=c(1,3:11))
subRAKg <- subset(dfRAKg, select=c(1,3:11)) 
subRAKl <- subset(dfRAKl, select=c(1,3:11))
subTNIg <- subset(dfTNIg, select=c(1,3:11)) 
subTNIl <- subset(dfTNIl, select=c(1,3:11))
subYGNg <- subset(dfYGNg, select=c(1,3:11)) 
subYGNl <- subset(dfYGNl, select=c(1,3:11))

# 2. Add Change Type and Site Name column
# Ayeyarwady
type1a <- rep("Gain", nrow(subAYEg))
type2a <- rep("Loss", nrow(subAYEl))
site1a <- rep("Ayeyarwady", nrow(subAYEg))
site2a <- rep("Ayeyarwady", nrow(subAYEl))
subAYEg <- cbind(subAYEg, type1a, site1a)
subAYEl <- cbind(subAYEl, type2a, site2a)
# Bago
type1b <- rep("Gain", nrow(subBAGg))
type2b <- rep("Loss", nrow(subBAGl))
site1b <- rep("Bago", nrow(subBAGg))
site2b <- rep("Bago", nrow(subBAGl))
subBAGg <- cbind(subBAGg, type1b, site1b)
subBAGl <- cbind(subBAGl, type2b, site2b)
# Mon
type1c <- rep("Gain", nrow(subMONg))
type2c <- rep("Loss", nrow(subMONl))
site1c <- rep("Mon", nrow(subMONg))
site2c <- rep("Mon", nrow(subMONl))
subMONg <- cbind(subMONg, type1c, site1c)
subMONl <- cbind(subMONl, type2c, site2c)
# Rakhine
type1d <- rep("Gain", nrow(subRAKg))
type2d <- rep("Loss", nrow(subRAKl))
site1d <- rep("Rakhine", nrow(subRAKg))
site2d <- rep("Rakhine", nrow(subRAKl))
subRAKg <- cbind(subRAKg, type1d, site1d)
subRAKl <- cbind(subRAKl, type2d, site2d)
# Tanintharyi
type1e <- rep("Gain", nrow(subTNIg))
type2e <- rep("Loss", nrow(subTNIl))
site1e <- rep("Tanintharyi", nrow(subTNIg))
site2e <- rep("Tanintharyi", nrow(subTNIl))
subTNIg <- cbind(subTNIg, type1e, site1e)
subTNIl <- cbind(subTNIl, type2e, site2e)
# Yangon
type1f <- rep("Gain", nrow(subYGNg))
type2f <- rep("Loss", nrow(subYGNl))
site1f <- rep("Yangon", nrow(subYGNg))
site2f <- rep("Yangon", nrow(subYGNl))
subYGNg <- cbind(subYGNg, type1f, site1f)
subYGNl <- cbind(subYGNl, type2f, site2f)

# 3. Reorder columns before renaming
subAYEg <- subAYEg[,c(1:2,11,12,3:10)]
subAYEl <- subAYEl[,c(1:2,11,12,3:10)]
subBAGg <- subBAGg[,c(1:2,11,12,3:10)]
subBAGl <- subBAGl[,c(1:2,11,12,3:10)]
subMONg <- subMONg[,c(1:2,11,12,3:10)]
subMONl <- subMONl[,c(1:2,11,12,3:10)]
subRAKg <- subRAKg[,c(1:2,11,12,3:10)]
subRAKl <- subRAKl[,c(1:2,11,12,3:10)]
subTNIg <- subTNIg[,c(1:2,11,12,3:10)]
subTNIl <- subTNIl[,c(1:2,11,12,3:10)]
subYGNg <- subYGNg[,c(1:2,11,12,3:10)]
subYGNl <- subYGNl[,c(1:2,11,12,3:10)]

# 4. Change column names for easier reference
# Note the following description of category level column names
# ColA - Years of Time Interval
# ColB - Category Name
# ColC - Change Type
# ColD - Study Area/Site
# ColE - Observed Annual Loss/Gain [number of elements]
# ColF - Loss/Gain Intensity [percent of t1/t2 category]
# ColG - Uniform Intensity [percent of interval domain]
# ColH - Uniform Annual Loss/Gain [number of elements]
# ColI - Hypothesized Annual Error [number of elements]
# ColJ - Commission Intensity [percent of t1/t2 category]
# ColK - Omission Intensity [percent of t1/t2 category]
# ColL - Hypothesized t1/t2 Error [percent of interval domain]

list <- c("ColA","ColB","ColC","ColD","ColE","ColF","ColG","ColH","ColI","ColJ","ColK","ColL")
colnames(subAYEg) <- c(list)
colnames(subAYEl) <- c(list)
colnames(subBAGg) <- c(list)
colnames(subBAGl) <- c(list)
colnames(subMONg) <- c(list)
colnames(subMONl) <- c(list)
colnames(subRAKg) <- c(list)
colnames(subRAKl) <- c(list)
colnames(subTNIg) <- c(list)
colnames(subTNIl) <- c(list)
colnames(subYGNg) <- c(list)
colnames(subYGNl) <- c(list)

# 6. Combine separate Loss and Gain datasets into one dataframe
catALL <- rbind(subAYEg, subAYEl, subBAGg, subBAGl, subMONg, subMONl, subRAKg, subRAKl, subTNIg, subTNIl, subYGNg, subYGNl)

# 7. Replace "Undefined" cells as 0 and convert ColF and ColK to numeric data types
#catALL[catALL=="Undefined"] <- 0
#catALL <- transform(catALL, ColF = as.numeric(ColF), ColK = as.numeric(ColK))

# Generate Plots ------------------------

# Plot 1: Gain and Loss Intensities only
plotCAT <- ggplot() + geom_bar(data=catALL, aes(x=ColB, y=ColF, fill=ColC), stat="identity", position=position_dodge())
plotCAT <- plotCAT  + geom_hline(data=catALL, aes(yintercept=ColG, colour="#000000"), linetype="dashed") # Uniform line
plotCAT <- plotCAT  + facet_grid(ColD ~ ColA, scales="free_y")
plotCAT <- plotCAT  + labs(x="Category", y="Category Intensity (% of Category)")
plotCAT <- plotCAT  + scale_fill_manual(values=c("#8acd66","#b43507"), labels=c("Gain Intensity","Loss Intensity"))
plotCAT <- plotCAT  + scale_colour_manual(values=c("#000000"), labels=c("Uniform Intensity"))
plotCAT <- plotCAT  + theme(panel.grid.minor=element_blank())
plotCAT <- plotCAT  + theme(legend.position="bottom", legend.box="horizontal", legend.title=element_blank())

# Save Outputs --------------------------

# Output boxplots to a PDF file
ggsave(plotCAT, file="Category-Level-Intensity-Analysis-Mangroves.pdf", width=20, height=25, units="cm", dpi=300)
