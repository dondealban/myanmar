# Script Description --------------------
# This script creates a stacked area graph of multi-temporal land cover data, particularly
# the land cover maps produced using combined Landsat and L-band SAR data at three time-
# points: 1996, 2007, and 2016 for Tanintharyi Region, Myanmar. The land cover maps consist
# of 9 categories including: bare ground, built-up area, forest, mangrove, oil palm, rice 
# paddy, rubber, shrub/orchard, and water body.
#
# Script By:      Jose Don T De Alban
# Date Created:   20 Nov 2017
# Last Modified:  16 Apr 2020


# Set Working Directory -----------------
setwd("/Users/dondealban/Tanintharyi")

# Load Libraries and Data ---------------
library(reshape2)
library(ggplot2)

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
colnames(temp) <- c("1","2","3","4","5","6","7","8","9")

# Add years as another column
row.names(temp) <- c("1996","2007","2016")

# Convert wide format data frame into long format data frame
data <- melt(temp, id.vars="years", variable.name="class", value.name="percentage")
colnames(data) <- c("Years","Class","Percentage")

# Create Stacked Area Graphs ------------

plot <- ggplot() + geom_area(aes(x=Years, y=Percentage, fill=factor(Class,
                   labels=c("Bare Ground",
                            "Built-up Area",
                            "Forest",
                            "Mangrove",
                            "Oil Palm",
                            "Rice Paddy",
                            "Rubber",
                            "Shrub/Orchard",
                            "Water Body"))), 
                   data=data)
plot <- plot + labs(x="Year", y="Percentage of Landscape", fill="Land Cover Category")
plot <- plot + scale_fill_manual(values=c("#ffff66","#ff0000","#246a24","#6666ff","#ff8000",
                                          "#a65400","#ff00ff","#ccff66","#66ccff"))
plot <- plot + scale_x_continuous(breaks=c(1996,2007,2016))
plot <- plot + theme_bw()
plot <- plot + theme(legend.position="bottom", legend.box="horizontal", legend.title = element_blank())

ggsave(plot, file="StackedArea-00-Tanintharyi.pdf", width=16, height=15, units="cm", dpi=300)
