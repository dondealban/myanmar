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
dfTNIg <- as.data.frame(read_excel("Category_Level_Intensity_Analysis.xlsx", sheet="Gain_YGN"))
dfTNIl <- as.data.frame(read_excel("Category_Level_Intensity_Analysis.xlsx", sheet="Loss_YGN"))

# Clean and Subset Data -------------------

# 1. Select columns: include all columns except Category ID
subMINDRg <- subset(dfMINDRg, select=c(1,3:11))
subMINDRl <- subset(dfMINDRl, select=c(1,3:11))
subMCWSg  <- subset(dfMCWSg, select=c(1,3:11))
subMCWSl  <- subset(dfMCWSl, select=c(1,3:11))
subMIBNPg <- subset(dfMIBNPg, select=c(1,3:11)) 
subMIBNPl <- subset(dfMIBNPl, select=c(1,3:11))
subNLNPg  <- subset(dfNLNPg, select=c(1,3:11)) 
subNLNPl  <- subset(dfNLNPl, select=c(1,3:11))

# *Remove classes: MNG, BUA, WTR for this domain of analysis
# Mts Iglit-Baco National Park
remove.list1 <- paste(c("MNG","BUA","WTR"), collapse='|')
subMIBNPg <- subMIBNPg %>% filter(!grepl(remove.list1, subMIBNPg$Category_Name))
subMIBNPl <- subMIBNPl %>% filter(!grepl(remove.list1, subMIBNPl$Category_Name))
# Naujan Lake National Park
remove.list2 <- paste(c("GRA","BUA","ERK"), collapse='|')
subNLNPg <- subNLNPg %>% filter(!grepl(remove.list2, subNLNPg$Category_Name))
subNLNPl <- subNLNPl %>% filter(!grepl(remove.list2, subNLNPl$Category_Name))

# 2. Add Change Type column
# Mindoro Island
type1a <- rep("Gain", nrow(subMINDRg))
type2a <- rep("Loss", nrow(subMINDRl))
site1a <- rep("Mindoro Island", nrow(subMINDRg))
site2a <- rep("Mindoro Island", nrow(subMINDRl))
subMINDRg <- cbind(subMINDRg, type1a, site1a)
subMINDRl <- cbind(subMINDRl, type2a, site2a)
# Mt Calavite Wildlife Sanctuary
type1b <- rep("Gain", nrow(subMCWSg))
type2b <- rep("Loss", nrow(subMCWSl))
site1b <- rep("PA MCWS", nrow(subMCWSg))
site2b <- rep("PA MCWS", nrow(subMCWSl))
subMCWSg <- cbind(subMCWSg, type1b, site1b)
subMCWSl <- cbind(subMCWSl, type2b, site2b)
# Mts Iglit-Baco National Park
type1c <- rep("Gain", nrow(subMIBNPg))
type2c <- rep("Loss", nrow(subMIBNPl))
site1c <- rep("PA MIBNP", nrow(subMIBNPg))
site2c <- rep("PA MIBNP", nrow(subMIBNPl))
subMIBNPg <- cbind(subMIBNPg, type1c, site1c)
subMIBNPl <- cbind(subMIBNPl, type2c, site2c)
# Naujan Lake National Park
type1d <- rep("Gain", nrow(subNLNPg))
type2d <- rep("Loss", nrow(subNLNPl))
site1d <- rep("PA NLNP", nrow(subNLNPg))
site2d <- rep("PA NLNP", nrow(subNLNPl))
subNLNPg <- cbind(subNLNPg, type1d, site1d)
subNLNPl <- cbind(subNLNPl, type2d, site2d)

# 3. Reorder columns before renaming
subMINDRg <- subMINDRg[,c(1:2,11,12,3:10)]
subMINDRl <- subMINDRl[,c(1:2,11,12,3:10)]
subMCWSg  <- subMCWSg[,c(1:2,11,12,3:10)]
subMCWSl  <- subMCWSl[,c(1:2,11,12,3:10)]
subMIBNPg <- subMIBNPg[,c(1:2,11,12,3:10)]
subMIBNPl <- subMIBNPl[,c(1:2,11,12,3:10)]
subNLNPg  <- subNLNPg[,c(1:2,11,12,3:10)]
subNLNPl  <- subNLNPl[,c(1:2,11,12,3:10)]

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
colnames(subMINDRg) <- c(list)
colnames(subMINDRl) <- c(list)
colnames(subMCWSg)  <- c(list)
colnames(subMCWSl)  <- c(list)
colnames(subMIBNPg) <- c(list)
colnames(subMIBNPl) <- c(list)
colnames(subNLNPg)  <- c(list)
colnames(subNLNPl)  <- c(list)

# 6. Combine separate Loss and Gain datasets into one dataframe
catALL <- rbind(subMINDRg, subMINDRl, subMCWSg, subMCWSl, subMIBNPg, subMIBNPl, subNLNPg, subNLNPl)

# 7. Replace "Undefined" cells as 0 and convert ColF and ColK to numeric data types
#catALL[catALL=="Undefined"] <- 0
catALL <- transform(catALL, ColF = as.numeric(ColF), ColK = as.numeric(ColK))

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
ggsave(plotCAT, file="Category-Level-Intensity-Analysis_Mindoro.pdf", width=25, height=25, units="cm", dpi=300)
