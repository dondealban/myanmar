# This script generates plots from the results of the Weights-of-Evidence (WoE) method
# implemented in DINAMICA EGO to assess the association of various spatial determinants
# (e.g., biophysical and socio-economic variables) with the transitions of agricultural
# expansion of major crop commodities (i.e., oil palm, rubber, rice) in Tanintharyi 
# Region, Myanmar.
# 
# Script by:      Jose Don T. De Alban
# Date created:   18 May 2020
# Date modified:  18 Jun 2020   


# Load Libraries -------------------------
library(tidyverse)

# Set Working Directories ----------------
DirMAIN  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/"
DirPLOT  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/plots/"
DirOPMI1 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/opm/c_1996_2007/step03/"
DirOPMI2 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/opm/c_2007_2016/step03/"

# Read Data Files ------------------------
# WoE data for oil palm
setwd(DirOPMI1)
dfOPMi1 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")
setwd(DirOPMI2)
dfOPMi2 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")

# Clean Data Files -----------------------
# Replace character strings
dfOPMi1$Variable. <- gsub(".*/", "", dfOPMi1$Variable.)
dfOPMi2$Variable. <- gsub(".*/", "", dfOPMi2$Variable.)
# Add columns to indicate time-intervals
dfOPMi1$Time.Interval <- rep("1996-2007", nrow(dfOPMi1))
dfOPMi2$Time.Interval <- rep("2007-2016", nrow(dfOPMi2))
# Combine dataframes
dfOPMmerge <- rbind(dfOPMi1, dfOPMi2)

# Extract Data Subsets -------------------
# Extract relevant spatial determinants based on literature
dfOPM <- dfOPMmerge %>% filter(Variable. %in% "Elev" | Variable. %in% "Slope" |
                               Variable. %in% "Acc15" | Variable. %in% "PDn15" |
                               Variable. %in% "Bio01" | Variable. %in% "Bio06" | Variable. %in% "Bio12" |
                               Variable. %in% "Bio13" | Variable. %in% "Bio14" |
                               Variable. %in% "distance_to_5" | Variable. %in% "D_River" | Variable. %in% "D_Road" |
                               Variable. %in% "D_Town" | Variable. %in% "D_Vill" |
                               Variable. %in% "Cy000" | Variable. %in% "Sd000" | Variable. %in% "BD000" | 
                               Variable. %in% "OC000" | Variable. %in% "PH000" | Variable. %in% "WC000")
# Excluded spatial determinants
#                               Variable. %in% "Bio02" | Variable. %in% "Bio03" | Variable. %in% "Bio04" |
#                               Variable. %in% "Bio05" | Variable. %in% "Bio07" | Variable. %in% "Bio08" |
#                               Variable. %in% "Bio09" | Variable. %in% "Bio10" | Variable. %in% "Bio11" |
#                               Variable. %in% "Bio15" | Variable. %in% "Bio16" | Variable. %in% "Bio17" |
#                               Variable. %in% "Bio18" | Variable. %in% "Bio19" |
#                               Variable. %in% "S_Txn" | Variable. %in% "Tx000" |
#                               Variable. %in% "D_Opm1996" | Variable. %in% "D_Opm2007" | Variable. %in% "D_Opm2016" |
#                               Variable. %in% "D_Mill" | Variable. %in% "Acc00" | Variable. %in% "PDn05" |


# Extract per transition
dfFORtoOPM <- dfOPM %>% filter(dfOPM$Transition_From. %in% "3")
dfMNGtoOPM <- dfOPM %>% filter(dfOPM$Transition_From. %in% "4")
dfRPDtoOPM <- dfOPM %>% filter(dfOPM$Transition_From. %in% "6")
dfRBRtoOPM <- dfOPM %>% filter(dfOPM$Transition_From. %in% "7")
dfSHBtoOPM <- dfOPM %>% filter(dfOPM$Transition_From. %in% "8")

# Generate Per Transition Plots ----------

# FOR to OPM

# WoE contrast values
pFORtoOPMcon <- ggplot() + geom_line(data=dfFORtoOPM, aes(x=Range_Lower_Limit., y=Contrast, colour=Time.Interval))
pFORtoOPMcon <- pFORtoOPMcon + facet_wrap(~ Variable., scales="free_x")
pFORtoOPMcon <- pFORtoOPMcon + labs(title="Association of Spatial Determinants with FOR to OPM Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# WoE coefficients
pFORtoOPMwoe <- ggplot() + geom_line(data=dfFORtoOPM, aes(x=Range_Lower_Limit., y=Weight_Coefficient, colour=Time.Interval))
pFORtoOPMwoe <- pFORtoOPMwoe + facet_wrap(~ Variable., scales="free_x")
pFORtoOPMwoe <- pFORtoOPMwoe + labs(title="Association of Spatial Determinants with FOR to OPM Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")

# MNG to OPM

# WoE contrast values
pMNGtoOPMcon <- ggplot() + geom_line(data=dfMNGtoOPM, aes(x=Range_Lower_Limit., y=Contrast, colour=Time.Interval))
pMNGtoOPMcon <- pMNGtoOPMcon + facet_wrap(~ Variable., scales="free_x")
pMNGtoOPMcon <- pMNGtoOPMcon + labs(title="Association of Spatial Determinants with MNG to OPM Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# WoE coefficients
pMNGtoOPMwoe <- ggplot() + geom_line(data=dfMNGtoOPM, aes(x=Range_Lower_Limit., y=Weight_Coefficient, colour=Time.Interval))
pMNGtoOPMwoe <- pMNGtoOPMwoe + facet_wrap(~ Variable., scales="free_x")
pMNGtoOPMwoe <- pMNGtoOPMwoe + labs(title="Association of Spatial Determinants with MNG to OPM Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")

# RPD to OPM

# WoE contrast values
pRPDtoOPMcon <- ggplot() + geom_line(data=dfRPDtoOPM, aes(x=Range_Lower_Limit., y=Contrast, colour=Time.Interval))
pRPDtoOPMcon <- pRPDtoOPMcon + facet_wrap(~ Variable., scales="free_x")
pRPDtoOPMcon <- pRPDtoOPMcon + labs(title="Association of Spatial Determinants with RPD to OPM Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# WoE coefficients
pRPDtoOPMwoe <- ggplot() + geom_line(data=dfRPDtoOPM, aes(x=Range_Lower_Limit., y=Weight_Coefficient, colour=Time.Interval))
pRPDtoOPMwoe <- pRPDtoOPMwoe + facet_wrap(~ Variable., scales="free_x")
pRPDtoOPMwoe <- pRPDtoOPMwoe + labs(title="Association of Spatial Determinants with RPD to OPM Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")

# RBR to OPM

# WoE contrast values
pRBRtoOPMcon <- ggplot() + geom_line(data=dfRBRtoOPM, aes(x=Range_Lower_Limit., y=Contrast, colour=Time.Interval))
pRBRtoOPMcon <- pRBRtoOPMcon + facet_wrap(~ Variable., scales="free_x")
pRBRtoOPMcon <- pRBRtoOPMcon + labs(title="Association of Spatial Determinants with RBR to OPM Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# WoE coefficients
pRBRtoOPMwoe <- ggplot() + geom_line(data=dfRBRtoOPM, aes(x=Range_Lower_Limit., y=Weight_Coefficient, colour=Time.Interval))
pRBRtoOPMwoe <- pRBRtoOPMwoe + facet_wrap(~ Variable., scales="free_x")
pRBRtoOPMwoe <- pRBRtoOPMwoe + labs(title="Association of Spatial Determinants with RBR to OPM Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")

# SHB to OPM

# WoE contrast values
pSHBtoOPMcon <- ggplot() + geom_line(data=dfSHBtoOPM, aes(x=Range_Lower_Limit., y=Contrast, colour=Time.Interval))
pSHBtoOPMcon <- pSHBtoOPMcon + facet_wrap(~ Variable., scales="free_x")
pSHBtoOPMcon <- pSHBtoOPMcon + labs(title="Association of Spatial Determinants with SHB to OPM Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# WoE coefficients
pSHBtoOPMwoe <- ggplot() + geom_line(data=dfSHBtoOPM, aes(x=Range_Lower_Limit., y=Weight_Coefficient, colour=Time.Interval))
pSHBtoOPMwoe <- pSHBtoOPMwoe + facet_wrap(~ Variable., scales="free_x")
pSHBtoOPMwoe <- pSHBtoOPMwoe + labs(title="Association of Spatial Determinants with SHB to OPM Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")


# Save Output Plots ----------------------
setwd(DirDATA)
ggsave(pFORtoOPMcon, file="TNI_FORtoOPM_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pFORtoOPMwoe, file="TNI_FORtoOPM_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)

ggsave(pMNGtoOPMcon, file="TNI_MNGtoOPM_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pMNGtoOPMwoe, file="TNI_MNGtoOPM_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)

ggsave(pRPDtoOPMcon, file="TNI_RPDtoOPM_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pRPDtoOPMwoe, file="TNI_RPDtoOPM_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)

ggsave(pRBRtoOPMcon, file="TNI_RBRtoOPM_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pRBRtoOPMwoe, file="TNI_RBRtoOPM_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)

ggsave(pSHBtoOPMcon, file="TNI_SHBtoOPM_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pSHBtoOPMwoe, file="TNI_SHBtoOPM_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)
