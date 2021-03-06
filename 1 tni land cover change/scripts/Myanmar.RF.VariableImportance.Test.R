# This test script assesses the variable importance of a Random Forest classification
# using the randomForest, party, and VSURF packages. The objective is to determine the
# importance of predictor variables, to select variables that contribute to improving
# model performance, and to exclude variables that do not improve model performance.
#
# Script By:      Jose Don T De Alban
# Date Created:   03 Mar 2017
# Last Modified:  08 Mar 2017


# LOAD LIBRARIES AND DATA

# Set working directory
setwd("/Users/dondealban/Dropbox/Research/myanmar/variable importance/")

# Load the required R libraries
library(randomForest)
library(party)
library(corrplot)
library(ggcorrplot)
library(VSURF)

# Read data, define variables, and store data in variables
data <- read.csv(file="/Users/dondealban/Dropbox/Research/myanmar/image statistics/distribution/set a/Table_SetA_1995_2015_Merge_ForR.csv", header=TRUE, sep=",")


# SUBSET DATA AND STORE INTO VARIABLES

# Subset data by year
data1995 <- subset(data, data$YEAR=="1995")
data2015 <- subset(data, data$YEAR=="2015")

# Subset data containing only numerical type variables by year
ndata1995 <- data1995[, c(4:24)]
ndata2015 <- data2015[, c(4:24)]


# SET RANDOM SEED
set.seed(2017)


# CALCULATE AND PLOT CORRELATION MATRICES

# Calculate correlation matrices
cor1995 <- cor(ndata1995)
cor2015 <- cor(ndata2015)

# Plot correlation matrices for visualisation
cor1995cm <- ggcorrplot(cor1995, hc.order=TRUE)
cor2015cm <- ggcorrplot(cor2015, hc.order=TRUE)


# RUN RANDOM FOREST IMPLEMENTATION

# Define factor predictor variables
data1995$LC_TYPE <- factor(data1995$LC_TYPE)
data2015$LC_TYPE <- factor(data2015$LC_TYPE)
data1995$YEAR <- factor(data1995$YEAR)
data2015$YEAR <- factor(data2015$YEAR)

# randomForest package implementation
rf1995 <- randomForest(LC_TYPE ~ B1 + B2 + B3 + B4 + B5 + B7 + B6_B10 + B6_B11 + EVI +
                       HH + HH_ASM + HH_CON + HH_COR + HH_DIS + HH_ENT + HH_IDM + HH_SAVG +
                       HH_VAR + LSWI + NDTI + NDVI + SATVI, data=data1995,
                       mtry=7, ntree=100, importance=TRUE)
rf2015 <- randomForest(LC_TYPE ~ B1 + B2 + B3 + B4 + B5 + B7 + B6_B10 + B6_B11 + EVI +
                       HH + HH_ASM + HH_CON + HH_COR + HH_DIS + HH_ENT + HH_IDM + HH_SAVG +
                       HH_VAR + LSWI + NDTI + NDVI + SATVI, data=data2015,
                       mtry=7, ntree=100, importance=TRUE)

# randomForest variable importance based on permutation importance (mean decrease in accuracy)
rf1995t1 <- importance(rf1995, type=1)
rf2015t1 <- importance(rf2015, type=1)

# randomForest variable importance based on Gini importance (mean decrease in impurity)
rf1995t2 <- importance(rf1995, type=2)
rf2015t2 <- importance(rf2015, type=2)

# party package implementation
cf1995 <- cforest(LC_TYPE ~ B1 + B2 + B3 + B4 + B5 + B7 + B6_B10 + B6_B11 + EVI + 
                  HH + HH_ASM + HH_CON + HH_COR + HH_DIS + HH_ENT + HH_IDM + HH_SAVG +
                  HH_VAR + LSWI + NDTI + NDVI + SATVI, data=data1995, 
                  control=cforest_unbiased(mtry=7, ntree=100))
cf2015 <- cforest(LC_TYPE ~ B1 + B2 + B3 + B4 + B5 + B7 + B6_B10 + B6_B11 + EVI + 
                  HH + HH_ASM + HH_CON + HH_COR + HH_DIS + HH_ENT + HH_IDM + HH_SAVG +
                  HH_VAR + LSWI + NDTI + NDVI + SATVI, data=data2015, 
                  control=cforest_unbiased(mtry=7, ntree=100))

# vsurf package implementation
vs1995 <- VSURF(formula=LC_TYPE ~ B1 + B2 + B3 + B4 + B5 + B7 + B6_B10 + B6_B11 + EVI +
                HH + HH_ASM + HH_CON + HH_COR + HH_DIS + HH_ENT + HH_IDM + HH_SAVG +
                HH_VAR + LSWI + NDTI + NDVI + SATVI, data=data1995, mtry=7, ntree=100,
                na.action = na.omit)
vs2015 <- VSURF(formula=LC_TYPE ~ B1 + B2 + B3 + B4 + B5 + B7 + B6_B10 + B6_B11 + EVI +
                HH + HH_ASM + HH_CON + HH_COR + HH_DIS + HH_ENT + HH_IDM + HH_SAVG +
                HH_VAR + LSWI + NDTI + NDVI + SATVI, data=data2015, mtry=7, ntree=100, 
                na.action = na.omit)


# SAVE OUTPUTS TO FILE

# Save correlation matrices as pdf files

ggsave(cor1995cm, file="output-correlation-matrix-1995.pdf", width=7, height=5.5, units="in", dpi=300)
ggsave(cor2015cm, file="output-correlation-matrix-2015.pdf", width=7, height=5.5, units="in", dpi=300)

# Save random forest package results as txt file

sink("output-rf-randomforest-1995.txt", append=FALSE, split=TRUE)
print(rf1995)
print(rf1995t1)
print(rf1995t2)
sink()
sink("output-rf-randomforest-2015.txt", append=FALSE, split=TRUE)
print(rf2015)
print(rf2015t1)
print(rf2015t2)
sink()

# Save graph of random forest variable importance as pdf file

pdf("output-rf-varimp-graph-1995.pdf", width=7, height=5.5)
varImpPlot(rf1995)
dev.off()
pdf("output-rf-varimp-graph-2015.pdf", width=7, height=5.5)
varImpPlot(rf2015)
dev.off()

# Save party package results as txt file
# Note: for party implementation of variable importance, conditional setting was set to
# "FALSE" instead of "TRUE" due to errors encountered--i.e., crashes RStudio application

sink("output-rf-party-1995.txt", append=FALSE, split=TRUE)
print(cf1995)
print(system.time(vi1995 <- varimp(cf1995, conditional=FALSE)))
print(vi1995)
sink()
sink("output-rf-party-2015.txt", append=FALSE, split=TRUE)
print(cf2015)
print(system.time(vi2015 <- varimp(cf2015, conditional=FALSE)))
print(vi2015)
sink()

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