# Script Description --------------------
# This R script generates barplots using ggplot2 package to visualise the interval-level
# intensity analysis of mangrove cover changes in selected coastal regions of Myanmar,
# derived from land cover classification of combined Landsat and L-band SAR data for two
# time-intervals: 1996-2007 and 2007-2016. Intensity analysis was calculated using an 
# Excel spreadsheet with a VBA macro (see https://sites.google.com/site/intensityanalysis/).
#
# Script By:      Jose Don T De Alban
# Date Created:   25 Apr 2017
# Last Modified:  04 Dec 2018

# Set Working Directory -------------------
setwd("/Users/dondealban/Dropbox/Research/myanmar/3 mmr land cover transitions/mangroves")

# Load Libraries --------------------------
library(tidyverse)
library(readxl)

# Read Input Data -------------------------

# Read interval level XLSX data file
xlsxAYE <- read_excel("1_IA_Ayeyarwady.xlsx", sheet="Interval_Level")
xlsxBAG <- read_excel("2_IA_Bago.xlsx", sheet="Interval_Level")
xlsxMON <- read_excel("9_IA_Mon.xlsx", sheet="Interval_Level")
xlsxRAK <- read_excel("11_IA_Rakhine.xlsx", sheet="Interval_Level")
xlsxTNI <- read_excel("14_IA_Tanintharyi.xlsx", sheet="Interval_Level")
xlsxYGN <- read_excel("15_IA_Yangon.xlsx", sheet="Interval_Level")

# Clean and Subset Data -------------------

# Remove first row with unnecessary header name 
tempAYE <- xlsxAYE[-c(1),] %>% write_csv("Interval_Level_Ayeyarwady.csv")
tempBAG <- xlsxBAG[-c(1),] %>% write_csv("Interval_Level_Bago.csv")
tempMON <- xlsxMON[-c(1),] %>% write_csv("Interval_Level_Mon.csv")
tempRAK <- xlsxRAK[-c(1),] %>% write_csv("Interval_Level_Rakhine.csv")
tempTNI <- xlsxTNI[-c(1),] %>% write_csv("Interval_Level_Tanintharyi.csv")
tempYGN <- xlsxYGN[-c(1),] %>% write_csv("Interval_Level_Yangon.csv")

# And save and then read CSV file
csvAYE <- read.csv(file="Interval_Level_Ayeyarwady.csv", header=TRUE, sep=",")
csvBAG <- read.csv(file="Interval_Level_Bago.csv", header=TRUE, sep=",")
csvMON <- read.csv(file="Interval_Level_Mon.csv", header=TRUE, sep=",")
csvRAK <- read.csv(file="Interval_Level_Rakhine.csv", header=TRUE, sep=",")
csvTNI <- read.csv(file="Interval_Level_Tanintharyi.csv", header=TRUE, sep=",")
csvYGN <- read.csv(file="Interval_Level_Yangon.csv", header=TRUE, sep=",")

# Add new column with site name
csvAYE$Site <- c("Ayeyarwady")
csvBAG$Site <- c("Bago")
csvMON$Site <- c("Mon")
csvRAK$Site <- c("Rakhine")
csvTNI$Site <- c("Tanintharyi")
csvYGN$Site <- c("Yangon")

# Combine data frames
csvINT <- rbind(csvMINDR, csvARMNP, csvMCWS, csvMIBNP, csvNLNP)

# Rename column names
colnames(csvINT) <- c("Time.Interval","Obs.Change","Ann.Change","Uni.Ann.Change",
                      "Uni.Change","Hypo.Error","Comm.Intensity","Om.Intensity","Site") 

# Select columns: time interval, observed change rate, uniform change rate, site
dfINT <- subset(csvINT, select=c(1,3:4,9))
dfINT$Time.Interval <- gsub('_', '-', dfINT$Time.Interval) # Replace character in column
#dfINT[,3] <- as.numeric(dfINT[,3]) # Change column to numeric class
#uINT <- dfINT$Uni.Change[1] # Store uniform intensity value as constant in a variable

# Generate Plots ------------------------

# Interval-level intensity analysis plot for all domains for both intervals
plotINT <- ggplot() + geom_bar(data=dfINT, aes(x=Time.Interval, y=Ann.Change, fill="#c6c3bf"), stat="identity", position=position_dodge())
plotINT <- plotINT  + geom_hline(data=dfINT, aes(yintercept=Uni.Ann.Change, colour="#000000"), linetype="dashed") # Uniform line
plotINT <- plotINT  + facet_wrap(~Site)
plotINT <- plotINT  + labs(x="Time Interval", y="Annual Change (% of Map)")
plotINT <- plotINT  + scale_fill_manual(values=c("#c6c3bf"), name="", labels = c("Observed Change"))
plotINT <- plotINT  + scale_colour_manual(values=c("#000000"), labels=c("Uniform Intensity"))
plotINT <- plotINT  + theme(legend.title=element_blank(), legend.position=c(0.85,0.2), legend.box="vertical")
plotINT <- plotINT  + theme(panel.grid.minor=element_blank())

# Save Output Plots -----------------------

# Output boxplots to a PDF file
ggsave(plotINT, file="Mindoro-Interval-Level-Intensity-Analysis.pdf", width=19.89, height=15, units="cm", dpi=300)

