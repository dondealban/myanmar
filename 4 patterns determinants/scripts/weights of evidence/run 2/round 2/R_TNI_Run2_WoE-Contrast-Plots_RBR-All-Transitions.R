# This script generates plots from the results of the Weights-of-Evidence (WoE) method
# implemented in DINAMICA EGO to assess the association of various spatial determinants
# (e.g., biophysical and socio-economic variables) with the transitions of agricultural
# expansion of major crop commodities (i.e., oil palm, rubber, rice) in Tanintharyi 
# Region, Myanmar.
# 
# Script by:      Jose Don T. De Alban
# Date created:   17 Jun 2020
# Date modified:  02 Jul 2020 


# Load Libraries -------------------------
library(tidyverse)

# Set Working Directories ----------------
DirMAIN  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/"
DirPLOT  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/plots/"
DirRBRI1 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/rbr/c_1996_2007/step03/"
DirRBRI2 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/rbr/c_2007_2016/step03/"

# Read Data Files ------------------------
# WoE data for rubber
setwd(DirRBRI1)
csvRBRi1 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")
setwd(DirRBRI2)
csvRBRi2 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")

# Extract Data Subsets -------------------

# Replace character strings
csvRBRi1$Variable. <- gsub(".*/", "", csvRBRi1$Variable.)
csvRBRi2$Variable. <- gsub(".*/", "", csvRBRi2$Variable.)
# Remove rows in dataframes that satisfy conditions
dfRBRi1 <- csvRBRi1 %>% filter(!(Significant == 0))
dfRBRi2 <- csvRBRi2 %>% filter(!(Significant == 0))

# Construct dataframes for relative importance plots
impRBRi1 <- dfRBRi1 %>% filter(Contrast >= 0)
impRBRi2 <- dfRBRi2 %>% filter(Contrast >= 0)
# Create new column with concatenated data from three columns
impRBRi1$VariableLimits <- trimws(paste(impRBRi1$Variable.,"_",
                                        impRBRi1$Range_Lower_Limit.,"_",impRBRi1$Range_Upper_Limit.), which=c("both"))
impRBRi2$VariableLimits <- trimws(paste(impRBRi2$Variable.,"_",
                                        impRBRi2$Range_Lower_Limit.,"_",impRBRi2$Range_Upper_Limit.), which=c("both"))
# Select top 5 variables per gain transition
imp5RBRi1 <- impRBRi1 %>% arrange(desc(Contrast)) %>% group_by(Transition_From.) %>% slice(1:5)
imp5RBRi2 <- impRBRi2 %>% arrange(desc(Contrast)) %>% group_by(Transition_From.) %>% slice(1:5)

# Generate Plots -------------------------

# Plot with transitions from all source land cover types
# WoE Contrast values: 1996-2007
pRBRi1con <- ggplot() + geom_line(data=dfRBRi1, aes(x=Range_Upper_Limit., y=Contrast, colour=as.factor(Transition_From.)))
pRBRi1con <- pRBRi1con + facet_wrap(~ Variable., scales="free")
pRBRi1con <- pRBRi1con + labs(title="Association of Spatial Determinants with Rubber Gain Transitions",
                              subtitle="Time-Interval: 1996-2007", x="Ranges", y="Contrast")
pRBRi1con <- pRBRi1con + scale_colour_manual(name="Source Land Cover",
                                             values=c("#246a24","#6666ff","#ff8000","#a65400","#ccff66"),
                                             labels=c("Forest","Mangrove","Oil Palm","Rice Paddy","Shrub/Orchard"))
# WoE Contrast values: 2007-2016
pRBRi2con <- ggplot() + geom_line(data=dfRBRi2, aes(x=Range_Upper_Limit., y=Contrast, colour=as.factor(Transition_From.)))
pRBRi2con <- pRBRi2con + facet_wrap(~ Variable., scales="free")
pRBRi2con <- pRBRi2con + labs(title="Association of Spatial Determinants with Rubber Gain Transitions",
                              subtitle="Time-Interval: 2007-2016", x="Ranges", y="Contrast")
pRBRi2con <- pRBRi2con + scale_colour_manual(name="Source Land Cover",
                                             values=c("#246a24","#6666ff","#ff8000","#a65400","#ccff66"),
                                             labels=c("Forest","Mangrove","Oil Palm","Rice Paddy","Shrub/Orchard"))
# WoE Coefficients: 1996-2007
pRBRi1woe <- ggplot() + geom_line(data=dfRBRi1, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=as.factor(Transition_From.)))
pRBRi1woe <- pRBRi1woe + facet_wrap(~ Variable., scales="free")
pRBRi1woe <- pRBRi1woe + labs(title="Association of Spatial Determinants with Rubber Gain Transitions",
                              subtitle="Time-Interval: 1996-2007", x="Ranges", y="Weights-of-Evidence Coefficients")
pRBRi1woe <- pRBRi1woe + scale_colour_manual(name="Source Land Cover",
                                             values=c("#246a24","#6666ff","#ff8000","#a65400","#ccff66"),
                                             labels=c("Forest","Mangrove","Oil Palm","Rice Paddy","Shrub/Orchard"))
# WoE Coefficients: 2007-2016
pRBRi2woe <- ggplot() + geom_line(data=dfRBRi2, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=as.factor(Transition_From.)))
pRBRi2woe <- pRBRi2woe + facet_wrap(~ Variable., scales="free")
pRBRi2woe <- pRBRi2woe + labs(title="Association of Spatial Determinants with Rubber Gain Transitions",
                              subtitle="Time-Interval: 2007-2016", x="Ranges", y="Weights-of-Evidence Coefficients")
pRBRi2woe <- pRBRi2woe + scale_colour_manual(name="Source Land Cover",
                                             values=c("#246a24","#6666ff","#ff8000","#a65400","#ccff66"),
                                             labels=c("Forest","Mangrove","Oil Palm","Rice Paddy","Shrub/Orchard"))

# Relative importance of spatial determinants based on WoE Contrast
# WoE Contrast values: 1996-2007
pRBRi1imp <- ggplot() + geom_col(data=imp5RBRi1, aes(x=VariableLimits, y=Contrast), position="dodge")
pRBRi1imp <- pRBRi1imp + coord_flip()
pRBRi1imp <- pRBRi1imp + facet_grid(rows=vars(Transition_From.), scales="free")
pRBRi1imp <- pRBRi1imp + labs(title="Top 5 Spatial Determinants for Rubber Gain Transitions",
                              subtitle="Time-Interval: 1996-2007", x="Variables [Lower-Upper Range Limits]", y="Contrast")
# WoE Contrast values: 2007-2016
pRBRi2imp <- ggplot() + geom_col(data=imp5RBRi2, aes(x=VariableLimits, y=Contrast), position="dodge")
pRBRi2imp <- pRBRi2imp + coord_flip()
pRBRi2imp <- pRBRi2imp + facet_grid(rows=vars(Transition_From.), scales="free")
pRBRi2imp <- pRBRi2imp + labs(title="Top 5 Spatial Determinants for Rubber Gain Transitions",
                              subtitle="Time-Interval: 2007-2016", x="Variables [Lower-Upper Range Limits]", y="Contrast")

# Save Output Plots ----------------------
setwd(DirPLOT)
ggsave(pRBRi1con, file="TNI_AllTransitions_SD_RBR_I1_Con.pdf", width=40, height=30, units="cm", dpi=300)
ggsave(pRBRi2con, file="TNI_AllTransitions_SD_RBR_I2_Con.pdf", width=40, height=30, units="cm", dpi=300)
ggsave(pRBRi1woe, file="TNI_AllTransitions_SD_RBR_I1_WoE.pdf", width=40, height=30, units="cm", dpi=300)
ggsave(pRBRi2woe, file="TNI_AllTransitions_SD_RBR_I2_WoE.pdf", width=40, height=30, units="cm", dpi=300)
ggsave(pRBRi1imp, file="TNI_AllTransitions_SD_RBR_I1_Imp.pdf", width=20, height=25, units="cm", dpi=300)
ggsave(pRBRi2imp, file="TNI_AllTransitions_SD_RBR_I2_Imp.pdf", width=20, height=25, units="cm", dpi=300)
