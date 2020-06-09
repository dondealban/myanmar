# This script generates plots from the results of the Weights-of-Evidence (WoE) method
# implemented in DINAMICA EGO to assess the association of various spatial determinants
# (e.g., biophysical and socio-economic variables) with the transitions of agricultural
# expansion of major crop commodities (i.e., oil palm, rubber, rice) in Tanintharyi 
# Region, Myanmar.
# 
# Script by:      Jose Don T. De Alban
# Date created:   18 May 2020
# Date modified:  09 Jun 2020   


# Load Libraries -------------------------
library(tidyverse)

# Set Working Directories ----------------
DirMAIN  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/"
DirDATA  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/"
DirOPMI1 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/opm/c_1996_2007/step03/"
DirOPMI2 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/opm/c_2007_2016/step03/"
DirRBRI1 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/rbr/c_1996_2007/step03/"
DirRBRI2 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/rbr/c_2007_2016/step03/"
DirRPDI1 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/rpd/c_1996_2007/step03/"
DirRPDI2 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/rpd/c_2007_2016/step03/"

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

# Plot with transitions from all source land cover types
# WoE Contrast values: 1996-2007
pOPMi1con <- ggplot() + geom_line(data=dfOPMi1, aes(x=Range_Lower_Limit., y=Contrast, colour=as.factor(Transition_From.)))
pOPMi1con <- pOPMi1con + facet_wrap(~ Variable., scales="free")
pOPMi1con <- pOPMi1con + labs(title="Association of Spatial Determinants with Oil Palm Gain Transitions",
                              subtitle="Time-Interval: 1996-2007", x="Ranges", y="Contrast")
pOPMi1con <- pOPMi1con + scale_colour_manual(name="Source Land Cover",
                                             values=c("#246a24","#6666ff","#a65400","#ff00ff","#ccff66"),
                                             labels=c("Forest","Mangrove","Rice Paddy","Rubber","Shrub/Orchard"))
# WoE Contrast values: 2007-2016
pOPMi2con <- ggplot() + geom_line(data=dfOPMi2, aes(x=Range_Lower_Limit., y=Contrast, colour=as.factor(Transition_From.)))
pOPMi2con <- pOPMi2con + facet_wrap(~ Variable., scales="free")
pOPMi2con <- pOPMi2con + labs(title="Association of Spatial Determinants with Oil Palm Gain Transitions",
                              subtitle="Time-Interval: 2007-2016", x="Ranges", y="Contrast")
pOPMi2con <- pOPMi2con + scale_colour_manual(name="Source Land Cover",
                                             values=c("#246a24","#6666ff","#a65400","#ff00ff","#ccff66"),
                                             labels=c("Forest","Mangrove","Rice Paddy","Rubber","Shrub/Orchard"))
# WoE Coefficients: 1996-2007
pOPMi1woe <- ggplot() + geom_line(data=dfOPMi1, aes(x=Range_Lower_Limit., y=Weight_Coefficient, colour=as.factor(Transition_From.)))
pOPMi1woe <- pOPMi1woe + facet_wrap(~ Variable., scales="free")
pOPMi1woe <- pOPMi1woe + labs(title="Association of Spatial Determinants with Oil Palm Gain Transitions",
                              subtitle="Time-Interval: 1996-2007", x="Ranges", y="Weights-of-Evidence Coefficients")
pOPMi1woe <- pOPMi1woe + scale_colour_manual(name="Source Land Cover",
                                             values=c("#246a24","#6666ff","#a65400","#ff00ff","#ccff66"),
                                             labels=c("Forest","Mangrove","Rice Paddy","Rubber","Shrub/Orchard"))
# WoE Coefficients: 2007-2016
pOPMi2woe <- ggplot() + geom_line(data=dfOPMi2, aes(x=Range_Lower_Limit., y=Weight_Coefficient, colour=as.factor(Transition_From.)))
pOPMi2woe <- pOPMi2woe + facet_wrap(~ Variable., scales="free")
pOPMi2woe <- pOPMi2woe + labs(title="Association of Spatial Determinants with Oil Palm Gain Transitions",
                              subtitle="Time-Interval: 2007-2016", x="Ranges", y="Weights-of-Evidence Coefficients")
pOPMi2woe <- pOPMi2woe + scale_colour_manual(name="Source Land Cover",
                                             values=c("#246a24","#6666ff","#a65400","#ff00ff","#ccff66"),
                                             labels=c("Forest","Mangrove","Rice Paddy","Rubber","Shrub/Orchard"))

# Plot with transition from one source land cover type only
plotLN <- ggplot() + geom_line(data=dfFOR1, aes(x=Range_Lower_Limit., y=Contrast))
plotLN <- plotLN + facet_wrap(~ Variable., scales="free_x")
plotPT <- ggplot() + geom_point(data=dfFOR1, aes(x=Range_Lower_Limit., y=Contrast))
plotPT <- plotPT + facet_wrap(~ Variable., scales="free_x")
