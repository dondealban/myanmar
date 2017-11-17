# Script Description --------------------
# This script creates a stacked area graph of time-series land cover data. 
#
# Script By:      Jose Don T De Alban
# Date Created:   17 Nov 2017
# Last Modified:  


# Set Working Directory -----------------
setwd("/Users/dondealban/Dropbox/Research/myanmar/intensity analysis/stacked area/ipcc/")

# Load Libraries and Data ---------------
library(ggplot2)


# Read data, define variables, and store data in variables
c1992 <- read.csv(file="Landscape_1992_Reclass.csv", header=TRUE, sep=",")
