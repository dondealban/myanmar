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
data <- read.csv("/Users/dondealban/Dropbox/Research/myanmar/image statistics/distribution/
                 set a/Table_SetA_1995_2015_Merge_ForR.csv", header=TRUE, sep=",")