# This script generates plots from the results of the Weights-of-Evidence (WoE) method
# implemented in DINAMICA EGO to assess the association of various spatial determinants
# (e.g., biophysical and socio-economic variables) with the transitions of agricultural
# expansion of major crop commodities (i.e., oil palm, rubber, rice) in Tanintharyi 
# Region, Myanmar.
# 
# Script by:      Jose Don T. De Alban
# Date created:   18 May 2020
# Date modified:  11 Mar 2021   


# Load Libraries -------------------------
library(tidyverse)

# Set Working Directories ----------------
DirMAIN  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/"
DirPLOT  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/round 2/plots/"
DirRBRI1 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/round 2/rbr/c_1996_2007/step03/"
DirRBRI2 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/round 2/rbr/c_2007_2016/step03/"

# Read Data Files ------------------------
# WoE data for rubber
setwd(DirRBRI1)
csvRBRi1 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")
setwd(DirRBRI2)
csvRBRi2 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")

# Construct Omnibus Dataframe ------------
# Replace character strings
csvRBRi1$Variable. <- gsub(".*/", "", csvRBRi1$Variable.)
csvRBRi2$Variable. <- gsub(".*/", "", csvRBRi2$Variable.)
# Remove rows in dataframes that satisfy conditions
dfRBRi1 <- csvRBRi1 %>% filter(!(Significant == 0 | Variable. == "distance_to_7"))
dfRBRi2 <- csvRBRi2 %>% filter(!(Significant == 0 | Variable. == "distance_to_7"))
# Add columns to indicate time-intervals
dfRBRi1$Time.Interval <- rep("1996-2007", nrow(dfRBRi1))
dfRBRi2$Time.Interval <- rep("2007-2016", nrow(dfRBRi2))
# Combine dataframes
dfRBRall <- rbind(dfRBRi1, dfRBRi2)

# Extract subsets per transition
dfFORtoRBR <- dfRBRall %>% filter(dfRBRall$Transition_From. %in% "3")
dfMNGtoRBR <- dfRBRall %>% filter(dfRBRall$Transition_From. %in% "4")
dfOPMtoRBR <- dfRBRall %>% filter(dfRBRall$Transition_From. %in% "5")
dfRPDtoRBR <- dfRBRall %>% filter(dfRBRall$Transition_From. %in% "6")
dfSHBtoRBR <- dfRBRall %>% filter(dfRBRall$Transition_From. %in% "8")

# Generate Plots: All Variables Per Transition ----------

# WoE Contrast

# FOR to RBR: WoE Contrast values
pFORtoRBRcon <- ggplot() + geom_line(data=dfFORtoRBR, aes(x=Range_Upper_Limit., y=Contrast, colour=Time.Interval))
pFORtoRBRcon <- pFORtoRBRcon + facet_wrap(~ Variable., scales="free_x")
pFORtoRBRcon <- pFORtoRBRcon + labs(title="Association of Spatial Determinants with FOR to RBR Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# MNG to RBR: WoE Contrast values
pMNGtoRBRcon <- ggplot() + geom_line(data=dfMNGtoRBR, aes(x=Range_Upper_Limit., y=Contrast, colour=Time.Interval))
pMNGtoRBRcon <- pMNGtoRBRcon + facet_wrap(~ Variable., scales="free_x")
pMNGtoRBRcon <- pMNGtoRBRcon + labs(title="Association of Spatial Determinants with MNG to RBR Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# OPM to RBR: WoE Contrast values
pOPMtoRBRcon <- ggplot() + geom_line(data=dfOPMtoRBR, aes(x=Range_Upper_Limit., y=Contrast, colour=Time.Interval))
pOPMtoRBRcon <- pOPMtoRBRcon + facet_wrap(~ Variable., scales="free_x")
pOPMtoRBRcon <- pOPMtoRBRcon + labs(title="Association of Spatial Determinants with OPM to RBR Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# RPD to RBR: WoE Contrast values
pRPDtoRBRcon <- ggplot() + geom_line(data=dfRPDtoRBR, aes(x=Range_Upper_Limit., y=Contrast, colour=Time.Interval))
pRPDtoRBRcon <- pRPDtoRBRcon + facet_wrap(~ Variable., scales="free_x")
pRPDtoRBRcon <- pRPDtoRBRcon + labs(title="Association of Spatial Determinants with RPD to RBR Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# SHB to RBR: WoE Contrast values
pSHBtoRBRcon <- ggplot() + geom_line(data=dfSHBtoRBR, aes(x=Range_Upper_Limit., y=Contrast, colour=Time.Interval))
pSHBtoRBRcon <- pSHBtoRBRcon + facet_wrap(~ Variable., scales="free_x")
pSHBtoRBRcon <- pSHBtoRBRcon + labs(title="Association of Spatial Determinants with SHB to RBR Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")

# WoE Coefficients

# FOR to RBR: WoE coefficients
pFORtoRBRwoe <- ggplot() + geom_line(data=dfFORtoRBR, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=Time.Interval))
pFORtoRBRwoe <- pFORtoRBRwoe + facet_wrap(~ Variable., scales="free_x")
pFORtoRBRwoe <- pFORtoRBRwoe + labs(title="Association of Spatial Determinants with FOR to RBR Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")
# MNG to RBR: WoE coefficients
pMNGtoRBRwoe <- ggplot() + geom_line(data=dfMNGtoRBR, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=Time.Interval))
pMNGtoRBRwoe <- pMNGtoRBRwoe + facet_wrap(~ Variable., scales="free_x")
pMNGtoRBRwoe <- pMNGtoRBRwoe + labs(title="Association of Spatial Determinants with MNG to RBR Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")
# OPM to RBR: WoE coefficients
pOPMtoRBRwoe <- ggplot() + geom_line(data=dfOPMtoRBR, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=Time.Interval))
pOPMtoRBRwoe <- pOPMtoRBRwoe + facet_wrap(~ Variable., scales="free_x")
pOPMtoRBRwoe <- pOPMtoRBRwoe + labs(title="Association of Spatial Determinants with OPM to RBR Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")
# RPD to RBR: WoE coefficients
pRPDtoRBRwoe <- ggplot() + geom_line(data=dfRPDtoRBR, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=Time.Interval))
pRPDtoRBRwoe <- pRPDtoRBRwoe + facet_wrap(~ Variable., scales="free_x")
pRPDtoRBRwoe <- pRPDtoRBRwoe + labs(title="Association of Spatial Determinants with RPD to RBR Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")
# SHB to RBR: WoE coefficients
pSHBtoRBRwoe <- ggplot() + geom_line(data=dfSHBtoRBR, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=Time.Interval))
pSHBtoRBRwoe <- pSHBtoRBRwoe + facet_wrap(~ Variable., scales="free_x")
pSHBtoRBRwoe <- pSHBtoRBRwoe + labs(title="Association of Spatial Determinants with SHB to RBR Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")

# Save Plots: All Variables Per Transition --------------
setwd(DirPLOT)
ggsave(pFORtoRBRcon, file="TNI_AllVariables_FORtoRBR_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pMNGtoRBRcon, file="TNI_AllVariables_MNGtoRBR_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pRPDtoRBRcon, file="TNI_AllVariables_RPDtoRBR_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pOPMtoRBRcon, file="TNI_AllVariables_OPMtoRBR_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pSHBtoRBRcon, file="TNI_AllVariables_SHBtoRBR_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pFORtoRBRwoe, file="TNI_AllVariables_FORtoRBR_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pMNGtoRBRwoe, file="TNI_AllVariables_MNGtoRBR_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pRPDtoRBRwoe, file="TNI_AllVariables_RPDtoRBR_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pOPMtoRBRwoe, file="TNI_AllVariables_OPMtoRBR_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pSHBtoRBRwoe, file="TNI_AllVariables_SHBtoRBR_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)
