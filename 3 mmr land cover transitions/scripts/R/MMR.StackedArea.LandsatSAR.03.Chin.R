# Script Description --------------------
# This script creates a stacked area graph of multi-temporal land cover data, particularly
# the land cover maps produced using combined Landsat+SAR data (optical Landsat 5 TM/8 OLI;
# L-band SAR JERS-1/ALOS-PALSAR-1/ALOS-PALSAR-2) at three time-points: 1996,2007,2016 for
# Myanmar. The land cover maps consist of 10 categories including: bare ground, built-up,
# forest, ice/snow, mangrove, oil palm, rice paddy, rubber, shrubland, water.
#
# Script By:      Jose Don T De Alban
# Date Created:   20 Nov 2017
# Last Modified:  04 Oct 2018


# Set Working Directory -----------------
setwd("/Users/dondealban/Dropbox/Research/myanmar/3 mmr land cover transitions/stacked area/3_chin")

# Load Libraries and Data ---------------
library(reshape2)
library(tidyverse)

# Read csv files in the directory and store as a list
filenames <- list.files()

# Class 3 is present only in 2007 and 2016, hence need to split files into two groups
period1 <- filenames[1]   # 1996-2007
period2 <- filenames[2:3] # 2007-2016

# Function to read data
readdata <- function(filename) {
  df <- read.csv(filename, sep="\t")
  vec <- df[, 3]           # Read column with percentage values
  names(vec) <- df[, 1]    # Read column with class codes
  return(vec)
}

# Combine as class codes and percentage values in a matrix
temp1 <- do.call(rbind, lapply(period1, readdata))
temp2 <- do.call(rbind, lapply(period2, readdata))

# Create new column with zeroes for Class 3 in 1st period and insert in matrix
temp1a <- t(as.matrix(c(temp1[,1:2], 0, temp1[,3:ncol(temp1)]))) # transposed 1x10 matrix

# Combine matrices from two periods and change column names
temp3 <- rbind(temp1a, temp2)
temp <- temp3
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
plot <- plot + labs(title="Net Land Cover Transitions: Chin State", x="Year", y="Percentage of Landscape", fill="Land Cover Category")
plot <- plot + guides(fill=guide_legend(ncol=1))
plot <- plot + theme(legend.position="bottom")
plot <- plot + theme_bw()
plot <- plot + scale_fill_manual(values=c("#ff0000","#246a24","#a6cee3","#6666ff","#ff8000",
                                          "#a65400","#ff00ff","#ccff66","#66ccff","#ffff66"))
plot <- plot + scale_x_continuous(breaks=c(1996,2007,2016))

ggsave(plot, file="StackedArea-03-Chin.pdf", width=19.89, height=15, units="cm", dpi=300)
