# Script Description ----------------------
# This is a test R script for visualising category level intensity analysis results.
#
# Script By:      Jose Don T De Alban
# Date Created:   13 Mar 2018
# Last Modified:  

# Set Working Directory -------------------

setwd("/Users/dondealban/Dropbox/Research/myanmar/intensity analysis/barplots/esa cci/tanintharyi/set 01 again/")

# Load Libraries --------------------------

library(tidyverse)
library(readxl)
library(ggplot2)
library(plyr)
library(tidyr)

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

# 3. Note the following description of category level column names
# ColA - Interval
# ColB - Category Name
# ColC - Change Type
# ColD - Observed Annual Loss/Gain [number of elements]
# ColE - Loss/Gain Intensity [percent of t1/t2 category]
# ColF - Uniform Intensity [percent of interval domain]
# ColG - Uniform Annual Loss/Gain [number of elements]
# ColH - Hypothesized Annual Error [number of elements]
# ColI - Commission Intensity [percent of t1/t2 category]
# ColJ - Omission Intensity [percent of t1/t2 category]
# ColK - Hypothesized t1/t2 Error [percent of interval domain]

# 3. Change column names
list <- c("ColA","ColB","ColC","ColD","ColE","ColF","ColG","ColH","ColI","ColJ")
colnames(dfL) <- c(list)
colnames(dfG) <- c(list)



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
plotCAT <- ggplot() + geom_bar(data=dfCAT, aes(x=Category, y=Gain.Intensity, fill="#8acd66"), stat="identity")
plotCAT <- plotCAT  + geom_bar(data=dfCAT, aes(x=Category, y=Loss.Intensity, fill="#b43507"), stat="identity")
plotCAT <- plotCAT  + geom_hline(data=dfCAT, aes(yintercept=Uni.Intensity, colour="#000000"), linetype="dashed") # Uniform line
plotCAT <- plotCAT  + facet_wrap(~ Year)
plotCAT <- plotCAT  + labs(title="Category Intensity Analysis: 1992-2015", 
                           x="Category", y="Category Intensity (% of Category, x 100)")
plotCAT <- plotCAT  + scale_x_discrete(labels=c("Crp","For","Non","Oth"))
plotCAT <- plotCAT  + scale_fill_manual(values=c("#8acd66","#b43507"), name="Change Direction", labels = c("Category Gain","Category Loss"))
plotCAT <- plotCAT  + scale_colour_manual(values=c("#000000"), name="Uniform Line", labels = c("Uniform Line"))
plotCAT <- plotCAT  + theme_minimal()