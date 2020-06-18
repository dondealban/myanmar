# This script generates plots from the results of the Weights-of-Evidence (WoE) method
# implemented in DINAMICA EGO to assess the association of various spatial determinants
# (e.g., biophysical and socio-economic variables) with the transitions of agricultural
# expansion of major crop commodities (i.e., oil palm, rubber, rice) in Tanintharyi 
# Region, Myanmar.
# 
# Script by:      Jose Don T. De Alban
# Date created:   18 May 2020
# Date modified:  18 Jun 2020   


# Load Libraries -------------------------
library(tidyverse)

# Set Working Directories ----------------
DirMAIN  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/"
DirPLOT  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/plots/"
DirOPMI1 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/opm/c_1996_2007/step03/"
DirOPMI2 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/opm/c_2007_2016/step03/"
DirRBRI1 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/rbr/c_1996_2007/step03/"
DirRBRI2 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/rbr/c_2007_2016/step03/"
DirRPDI1 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/rpd/c_1996_2007/step03/"
DirRPDI2 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/rpd/c_2007_2016/step03/"

# Read Data Files ------------------------
# WoE data for oil palm
setwd(DirOPMI1)
dfOPMi1 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")
setwd(DirOPMI2)
dfOPMi2 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")
setwd(DirRBRI1)
dfRBRi1 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")
setwd(DirRBRI2)
dfRBRi2 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")
setwd(DirRPDI1)
dfRPDi1 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")
setwd(DirRPDI2)
dfRPDi2 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")

# Clean and Extract Data Subsets ---------

# Replace character strings
dfOPMi1$Variable. <- gsub(".*/", "", dfOPMi1$Variable.)
dfOPMi2$Variable. <- gsub(".*/", "", dfOPMi2$Variable.)
dfRBRi1$Variable. <- gsub(".*/", "", dfRBRi1$Variable.)
dfRBRi2$Variable. <- gsub(".*/", "", dfRBRi2$Variable.)
dfRPDi1$Variable. <- gsub(".*/", "", dfRPDi1$Variable.)
dfRPDi2$Variable. <- gsub(".*/", "", dfRPDi2$Variable.)
# Combine dataframes per time-interval
dfI1 <- rbind(dfOPMi1, dfRPDi1, dfRBRi1)
dfI2 <- rbind(dfOPMi2, dfRPDi2, dfRBRi2)
#Add column for time-intervals
colT1 <- rep("1996-2007", nrow(dfI1))
colT2 <- rep("2007-2016", nrow(dfI2))
# Add time-interval column for dataframes
dfALLi1 <- cbind(dfI1, colT1)
dfALLi2 <- cbind(dfI2, colT2)
# Rename column names
names <- c("TransitionFrom","TransitionTo","Variable","RangeLowerLimit","RangeUpperLimit",
          "PossibleTransitions","ExecutedTransitions","WeightCoefficient","Contrast","Significant","X","TimeInterval")
colnames(dfALLi1) <- c(names)
colnames(dfALLi2) <- c(names)
# Combine all dataframes into one omnibus dataframe
dfALL <- rbind(dfALLi1, dfALLi2)
# Extract data subset (distance to commodity variables)
dfSUB <- dfALL %>% filter(Variable %in% c("distance_to_5","distance_to_6","distance_to_7"))

# Generate Plots -------------------------

# Plot distance to commodity weights per commodity gain transitions for both time-intervals
plotSUB <- ggplot() + geom_line(data=dfSUB, aes(x=RangeLowerLimit, y=Contrast, colour=as.factor(TransitionFrom)))
plotSUB <- plotSUB + facet_grid(TransitionTo ~ TimeInterval, scales="free_x")
plotSUB <- plotSUB + labs(title="Weights-of-Evidence (Contrast) of Commodity Gain Transitions",
                          x="Distance to Commodity (in meters)", y="Contrast")
plotSUB <- plotSUB + scale_colour_manual(name="Source Land Cover",
                                         values=c("#246a24","#6666ff","#ff8000","#a65400","#ff00ff","#ccff66"),
                                         labels=c("Forest","Mangrove","Oil Palm","Rice Paddy","Rubber","Shrub/Orchard"))
