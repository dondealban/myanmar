# This script generates plots from the results of the Weights-of-Evidence (WoE) method
# implemented in DINAMICA EGO to assess the association of various spatial determinants
# (e.g., biophysical and socio-economic variables) with the transitions of agricultural
# expansion of major crop commodities (i.e., oil palm, rubber, rice) in Tanintharyi 
# Region, Myanmar.
# 
# Script by:      Jose Don T. De Alban
# Date created:   18 May 2020
# Date modified:  21 May 2020   


# Load Libraries -------------------------
library(tidyverse)

# Set Working Directories ----------------
DirMAIN  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/"
DirDATA  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/"
DirOPMI1 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/opm/c_1996_2007/step03/"
DirOPMI2 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/opm/c_2007_2016/step03/"

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
                               Variable. %in% "Bio01" | Variable. %in% "Bio06" | Variable. %in% "Bio12" |
                               Variable. %in% "Bio13" | Variable. %in% "Bio14" | Variable. %in% "distance_to_5" |
                               Variable. %in% "D_Mill" | Variable. %in% "D_River" | Variable. %in% "D_Road" |
                               Variable. %in% "D_Town" | Variable. %in% "D_Vill" | Variable. %in% "D_Road" |
                               Variable. %in% "BD000" | Variable. %in% "Cy000" | Variable. %in% "Sd000" |
                               Variable. %in% "OC000" | Variable. %in% "PH000" | Variable. %in% "WC000")  

# Extract per transition
dfFORtoOPM <- dfOPM %>% filter(dfOPM$Transition_From. %in% "3")
dfMNGtoOPM <- dfOPM %>% filter(dfOPM$Transition_From. %in% "4")
dfRBRtoOPM <- dfOPM %>% filter(dfOPM$Transition_From. %in% "7")

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

# Save Output Plots ----------------------
ggsave(pFORtoOPMcon, file="TNI_FORtoOPM_SD_Con.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(pFORtoOPMwoe, file="TNI_FORtoOPM_SD_WoE.pdf", width=19.89, height=15, units="cm", dpi=300)


