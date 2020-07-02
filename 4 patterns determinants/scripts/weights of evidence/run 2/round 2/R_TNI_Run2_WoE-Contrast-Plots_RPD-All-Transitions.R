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

# Construct dataframes for relative importance plots
impRPDi1 <- dfRPDi1 %>% filter(Contrast >= 0)
impRPDi2 <- dfRPDi2 %>% filter(Contrast >= 0)
# Create new column with concatenated data from three columns
impRPDi1$VariableLimits <- trimws(paste(impRPDi1$Variable.,"_",
                                        impRPDi1$Range_Lower_Limit.,"_",impRPDi1$Range_Upper_Limit.), which=c("both"))
impRPDi2$VariableLimits <- trimws(paste(impRPDi2$Variable.,"_",
                                        impRPDi2$Range_Lower_Limit.,"_",impRPDi2$Range_Upper_Limit.), which=c("both"))
# Select top 5 variables per gain transition
imp5RPDi1 <- impRPDi1 %>% arrange(desc(Contrast)) %>% group_by(Transition_From.) %>% slice(1:5)
imp5RPDi2 <- impRPDi2 %>% arrange(desc(Contrast)) %>% group_by(Transition_From.) %>% slice(1:5)

# Generate Plots -------------------------

# Plot with transitions from all source land cover types
# WoE Contrast values: 1996-2007
pRPDi1con <- ggplot() + geom_line(data=dfRPDi1, aes(x=Range_Upper_Limit., y=Contrast, colour=as.factor(Transition_From.)))
pRPDi1con <- pRPDi1con + facet_wrap(~ Variable., scales="free")
pRPDi1con <- pRPDi1con + labs(title="Association of Spatial Determinants with Rice Paddy Gain Transitions",
                              subtitle="Time-Interval: 1996-2007", x="Ranges", y="Contrast")
pRPDi1con <- pRPDi1con + scale_colour_manual(name="Source Land Cover",
                                             values=c("#246a24","#6666ff","#ff8000","#ff00ff","#ccff66"),
                                             labels=c("Forest","Mangrove","Oil Palm","Rubber","Shrub/Orchard"))
# WoE Contrast values: 2007-2016
pRPDi2con <- ggplot() + geom_line(data=dfRPDi2, aes(x=Range_Upper_Limit., y=Contrast, colour=as.factor(Transition_From.)))
pRPDi2con <- pRPDi2con + facet_wrap(~ Variable., scales="free")
pRPDi2con <- pRPDi2con + labs(title="Association of Spatial Determinants with Rice Paddy Gain Transitions",
                              subtitle="Time-Interval: 2007-2016", x="Ranges", y="Contrast")
pRPDi2con <- pRPDi2con + scale_colour_manual(name="Source Land Cover",
                                             values=c("#246a24","#6666ff","#ff8000","#ff00ff","#ccff66"),
                                             labels=c("Forest","Mangrove","Oil Palm","Rubber","Shrub/Orchard"))
# WoE Coefficients: 1996-2007
pRPDi1woe <- ggplot() + geom_line(data=dfRPDi1, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=as.factor(Transition_From.)))
pRPDi1woe <- pRPDi1woe + facet_wrap(~ Variable., scales="free")
pRPDi1woe <- pRPDi1woe + labs(title="Association of Spatial Determinants with Rice Paddy Gain Transitions",
                              subtitle="Time-Interval: 1996-2007", x="Ranges", y="Weights-of-Evidence Coefficients")
pRPDi1woe <- pRPDi1woe + scale_colour_manual(name="Source Land Cover",
                                             values=c("#246a24","#6666ff","#ff8000","#ff00ff","#ccff66"),
                                             labels=c("Forest","Mangrove","Oil Palm","Rubber","Shrub/Orchard"))
# WoE Coefficients: 2007-2016
pRPDi2woe <- ggplot() + geom_line(data=dfRPDi2, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=as.factor(Transition_From.)))
pRPDi2woe <- pRPDi2woe + facet_wrap(~ Variable., scales="free")
pRPDi2woe <- pRPDi2woe + labs(title="Association of Spatial Determinants with Rice Paddy Gain Transitions",
                              subtitle="Time-Interval: 2007-2016", x="Ranges", y="Weights-of-Evidence Coefficients")
pRPDi2woe <- pRPDi2woe + scale_colour_manual(name="Source Land Cover",
                                             values=c("#246a24","#6666ff","#ff8000","#ff00ff","#ccff66"),
                                             labels=c("Forest","Mangrove","Oil Palm","Rubber","Shrub/Orchard"))

# Relative importance of spatial determinants based on WoE Contrast
# WoE Contrast values: 1996-2007
pRPDi1imp <- ggplot() + geom_col(data=imp5RPDi1, aes(x=VariableLimits, y=Contrast), position="dodge")
pRPDi1imp <- pRPDi1imp + coord_flip()
pRPDi1imp <- pRPDi1imp + facet_grid(rows=vars(Transition_From.), scales="free")
pRPDi1imp <- pRPDi1imp + labs(title="Top 5 Spatial Determinants for Rice Paddy Gain Transitions",
                              subtitle="Time-Interval: 1996-2007", x="Variables [Lower-Upper Range Limits]", y="Contrast")
# WoE Contrast values: 2007-2016
pRPDi2imp <- ggplot() + geom_col(data=imp5RPDi2, aes(x=VariableLimits, y=Contrast), position="dodge")
pRPDi2imp <- pRPDi2imp + coord_flip()
pRPDi2imp <- pRPDi2imp + facet_grid(rows=vars(Transition_From.), scales="free")
pRPDi2imp <- pRPDi2imp + labs(title="Top 5 Spatial Determinants for Rice Paddy Gain Transitions",
                              subtitle="Time-Interval: 2007-2016", x="Variables [Lower-Upper Range Limits]", y="Contrast")

# Save Output Plots ----------------------
setwd(DirPLOT)
ggsave(pRPDi1con, file="TNI_AllTransitions_SD_RPD_I1_Con.pdf", width=40, height=30, units="cm", dpi=300)
ggsave(pRPDi2con, file="TNI_AllTransitions_SD_RPD_I2_Con.pdf", width=40, height=30, units="cm", dpi=300)
ggsave(pRPDi1woe, file="TNI_AllTransitions_SD_RPD_I1_WoE.pdf", width=40, height=30, units="cm", dpi=300)
ggsave(pRPDi2woe, file="TNI_AllTransitions_SD_RPD_I2_WoE.pdf", width=40, height=30, units="cm", dpi=300)
ggsave(pRPDi1imp, file="TNI_AllTransitions_SD_RPD_I1_Imp.pdf", width=20, height=25, units="cm", dpi=300)
ggsave(pRPDi2imp, file="TNI_AllTransitions_SD_RPD_I2_Imp.pdf", width=20, height=25, units="cm", dpi=300)
