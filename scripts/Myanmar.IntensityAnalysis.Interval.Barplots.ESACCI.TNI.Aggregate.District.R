# Script Description --------------------
# This R script generates barplots using ggplot2 package to visualise the interval level
# intensity analysis of changes between 6 land cover types derived from ESA CCI land
# cover data (1992-2015) covering Tanintharyi, Myanmar. The original land cover classes
# were reclassified/aggregated into six classes: Forest (FOR), Mosaic Vegetation (MOS),
# Shrubland (SHB), Other Vegetation (OTH), Cropland (CRP), and Non-Vegetation (NON). 
# Intensity analysis was calculated using an Excel spreadsheet with a VBA macro (see 
# https://sites.google.com/site/intensityanalysis/) and the 24 annual ESA CCI land cover
# data layers. The domain of the analysis is thelandscape extent within the Tanintharyi
# Region, Myanmar.
#
# Script By:      Jose Don T De Alban
# Date Created:   25 Apr 2017
# Last Modified:  24 Jun 2018

# Set Working Directory -------------------

setwd("/Users/dondealban/Dropbox/Research/myanmar/intensity analysis/barplots/esa cci/tanintharyi/set 01 again/")

# Load Libraries --------------------------

library(tidyverse)
library(readxl)
library(ggplot2)
library(plyr)
library(tidyr)

# Read Input Data -------------------------

# Read interval level XLSX data file
xlsxINT  <- read_excel("TNI_IntensityAnalysis.xlsx", sheet="Interval_Level")

# Clean and Subset Data -------------------

# Remove first row with unnecessary header name, and save and then read CSV file
xlsxINT <- xlsxINT[-c(1),] %>% write_csv("Interval_Level.csv")
csvINT <- read.csv(file="Interval_Level.csv", header=TRUE, sep=",")

# Rename column names
colnames(csvINT) <- c("Time.Interval","Obs.Change","Ann.Change","Uni.Ann.Change",
                      "Uni.Change","Hypo.Error","Comm.Intensity","Om.Intensity") 

# Select columns: time interval, observed change rate, uniform change rate
dfINT <- subset(csvINT, select=c(1:2,5))
dfINT$Time.Interval <- gsub('_', '-', dfINT$Time.Interval) # Replace character in column
dfINT[,3] <- as.numeric(dfINT[,3]) # Change column to numeric class
uINT <- dfINT$Uni.Change[1] # Store uniform intensity value as constant in a variable

# Generate Plots --------------------------

# Interval Level
plotINT <- ggplot() + geom_bar(data=dfINT, aes(x=Time.Interval, y=Obs.Change, fill="#c6c3bf"),  stat="identity")
plotINT <- plotINT  + geom_hline(yintercept=0, colour="grey90")
plotINT <- plotINT  + geom_hline(aes(yintercept=uINT, colour="#000000"), linetype="dashed") # uniform line
plotINT <- plotINT  + labs(x="Time Interval", y="Observed Change (% of Map)")
plotINT <- plotINT  + scale_fill_manual(values=c("#c6c3bf"), name="", labels = c("Observed Change"))
plotINT <- plotINT  + scale_colour_manual(values=c("#000000"), name="", labels = c("Uniform Line"))
plotINT <- plotINT  + scale_x_discrete(breaks=c("1992-1993","1997-1998","2001-2002","2004-2005","2009-2010","2014-2015"))
plotINT <- plotINT  + theme_light()

# Save Output Plots -----------------------

# Output boxplots to a PDF file
ggsave(plotINT, file="IntensityAnalysis-Interval-Set01.pdf", width=19.89, height=15, units="cm", dpi=300)
