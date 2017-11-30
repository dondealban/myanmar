# Script Description --------------------
# This script creates line graphs plotting the map similarity results to validate the
# land use/cover change simulations using Dinamica EGO. The land cover datasets used
# consists of time-series land cover data, particularly the ESA CCI land cover data 
# (1992-2015), covering Tanintharyi, Myanmar. The original land cover classes were
# reclassified into four bespoke classes: Forest (FOR), Other Vegetation (VEG),
# Cropland (CRP), and Non-Vegetation (NON).
#
# Script By:      Jose Don T De Alban
# Date Created:   22 Nov 2017
# Last Modified:  30 Nov 2017


# Load Libraries and Data ---------------
library(ggplot2)
library(reshape2)
library(plyr)


# Set 01 --------------------------------

# Set working directory
setwd("/Users/dondealban/Dropbox/Research/myanmar/simulation/validation/tanintharyi/bespoke/set 01/")

# Read CSV data file
dataSet1 <- read.csv(file="tni_multiple_windows_similarity_sub_1992_2015.csv", header=TRUE, sep=",")
colnames(dataSet1) <- c("Window.Size","Min.Sim","Max.Sim") # Rename column names
dfSet1 <- melt(dataSet1, id.vars="Window.Size", na.rm=TRUE)

# Create line graphs
plotSet1 <- ggplot() + geom_line(data=dfSet1, aes(x=Window.Size, y=value, colour=variable))
plotSet1 <- plotSet1 + labs(title="Observed vs Actual Map Similarity", 
                            subtitle="Time Interval: 1992-2015",
                            x="Window Size", y="Map Similarity (%)")
plotSet1 <- plotSet1 + scale_colour_manual(values=variable, name="Similarity", labels = c("Minimum","Maximum"))
plotSet1 <- plotSet1 + ylim(0,1) + xlim(0,12)
plotSet1 <- plotSet1 + theme_minimal()

# ggsave(bespoke, file="StackedArea-Bespoke.pdf", width=19.89, height=15, units="cm", dpi=300)

# Set 02 --------------------------------

# Set working directory
setwd("/Users/dondealban/Dropbox/Research/myanmar/simulation/validation/tanintahryi/bespoke/set 02/")

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
row.names(temp) <- c("1992","1993","1994","1995","1996","1997","1998","1999",
                     "2000","2001","2002","2003","2004","2005","2006","2007",
                     "2008","2009","2010","2011","2012","2013","2014","2015")

# Convert wide format data frame into long format data frame
data <- melt(temp, id.vars="years", variable.name="class", value.name="percentage")
colnames(data) <- c("Years","Class","Percentage")

# Create Stacked Area Graphs ------------

bespoke <- ggplot() + geom_area(aes(x=Years, y=Percentage, fill=factor(Class, labels=c("Cropland","Other Vegetation","Forest","Non-Vegetation"))), data=data)
bespoke <- bespoke + labs(title="Land Cover Transitions", x="Year", y="Percentage of Landscape", fill="Land Cover")
bespoke <- bespoke + theme_bw() +scale_fill_manual(values=c("#ffff64","#8ca000","#003c00","#a6cee3"))

ggsave(bespoke, file="StackedArea-Bespoke.pdf", width=19.89, height=15, units="cm", dpi=300)

