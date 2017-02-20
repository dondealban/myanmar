# This R script implements a decision tree classification using the tree package. The
# objective is to generate a tree based on specified predictor variables and to determine
# the variables and thresholds used for splitting classes.
#
# Script By:      Jose Don T De Alban
# Date Created:   17 Feb 2017
# Last Modified:  20 Feb 2017


# LOAD LIBRARIES AND DATA

# Set working directory
setwd("/Users/dondealban/Dropbox/Research/myanmar/decision tree/")

# Load the required R libraries
library(tree)

# Read data, define variables, and store data in variables
data <- read.csv(file="SetD_2015_LP_1D_30m_RF_9CL_ForR.csv", header=TRUE, sep=",")


# CREATE SUBSETS TO DEFINE CLASSES IN MULTI-LEVEL CLASSIFICATION

# Level 1: vegetation | non-vegetation
data$LC1[data$LC_TYPE=="FOR" | data$LC_TYPE=="MNG" | data$LC_TYPE=="OPM" | data$LC_TYPE=="RBM" | data$LC_TYPE=="SHB"] <- "VEG"
data$LC1[data$LC_TYPE!="FOR" & data$LC_TYPE!="MNG" & data$LC_TYPE!="OPM" & data$LC_TYPE!="RBM" & data$LC_TYPE!="SHB"] <- "NVG"

# Level 2: forest | shrubs/orchards | mangrove/oil palm/rubber
data$LC2[data$LC1=="NVG"] <- "NVG"
data$LC2[data$LC1!="NVG" & data$LC_TYPE=="FOR"] <- "FOR"
data$LC2[data$LC1!="NVG" & data$LC_TYPE=="SHB"] <- "SHB"
data$LC2[data$LC1!="NVG" & data$LC_TYPE!="MNG" | data$LC_TYPE=="OPM" | data$LC_TYPE=="RBM"] <- "MOR"

