# Script Description --------------------
# This R script generates barplots using ggplot2 package to visualise the which land cover
# categories are mangroves losing to and gaining from the most in each time-interval across
# all mangrove regions in Myanmar.
#
# Script By:      Jose Don T De Alban
# Date Created:   13 Dec 2018
# Last Modified:  

# Set Working Directory -------------------
setwd("/Users/dondealban/Dropbox/Research/myanmar/3 mmr land cover transitions/mangroves/")

# Load Libraries --------------------------
library(tidyverse)

# Read Input Data -------------------------
csv <- read.csv(file="Loss & Gain Totals.csv", header=TRUE, sep=",")

