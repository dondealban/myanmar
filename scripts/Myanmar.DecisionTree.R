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

# Notation: INC = include class; EXC = exclude class

# Level 1: vegetation | non-vegetation
data$LC1[data$LC_TYPE=="FOR" | data$LC_TYPE=="MNG" | data$LC_TYPE=="OPM" | data$LC_TYPE=="RBM" | data$LC_TYPE=="SHB"] <- "INC"
data$LC1[data$LC_TYPE!="FOR" & data$LC_TYPE!="MNG" & data$LC_TYPE!="OPM" & data$LC_TYPE!="RBM" & data$LC_TYPE!="SHB"] <- "EXC"

# Level 2: forest | shrubs/orchards | mangrove/oil palm/rubber
data$LC2[data$LC1=="EXC"] <- "EXC"
data$LC2[data$LC1=="INC" & data$LC_TYPE=="FOR"] <- "EXC"
data$LC2[data$LC1=="INC" & data$LC_TYPE=="SHB"] <- "EXC"
data$LC2[data$LC1=="INC" & data$LC_TYPE=="MNG"] <- "INC"
data$LC2[data$LC1=="INC" & data$LC_TYPE=="OPM"] <- "INC"
data$LC2[data$LC1=="INC" & data$LC_TYPE=="RBM"] <- "INC"

# Level 3: mangrove | oil palm/rubber
data$LC3[data$LC2=="EXC"] <- "EXC"
data$LC3[data$LC2=="INC" & data$LC_TYPE=="MNG"] <- "EXC"
data$LC3[data$LC2=="INC" & data$LC_TYPE=="OPM"] <- "INC"
data$LC3[data$LC2=="INC" & data$LC_TYPE=="RBM"] <- "INC"

# Level 4: oil palm | rubber
data$LC4[data$LC3=="EXC"] <- "EXC"
data$LC4[data$LC3=="INC" & data$LC_TYPE=="OPM"] <- "OPM"
data$LC4[data$LC3=="INC" & data$LC_TYPE=="RBM"] <- "RBM"

# Select observations per classification level and store selected data in variables

data.l1  <- data
data.l2  <- subset(data, subset=(LC1=="INC"))
data.l3  <- subset(data, subset=(LC2=="INC"))
data.l4  <- subset(data, subset=(LC3=="INC"))

# EXECUTE DECISION TREE CLASSIFICATION

# Execute tree function using specified classification level and predictor variables

tree.l1  <- tree(factor(LC1) ~ HH, data.l1)
tree.l2  <- tree(factor(LC2) ~ B4, data.l2)
tree.l3  <- tree(factor(LC3) ~ B5, data.l3)
tree.l4  <- tree(factor(LC4) ~ HH + B6, data.l4)

