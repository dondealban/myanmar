# This script generates plots from the results of the Weights-of-Evidence (WoE) method
# implemented in DINAMICA EGO to assess the association of various spatial determinants
# (e.g., biophysical and socio-economic variables) with the transitions of agricultural
# expansion of major crop commodities (i.e., oil palm, rubber, rice) in Tanintharyi 
# Region, Myanmar.
# 
# Script by:      Jose Don T. De Alban
# Date created:   18 May 2020
# Date modified:  11 Jun 2020   


# Load Libraries -------------------------
library(tidyverse)

# Set Working Directories ----------------
DirMAIN  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/"
DirDATA  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 1/plots/"
DirOPMI1 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 1/opm/c_1996_2007/step03/"
DirOPMI2 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 1/opm/c_2007_2016/step03/"

# Read Data Files ------------------------
# WoE data for oil palm
setwd(DirOPMI1)
dfOPMi1 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")
setwd(DirOPMI2)
dfOPMi2 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")

# Extract Data Subsets -------------------

# Replace character strings
dfOPMi1$Variable. <- gsub(".*/", "", dfOPMi1$Variable.)
dfOPMi2$Variable. <- gsub(".*/", "", dfOPMi2$Variable.)

# Generate Plots -------------------------

# Plot with transitions from all source land cover types
# WoE Contrast values: 1996-2007
pOPMi1con <- ggplot() + geom_line(data=dfOPMi1, aes(x=Range_Upper_Limit., y=Contrast, colour=as.factor(Transition_From.)))
pOPMi1con <- pOPMi1con + facet_wrap(~ Variable., scales="free")
pOPMi1con <- pOPMi1con + labs(title="Association of Spatial Determinants with Oil Palm Gain Transitions",
                              subtitle="Time-Interval: 1996-2007", x="Ranges", y="Contrast")
pOPMi1con <- pOPMi1con + scale_colour_manual(name="Source Land Cover",
                                             values=c("#246a24","#6666ff","#a65400","#ff00ff","#ccff66"),
                                             labels=c("Forest","Mangrove","Rice Paddy","Rubber","Shrub/Orchard"))
# WoE Contrast values: 2007-2016
pOPMi2con <- ggplot() + geom_line(data=dfOPMi2, aes(x=Range_Upper_Limit., y=Contrast, colour=as.factor(Transition_From.)))
pOPMi2con <- pOPMi2con + facet_wrap(~ Variable., scales="free")
pOPMi2con <- pOPMi2con + labs(title="Association of Spatial Determinants with Oil Palm Gain Transitions",
                              subtitle="Time-Interval: 2007-2016", x="Ranges", y="Contrast")
pOPMi2con <- pOPMi2con + scale_colour_manual(name="Source Land Cover",
                                             values=c("#246a24","#6666ff","#a65400","#ff00ff","#ccff66"),
                                             labels=c("Forest","Mangrove","Rice Paddy","Rubber","Shrub/Orchard"))
# WoE Coefficients: 1996-2007
pOPMi1woe <- ggplot() + geom_line(data=dfOPMi1, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=as.factor(Transition_From.)))
pOPMi1woe <- pOPMi1woe + facet_wrap(~ Variable., scales="free")
pOPMi1woe <- pOPMi1woe + labs(title="Association of Spatial Determinants with Oil Palm Gain Transitions",
                              subtitle="Time-Interval: 1996-2007", x="Ranges", y="Weights-of-Evidence Coefficients")
pOPMi1woe <- pOPMi1woe + scale_colour_manual(name="Source Land Cover",
                                             values=c("#246a24","#6666ff","#a65400","#ff00ff","#ccff66"),
                                             labels=c("Forest","Mangrove","Rice Paddy","Rubber","Shrub/Orchard"))
# WoE Coefficients: 2007-2016
pOPMi2woe <- ggplot() + geom_line(data=dfOPMi2, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=as.factor(Transition_From.)))
pOPMi2woe <- pOPMi2woe + facet_wrap(~ Variable., scales="free")
pOPMi2woe <- pOPMi2woe + labs(title="Association of Spatial Determinants with Oil Palm Gain Transitions",
                              subtitle="Time-Interval: 2007-2016", x="Ranges", y="Weights-of-Evidence Coefficients")
pOPMi2woe <- pOPMi2woe + scale_colour_manual(name="Source Land Cover",
                                             values=c("#246a24","#6666ff","#a65400","#ff00ff","#ccff66"),
                                             labels=c("Forest","Mangrove","Rice Paddy","Rubber","Shrub/Orchard"))

