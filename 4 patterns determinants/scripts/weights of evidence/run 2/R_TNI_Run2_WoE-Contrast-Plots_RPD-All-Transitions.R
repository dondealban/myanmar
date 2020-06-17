# This script generates plots from the results of the Weights-of-Evidence (WoE) method
# implemented in DINAMICA EGO to assess the association of various spatial determinants
# (e.g., biophysical and socio-economic variables) with the transitions of agricultural
# expansion of major crop commodities (i.e., oil palm, rubber, rice) in Tanintharyi 
# Region, Myanmar.
# 
# Script by:      Jose Don T. De Alban
# Date created:   17 Jun 2020
# Date modified:     


# Load Libraries -------------------------
library(tidyverse)

# Set Working Directories ----------------
DirMAIN  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/"
DirDATA  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/plots/"
DirRPDI1 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/rpd/c_1996_2007/step03/"
DirRPDI2 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/rpd/c_2007_2016/step03/"

# Read Data Files ------------------------
# WoE data for rice paddy
setwd(DirRPDI1)
csvRPDi1 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")
setwd(DirRPDI2)
csvRPDi2 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")

# Extract Data Subsets -------------------

# Replace character strings
csvRPDi1$Variable. <- gsub(".*/", "", csvRPDi1$Variable.)
csvRPDi2$Variable. <- gsub(".*/", "", csvRPDi2$Variable.)
# Remove rows in dataframes that satisfy conditions
dfRPDi1 <- csvRPDi1 %>% filter(!(Significant == 0))
dfRPDi2 <- csvRPDi2 %>% filter(!(Significant == 0))

# Generate Plots -------------------------

# Plot with transitions from all source land cover types
# WoE Contrast values: 1996-2007
pRPDi1con <- ggplot() + geom_line(data=dfRPDi1, aes(x=Range_Upper_Limit., y=Contrast, colour=as.factor(Transition_From.)))
pRPDi1con <- pRPDi1con + facet_wrap(~ Variable., scales="free")
pRPDi1con <- pRPDi1con + labs(title="Association of Spatial Determinants with Rubber Gain Transitions",
                              subtitle="Time-Interval: 1996-2007", x="Ranges", y="Contrast")
pRPDi1con <- pRPDi1con + scale_colour_manual(name="Source Land Cover",
                                             values=c("#246a24","#6666ff","#ff8000","#a65400","#ccff66"),
                                             labels=c("Forest","Mangrove","Oil Palm","Rice Paddy","Shrub/Orchard"))
# WoE Contrast values: 2007-2016
pRPDi2con <- ggplot() + geom_line(data=dfRPDi2, aes(x=Range_Upper_Limit., y=Contrast, colour=as.factor(Transition_From.)))
pRPDi2con <- pRPDi2con + facet_wrap(~ Variable., scales="free")
pRPDi2con <- pRPDi2con + labs(title="Association of Spatial Determinants with Rubber Gain Transitions",
                              subtitle="Time-Interval: 2007-2016", x="Ranges", y="Contrast")
pRPDi2con <- pRPDi2con + scale_colour_manual(name="Source Land Cover",
                                             values=c("#246a24","#6666ff","#ff8000","#a65400","#ccff66"),
                                             labels=c("Forest","Mangrove","Oil Palm","Rice Paddy","Shrub/Orchard"))
# WoE Coefficients: 1996-2007
pRPDi1woe <- ggplot() + geom_line(data=dfRPDi1, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=as.factor(Transition_From.)))
pRPDi1woe <- pRPDi1woe + facet_wrap(~ Variable., scales="free")
pRPDi1woe <- pRPDi1woe + labs(title="Association of Spatial Determinants with Rubber Gain Transitions",
                              subtitle="Time-Interval: 1996-2007", x="Ranges", y="Weights-of-Evidence Coefficients")
pRPDi1woe <- pRPDi1woe + scale_colour_manual(name="Source Land Cover",
                                             values=c("#246a24","#6666ff","#ff8000","#a65400","#ccff66"),
                                             labels=c("Forest","Mangrove","Oil Palm","Rice Paddy","Shrub/Orchard"))
# WoE Coefficients: 2007-2016
pRPDi2woe <- ggplot() + geom_line(data=dfRPDi2, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=as.factor(Transition_From.)))
pRPDi2woe <- pRPDi2woe + facet_wrap(~ Variable., scales="free")
pRPDi2woe <- pRPDi2woe + labs(title="Association of Spatial Determinants with Rubber Gain Transitions",
                              subtitle="Time-Interval: 2007-2016", x="Ranges", y="Weights-of-Evidence Coefficients")
pRPDi2woe <- pRPDi2woe + scale_colour_manual(name="Source Land Cover",
                                             values=c("#246a24","#6666ff","#ff8000","#a65400","#ccff66"),
                                             labels=c("Forest","Mangrove","Oil Palm","Rice Paddy","Shrub/Orchard"))

# Save Output Plots ----------------------
setwd(DirDATA)
ggsave(pRPDi1con, file="TNI_AllTransitions_SD_RPD_I1_Con.pdf", width=40, height=30, units="cm", dpi=300)
ggsave(pRPDi2con, file="TNI_AllTransitions_SD_RPD_I2_Con.pdf", width=40, height=30, units="cm", dpi=300)
ggsave(pRPDi1woe, file="TNI_AllTransitions_SD_RPD_I1_WoE.pdf", width=40, height=30, units="cm", dpi=300)
ggsave(pRPDi2woe, file="TNI_AllTransitions_SD_RPD_I2_WoE.pdf", width=40, height=30, units="cm", dpi=300)
