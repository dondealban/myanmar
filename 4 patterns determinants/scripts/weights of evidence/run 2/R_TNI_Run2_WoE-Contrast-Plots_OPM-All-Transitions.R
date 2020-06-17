# This script generates plots from the results of the Weights-of-Evidence (WoE) method
# implemented in DINAMICA EGO to assess the association of various spatial determinants
# (e.g., biophysical and socio-economic variables) with the transitions of agricultural
# expansion of major crop commodities (i.e., oil palm, rubber, rice) in Tanintharyi 
# Region, Myanmar.
# 
# Script by:      Jose Don T. De Alban
# Date created:   18 May 2020
# Date modified:  17 Jun 2020   


# Load Libraries -------------------------
library(tidyverse)

# Set Working Directories ----------------
DirMAIN  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/"
DirDATA  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/plots/"
DirOPMI1 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/opm/c_1996_2007/step03/"
DirOPMI2 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/opm/c_2007_2016/step03/"

# Read Data Files ------------------------
# WoE data for oil palm
setwd(DirOPMI1)
csvOPMi1 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")
setwd(DirOPMI2)
csvOPMi2 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")

# Extract Data Subsets -------------------

# Replace character strings
csvOPMi1$Variable. <- gsub(".*/", "", csvOPMi1$Variable.)
csvOPMi2$Variable. <- gsub(".*/", "", csvOPMi2$Variable.)
# Remove rows in dataframes that satisfy conditions
dfOPMi1 <- csvOPMi1 %>% filter(!(Significant == 0))
dfOPMi2 <- csvOPMi2 %>% filter(!(Significant == 0 | Variable. == "D_DefoI1"))

# Construct dataframes for relative importance plots
impOPMi1 <- dfOPMi1 %>% filter(Contrast >= 0)
impOPMi2 <- dfOPMi2 %>% filter(Contrast >= 0)
# Create new column with concatenated data from three columns
impOPMi1$VariableLimits <- trimws(paste(impOPMi1$Variable.,"_",
                                        impOPMi1$Range_Lower_Limit.,"_",impOPMi1$Range_Upper_Limit.), which=c("both"))
impOPMi2$VariableLimits <- trimws(paste(impOPMi2$Variable.,"_",
                                        impOPMi2$Range_Lower_Limit.,"_",impOPMi2$Range_Upper_Limit.), which=c("both"))
# Select top 5 variables per gain transition
imp5OPMi1 <- impOPMi1 %>% arrange(desc(Contrast)) %>% group_by(Transition_From.) %>% slice(1:5)
imp5OPMi2 <- impOPMi2 %>% arrange(desc(Contrast)) %>% group_by(Transition_From.) %>% slice(1:5)

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

# Relative importance of spatial determinants based on WoE Contrast
# WoE Contrast values: 1996-2007
pOPMi1imp <- ggplot() + geom_col(data=imp5OPMi1, aes(x=VariableLimits, y=Contrast), position="dodge")
pOPMi1imp <- pOPMi1imp + coord_flip()
pOPMi1imp <- pOPMi1imp + facet_grid(rows=vars(Transition_From.), scales="free")
pOPMi1imp <- pOPMi1imp + labs(title="Top 5 Spatial Determinants for Oil Palm Gain Transitions",
                              subtitle="Time-Interval: 1996-2007", x="Variables [Lower-Upper Range Limits]", y="Contrast")
# WoE Contrast values: 2007-2016
pOPMi2imp <- ggplot() + geom_col(data=imp5OPMi2, aes(x=VariableLimits, y=Contrast), position="dodge")
pOPMi2imp <- pOPMi2imp + coord_flip()
pOPMi2imp <- pOPMi2imp + facet_grid(rows=vars(Transition_From.), scales="free")
pOPMi2imp <- pOPMi2imp + labs(title="Top 5 Spatial Determinants for Oil Palm Gain Transitions",
                              subtitle="Time-Interval: 2007-2016", x="Variables [Lower-Upper Range Limits]", y="Contrast")

# Save Output Plots ----------------------
setwd(DirDATA)
ggsave(pOPMi1con, file="TNI_AllTransitions_SD_OPM_I1_Con.pdf", width=40, height=30, units="cm", dpi=300)
ggsave(pOPMi2con, file="TNI_AllTransitions_SD_OPM_I2_Con.pdf", width=40, height=30, units="cm", dpi=300)
ggsave(pOPMi1woe, file="TNI_AllTransitions_SD_OPM_I1_WoE.pdf", width=40, height=30, units="cm", dpi=300)
ggsave(pOPMi2woe, file="TNI_AllTransitions_SD_OPM_I2_WoE.pdf", width=40, height=30, units="cm", dpi=300)
ggsave(pOPMi1imp, file="TNI_AllTransitions_SD_OPM_I1_Imp.pdf", width=20, height=25, units="cm", dpi=300)
ggsave(pOPMi2imp, file="TNI_AllTransitions_SD_OPM_I2_Imp.pdf", width=20, height=25, units="cm", dpi=300)
