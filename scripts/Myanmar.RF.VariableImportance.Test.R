# This test script assesses the variable importance of a Random Forest classification
# using the randomForest and party packages. The objective is to determine the importance
# of predictor variables and to subsequently select variables that contribute to improving
# model performance and to exclude variables that do not improve model performance.
#
# Script By:      Jose Don T De Alban
# Date Created:   03 Mar 2017
# Last Modified:  


# LOAD LIBRARIES AND DATA

# Set working directory
setwd("/Users/dondealban/Dropbox/Research/myanmar/variable importance/")

# Load the required R libraries
library(randomForest)
library(party)
library(ggcorrplot)

# Read data, define variables, and store data in variables
data <- read.csv(file="/Users/dondealban/Dropbox/Research/myanmar/image statistics/distribution/
                 set a/Table_SetA_1995_2015_Merge_ForR.csv", header=TRUE, sep=",")


# SUBSET DATA AND STORE INTO VARIABLES

# Subset data by year
data1995 <- subset(data, data$YEAR=="1995")
data2015 <- subset(data, data$YEAR=="2015")

# Subset data containing only numerical type variables by year
ndata1995 <- data1995[, c(3:24)]
ndata2015 <- data2015[, c(3,24)]


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

# randomForest implementation
rf1995 <- randomForest(LC_TYPE ~ B1 + B2 + B3 + B4 + B5 + B7 + B6_B10 + B6_B11 + EVI +
                       HH + HH_ASM + HH_CON + HH_COR + HH_DIS + HH_ENT + HH_IDM + HH_SAVG +
                       HH_VAR + LSWI + NDTI + NDVI + SATVI, data=data1995,
                       mtry=2, ntree=50, importance=TRUE)
rf2015 <- randomForest(LC_TYPE ~ B1 + B2 + B3 + B4 + B5 + B7 + B6_B10 + B6_B11 + EVI +
                       HH + HH_ASM + HH_CON + HH_COR + HH_DIS + HH_ENT + HH_IDM + HH_SAVG +
                       HH_VAR + LSWI + NDTI + NDVI + SATVI, data=data2015,
                       mtry=2, ntree=50, importance=TRUE)

# randomForest variable importance based on permutation importance (mean decrease in accuracy)
rf1995t1 <- importance(rf1995, type=1)
rf2015t1 <- importance(rf2015, type=1)

# randomForest variable importance based on Gini importance (mean decrease in impurity)
rf1995t2 <- importance(rf1995, type=2)
rf2015t2 <- importance(rf2015, type=2)


# SAVE OUTPUTS TO FILE

# Save correlation matrices as pdf files

pdf("output-correlation-matrix-1995.pdf", width=7, height=5.5)
plot(cor1995cm)
text(cor1995cm, cex=0.70)
dev.off()
pdf("output-correlation-matrix-2015.pdf", width=7, height=5.5)
plot(cor1995cm)
text(cor1995cm, cex=0.70)
dev.off()

# Save random forest and variable importance results as txt file

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