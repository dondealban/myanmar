# This script generates plots from the results of the Weights-of-Evidence (WoE) method
# implemented in DINAMICA EGO to assess the association of various spatial determinants
# (e.g., biophysical and socio-economic variables) with the transitions of agricultural
# expansion of major crop commodities (i.e., oil palm, rubber, rice) in Tanintharyi 
# Region, Myanmar.
# 
# Script by:      Jose Don T. De Alban
# Date created:   18 Jun 2020
# Date modified:     


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
csvOPMi1 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")
setwd(DirOPMI2)
csvOPMi2 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")
setwd(DirRBRI1)
csvRBRi1 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")
setwd(DirRBRI2)
csvRBRi2 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")
setwd(DirRPDI1)
csvRPDi1 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")
setwd(DirRPDI2)
csvRPDi2 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")

# Clean and Extract Data Subsets ---------

# Replace character strings
csvOPMi1$Variable. <- gsub(".*/", "", csvOPMi1$Variable.)
csvOPMi2$Variable. <- gsub(".*/", "", csvOPMi2$Variable.)
csvRBRi1$Variable. <- gsub(".*/", "", csvRBRi1$Variable.)
csvRBRi2$Variable. <- gsub(".*/", "", csvRBRi2$Variable.)
csvRPDi1$Variable. <- gsub(".*/", "", csvRPDi1$Variable.)
csvRPDi2$Variable. <- gsub(".*/", "", csvRPDi2$Variable.)
# Remove rows in dataframes that satisfy conditions
dfOPMi1 <- csvOPMi1 %>% filter(!(Significant == 0))
dfOPMi2 <- csvOPMi2 %>% filter(!(Significant == 0))
dfRBRi1 <- csvRBRi1 %>% filter(!(Significant == 0))
dfRBRi2 <- csvRBRi2 %>% filter(!(Significant == 0))
dfRPDi1 <- csvRPDi1 %>% filter(!(Significant == 0))
dfRPDi2 <- csvRPDi2 %>% filter(!(Significant == 0))
# Add column for commodity type per time-interval for dataframes
commodity <- rep("OPM", nrow(dfOPMi1))
  dfOPMi1 <- cbind(dfOPMi1, commodity)
commodity <- rep("OPM", nrow(dfOPMi2))
  dfOPMi2 <- cbind(dfOPMi2, commodity)
commodity <- rep("RBR", nrow(dfRBRi1))
  dfRBRi1 <- cbind(dfRBRi1, commodity)
commodity <- rep("RBR", nrow(dfRBRi2))
  dfRBRi2 <- cbind(dfRBRi2, commodity)
commodity <- rep("RPD", nrow(dfRPDi1))
  dfRPDi1 <- cbind(dfRPDi1, commodity)
commodity <- rep("RPD", nrow(dfRPDi2))
  dfRPDi2 <- cbind(dfRPDi2, commodity)
# Combine dataframes per time-interval
dfI1 <- rbind(dfOPMi1, dfRPDi1, dfRBRi1)
dfI2 <- rbind(dfOPMi2, dfRPDi2, dfRBRi2)
# Add column for time-intervals
colT1 <- rep("1996-2007", nrow(dfI1))
colT2 <- rep("2007-2016", nrow(dfI2))
# Add time-interval column for dataframes
dfALLi1 <- cbind(dfI1, colT1)
dfALLi2 <- cbind(dfI2, colT2)
# Rename column names
names <- c("TransitionFrom","TransitionTo","Variable","RangeLowerLimit","RangeUpperLimit","PossibleTransitions",
          "ExecutedTransitions","WeightCoefficient","Contrast","Significant","X","Commodity","TimeInterval")
colnames(dfALLi1) <- c(names)
colnames(dfALLi2) <- c(names)
# Combine all dataframes into one omnibus dataframe
dfALL <- rbind(dfALLi1, dfALLi2)
# Extract data subset (distance to commodity variables)
dfSUB <- dfALL %>% filter(Variable %in% c("distance_to_5","distance_to_6","distance_to_7"))

# Generate Plots -------------------------

# Plot distance to commodity weights per commodity gain transitions for both time-intervals
plotSUB <- ggplot() + geom_line(data=dfSUB, aes(x=RangeLowerLimit, y=Contrast, colour=as.factor(TransitionFrom)))
plotSUB <- plotSUB + facet_grid(Commodity ~ TimeInterval)
plotSUB <- plotSUB + labs(title="Weights-of-Evidence (Contrast) of Commodity Gain Transitions",
                          x="Distance to Previously Established Plantation (in meters)", y="Contrast")
plotSUB <- plotSUB + scale_colour_manual(name="Source Land Cover",
                                         values=c("#246a24","#6666ff","#ff8000","#a65400","#ff00ff","#ccff66"),
                                         labels=c("Forest","Mangrove","Oil Palm","Rice Paddy","Rubber","Shrub/Orchard"))

# Save Output Plots ----------------------
setwd(DirPLOT)
ggsave(plotSUB, file="TNI_WoE-Contrast_DistToCommodity_I1-I2_AllTransitions.pdf", width=25, height=15, units="cm", dpi=300)
