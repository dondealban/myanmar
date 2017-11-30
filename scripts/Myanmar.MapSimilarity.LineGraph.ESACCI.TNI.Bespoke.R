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


# Load Libraries ------------------------
library(ggplot2)
library(reshape2)


# Set 01 --------------------------------

# Set working directory
setwd("/Users/dondealban/Dropbox/Research/myanmar/simulation/validation/tanintharyi/bespoke/set 01/")

# Read CSV data file
dataSet1 <- read.csv(file="tni_multiple_windows_similarity_sub_1992_2015.csv", header=TRUE, sep=",")
colnames(dataSet1) <- c("Window.Size","Min.Sim","Max.Sim") # Rename column names
dfSet1 <- melt(dataSet1, id.vars="Window.Size", na.rm=TRUE)

# Create line graphs
plotSet1 <- ggplot() + geom_line(data=dfSet1, aes(x=Window.Size, y=value, colour=variable))
plotSet1 <- plotSet1 + labs(title="Observed vs Simulated Map Similarity", 
                            subtitle="Single time interval from 1992 to 2015",
                            x="Window Size", y="% Similarity (x 100)")
plotSet1 <- plotSet1 + scale_colour_manual(values=c("#b3cce6","#264d73"), name="Similarity", labels = c("Minimum","Maximum"))
plotSet1 <- plotSet1 + ylim(0,1) + xlim(0.0,11)
plotSet1 <- plotSet1 + theme_light()


# Set 02 --------------------------------

# Set working directory
setwd("/Users/dondealban/Dropbox/Research/myanmar/simulation/validation/tanintharyi/bespoke/set 02/")

# Read csv files in the directory and store as a list
files <- list.files()

# Function to read maximum similarity data
readmax <- function(filename) {
  df <- read.csv(filename, sep=",")
  max <- df[, 3]           # Read column with maximum similarity values
  names(max) <- df[, 1]    # Read column with window sizes
  return(max)
}

# Combine as window sizes and similarity values in a matrix
maxSet2 <- do.call(rbind, lapply(files, readmax))

# Add years as another column
row.names(maxSet2) <- c("1992-1995","1993-1996","1994-1997","1995-1998","1996-1999",
                        "1997-2000","1998-2001","1999-2002","2000-2003","2001-2004",
                        "2002-2005","2003-2006","2004-2007","2005-2008","2006-2009",
                        "2007-2010","2008-2011","2009-2012","2010-2013","2011-2014",
                        "2012-2015")

# Function to read minimum similarity data
readmin <- function(filename) {
  df <- read.csv(filename, sep=",")
  min <- df[, 2]           # Read column with minimum similarity values
  names(min) <- df[, 1]    # Read column with window sizes
  return(min)
}

# Combine as window sizes and similarity values in a matrix
minSet2 <- do.call(rbind, lapply(files, readmin))

# Add years as another column
row.names(minSet2) <- c("1992-1995","1993-1996","1994-1997","1995-1998","1996-1999",
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

