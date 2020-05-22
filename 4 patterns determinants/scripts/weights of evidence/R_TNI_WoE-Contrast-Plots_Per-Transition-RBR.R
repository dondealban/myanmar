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
DirRBRI1 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/rbr/c_1996_2007/step03/"
DirRBRI2 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/rbr/c_2007_2016/step03/"

# Read Data Files ------------------------
# WoE data for rubber
setwd(DirRBRI1)
dfRBRi1 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")
setwd(DirRBRI2)
dfRBRi2 <- read.csv(file="tni_weights.csv", header=TRUE, sep=",")

# Clean Data Files -----------------------
# Replace character strings
dfRBRi1$Variable. <- gsub(".*/", "", dfRBRi1$Variable.)
dfRBRi2$Variable. <- gsub(".*/", "", dfRBRi2$Variable.)
# Add columns to indicate time-intervals
dfRBRi1$Time.Interval <- rep("1996-2007", nrow(dfRBRi1))
dfRBRi2$Time.Interval <- rep("2007-2016", nrow(dfRBRi2))
# Combine dataframes
dfRBRmerge <- rbind(dfRBRi1, dfRBRi2)

# Extract Data Subsets -------------------
# Extract relevant spatial determinants based on literature
dfRBR <- dfRBRmerge %>% filter(Variable. %in% "Elev" | Variable. %in% "Slope" | Variable. %in% "Acc15" | 
                               Variable. %in% "Bio01" | Variable. %in% "Bio02" | Variable. %in% "Bio04" |
                               Variable. %in% "Bio08" | Variable. %in% "Bio12" | Variable. %in% "Bio13" | 
                               Variable. %in% "Bio14" | Variable. %in% "Bio15" | Variable. %in% "Bio16" | 
                               Variable. %in% "Bio17" | Variable. %in% "Bio18" | Variable. %in% "Bio19" |
                               Variable. %in% "distance_to_7" | Variable. %in% "D_River" | Variable. %in% "D_Road" |
                               Variable. %in% "D_Town" | Variable. %in% "D_Vill")
# Excluded spatial determinants
#                               Variable. %in% "Bio03" | Variable. %in% "Bio05" | Variable. %in% "Bio06" | 
#                               Variable. %in% "Bio07" | Variable. %in% "Bio09" | Variable. %in% "Bio10" | 
#                               Variable. %in% "Bio11" |
#                               Variable. %in% "S_Txn" | Variable. %in% "Tx000" | 
#                               Variable. %in% "Cy000" | Variable. %in% "Sd000" | Variable. %in% "BD000" | 
#                               Variable. %in% "OC000" | Variable. %in% "PH000" | Variable. %in% "WC000" |
#                               Variable. %in% "D_Rbr1996" | Variable. %in% "D_Rbr2007" | Variable. %in% "D_Rbr2016" |
#                               Variable. %in% "D_Mill" | Variable. %in% "Acc00" | 
#                               Variable. %in% "PDn05" | Variable. %in% "PDn15" |


# Extract per transition
dfFORtoRBR <- dfRBR %>% filter(dfRBR$Transition_From. %in% "3")
dfMNGtoRBR <- dfRBR %>% filter(dfRBR$Transition_From. %in% "4")
dfOPMtoRBR <- dfRBR %>% filter(dfRBR$Transition_From. %in% "5")
dfRPDtoRBR <- dfRBR %>% filter(dfRBR$Transition_From. %in% "6")
dfSHBtoRBR <- dfRBR %>% filter(dfRBR$Transition_From. %in% "8")

# Generate Per Transition Plots ----------

# FOR to RBR

# WoE contrast values
pFORtoRBRcon <- ggplot() + geom_line(data=dfFORtoRBR, aes(x=Range_Lower_Limit., y=Contrast, colour=Time.Interval))
pFORtoRBRcon <- pFORtoRBRcon + facet_wrap(~ Variable., scales="free_x")
pFORtoRBRcon <- pFORtoRBRcon + labs(title="Association of Spatial Determinants with FOR to RBR Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# WoE coefficients
pFORtoRBRwoe <- ggplot() + geom_line(data=dfFORtoRBR, aes(x=Range_Lower_Limit., y=Weight_Coefficient, colour=Time.Interval))
pFORtoRBRwoe <- pFORtoRBRwoe + facet_wrap(~ Variable., scales="free_x")
pFORtoRBRwoe <- pFORtoRBRwoe + labs(title="Association of Spatial Determinants with FOR to RBR Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")

# MNG to RBR

# WoE contrast values
pMNGtoRBRcon <- ggplot() + geom_line(data=dfMNGtoRBR, aes(x=Range_Lower_Limit., y=Contrast, colour=Time.Interval))
pMNGtoRBRcon <- pMNGtoRBRcon + facet_wrap(~ Variable., scales="free_x")
pMNGtoRBRcon <- pMNGtoRBRcon + labs(title="Association of Spatial Determinants with MNG to RBR Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# WoE coefficients
pMNGtoRBRwoe <- ggplot() + geom_line(data=dfMNGtoRBR, aes(x=Range_Lower_Limit., y=Weight_Coefficient, colour=Time.Interval))
pMNGtoRBRwoe <- pMNGtoRBRwoe + facet_wrap(~ Variable., scales="free_x")
pMNGtoRBRwoe <- pMNGtoRBRwoe + labs(title="Association of Spatial Determinants with MNG to RBR Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")

# OPM to RBR

# WoE contrast values
pOPMtoRBRcon <- ggplot() + geom_line(data=dfOPMtoRBR, aes(x=Range_Lower_Limit., y=Contrast, colour=Time.Interval))
pOPMtoRBRcon <- pOPMtoRBRcon + facet_wrap(~ Variable., scales="free_x")
pOPMtoRBRcon <- pOPMtoRBRcon + labs(title="Association of Spatial Determinants with OPM to RBR Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# WoE coefficients
pOPMtoRBRwoe <- ggplot() + geom_line(data=dfOPMtoRBR, aes(x=Range_Lower_Limit., y=Weight_Coefficient, colour=Time.Interval))
pOPMtoRBRwoe <- pOPMtoRBRwoe + facet_wrap(~ Variable., scales="free_x")
pOPMtoRBRwoe <- pOPMtoRBRwoe + labs(title="Association of Spatial Determinants with OPM to RBR Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")

# RPD to RBR

# WoE contrast values
pRPDtoRBRcon <- ggplot() + geom_line(data=dfRPDtoRBR, aes(x=Range_Lower_Limit., y=Contrast, colour=Time.Interval))
pRPDtoRBRcon <- pRPDtoRBRcon + facet_wrap(~ Variable., scales="free_x")
pRPDtoRBRcon <- pRPDtoRBRcon + labs(title="Association of Spatial Determinants with RPD to RBR Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# WoE coefficients
pRPDtoRBRwoe <- ggplot() + geom_line(data=dfRPDtoRBR, aes(x=Range_Lower_Limit., y=Weight_Coefficient, colour=Time.Interval))
pRPDtoRBRwoe <- pRPDtoRBRwoe + facet_wrap(~ Variable., scales="free_x")
pRPDtoRBRwoe <- pRPDtoRBRwoe + labs(title="Association of Spatial Determinants with RPD to RBR Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")

# SHB to RBR

# WoE contrast values
pSHBtoRBRcon <- ggplot() + geom_line(data=dfSHBtoRBR, aes(x=Range_Lower_Limit., y=Contrast, colour=Time.Interval))
pSHBtoRBRcon <- pSHBtoRBRcon + facet_wrap(~ Variable., scales="free_x")
pSHBtoRBRcon <- pSHBtoRBRcon + labs(title="Association of Spatial Determinants with SHB to RBR Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# WoE coefficients
pSHBtoRBRwoe <- ggplot() + geom_line(data=dfSHBtoRBR, aes(x=Range_Lower_Limit., y=Weight_Coefficient, colour=Time.Interval))
pSHBtoRBRwoe <- pSHBtoRBRwoe + facet_wrap(~ Variable., scales="free_x")
pSHBtoRBRwoe <- pSHBtoRBRwoe + labs(title="Association of Spatial Determinants with SHB to RBR Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")


# Save Output Plots ----------------------
setwd(DirDATA)
ggsave(pFORtoRBRcon, file="TNI_FORtoRBR_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pFORtoRBRwoe, file="TNI_FORtoRBR_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)

ggsave(pMNGtoRBRcon, file="TNI_MNGtoRBR_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pMNGtoRBRwoe, file="TNI_MNGtoRBR_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)

ggsave(pRPDtoRBRcon, file="TNI_RPDtoRBR_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pRPDtoRBRwoe, file="TNI_RPDtoRBR_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)

ggsave(pOPMtoRBRcon, file="TNI_OPMtoRBR_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pOPMtoRBRwoe, file="TNI_OPMtoRBR_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)

ggsave(pSHBtoRBRcon, file="TNI_SHBtoRBR_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pSHBtoRBRwoe, file="TNI_SHBtoRBR_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)
