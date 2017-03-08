# This script assesses variable importance and implements variable selection from a 
# Random Forest classification using the VSURF package. The objective is to determine
# the importance of predictor variables, to select variables that contribute to
# improving model performance, and to exclude variables that do not improve model
# performance.
#
# Script By:      Jose Don T De Alban
# Date Created:   03 Mar 2017
# Last Modified:  08 Mar 2017


# LOAD LIBRARIES AND DATA

# Set working directory
setwd("/Users/dondealban/Dropbox/Research/myanmar/variable importance/")

# Load the required R libraries
library(VSURF)

# Read data, define variables, and store data in variables
SetA <- read.csv(file="/Users/dondealban/Dropbox/Research/myanmar/image statistics/distribution/set a/Table_SetA_1995_2015_Merge_ForR.csv", header=TRUE, sep=",")
SetB <- read.csv(file="/Users/dondealban/Dropbox/Research/myanmar/image statistics/distribution/set b/Table_Table_SetB_2015_LP_1D_30m_RF_ForR.csv", header=TRUE, sep=",")


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
# Note: total predictor variables n=22; mtry=n/3
vsSetA1995 <- VSURF(formula=LC_TYPE ~ B1 + B2 + B3 + B4 + B5 + B7 + B6_B10 + B6_B11 + EVI +
              HH + HH_ASM + HH_CON + HH_COR + HH_DIS + HH_ENT + HH_IDM + HH_SAVG + HH_VAR +
              LSWI + NDTI + NDVI + SATVI, data=SetA1995, mtry=7, ntree=100,
              na.action = na.omit)
vsSetA2015 <- VSURF(formula=LC_TYPE ~ B1 + B2 + B3 + B4 + B5 + B7 + B6_B10 + B6_B11 + EVI +
              HH + HH_ASM + HH_CON + HH_COR + HH_DIS + HH_ENT + HH_IDM + HH_SAVG + HH_VAR +
              LSWI + NDTI + NDVI + SATVI, data=SetA2015, mtry=7, ntree=100, 
              na.action = na.omit)

# Set B vsurf package implementation
# Note: total predictor variables n=37; mtry=n/3
vsSetB2015 <- VSURF(formula=LC_TYPE ~ AVE + B2 + B3 + B4 + B5 + B6 + B7 + B10 + B11 + DIF + EVI +
              HH + HH_ASM + HH_CON + HH_COR + HH_DIS + HH_ENT + HH_IDM + HH_SAVG + HH_VAR +
              HV + HV_ASM + HV_CON + HV_COR + HV_DIS + HV_ENT + HV_IDM + HV_SAVG + HV_VAR +
              LSWI + NDI + NDTI + NDVI + NLI + RT1 + RT2 + SATVI, data=SetB2015,
              mtry=12, ntree=100, na.action = na.omit)

# SAVE OUTPUTS TO FILE


# Save vsurf package plots as pdf files and summaries as txt files

# Summaries
sink("output-rf-vsurf-1995.txt", append=FALSE, split=TRUE)
print(summary(vs1995))
print(number[vs1995$varselect.thres])
print(number[vs1995$varselect.interp])
print(number[vs1995$varselect.pred])
sink()
sink("output-rf-vsurf-2015.txt", append=FALSE, split=TRUE)
print(summary(vs2015))
print(number[vs2015$varselect.thres])
print(number[vs2015$varselect.interp])
print(number[vs2015$varselect.pred])
sink()

# 1995 plots
pdf("output-rf-vsurf-plot-00-allsteps-1995.pdf", width=7, height=5.5)
plot(vs1995)
dev.off()
pdf("output-rf-vsurf-plot-01-threshold-1995.pdf", width=7, height=5.5)
plot(vs1995, step="thres", imp.sd=TRUE, var.names = TRUE)
dev.off()
pdf("output-rf-vsurf-plot-02-interpret-1995.pdf", width=7, height=5.5)
plot(vs1995, step="interp", imp.sd=TRUE, var.names = TRUE)
dev.off()
pdf("output-rf-vsurf-plot-03-predict-1995.pdf", width=7, height=5.5)
plot(vs1995, step="pred", imp.sd=TRUE, var.names = TRUE)
dev.off()

# 2015 plots
pdf("output-rf-vsurf-plot-00-allsteps-2015.pdf", width=7, height=5.5)
plot(vs2015)
dev.off()
pdf("output-rf-vsurf-plot-01-threshold-2015.pdf", width=7, height=5.5)
plot(vs2015, step="thres", imp.sd=TRUE, var.names = TRUE)
dev.off()
pdf("output-rf-vsurf-plot-02-interpret-2015.pdf", width=7, height=5.5)
plot(vs2015, step="interp", imp.sd=TRUE, var.names = TRUE)
dev.off()
pdf("output-rf-vsurf-plot-03-predict-2015.pdf", width=7, height=5.5)
plot(vs2015, step="pred", imp.sd=TRUE, var.names = TRUE)
dev.off()