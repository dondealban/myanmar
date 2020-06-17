# This script generates plots from the results of the Weights-of-Evidence (WoE) method
# implemented in DINAMICA EGO to assess the association of various spatial determinants
# (e.g., biophysical and socio-economic variables) with the transitions of agricultural
# expansion of major crop commodities (i.e., oil palm, rubber, rice) in Tanintharyi 
# Region, Myanmar.
# 
# Script by:      Jose Don T. De Alban
# Date created:   18 May 2020
# Date modified:  22 May 2020   


# Load Libraries -------------------------
library(tidyverse)

# Set Working Directories ----------------
DirMAIN  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/"
DirDATA  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/"
DirRPDI1 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/rpd/c_1996_2007/step03/"
DirRPDI2 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/rpd/c_2007_2016/step03/"

# Read Data Files ------------------------
# WoE data for rice paddy
setwd(DirRPDI1)
dfRPDi1 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")
setwd(DirRPDI2)
dfRPDi2 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")

# Clean Data Files -----------------------
# Replace character strings
dfRPDi1$Variable. <- gsub(".*/", "", dfRPDi1$Variable.)
dfRPDi2$Variable. <- gsub(".*/", "", dfRPDi2$Variable.)
# Add columns to indicate time-intervals
dfRPDi1$Time.Interval <- rep("1996-2007", nrow(dfRPDi1))
dfRPDi2$Time.Interval <- rep("2007-2016", nrow(dfRPDi2))
# Combine dataframes
dfRPDmerge <- rbind(dfRPDi1, dfRPDi2)

# Extract Data Subsets -------------------
# Extract relevant spatial determinants based on literature
dfRPD <- dfRPDmerge %>% filter(Variable. %in% "Elev" | Variable. %in% "Slope" |
                               Variable. %in% "Acc15" | Variable. %in% "PDn15" |
                               Variable. %in% "Bio01" | Variable. %in% "Bio02" | Variable. %in% "Bio03" | 
                               Variable. %in% "Bio04" | Variable. %in% "Bio05" | Variable. %in% "Bio06" | 
                               Variable. %in% "Bio07" | Variable. %in% "Bio08" | Variable. %in% "Bio09" |
                               Variable. %in% "Bio10" | Variable. %in% "Bio11" | Variable. %in% "Bio12" |
                               Variable. %in% "Bio13" | Variable. %in% "Bio14" | Variable. %in% "Bio15" | 
                               Variable. %in% "Bio16" | Variable. %in% "Bio17" | Variable. %in% "Bio18" | 
                               Variable. %in% "Bio19" | Variable. %in% "distance_to_6" | 
                               Variable. %in% "D_River" | Variable. %in% "D_Road" |
                               Variable. %in% "D_Town" | Variable. %in% "D_Vill" | Variable. %in% "Tx000" |
                               Variable. %in% "Cy000" | Variable. %in% "Sd000" | Variable. %in% "BD000" | 
                               Variable. %in% "OC000" | Variable. %in% "PH000" | Variable. %in% "WC000")
# Excluded spatial determinants
#                               Variable. %in% "S_Txn" | 
#                               Variable. %in% "D_Opm1996" | Variable. %in% "D_Opm2007" | Variable. %in% "D_Opm2016" |
#                               Variable. %in% "D_Mill" | Variable. %in% "Acc00" | Variable. %in% "PDn05" |


# Extract per transition
dfFORtoRPD <- dfRPD %>% filter(dfRPD$Transition_From. %in% "3")
dfMNGtoRPD <- dfRPD %>% filter(dfRPD$Transition_From. %in% "4")
dfOPMtoRPD <- dfRPD %>% filter(dfRPD$Transition_From. %in% "5")
dfRBRtoRPD <- dfRPD %>% filter(dfRPD$Transition_From. %in% "7")
dfSHBtoRPD <- dfRPD %>% filter(dfRPD$Transition_From. %in% "8")

# Generate Per Transition Plots ----------

# FOR to RPD

# WoE contrast values
pFORtoRPDcon <- ggplot() + geom_line(data=dfFORtoRPD, aes(x=Range_Lower_Limit., y=Contrast, colour=Time.Interval))
pFORtoRPDcon <- pFORtoRPDcon + facet_wrap(~ Variable., scales="free_x")
pFORtoRPDcon <- pFORtoRPDcon + labs(title="Association of Spatial Determinants with FOR to RPD Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# WoE coefficients
pFORtoRPDwoe <- ggplot() + geom_line(data=dfFORtoRPD, aes(x=Range_Lower_Limit., y=Weight_Coefficient, colour=Time.Interval))
pFORtoRPDwoe <- pFORtoRPDwoe + facet_wrap(~ Variable., scales="free_x")
pFORtoRPDwoe <- pFORtoRPDwoe + labs(title="Association of Spatial Determinants with FOR to RPD Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")

# MNG to RPD

# WoE contrast values
pMNGtoRPDcon <- ggplot() + geom_line(data=dfMNGtoRPD, aes(x=Range_Lower_Limit., y=Contrast, colour=Time.Interval))
pMNGtoRPDcon <- pMNGtoRPDcon + facet_wrap(~ Variable., scales="free_x")
pMNGtoRPDcon <- pMNGtoRPDcon + labs(title="Association of Spatial Determinants with MNG to RPD Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# WoE coefficients
pMNGtoRPDwoe <- ggplot() + geom_line(data=dfMNGtoRPD, aes(x=Range_Lower_Limit., y=Weight_Coefficient, colour=Time.Interval))
pMNGtoRPDwoe <- pMNGtoRPDwoe + facet_wrap(~ Variable., scales="free_x")
pMNGtoRPDwoe <- pMNGtoRPDwoe + labs(title="Association of Spatial Determinants with MNG to RPD Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")

# OPM to RPD

# WoE contrast values
pOPMtoRPDcon <- ggplot() + geom_line(data=dfOPMtoRPD, aes(x=Range_Lower_Limit., y=Contrast, colour=Time.Interval))
pOPMtoRPDcon <- pOPMtoRPDcon + facet_wrap(~ Variable., scales="free_x")
pOPMtoRPDcon <- pOPMtoRPDcon + labs(title="Association of Spatial Determinants with OPM to RPD Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# WoE coefficients
pOPMtoRPDwoe <- ggplot() + geom_line(data=dfOPMtoRPD, aes(x=Range_Lower_Limit., y=Weight_Coefficient, colour=Time.Interval))
pOPMtoRPDwoe <- pOPMtoRPDwoe + facet_wrap(~ Variable., scales="free_x")
pOPMtoRPDwoe <- pOPMtoRPDwoe + labs(title="Association of Spatial Determinants with OPM to RPD Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")

# RBR to RPD

# WoE contrast values
pRBRtoRPDcon <- ggplot() + geom_line(data=dfRBRtoRPD, aes(x=Range_Lower_Limit., y=Contrast, colour=Time.Interval))
pRBRtoRPDcon <- pRBRtoRPDcon + facet_wrap(~ Variable., scales="free_x")
pRBRtoRPDcon <- pRBRtoRPDcon + labs(title="Association of Spatial Determinants with RBR to RPD Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# WoE coefficients
pRBRtoRPDwoe <- ggplot() + geom_line(data=dfRBRtoRPD, aes(x=Range_Lower_Limit., y=Weight_Coefficient, colour=Time.Interval))
pRBRtoRPDwoe <- pRBRtoRPDwoe + facet_wrap(~ Variable., scales="free_x")
pRBRtoRPDwoe <- pRBRtoRPDwoe + labs(title="Association of Spatial Determinants with RBR to RPD Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")

# SHB to RPD

# WoE contrast values
pSHBtoRPDcon <- ggplot() + geom_line(data=dfSHBtoRPD, aes(x=Range_Lower_Limit., y=Contrast, colour=Time.Interval))
pSHBtoRPDcon <- pSHBtoRPDcon + facet_wrap(~ Variable., scales="free_x")
pSHBtoRPDcon <- pSHBtoRPDcon + labs(title="Association of Spatial Determinants with SHB to RPD Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# WoE coefficients
pSHBtoRPDwoe <- ggplot() + geom_line(data=dfSHBtoRPD, aes(x=Range_Lower_Limit., y=Weight_Coefficient, colour=Time.Interval))
pSHBtoRPDwoe <- pSHBtoRPDwoe + facet_wrap(~ Variable., scales="free_x")
pSHBtoRPDwoe <- pSHBtoRPDwoe + labs(title="Association of Spatial Determinants with SHB to RPD Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")


# Save Output Plots ----------------------
setwd(DirDATA)
ggsave(pFORtoRPDcon, file="TNI_FORtoRPD_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pFORtoRPDwoe, file="TNI_FORtoRPD_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)

ggsave(pMNGtoRPDcon, file="TNI_MNGtoRPD_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pMNGtoRPDwoe, file="TNI_MNGtoRPD_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)

ggsave(pOPMtoRPDcon, file="TNI_OPMtoRPD_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pOPMtoRPDwoe, file="TNI_OPMtoRPD_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)

ggsave(pRBRtoRPDcon, file="TNI_RBRtoRPD_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pRBRtoRPDwoe, file="TNI_RBRtoRPD_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)

ggsave(pSHBtoRPDcon, file="TNI_SHBtoRPD_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pSHBtoRPDwoe, file="TNI_SHBtoRPD_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)
