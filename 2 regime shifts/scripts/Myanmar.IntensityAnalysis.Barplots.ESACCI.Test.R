# Script Description --------------------
# This R script generates barplots using ggplot2 package to visualise the results of
# intensity analysis of changes between 4 land cover types derived from ESA CCI land
# cover data (1992-2015) covering Tanintharyi, Myanmar. The original land cover classes
# were reclassified into four bespoke classes: Forest (FOR), Other Vegetation (VEG),
# Cropland (CRP), and Non-Forest (NON).
#
# Intensity analysis was calculated using Dinamica EGO platform using the 24 annual 
# ESA CCI land cover data layers. The domain of the analysis is the landscape extent
# within the following coordinates: 97 to 100 deg E longitude; 9 to 16 deg N latitude.
#
# Script By:      Jose Don T De Alban
# Date Created:   25 Apr 2017
# Last Modified:  01 Dec 2017


# Set Working Directory -----------------
setwd("/Users/dondealban/Dropbox/Research/myanmar/intensity analysis/barplots/esa cci/tanintharyi/test/")

# Load Libraries ------------------------
#library(dplyr)
library(ggplot2)
library(plyr)
#library(reshape2)
library(tidyr)


# INTERVAL Level ------------------------

# Read CSV data file
dataINT <- read.csv(file="Interval_level.csv", header=TRUE, sep=",")

# Select columns: interval number, annual change rate, uniform change rate
dfI <- subset(dataINT, select=c(1:2,4:5))
colnames(dfI) <- c("Interval","Int.Length","Ann.Change","Uni.Change") # Rename column names

# Insert rows for missing intervals (Note: 1992 to 2015 = 24 years)
tmin = 1
tmax = 23
dfINT <- complete(dfI, nesting(Int.Length), Interval=seq(min(tmin), max(tmax), 1L))
dfINT <- replace_na(dfINT, list(Ann.Change=0, Uni.Change=dfINT[3,4]))
dfINT$Years <- c("1992-1993","1993-1994","1994-1995","1995-1996",
                 "1996-1997","1997-1998","1998-1999","1999-2000",
                 "2000-2001","2001-2002","2002-2003","2003-2004",
                 "2004-2005","2005-2006","2006-2007","2007-2008",
                 "2008-2009","2009-2010","2010-2011","2011-2012",
                 "2012-2013","2013-2014","2014-2015")
dfINT <- as.data.frame(dfINT)
uINT <- dfINT[[1,4]]


# CATEGORY Level ------------------------

# Read CSV data file
dataCATl <- read.csv(file="Categorical_level_loss.csv", header=TRUE, sep=",")
dataCATg <- read.csv(file="Categorical_level_gain.csv", header=TRUE, sep=",")

# Select columns from loss and gain of categories

# Select columns: interval number, category, annual loss and gain change rate, uniform change rate
dfL <- subset(dataCATl, select=c(1:3,5))
dfG <- subset(dataCATg, select=c(5:6))
colnames(dfL) <- c("Interval","Cat.Code","Category","Loss.Intensity") # Rename column names
colnames(dfG) <- c("Gain.Intensity","Uni.Intensity") # Rename column names
dfCAT <- cbind(dfL, dfG)

# Create lookup table
Interval <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)
Year <- c("1992-1993","1993-1994","1994-1995","1995-1996","1996-1997","1997-1998",
          "1998-1999","1999-2000","2000-2001","2001-2002","2002-2003","2003-2004",
          "2004-2005","2005-2006","2006-2007","2007-2008","2008-2009","2009-2010",
          "2010-2011","2011-2012","2012-2013","2013-2014","2014-2015")
lookup <- as.data.frame(cbind(Interval,Year), stringsAsFactors=FALSE)

# Match time interval with year in new column based on lookup table 
dfCAT <- join(dfCAT, lookup, by='Interval')


# Generate Plots ------------------------

# Interval Level
plotINT <- ggplot() + geom_bar(data=dfINT, aes(x=Years, y=Ann.Change, fill="#c6c3bf"),  stat="identity")
plotINT <- plotINT  + geom_hline(yintercept=0, colour="grey90")
plotINT <- plotINT  + geom_hline(aes(yintercept=uINT, colour="#000000"), linetype="dashed") # uniform line
plotINT <- plotINT  + labs(title="Time Intensity Analysis: 1992-2015", x="Time Interval", y="Annual Change (% of Map)")
plotINT <- plotINT  + scale_fill_manual(values=c("#c6c3bf"), name="", labels = c("Annual Change"))
plotINT <- plotINT  + scale_colour_manual(values=c("#000000"), name="", labels = c("Uniform Line"))
plotINT <- plotINT  + scale_x_discrete(breaks=c("1992-1993","1997-1998","2001-2002","2004-2005","2014-2015"))
plotINT <- plotINT  + theme_minimal()

# Category Level
plotCAT <- ggplot() + geom_bar(data=dfCAT, aes(x=Category, y=Gain.Intensity, fill="#8acd66"), stat="identity")
plotCAT <- plotCAT  + geom_bar(data=dfCAT, aes(x=Category, y=-Loss.Intensity, fill="#b43507"), stat="identity")
plotCAT <- plotCAT  + geom_hline(data=dfCAT, aes(yintercept=Uni.Intensity, colour="#009404"), linetype="dashed") # Uniform line
plotCAT <- plotCAT  + geom_hline(data=dfCAT, aes(yintercept=-Uni.Intensity, colour="#ff0000"), linetype="dashed") # Uniform line
plotCAT <- plotCAT  + facet_wrap(~ Year)
plotCAT <- plotCAT  + labs(title="Category Intensity Analysis: 1992-2015", 
                           x="Category", y="Category Intensity (% of Category)")
plotCAT <- plotCAT  + scale_x_discrete(labels=c("Crp","For","Non","Oth"))
plotCAT <- plotCAT  + scale_fill_manual(values=c("#8acd66","#b43507"), name="Change Direction", labels = c("Category Gain","Category Loss"))
plotCAT <- plotCAT  + scale_colour_manual(values=c("#009404", "#ff0000"), name="Uniform Line", labels = c("Gain", "Loss"))
plotCAT <- plotCAT  + theme_light()


# Save Output Plots ---------------------

# Output boxplots to a PDF file
ggsave(plotINT, file="IntensityAnalysis-Interval.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(plotCAT, file="IntensityAnalysis-Category.pdf", width=19.89, height=15, units="cm", dpi=300)

