# Script Description --------------------
# This script creates a stacked area graph of time-series land cover data, particularly
# the ESA CCI land cover data (1992-2015), reclassifed to aggregated broad land cover
# categories such as Forest, Cropland, Other Vegetation, and Non-Vegetation. 
#
# Script By:      Jose Don T De Alban
# Date Created:   22 Nov 2017
# Last Modified:  23 Feb 2018


# Set Working Directory -----------------
setwd("/Users/dondealban/Dropbox/Research/myanmar/intensity analysis/stacked area/tanintharyi/bespoke tier2/")

# Load Libraries and Data ---------------
library(ggplot2)
library(reshape2)
library(plyr)

# Read csv files in the directory and store as a list
filenames <- list.files()

# Function to read data
readdata <- function(filename) {
  df <- read.csv(filename, sep="\t")
  vec <- df[, 3]           # Read column with percentage values
  names(vec) <- df[, 1]    # Read column with class codes
  return(vec)
}

# Combine as class codes and percentage values in a matrix
temp <- do.call(rbind, lapply(filenames, readdata))
colnames(temp) <- c("3","2","1","4")

# Add years as another column
row.names(temp) <- c("1992","2015","2020","2025","2030")

# Convert wide format data frame into long format data frame
data <- melt(temp, id.vars="years", variable.name="class", value.name="percentage")
colnames(data) <- c("Years","Class","Percentage")

# Create Stacked Bar Graphs ------------
bespoke <- ggplot() + geom_bar(aes(x=as.factor(Years), y=Percentage, fill=factor(Class, labels=c("Cropland","Other Vegetation","Forest","Non-Vegetation"))), data=data, stat="identity")
bespoke <- bespoke + labs(x="Year", y="Percentage of Landscape")
bespoke <- bespoke + theme_bw() + theme(legend.position="none")
bespoke <- bespoke + scale_fill_manual(values=c("#ffff64","#8ca000","#003c00","#a6cee3"))
bespoke <- bespoke + theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank())

ggsave(bespoke, file="StackedBar-Bespoke-Tier2.pdf", width=29.7, height=8, units="cm", dpi=400)
ggsave(bespoke, file="StackedBar-Bespoke-Tier2.png", width=29.7, height=8, units="cm", dpi=400)

