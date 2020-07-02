# This script generates plots from the results of the Weights-of-Evidence (WoE) method
# implemented in DINAMICA EGO to assess the association of various spatial determinants
# (e.g., biophysical and socio-economic variables) with the transitions of agricultural
# expansion of major crop commodities (i.e., oil palm, rubber, rice) in Tanintharyi 
# Region, Myanmar.
# 
# Script by:      Jose Don T. De Alban
# Date created:   18 May 2020
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

# Construct Omnibus Dataframe ------------
# Replace character strings
csvRPDi1$Variable. <- gsub(".*/", "", csvRPDi1$Variable.)
csvRPDi2$Variable. <- gsub(".*/", "", csvRPDi2$Variable.)
# Remove rows in dataframes that satisfy conditions
dfRPDi1 <- csvRPDi1 %>% filter(!(Significant == 0))
dfRPDi2 <- csvRPDi2 %>% filter(!(Significant == 0))
# Add columns to indicate time-intervals
dfRPDi1$Time.Interval <- rep("1996-2007", nrow(dfRPDi1))
dfRPDi2$Time.Interval <- rep("2007-2016", nrow(dfRPDi2))
# Combine dataframes
dfRPDall <- rbind(dfRPDi1, dfRPDi2)

# Extract subsets per transition
dfFORtoRPD <- dfRPDall %>% filter(dfRPDall$Transition_From. %in% "3")
dfMNGtoRPD <- dfRPDall %>% filter(dfRPDall$Transition_From. %in% "4")
dfOPMtoRPD <- dfRPDall %>% filter(dfRPDall$Transition_From. %in% "5")
dfRBRtoRPD <- dfRPDall %>% filter(dfRPDall$Transition_From. %in% "7")
dfSHBtoRPD <- dfRPDall %>% filter(dfRPDall$Transition_From. %in% "8")

# Generate Plots: All Variables Per Transition ----------

# WoE Contrast

# FOR to RPD: WoE Contrast values
pFORtoRPDcon <- ggplot() + geom_line(data=dfFORtoRPD, aes(x=Range_Upper_Limit., y=Contrast, colour=Time.Interval))
pFORtoRPDcon <- pFORtoRPDcon + facet_wrap(~ Variable., scales="free_x")
pFORtoRPDcon <- pFORtoRPDcon + labs(title="Association of Spatial Determinants with FOR to RPD Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# MNG to RPD: WoE Contrast values
pMNGtoRPDcon <- ggplot() + geom_line(data=dfMNGtoRPD, aes(x=Range_Upper_Limit., y=Contrast, colour=Time.Interval))
pMNGtoRPDcon <- pMNGtoRPDcon + facet_wrap(~ Variable., scales="free_x")
pMNGtoRPDcon <- pMNGtoRPDcon + labs(title="Association of Spatial Determinants with MNG to RPD Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# OPM to RPD: WoE Contrast values
pOPMtoRPDcon <- ggplot() + geom_line(data=dfOPMtoRPD, aes(x=Range_Upper_Limit., y=Contrast, colour=Time.Interval))
pOPMtoRPDcon <- pOPMtoRPDcon + facet_wrap(~ Variable., scales="free_x")
pOPMtoRPDcon <- pOPMtoRPDcon + labs(title="Association of Spatial Determinants with OPM to RPD Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# RBR to RPD: WoE Contrast values
pRBRtoRPDcon <- ggplot() + geom_line(data=dfRBRtoRPD, aes(x=Range_Upper_Limit., y=Contrast, colour=Time.Interval))
pRBRtoRPDcon <- pRBRtoRPDcon + facet_wrap(~ Variable., scales="free_x")
pRBRtoRPDcon <- pRBRtoRPDcon + labs(title="Association of Spatial Determinants with RBR to RPD Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# SHB to RPD: WoE Contrast values
pSHBtoRPDcon <- ggplot() + geom_line(data=dfSHBtoRPD, aes(x=Range_Upper_Limit., y=Contrast, colour=Time.Interval))
pSHBtoRPDcon <- pSHBtoRPDcon + facet_wrap(~ Variable., scales="free_x")
pSHBtoRPDcon <- pSHBtoRPDcon + labs(title="Association of Spatial Determinants with SHB to RPD Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")

# WoE Coefficients

# FOR to RPD: WoE coefficients
pFORtoRPDwoe <- ggplot() + geom_line(data=dfFORtoRPD, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=Time.Interval))
pFORtoRPDwoe <- pFORtoRPDwoe + facet_wrap(~ Variable., scales="free_x")
pFORtoRPDwoe <- pFORtoRPDwoe + labs(title="Association of Spatial Determinants with FOR to RPD Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")
# MNG to RPD: WoE coefficients
pMNGtoRPDwoe <- ggplot() + geom_line(data=dfMNGtoRPD, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=Time.Interval))
pMNGtoRPDwoe <- pMNGtoRPDwoe + facet_wrap(~ Variable., scales="free_x")
pMNGtoRPDwoe <- pMNGtoRPDwoe + labs(title="Association of Spatial Determinants with MNG to RPD Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")
# OPM to RPD: WoE coefficients
pOPMtoRPDwoe <- ggplot() + geom_line(data=dfOPMtoRPD, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=Time.Interval))
pOPMtoRPDwoe <- pOPMtoRPDwoe + facet_wrap(~ Variable., scales="free_x")
pOPMtoRPDwoe <- pOPMtoRPDwoe + labs(title="Association of Spatial Determinants with OPM to RPD Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")
# RBR to RPD: WoE coefficients
pRBRtoRPDwoe <- ggplot() + geom_line(data=dfRBRtoRPD, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=Time.Interval))
pRBRtoRPDwoe <- pRBRtoRPDwoe + facet_wrap(~ Variable., scales="free_x")
pRBRtoRPDwoe <- pRBRtoRPDwoe + labs(title="Association of Spatial Determinants with RBR to RPD Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")
# SHB to RPD: WoE coefficients
pSHBtoRPDwoe <- ggplot() + geom_line(data=dfSHBtoRPD, aes(x=Range_Upper_Limit., y=Weight_Coefficient, colour=Time.Interval))
pSHBtoRPDwoe <- pSHBtoRPDwoe + facet_wrap(~ Variable., scales="free_x")
pSHBtoRPDwoe <- pSHBtoRPDwoe + labs(title="Association of Spatial Determinants with SHB to RPD Transition",
                                    x="Ranges", y="Weights-of-Evidence Coefficients", colour="Time-Interval")

# Save Plots: All Variables Per Transition --------------
setwd(DirPLOT)
ggsave(pFORtoRPDcon, file="TNI_AllVariables_FORtoRPD_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pMNGtoRPDcon, file="TNI_AllVariables_MNGtoRPD_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pOPMtoRPDcon, file="TNI_AllVariables_OPMtoRPD_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pRBRtoRPDcon, file="TNI_AllVariables_RBRtoRPD_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pSHBtoRPDcon, file="TNI_AllVariables_SHBtoRPD_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pFORtoRPDwoe, file="TNI_AllVariables_FORtoRPD_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pMNGtoRPDwoe, file="TNI_AllVariables_MNGtoRPD_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pOPMtoRPDwoe, file="TNI_AllVariables_OPMtoRPD_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pRBRtoRPDwoe, file="TNI_AllVariables_RBRtoRPD_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pSHBtoRPDwoe, file="TNI_AllVariables_SHBtoRPD_SD_WoE.pdf", width=30, height=20, units="cm", dpi=300)


# Extract Data Subsets -------------------
# Extract relevant spatial determinants based on literature
subRPD <- dfRPDall %>% filter(Variable. %in% c("Bio01","Bio02","Bio03","Bio04","Bio07","Bio12","Bio15",
                                               "distance_to_6","D_River","D_Road","D_Town","D_Vill",
                                               "Elev","Irrig","PDn05","PDn15","Slope",
                                               "BD000","Cy000","OC000","PH000","Sd000","Tx000","WC000"))
# Alternates
# subRPD <- dfRPDall %>% filter(!(Variable. %in% c("D_Rpd1996","D_Rpd2007","D_ComF","D_KBA","D_OPC","D_PA","D_ResF")))

# Excluded spatial determinants
# Variable. %in% "Elev" | Variable. %in% "Slope" | Variable. %in% "Acc00" | Variable. %in% "Acc15" | 
# Variable. %in% "Bio01" | Variable. %in% "Bio02" | Variable. %in% "Bio03" | Variable. %in% "Bio04" |
# Variable. %in% "Bio05" | Variable. %in% "Bio06" | Variable. %in% "Bio07" | Variable. %in% "Bio08" |
# Variable. %in% "Bio09" | Variable. %in% "Bio10" | Variable. %in% "Bio11" | Variable. %in% "Bio12" |
# Variable. %in% "Bio13" | Variable. %in% "Bio14" | Variable. %in% "Bio15" | Variable. %in% "Bio16" | 
# Variable. %in% "Bio17" | Variable. %in% "Bio18" | Variable. %in% "Bio19" |
# Variable. %in% "distance_to_6" | Variable. %in% "D_Rpd1996" | Variable. %in% "D_Rpd2007" | 
# Variable. %in% "D_River" | Variable. %in% "D_Road" | Variable. %in% "D_Town" | Variable. %in% "D_Vill" |
# Variable. %in% "Irrig" | Variable. %in% "PDn05" | Variable. %in% "PDn15" |
# Variable. %in% "Tx000" | Variable. %in% "Cy000" | Variable. %in% "Sd000" | Variable. %in% "BD000" | 
# Variable. %in% "OC000" | Variable. %in% "PH000" | Variable. %in% "WC000")

# Extract per transition
subFORtoRPD <- subRPD %>% filter(subRPD$Transition_From. %in% "3")
subMNGtoRPD <- subRPD %>% filter(subRPD$Transition_From. %in% "4")
subOPMtoRPD <- subRPD %>% filter(subRPD$Transition_From. %in% "5")
subRBRtoRPD <- subRPD %>% filter(subRPD$Transition_From. %in% "7")
subSHBtoRPD <- subRPD %>% filter(subRPD$Transition_From. %in% "8")

# Generate Plots: Select Variables Per Transition -------

# WoE Contrast

# FOR to RPD: WoE Contrast values
pFORtoRPDcon_sub <- ggplot() + geom_line(data=subFORtoRPD, aes(x=Range_Upper_Limit., y=Contrast, colour=Time.Interval))
pFORtoRPDcon_sub <- pFORtoRPDcon_sub + facet_wrap(~ Variable., scales="free_x")
pFORtoRPDcon_sub <- pFORtoRPDcon_sub + labs(title="Association of Spatial Determinants with FOR to RPD Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# MNG to RPD: WoE Contrast values
pMNGtoRPDcon_sub <- ggplot() + geom_line(data=subMNGtoRPD, aes(x=Range_Upper_Limit., y=Contrast, colour=Time.Interval))
pMNGtoRPDcon_sub <- pMNGtoRPDcon_sub + facet_wrap(~ Variable., scales="free_x")
pMNGtoRPDcon_sub <- pMNGtoRPDcon_sub + labs(title="Association of Spatial Determinants with MNG to RPD Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# OPM to RPD: WoE Contrast values
pOPMtoRPDcon_sub <- ggplot() + geom_line(data=subOPMtoRPD, aes(x=Range_Upper_Limit., y=Contrast, colour=Time.Interval))
pOPMtoRPDcon_sub <- pOPMtoRPDcon_sub + facet_wrap(~ Variable., scales="free_x")
pOPMtoRPDcon_sub <- pOPMtoRPDcon_sub + labs(title="Association of Spatial Determinants with OPM to RPD Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# RBR to RPD: WoE Contrast values
pRBRtoRPDcon_sub <- ggplot() + geom_line(data=subRBRtoRPD, aes(x=Range_Upper_Limit., y=Contrast, colour=Time.Interval))
pRBRtoRPDcon_sub <- pRBRtoRPDcon_sub + facet_wrap(~ Variable., scales="free_x")
pRBRtoRPDcon_sub <- pRBRtoRPDcon_sub + labs(title="Association of Spatial Determinants with RBR to RPD Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")
# SHB to RPD: WoE Contrast values
pSHBtoRPDcon_sub <- ggplot() + geom_line(data=subSHBtoRPD, aes(x=Range_Upper_Limit., y=Contrast, colour=Time.Interval))
pSHBtoRPDcon_sub <- pSHBtoRPDcon_sub + facet_wrap(~ Variable., scales="free_x")
pSHBtoRPDcon_sub <- pSHBtoRPDcon_sub + labs(title="Association of Spatial Determinants with SHB to RPD Transition",
                                    x="Ranges", y="Contrast", colour="Time-Interval")

# Save Plots: Select Variables Per Transition -----------
setwd(DirPLOT)
ggsave(pFORtoRPDcon_sub, file="TNI_SelectVariables_FORtoRPD_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pMNGtoRPDcon_sub, file="TNI_SelectVariables_MNGtoRPD_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pOPMtoRPDcon_sub, file="TNI_SelectVariables_OPMtoRPD_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pRBRtoRPDcon_sub, file="TNI_SelectVariables_RBRtoRPD_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)
ggsave(pSHBtoRPDcon_sub, file="TNI_SelectVariables_SHBtoRPD_SD_Con.pdf", width=30, height=20, units="cm", dpi=300)

