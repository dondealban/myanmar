# Script Description --------------------
# This R script generates line graphs using tidyverse package to visualise estimates of
# areal extents of mangroves at specific time-points in Myanmar and its sub-national units
# reported from published studies.
#
# Script By:      Jose Don T De Alban
# Date Created:   15 Jan 2019
# Last Modified:  

# Set Working Directory -------------------
setwd("/Users/dondealban/Dropbox/Research/myanmar/3 mmr land cover transitions/mangroves/")

# Load Libraries --------------------------
library(tidyverse)

# Read Input Data -------------------------
dfAREAL <- read.csv(file="Areal_Extents_Comparison.csv", header=TRUE, sep=",")
