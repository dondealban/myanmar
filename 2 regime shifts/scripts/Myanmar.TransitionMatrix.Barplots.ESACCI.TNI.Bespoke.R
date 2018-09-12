# Script Description --------------------
# This script creates barplots of selected land cover transitions between two time
# points from the output transition matrix calculations using Dinamica EGO. The land
# cover datasets used consists of time-series land cover data, particularly the ESA 
# CCI land cover data (1992-2015), covering Tanintharyi, Myanmar. The original land 
# cover classes were reclassified into four bespoke classes: Forest (FOR), Other 
# Vegetation (VEG), Cropland (CRP), and Non-Vegetation (NON).
#
# Script By:      Jose Don T De Alban
# Date Created:   22 Nov 2017
# Last Modified:  30 Nov 2017


# Load Libraries ------------------------
library(ggplot2)
library(reshape2)


# Set 02 --------------------------------

# Set working directory
setwd("/Users/dondealban/Dropbox/Research/myanmar/simulation/validation/tanintharyi/bespoke/set 02/transition matrix/")

# Read csv files in the directory and store as a list
tmatrices <- list.files()

# Function to read maximum similarity data
readdata <- function(filename) {
  df <- read.csv(filename, sep=",")
  vec <- df[, 3]           # Read column with maximum similarity values
  names(vec) <- df[, 1]    # Read column with window sizes
  return(vec)
}

# Combine as window sizes and similarity values in a matrix
tmSet2 <- do.call(rbind, lapply(tmatrices, readdata))

# Add years as another column
row.names(tmSet2) <- c("1992-1995","1993-1996","1994-1997","1995-1998","1996-1999",
                       "1997-2000","1998-2001","1999-2002","2000-2003","2001-2004",
                       "2002-2005","2003-2006","2004-2007","2005-2008","2006-2009",
                       "2007-2010","2008-2011","2009-2012","2010-2013","2011-2014",
                       "2012-2015")


# Convert wide format data frame into long format data frame
mxSet2 <- melt(maxSet2, id.vars="years", variable.name="windowsize", value.name="percentage")
mnSet2 <- melt(minSet2, id.vars="years", variable.name="windowsize", value.name="percentage")

# Add column to categorise maximum and minimum similarities
mxSet2$Similarity <- rep("Max", nrow(mxSet2)) # create new column with value of "Max"
mnSet2$Similarity <- rep("Min", nrow(mnSet2)) # create new column with value of "Min"

# Combine two data frames
dfSet2 <- rbind(mxSet2, mnSet2)
colnames(dfSet2) <- c("Time.Interval","Window.Size","Percentage","Similarity")

# Create line graphs
plotSet2 <- ggplot() + geom_line(data=dfSet2, aes(x=Window.Size, y=Percentage, colour=Similarity))
plotSet2 <- plotSet2 + facet_wrap(~ Time.Interval)

plotSet2 <- plotSet2 + labs(title="Observed vs Simulated Map Similarity", 
                            subtitle="Moving 3-year time interval from 1992 to 2015",
                            x="Window Size", y="% Similarity (x 100)")
plotSet2 <- plotSet2 + scale_colour_manual(values=c("#264d73","#b3cce6"), name="Similarity", labels = c("Maximum","Minimum"))
plotSet2 <- plotSet2 + theme_light()


# Save Output Plots ---------------------

ggsave(plotSet1, file="MapSimilarity-LineGraph-Set1.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(plotSet2, file="MapSimilarity-LineGraph-Set2.pdf", width=19.89, height=15, units="cm", dpi=300)

