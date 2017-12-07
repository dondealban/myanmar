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
# Last Modified:  07 Dec 2017


# Load Libraries ------------------------
library(ggplot2)
library(reshape2)
library(stringr)


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
setwd("/Users/dondealban/Dropbox/Research/myanmar/simulation/validation/tanintharyi/bespoke/set 02/similarity/")

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


# Set 03 --------------------------------

# Set working directory
setwd("/Users/dondealban/Dropbox/Research/myanmar/simulation/validation/tanintharyi/bespoke/set 03/similarity/")

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
maxSet3 <- do.call(rbind, lapply(files, readmax))

# Add years as another column
row.names(maxSet3) <- c("1992-1996","1993-1997","1994-1998","1995-1999","1996-2000",
                        "1997-2001","1998-2002","1999-2003","2000-2004","2001-2005",
                        "2002-2006","2003-2007","2004-2008","2005-2009","2006-2010",
                        "2007-2011","2008-2012","2009-2013","2010-2014","2011-2015")

# Function to read minimum similarity data
readmin <- function(filename) {
  df <- read.csv(filename, sep=",")
  min <- df[, 2]           # Read column with minimum similarity values
  names(min) <- df[, 1]    # Read column with window sizes
  return(min)
}

# Combine as window sizes and similarity values in a matrix
minSet3 <- do.call(rbind, lapply(files, readmin))

# Add years as another column
row.names(minSet3) <- c("1992-1996","1993-1997","1994-1998","1995-1999","1996-2000",
                        "1997-2001","1998-2002","1999-2003","2000-2004","2001-2005",
                        "2002-2006","2003-2007","2004-2008","2005-2009","2006-2010",
                        "2007-2011","2008-2012","2009-2013","2010-2014","2011-2015")

# Convert wide format data frame into long format data frame
mxSet3 <- melt(maxSet3, id.vars="years", variable.name="windowsize", value.name="percentage")
mnSet3 <- melt(minSet3, id.vars="years", variable.name="windowsize", value.name="percentage")

# Add column to categorise maximum and minimum similarities
mxSet3$Similarity <- rep("Max", nrow(mxSet3)) # create new column with value of "Max"
mnSet3$Similarity <- rep("Min", nrow(mnSet3)) # create new column with value of "Min"

# Combine two data frames
dfSet3 <- rbind(mxSet3, mnSet3)
colnames(dfSet3) <- c("Time.Interval","Window.Size","Percentage","Similarity")

# Create line graphs
plotSet3 <- ggplot() + geom_line(data=dfSet3, aes(x=Window.Size, y=Percentage, colour=Similarity))
plotSet3 <- plotSet3 + facet_wrap(~ Time.Interval)
plotSet3 <- plotSet3 + labs(title="Observed vs Simulated Map Similarity", 
                            subtitle="Moving 4-year time interval from 1992 to 2015",
                            x="Window Size", y="% Similarity (x 100)")
plotSet3 <- plotSet3 + scale_colour_manual(values=c("#264d73","#b3cce6"), name="Similarity", labels = c("Maximum","Minimum"))
plotSet3 <- plotSet3 + theme_light()


# Set 04 --------------------------------

# Set working directory
setwd("/Users/dondealban/Dropbox/Research/myanmar/simulation/validation/tanintharyi/bespoke/set 04/similarity/")

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
maxSet4 <- do.call(rbind, lapply(files, readmax))

# Add years as another column
row.names(maxSet4) <- c("1992-1997","1993-1998","1994-1999","1995-2000","1996-2001",
                        "1997-2002","1998-2003","1999-2004","2000-2005","2001-2006",
                        "2002-2007","2003-2008","2004-2009","2005-2010","2006-2011",
                        "2007-2012","2008-2013","2009-2014","2010-2015")

# Function to read minimum similarity data
readmin <- function(filename) {
  df <- read.csv(filename, sep=",")
  min <- df[, 2]           # Read column with minimum similarity values
  names(min) <- df[, 1]    # Read column with window sizes
  return(min)
}

# Combine as window sizes and similarity values in a matrix
minSet4 <- do.call(rbind, lapply(files, readmin))

# Add years as another column
row.names(minSet4) <- c("1992-1997","1993-1998","1994-1999","1995-2000","1996-2001",
                        "1997-2002","1998-2003","1999-2004","2000-2005","2001-2006",
                        "2002-2007","2003-2008","2004-2009","2005-2010","2006-2011",
                        "2007-2012","2008-2013","2009-2014","2010-2015")

# Convert wide format data frame into long format data frame
mxSet4 <- melt(maxSet4, id.vars="years", variable.name="windowsize", value.name="percentage")
mnSet4 <- melt(minSet4, id.vars="years", variable.name="windowsize", value.name="percentage")

# Add column to categorise maximum and minimum similarities
mxSet4$Similarity <- rep("Max", nrow(mxSet4)) # create new column with value of "Max"
mnSet4$Similarity <- rep("Min", nrow(mnSet4)) # create new column with value of "Min"

# Combine two data frames
dfSet4 <- rbind(mxSet4, mnSet4)
colnames(dfSet4) <- c("Time.Interval","Window.Size","Percentage","Similarity")

# Create line graphs
plotSet4 <- ggplot() + geom_line(data=dfSet4, aes(x=Window.Size, y=Percentage, colour=Similarity))
plotSet4 <- plotSet4 + facet_wrap(~ Time.Interval)
plotSet4 <- plotSet4 + labs(title="Observed vs Simulated Map Similarity", 
                            subtitle="Moving 5-year time interval from 1992 to 2015",
                            x="Window Size", y="% Similarity (x 100)")
plotSet4 <- plotSet4 + scale_colour_manual(values=c("#264d73","#b3cce6"), name="Similarity", labels = c("Maximum","Minimum"))
plotSet4 <- plotSet4 + theme_light()


# Combined Line Graph -------------------

# Select maximum similarity data values from 11x11 window size in all sets

w11yi3 <- subset(dfSet2, Window.Size==11 & Similarity=="Max") # 11x11 3-year interval
w11yi4 <- subset(dfSet3, Window.Size==11 & Similarity=="Max") # 11x11 4-year interval
w11yi5 <- subset(dfSet4, Window.Size==11 & Similarity=="Max") # 11x11 5-year interval

# Add "End Year" column
w11yi3$End.Year <- as.numeric(word(w11yi3$Time.Interval, 2, sep=fixed("-")))
w11yi4$End.Year <- as.numeric(word(w11yi4$Time.Interval, 2, sep=fixed("-")))
w11yi5$End.Year <- as.numeric(word(w11yi5$Time.Interval, 2, sep=fixed("-")))

# Add "Interval" column
w11yi3$Interval <- rep("3-year", nrow(w11yi3)) 
w11yi4$Interval <- rep("4-year", nrow(w11yi4))
w11yi5$Interval <- rep("5-year", nrow(w11yi5)) 

# Combine data frames
dfSetComb <- rbind(w11yi3, w11yi4, w11yi5)
dfSetComb[dfSetComb==1] <- NA

# Create combined line graphs
plotSetComb <- ggplot() + geom_rect(aes(xmin=1997, xmax=2004, ymin=-Inf, ymax=Inf), alpha=0.5, fill="#e6e6e6")
plotSetComb <- plotSetComb + geom_line(data=dfSetComb, aes(x=End.Year, y=Percentage, colour=Interval))
plotSetComb <- plotSetComb + geom_point(data=dfSetComb, aes(x=End.Year, y=Percentage, colour=Interval))
plotSetComb <- plotSetComb + scale_colour_brewer(type="qual", palette=2, name="Intervals", labels = c("3-year","4-year","5-year"))
plotSetComb <- plotSetComb + scale_fill_manual(values=c("#e6e6e6"), name="", labels=c("Period of land use regime shift"))
plotSetComb <- plotSetComb + labs(title="Observed vs Simulated Maximum Map Similarities", 
                                  subtitle="Comparison of similarities at various time intervals from 1992 to 2015; 11x11 window size",
                                  x="Ending Year of Time Interval", y="% Similarity (x 100)")
plotSetComb <- plotSetComb + theme_light()


# Save Output Plots ---------------------
ggsave(plotSet1, file="MapSimilarity-LineGraph-Set1.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(plotSet2, file="MapSimilarity-LineGraph-Set2.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(plotSet3, file="MapSimilarity-LineGraph-Set3.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(plotSet4, file="MapSimilarity-LineGraph-Set4.pdf", width=19.89, height=15, units="cm", dpi=300)

ggsave(plotSetComb, file="MapSimilarity-LineGraph-Max-Combined.pdf", width=19.89, height=15, units="cm", dpi=300)

