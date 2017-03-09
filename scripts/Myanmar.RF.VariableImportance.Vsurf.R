# This script assesses variable importance and implements variable selection from a 
# Random Forest classification using the VSURF package. The objective is to determine
# the importance of predictor variables, to select variables that contribute to
# improving model performance, and to exclude variables that do not improve model
# performance.
#
# Script By:      Jose Don T De Alban
# Date Created:   03 Mar 2017
# Last Modified:  09 Mar 2017


# LOAD LIBRARIES AND DATA

# Set working directory
setwd("/Users/dondealban/Dropbox/Research/myanmar/variable importance/")

# Load the required R libraries
library(VSURF)

# Read data, define variables, and store data in variables
SetA <- read.csv(file="/Users/dondealban/Dropbox/Research/myanmar/image statistics/distribution/set a/Table_SetA_1995_2015_Merge_ForR.csv", header=TRUE, sep=",")
SetB <- read.csv(file="/Users/dondealban/Dropbox/Research/myanmar/image statistics/distribution/set b/Table_SetB_2015_LP_1D_30m_RF_ForR.csv", header=TRUE, sep=",")


# SET RANDOM SEED
set.seed(2017)


# SUBSET DATA AND STORE INTO VARIABLES

# Subset data by year
SetA1995 <- subset(SetA, SetA$YEAR=="1995")
SetA2015 <- subset(SetA, SetA$YEAR=="2015")
SetB2015 <- subset(SetB, SetB$YEAR=="2015")

# Define factor predictor variables
# LC_TYPE
SetA1995$LC_TYPE <- factor(SetA1995$LC_TYPE)
SetA2015$LC_TYPE <- factor(SetA2015$LC_TYPE)
SetB2015$LC_TYPE <- factor(SetB2015$LC_TYPE)
# Year
SetA1995$YEAR <- factor(SetA1995$YEAR)
SetA2015$YEAR <- factor(SetA2015$YEAR)
SetB2015$YEAR <- factor(SetB2015$YEAR)


# RUN RANDOM FOREST IMPLEMENTATION ON SET A

# Set A vsurf package implementation
# Note: total predictor variables n=22; default values used for mtry=n and ntree=2000
vsSetA1995 <- VSURF(formula=LC_TYPE ~ B1 + B2 + B3 + B4 + B5 + B7 + B6_B10 + B6_B11 + EVI +
              HH + HH_ASM + HH_CON + HH_COR + HH_DIS + HH_ENT + HH_IDM + HH_SAVG + HH_VAR +
              LSWI + NDTI + NDVI + SATVI, data=SetA1995, 
              na.action = na.omit)
vsSetA2015 <- VSURF(formula=LC_TYPE ~ B1 + B2 + B3 + B4 + B5 + B7 + B6_B10 + B6_B11 + EVI +
              HH + HH_ASM + HH_CON + HH_COR + HH_DIS + HH_ENT + HH_IDM + HH_SAVG + HH_VAR +
              LSWI + NDTI + NDVI + SATVI, data=SetA2015, 
              na.action = na.omit)

# Save Set A summaries as txt files

numSetA <- c(4:25)

sink("output-rf-summary-SetA1995.txt", append=FALSE, split=TRUE)
print(summary(vsSetA1995))
print(numSetA[vsSetA1995$varselect.thres])
print(numSetA[vsSetA1995$varselect.interp])
print(numSetA[vsSetA1995$varselect.pred])
sink()
sink("output-rf-summary-SetA2015.txt", append=FALSE, split=TRUE)
print(summary(vsSetA2015))
print(numSetA[vsSetA2015$varselect.thres])
print(numSetA[vsSetA2015$varselect.interp])
print(numSetA[vsSetA2015$varselect.pred])
sink()

# Save Set A plots as pdf files

# SetA 1995 plots
pdf("output-rf-plot-00-allsteps-SetA1995.pdf", width=14, height=11)
plot(vsSetA1995)
dev.off()
pdf("output-rf-plot-01-threshold-SetA1995.pdf", width=14, height=11)
plot(vsSetA1995, step="thres", imp.sd=TRUE, var.names = TRUE)
dev.off()
pdf("output-rf-plot-02-interpret-SetA1995.pdf", width=14, height=11)
plot(vsSetA1995, step="interp", imp.sd=TRUE, var.names = TRUE)
dev.off()
pdf("output-rf-plot-03-predict-SetA1995.pdf", width=14, height=11)
plot(vsSetA1995, step="pred", imp.sd=TRUE, var.names = TRUE)
dev.off()

# SetA 2015 plots
pdf("output-rf-plot-00-allsteps-SetA2015.pdf", width=14, height=11)
plot(vsSetA2015)
dev.off()
pdf("output-rf-plot-01-threshold-SetA2015.pdf", width=14, height=11)
plot(vsSetA2015, step="thres", imp.sd=TRUE, var.names = TRUE)
dev.off()
pdf("output-rf-plot-02-interpret-SetA2015.pdf", width=14, height=11)
plot(vsSetA2015, step="interp", imp.sd=TRUE, var.names = TRUE)
dev.off()
pdf("output-rf-plot-03-predict-SetA2015.pdf", width=14, height=11)
plot(vsSetA2015, step="pred", imp.sd=TRUE, var.names = TRUE)
dev.off()


# RUN RANDOM FOREST IMPLEMENTATION ON SET B

# Set B vsurf package implementation
# Note: total predictor variables n=37; default values used for mtry=n and ntree=2000
vsSetB2015 <- VSURF(formula=LC_TYPE ~ AVE + B2 + B3 + B4 + B5 + B6 + B7 + B10 + B11 + DIF + EVI +
              HH + HH_ASM + HH_CON + HH_COR + HH_DIS + HH_ENT + HH_IDM + HH_SAVG + HH_VAR +
              HV + HV_ASM + HV_CON + HV_COR + HV_DIS + HV_ENT + HV_IDM + HV_SAVG + HV_VAR +
              LSWI + NDI + NDTI + NDVI + NLI + RT1 + RT2 + SATVI, data=SetB2015,
              na.action = na.omit)

# Save Set B summaries as txt files

numSetB <- c(4:40)

sink("output-rf-summary-SetB2015.txt", append=FALSE, split=TRUE)
print(summary(vsSetB2015))
print(numSetB[vsSetB2015$varselect.thres])
print(numSetB[vsSetB2015$varselect.interp])
print(numSetB[vsSetB2015$varselect.pred])
sink()

# Save Set B plots as pdf files

# SetB 2015 plots
pdf("output-rf-plot-00-allsteps-SetB2015.pdf", width=14, height=11)
plot(vsSetB2015)
dev.off()
pdf("output-rf-plot-01-threshold-SetB2015.pdf",width=14, height=11)
plot(vsSetB2015, step="thres", imp.sd=TRUE, var.names = TRUE)
dev.off()
pdf("output-rf-plot-02-interpret-SetB2015.pdf", width=14, height=11)
plot(vsSetB2015, step="interp", imp.sd=TRUE, var.names = TRUE)
dev.off()
pdf("output-rf-plot-03-predict-SetB2015.pdf", width=14, height=11)
plot(vsSetB2015, step="pred", imp.sd=TRUE, var.names = TRUE)
dev.off()
