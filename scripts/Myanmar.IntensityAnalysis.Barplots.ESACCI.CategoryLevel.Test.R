# Script Description ----------------------
# This is a test R script for visualising category level intensity analysis results.
#
# Script By:      Jose Don T De Alban
# Date Created:   13 Mar 2018
# Last Modified:  14 Mar 2018

# Set Working Directory -------------------

setwd("/Users/dondealban/Dropbox/Research/myanmar/intensity analysis/barplots/esa cci/tanintharyi/set 01 again/")

# Load Libraries --------------------------

library(ggplot2)
library(plyr)

# Read Input Data -------------------------

dataCATl <- read.csv(file="Category_Level_Losses.csv", header=TRUE, sep=",")
dataCATg <- read.csv(file="Category_Level_Gains.csv", header=TRUE, sep=",")

# Clean and Subset Data -------------------

# 1. Select columns: include all columns except Category ID
dfL <- subset(dataCATl, select=c(1,3:11))
dfG <- subset(dataCATg, select=c(1,3:11))

# 2. Add Change Type column
type1 <- rep("Loss", nrow(dfL))
type2 <- rep("Gain", nrow(dfG))
dfL <- cbind(dfL, type1)
dfG <- cbind(dfG, type2)

# 3. Add years of interval in the dataframe
# Create lookup table
Interval. <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)
Year <- c("1992-1993","1993-1994","1994-1995","1995-1996","1996-1997","1997-1998",
          "1998-1999","1999-2000","2000-2001","2001-2002","2002-2003","2003-2004",
          "2004-2005","2005-2006","2006-2007","2007-2008","2008-2009","2009-2010",
          "2010-2011","2011-2012","2012-2013","2013-2014","2014-2015")
lookup <- as.data.frame(cbind(Interval.,Year), stringsAsFactors=FALSE)

# Match time interval with year in new column based on lookup table 
dfL <- join(dfL, lookup, by='Interval.') # Need plyr package
dfG <- join(dfG, lookup, by='Interval.')

# 4. Reorder columns before renaming
dfL <- dfL[,c(1,12,2,11,3:10)]
dfG <- dfG[,c(1,12,2,11,3:10)]

# 5. Change column names for easier reference

# Note the following description of category level column names
# ColA - Interval
# ColB - Years of Time Interval
# ColC - Category Name
# ColD - Change Type
# ColE - Observed Annual Loss/Gain [number of elements]
# ColF - Loss/Gain Intensity [percent of t1/t2 category]
# ColG - Uniform Intensity [percent of interval domain]
# ColH - Uniform Annual Loss/Gain [number of elements]
# ColI - Hypothesized Annual Error [number of elements]
# ColJ - Commission Intensity [percent of t1/t2 category]
# ColK - Omission Intensity [percent of t1/t2 category]
# ColL - Hypothesized t1/t2 Error [percent of interval domain]

list <- c("ColA","ColB","ColC","ColD","ColE","ColF","ColG","ColH","ColI","ColJ","ColK","ColL")
colnames(dfL) <- c(list)
colnames(dfG) <- c(list)

# 6. Combine separate Loss and Gain datasets into one dataframe
dfCAT <- rbind(dfL, dfG)

# Generate Plots ------------------------

# Plot 1: Gain and Loss Intensities only
plotCAT <- ggplot() + geom_bar(data=dfCAT, aes(x=ColC, y=ColF, fill=ColD), stat="identity", position=position_dodge())
plotCAT <- plotCAT  + geom_hline(data=dfCAT, aes(yintercept=ColG, colour="#000000"), linetype="dashed") # Uniform line
plotCAT <- plotCAT  + facet_wrap(~ColB)
plotCAT <- plotCAT  + labs(x="Category", y="Category Intensity (% of Category)")
plotCAT <- plotCAT  + scale_x_discrete(labels=c("CRP","FOR","MOS","NON","OTH","SHB"))
plotCAT <- plotCAT  + scale_fill_manual(values=c("#8acd66","#b43507"), name="Intensity", labels=c("Gain","Loss"))
plotCAT <- plotCAT  + scale_colour_manual(values=c("#000000"), name="", labels=c("Uniform Line"))
plotCAT <- plotCAT  + theme_light() + theme(panel.grid.minor=element_blank())

# Plot 2: Loss Intensity only
plotL <- ggplot() + geom_bar(data=dfL, aes(x=ColC, y=ColF, fill=ColD), stat="identity")
plotL <- plotL + geom_hline(data=dfL, aes(yintercept=ColG, colour="#000000"), linetype="dashed") # Uniform line
plotL <- plotL + facet_wrap(~ColB)
plotL <- plotL + labs(x="Category", y="Category Intensity (% of Category)")
plotL <- plotL + scale_x_discrete(labels=c("CRP","FOR","MOS","NON","OTH","SHB"))
plotL <- plotL + scale_fill_manual(values=c("#b43507"), name="Intensity", labels=c("Loss"))
plotL <- plotL + scale_colour_manual(values=c("#000000"), name="", labels=c("Uniform Line"))
plotL <- plotL + theme(panel.grid.minor=element_blank())

# Plot 3: Gain Intensity only
plotG <- ggplot() + geom_bar(data=dfG, aes(x=ColC, y=ColF, fill=ColD), stat="identity")
plotG <- plotG + geom_hline(data=dfG, aes(yintercept=ColG, colour="#000000"), linetype="dashed") # Uniform line
plotG <- plotG + facet_wrap(~ColB)
plotG <- plotG + labs(x="Category", y="Category Intensity (% of Category)")
plotG <- plotG + scale_x_discrete(labels=c("CRP","FOR","MOS","NON","OTH","SHB"))
plotG <- plotG + scale_fill_manual(values=c("#8acd66"), name="Intensity", labels=c("Gain"))
plotG <- plotG + scale_colour_manual(values=c("#000000"), name="", labels=c("Uniform Line"))
plotG <- plotG + theme(panel.grid.minor=element_blank())
plotG <- plotG + scale_y_log10()


# Plot 4: 
plotLE <- ggplot() + geom_bar(data=dfG, aes(x=ColC, y=ColF, fill=ColD), stat="identity")
plotLE <- plotLE + geom_bar(data=dfL, aes(x=ColC, y=-ColF), stat="identity", position=position_dodge())
plotLE <- plotLE + geom_hline(data=dfG, aes(yintercept=ColG, colour="#000000"), linetype="dashed") # Uniform line
plotLE <- plotLE + geom_hline(data=dfL, aes(yintercept=-ColG, colour="#000000"), linetype="dashed") # Uniform line
plotLE <- plotLE + facet_wrap(~ColB)
plotLE <- plotLE + labs(x="Category", y="Category Intensity (% of Category)")
plotLE <- plotLE + scale_x_discrete(labels=c("CRP","FOR","MOS","NON","OTH","SHB"))
plotLE <- plotLE + scale_fill_manual(values=c("#8acd66","#b43507"), name="", labels=c("Gain Intensity","Loss Intensity"))
plotLE <- plotLE + scale_colour_manual(values=c("#000000","#000000"), name="", labels=c("Uniform Line"))
plotLE <- plotLE + theme(panel.grid.minor=element_blank())
