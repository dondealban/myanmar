# Script Description --------------------
# This script creates a stacked area graph of multi-temporal land cover data, particularly
# the land cover maps produced using combined Landsat+SAR data (optical Landsat 5 TM/8 OLI;
# L-band SAR JERS-1/ALOS-PALSAR-1/ALOS-PALSAR-2) at three time-points: 1996,2007,2016 for
# Myanmar. The land cover maps consist of 10 categories including: bare ground, built-up,
# forest, ice/snow, mangrove, oil palm, rice paddy, rubber, shrubland, water.
#
# Script By:      Jose Don T De Alban
# Date Created:   20 Nov 2017
# Last Modified:  26 Sep 2018


# Set Working Directory -----------------
setwd("/Users/dondealban/Dropbox/Research/myanmar/3 mmr land cover transitions/stacked area")

# Load Libraries and Data ---------------
#(ggplot2)
library(reshape2)
#library(plyr)
library(tidyverse)

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
colnames(temp) <- c("1","2","3","4","5","6","7","8","9","10")

# Add years as another column
row.names(temp) <- c("1996","2007","2016")

# Convert wide format data frame into long format data frame
data <- melt(temp, id.vars="years", variable.name="class", value.name="percentage")
colnames(data) <- c("Years","Class","Percentage")

# Create Stacked Area Graphs ------------

plot <- ggplot() + geom_area(aes(x=Years, y=Percentage, fill=factor(Class,
                   labels=c("Built-up",
                            "Forest",
                            "Ice and Snow",
                            "Mangrove",
                            "Oil Palm Mature",
                            "Rice Paddy",
                            "Rubber Mature",
                            "Shrubland",
                            "Water",
                            "Bare Ground"))), 
                   data=data)
plot <- plot + labs(title="Land Cover Transitions", x="Year", y="Percentage of Landscape", fill="Land Cover Category")
plot <- plot + guides(fill=guide_legend(ncol=1))
plot <- plot + theme(legend.position="bottom")
plot <- plot + theme_bw()
plot <- plot + scale_fill_manual(values=c("#6a3d9a","#33a02c","#a6cee3","#e31a1c","#ff7f00",
                                          "#ffff99","#fdbf6f","#fb9a99","#1f78b4","#b15928"))
plot <- plot + scale_x_discrete(breaks=c("1996","2007","2016"))

ggsave(plot, file="StackedArea-01-Myanmar.pdf", width=19.89, height=15, units="cm", dpi=300)
