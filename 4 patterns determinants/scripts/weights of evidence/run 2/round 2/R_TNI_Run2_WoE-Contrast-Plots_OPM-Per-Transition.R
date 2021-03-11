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
DirOPMI1 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/round 2/opm/c_1996_2007/step03/"
DirOPMI2 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/round 2/opm/c_2007_2016/step03/"

# Read Data Files ------------------------
# WoE data for oil palm
setwd(DirOPMI1)
csvOPMi1 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")
setwd(DirOPMI2)
csvOPMi2 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")

# Construct Omnibus Dataframe ------------
# Replace character strings
csvOPMi1$Variable. <- gsub(".*/", "", csvOPMi1$Variable.)
csvOPMi2$Variable. <- gsub(".*/", "", csvOPMi2$Variable.)
# Remove rows in dataframes that satisfy conditions
dfOPMi1 <- csvOPMi1 %>% filter(!(Significant == 0 | Variable. == "distance_to_5"))
dfOPMi2 <- csvOPMi2 %>% filter(!(Significant == 0 | Variable. == "distance_to_5"))
# Add columns to indicate time-intervals
dfOPMi1$Time.Interval <- rep("1996-2007", nrow(dfOPMi1))
dfOPMi2$Time.Interval <- rep("2007-2016", nrow(dfOPMi2))
# Combine dataframes
dfOPMall <- rbind(dfOPMi1, dfOPMi2)

# Extract subsets per transition
dfFORtoOPM <- dfOPMall %>% filter(dfOPMall$Transition_From. %in% "3")
dfMNGtoOPM <- dfOPMall %>% filter(dfOPMall$Transition_From. %in% "4")
dfRPDtoOPM <- dfOPMall %>% filter(dfOPMall$Transition_From. %in% "6")
dfRBRtoOPM <- dfOPMall %>% filter(dfOPMall$Transition_From. %in% "7")
dfSHBtoOPM <- dfOPMall %>% filter(dfOPMall$Transition_From. %in% "8")

# Construct dataframes for relative importance plots
impFORtoOPM <- dfFORtoOPM %>% filter(Contrast >= 0)
# Create new column with concatenated data from three columns
impFORtoOPM$VariableLimits <- trimws(paste(impFORtoOPM$Variable.,"_",
                                           impFORtoOPM$Range_Lower_Limit.,"_",
                                           impFORtoOPM$Range_Upper_Limit.), which=c("both"))

# Generate Plots: All Variables Per Transition ----------

# WoE Contrast

# FOR to OPM: WoE Contrast values
pFORtoOPMcon <- ggplot() + geom_line(data=dfFORtoOPM, aes(x=Range_Upper_Limit., y=Contrast, colour=Time.Interval))
pFORtoOPMcon <- pFORtoOPMcon + facet_wrap(~ Variable., scales="free_x")
pFORtoOPMcon <- pFORtoOPMcon + labs(title="Association of Spatial Determinants with FOR to OPM Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# MNG to OPM: WoE Contrast values
pMNGtoOPMcon <- ggplot() + geom_line(data=dfMNGtoOPM, aes(x=Range_Upper_Limit., y=Contrast, colour=Time.Interval))
pMNGtoOPMcon <- pMNGtoOPMcon + facet_wrap(~ Variable., scales="free_x")
pMNGtoOPMcon <- pMNGtoOPMcon + labs(title="Association of Spatial Determinants with MNG to OPM Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# RPD to OPM: WoE Contrast values
pRPDtoOPMcon <- ggplot() + geom_line(data=dfRPDtoOPM, aes(x=Range_Upper_Limit., y=Contrast, colour=Time.Interval))
pRPDtoOPMcon <- pRPDtoOPMcon + facet_wrap(~ Variable., scales="free_x")
pRPDtoOPMcon <- pRPDtoOPMcon + labs(title="Association of Spatial Determinants with RPD to OPM Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# RBR to OPM: WoE Contrast values
pRBRtoOPMcon <- ggplot() + geom_line(data=dfRBRtoOPM, aes(x=Range_Upper_Limit., y=Contrast, colour=Time.Interval))
pRBRtoOPMcon <- pRBRtoOPMcon + facet_wrap(~ Variable., scales="free_x")
pRBRtoOPMcon <- pRBRtoOPMcon + labs(title="Association of Spatial Determinants with RBR to OPM Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# SHB to OPM: WoE Contrast values
pSHBtoOPMcon <- ggplot() + geom_line(data=dfSHBtoOPM, aes(x=Range_Upper_Limit., y=Contrast, colour=Time.Interval))
pSHBtoOPMcon <- pSHBtoOPMcon + facet_wrap(~ Variable., scales="free_x")
pSHBtoOPMcon <- pSHBtoOPMcon + labs(title="Association of Spatial Determinants with SHB to OPM Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")

# WoE Coefficients

# FOR to OPM: WoE coefficients
pFORtoOPMwoe <- ggplot() + geom_line(data=dfFORtoOPM, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=Time.Interval))
pFORtoOPMwoe <- pFORtoOPMwoe + facet_wrap(~ Variable., scales="free_x")
pFORtoOPMwoe <- pFORtoOPMwoe + labs(title="Association of Spatial Determinants with FOR to OPM Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")
# MNG to OPM: WoE coefficients
pMNGtoOPMwoe <- ggplot() + geom_line(data=dfMNGtoOPM, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=Time.Interval))
pMNGtoOPMwoe <- pMNGtoOPMwoe + facet_wrap(~ Variable., scales="free_x")
pMNGtoOPMwoe <- pMNGtoOPMwoe + labs(title="Association of Spatial Determinants with MNG to OPM Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")
# RPD to OPM: WoE coefficients
pRPDtoOPMwoe <- ggplot() + geom_line(data=dfRPDtoOPM, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=Time.Interval))
pRPDtoOPMwoe <- pRPDtoOPMwoe + facet_wrap(~ Variable., scales="free_x")
pRPDtoOPMwoe <- pRPDtoOPMwoe + labs(title="Association of Spatial Determinants with RPD to OPM Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")
# RBR to OPM: WoE coefficients
pRBRtoOPMwoe <- ggplot() + geom_line(data=dfRBRtoOPM, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=Time.Interval))
pRBRtoOPMwoe <- pRBRtoOPMwoe + facet_wrap(~ Variable., scales="free_x")
pRBRtoOPMwoe <- pRBRtoOPMwoe + labs(title="Association of Spatial Determinants with RBR to OPM Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")
# SHB to OPM: WoE coefficients
pSHBtoOPMwoe <- ggplot() + geom_line(data=dfSHBtoOPM, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=Time.Interval))
pSHBtoOPMwoe <- pSHBtoOPMwoe + facet_wrap(~ Variable., scales="free_x")
pSHBtoOPMwoe <- pSHBtoOPMwoe + labs(title="Association of Spatial Determinants with SHB to OPM Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")

# Save Plots: All Variables Per Transition --------------
setwd(DirPLOT)
ggsave(pFORtoOPMcon, file="TNI_AllVariables_FORtoOPM_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pMNGtoOPMcon, file="TNI_AllVariables_MNGtoOPM_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pRPDtoOPMcon, file="TNI_AllVariables_RPDtoOPM_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pRBRtoOPMcon, file="TNI_AllVariables_RBRtoOPM_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pSHBtoOPMcon, file="TNI_AllVariables_SHBtoOPM_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pFORtoOPMwoe, file="TNI_AllVariables_FORtoOPM_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pMNGtoOPMwoe, file="TNI_AllVariables_MNGtoOPM_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pRPDtoOPMwoe, file="TNI_AllVariables_RPDtoOPM_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pRBRtoOPMwoe, file="TNI_AllVariables_RBRtoOPM_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pSHBtoOPMwoe, file="TNI_AllVariables_SHBtoOPM_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)
