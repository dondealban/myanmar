# This script generates plots from the results of the Weights-of-Evidence (WoE) method
# implemented in DINAMICA EGO to assess the association of various spatial determinants
# (e.g., biophysical and socio-economic variables) with the transitions of agricultural
# expansion of major crop commodities (i.e., oil palm, rubber, rice) in Tanintharyi 
# Region, Myanmar.
# 
# Script by:      Jose Don T. De Alban
# Date created:   18 May 2020
# Date modified:  21 May 2020   


# Load Libraries -------------------------
library(tidyverse)

# Set Working Directories ----------------
MainDir  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/"
DataDir  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/"
DirOPMI1 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/opm/c_1996_2007/step03/"
DirOPMI2 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/opm/c_2007_2016/step03/"

# Read Data Files ------------------------
# WoE data for oil palm
setwd(DirOPMI1)
dfOPMI1 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")
setwd(DirOPMI2)
dfOPMI2 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")

# Extract Data Subsets -------------------
# dfFOR <- subset(dfOPMI1, dfOPMI1$Transition_From.=="3")
dfFOR1 <- dfOPMI1 %>% filter(dfOPMI1$Transition_From. %in% "3")

# Generate Plots -------------------------

# Plot with transition from one source land cover type only
plotLN <- ggplot() + geom_line(data=dfFOR, aes(x=Range_Lower_Limit., y=Contrast))
plotLN <- plotLN + facet_wrap(~ Variable., scales="free_x")
plotPT <- ggplot() + geom_point(data=dfFOR, aes(x=Range_Lower_Limit., y=Contrast))
plotPT <- plotPT + facet_wrap(~ Variable., scales="free_x")


# Plot with transitions from all source land cover types
# Contrast values
pOPMI1con <- ggplot() + geom_line(data=dfOPMI1, aes(x=Range_Lower_Limit., y=Contrast, colour=as.factor(Transition_From.)))
pOPMI1con <- pOPMI1con + facet_wrap(~ Variable., scales="free")

pOPMI2con <- ggplot() + geom_line(data=dfOPMI2, aes(x=Range_Lower_Limit., y=Contrast, colour=as.factor(Transition_From.)))
pOPMI2con <- pOPMI2con + facet_wrap(~ Variable., scales="free")


# WoE coefficients
pOPMI1woe <- ggplot() + geom_line(data=dfOPMI1, aes(x=Range_Lower_Limit., y=Weight_Coefficient, colour=as.factor(Transition_From.)))
pOPMI1woe <- pOPMI1woe + facet_wrap(~ Variable., scales="free")

pOPMI2woe <- ggplot() + geom_line(data=dfOPMI2, aes(x=Range_Lower_Limit., y=Weight_Coefficient, colour=as.factor(Transition_From.)))
pOPMI2woe <- pOPMI2woe + facet_wrap(~ Variable., scales="free")

# Tests
#plotSet2 <- plotSet2 + labs(title="Observed vs Simulated Map Similarity", 
#                            subtitle="Moving 3-year time interval from 1992 to 2015",
#                            x="Window Size", y="% Similarity (x 100)")
#plotSet2 <- plotSet2 + scale_colour_manual(values=c("#264d73","#b3cce6"), name="Similarity", labels = c("Maximum","Minimum"))
#plotSet2 <- plotSet2 + theme_light()
