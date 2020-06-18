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
dfOPMi2 <- csvOPMi2 %>% filter(!(Significant == 0 | Variable. == "D_DefoI1"))
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
# Extract data subset (distance to various instruments, including previously deforested areas)
dfINST <- dfALL %>% filter(Variable %in% c("D_ComF","D_KBA","D_OPC","D_PA","D_ResF"))
dfCOMF <- dfALL %>% filter(Variable %in% c("D_ComF"))
dfKBA  <- dfALL %>% filter(Variable %in% c("D_KBA"))
dfOPC  <- dfALL %>% filter(Variable %in% c("D_OPC"))
dfPA   <- dfALL %>% filter(Variable %in% c("D_PA"))
dfRESF <- dfALL %>% filter(Variable %in% c("D_ResF"))
dfDEFO <- dfALL %>% filter(Variable %in% c("D_DefoI1","D_DefoI2"))

# Generate Plots -------------------------

# Plot distance to Community Forests per commodity gain transitions for both time-intervals
plotCOMF <- ggplot() + geom_line(data=dfCOMF, aes(x=RangeLowerLimit, y=Contrast, colour=as.factor(TransitionFrom)))
plotCOMF <- plotCOMF + facet_grid(Commodity ~ TimeInterval)
plotCOMF <- plotCOMF + labs(title="Weights-of-Evidence (Contrast) of Commodity Gain Transitions",
                            subtitle="Distance to Community Forest Areas", x="Distance (meters)", y="Contrast")
plotCOMF <- plotCOMF + scale_colour_manual(name="Source Land Cover",
                                           values=c("#246a24","#6666ff","#ff8000","#a65400","#ff00ff","#ccff66"),
                                           labels=c("Forest","Mangrove","Oil Palm","Rice Paddy","Rubber","Shrub/Orchard"))

# Plot distance to Key Biodiversity Areas per commodity gain transitions for both time-intervals
plotKBA <- ggplot() + geom_line(data=dfKBA, aes(x=RangeLowerLimit, y=Contrast, colour=as.factor(TransitionFrom)))
plotKBA <- plotKBA + facet_grid(Commodity ~ TimeInterval)
plotKBA <- plotKBA + labs(title="Weights-of-Evidence (Contrast) of Commodity Gain Transitions",
                          subtitle="Distance to Key Biodiversity Areas", x="Distance (meters)", y="Contrast")
plotKBA <- plotKBA + scale_colour_manual(name="Source Land Cover",
                                         values=c("#246a24","#6666ff","#ff8000","#a65400","#ff00ff","#ccff66"),
                                         labels=c("Forest","Mangrove","Oil Palm","Rice Paddy","Rubber","Shrub/Orchard"))

# Plot distance to Oil Palm Concessions per commodity gain transitions for both time-intervals
plotOPC <- ggplot() + geom_line(data=dfOPC, aes(x=RangeLowerLimit, y=Contrast, colour=as.factor(TransitionFrom)))
plotOPC <- plotOPC + facet_grid(Commodity ~ TimeInterval)
plotOPC <- plotOPC + labs(title="Weights-of-Evidence (Contrast) of Commodity Gain Transitions",
                          subtitle="Distance to Oil Palm Concessions", x="Distance (meters)", y="Contrast")
plotOPC <- plotOPC + scale_colour_manual(name="Source Land Cover",
                                         values=c("#246a24","#6666ff","#ff8000","#a65400","#ff00ff","#ccff66"),
                                         labels=c("Forest","Mangrove","Oil Palm","Rice Paddy","Rubber","Shrub/Orchard"))


# Plot distance to Protected Areas per commodity gain transitions for both time-intervals
plotPA <- ggplot() + geom_line(data=dfPA, aes(x=RangeLowerLimit, y=Contrast, colour=as.factor(TransitionFrom)))
plotPA <- plotPA + facet_grid(Commodity ~ TimeInterval)
plotPA <- plotPA + labs(title="Weights-of-Evidence (Contrast) of Commodity Gain Transitions",
                        subtitle="Distance to Protected Areas", x="Distance (meters)", y="Contrast")
plotPA <- plotPA + scale_colour_manual(name="Source Land Cover",
                                       values=c("#246a24","#6666ff","#ff8000","#a65400","#ff00ff","#ccff66"),
                                       labels=c("Forest","Mangrove","Oil Palm","Rice Paddy","Rubber","Shrub/Orchard"))

# Plot distance to Reserved Forests per commodity gain transitions for both time-intervals
plotRESF <- ggplot() + geom_line(data=dfRESF, aes(x=RangeLowerLimit, y=Contrast, colour=as.factor(TransitionFrom)))
plotRESF <- plotRESF + facet_grid(Commodity ~ TimeInterval)
plotRESF <- plotRESF + labs(title="Weights-of-Evidence (Contrast) of Commodity Gain Transitions",
                            subtitle="Distance to Reserved Forest Areas", x="Distance (meters)", y="Contrast")
plotRESF <- plotRESF + scale_colour_manual(name="Source Land Cover",
                                           values=c("#246a24","#6666ff","#ff8000","#a65400","#ff00ff","#ccff66"),
                                           labels=c("Forest","Mangrove","Oil Palm","Rice Paddy","Rubber","Shrub/Orchard"))

# Plot distance to previously deforested areas per commodity gain transitions for both time-intervals
plotDEFO <- ggplot() + geom_line(data=dfDEFO, aes(x=RangeLowerLimit, y=Contrast, colour=as.factor(TransitionFrom)))
plotDEFO <- plotDEFO + facet_grid(Commodity ~ TimeInterval)
plotDEFO <- plotDEFO + labs(title="Weights-of-Evidence (Contrast) of Commodity Gain Transitions",
                            subtitle="Distance to Previously Deforested Areas", x="Distance (meters)", y="Contrast")
plotDEFO <- plotDEFO + scale_colour_manual(name="Source Land Cover",
                                           values=c("#ff8000","#a65400","#ff00ff","#ccff66"),
                                           labels=c("Oil Palm","Rice Paddy","Rubber","Shrub/Orchard"))


# Save Output Plots ----------------------
setwd(DirPLOT)
ggsave(plotCOMF, file="TNI_WoE-Contrast_DistToComF_I1-I2_AllTransitions.pdf", width=25, height=15, units="cm", dpi=300)
ggsave(plotKBA, file="TNI_WoE-Contrast_DistToKBA_I1-I2_AllTransitions.pdf", width=25, height=15, units="cm", dpi=300)
ggsave(plotOPC, file="TNI_WoE-Contrast_DistToOPC_I1-I2_AllTransitions.pdf", width=25, height=15, units="cm", dpi=300)
ggsave(plotPA, file="TNI_WoE-Contrast_DistToPA_I1-I2_AllTransitions.pdf", width=25, height=15, units="cm", dpi=300)
ggsave(plotRESF, file="TNI_WoE-Contrast_DistToResF_I1-I2_AllTransitions.pdf", width=25, height=15, units="cm", dpi=300)
ggsave(plotDEFO, file="TNI_WoE-Contrast_DistToPrevDefoAreas_I1-I2_AllTransitions.pdf", width=25, height=15, units="cm", dpi=300)
