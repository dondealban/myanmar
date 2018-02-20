# Script Description --------------------
# This script creates a stacked area graph of time-series land cover data, particularly
# the ESA CCI land cover data (1992-2015) using original land cover categories.
#
# Script By:      Jose Don T De Alban
# Date Created:   20 Nov 2017
# Last Modified:  20 Feb 2018


# Set Working Directory -----------------
setwd("/Users/dondealban/Dropbox/Research/myanmar/intensity analysis/stacked area/kachin/original/")

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
colnames(temp) <- c("1","2","3","4","5",
                    "13","14","15","16",
                    "6","7","8","9","10","11","12",
                    "17","18","19","20","21")

# Add years as another column
row.names(temp) <- c("1992","1993","1994","1995","1996","1997","1998","1999",
                     "2000","2001","2002","2003","2004","2005","2006","2007",
                     "2008","2009","2010","2011","2012","2013","2014","2015")

# Convert wide format data frame into long format data frame
data <- melt(temp, id.vars="years", variable.name="class", value.name="percentage")
colnames(data) <- c("Years","Class","Percentage")

# Create Stacked Area Graphs ------------

orig <- ggplot() + geom_area(aes(x=Years, y=Percentage, fill=factor(Class,
                   labels=c("Cropland, rainfed",
                            "Cropland, herbaceous cover",
                            "Cropland, irrigated or post-flooding",
                            "Mosaic cropland (>50%) / natural vegetation (tree, shrub, herbaceous cover) (<50%)",
                            "Mosaic natural vegetation (tree, shrub, herbaceous cover) (>50%) / cropland (<50%)",
                            "Mosaic tree and shrub (>50%) / herbaceous cover (<50%)",
                            "Mosaic herbaceous cover (>50%) / tree and shrub (<50%)",
                            "Shrubland",
                            "Shrubland, evergreen",
                            "Shrubland, deciduous",
                            "Grassland",
                            "Sparse vegetation (tree, shrub, herbaceous cover) (<15%)",
                            "Tree cover, broadleaved, evergreen, closed to open (>15%)",
                            "Tree cover, broadleaved, deciduous, closed to open (>15%)",
                            "Tree cover, broadleaved, deciduous, closed (>40%)",
                            "Tree cover, needleleaved, evergreen, closed to open (>15%)",
                            "Tree cover, flooded, saline water",
                            "Shrub or herbaceous cover, flooded, fresh/saline/brakish water",
                            "Urban areas",
                            "Bare areas",
                            "Water bodies"))), 
                             data=data)
orig <- orig + labs(title="Land Cover Transitions", x="Year", y="Percentage of Landscape", fill="Land Cover (Original)")
orig <- orig + guides(fill=guide_legend(ncol=1))
orig <- orig + theme(legend.position="bottom")
orig <- orig + theme_bw()
orig <- orig + scale_fill_manual(values=c("#ffff64","#ffff64","#aaf0f0","#dcf064","#c8c864",
                                          "#8ca000","#be9600","#966400","#784b00","#966400","#ffb432","#ffebaf",
                                          "#006400","#00a000","#00a000","#003c00",
                                          "#009678","#00dc82","#c31400","#fff5d7","#0046c8"))

ggsave(orig, file="StackedArea-Original.pdf", width=29, height=16, units="cm", dpi=300)
