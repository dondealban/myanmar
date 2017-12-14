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
# Last Modified:  14 Dec 2017


# Load Libraries ------------------------
library(ggplot2)
library(reshape2)
library(stringr)


# Set 01 --------------------------------
# Full 24-year time interval
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
# 3-year time interval
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
# 4-year time interval
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
# 5-year time interval 
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


# Set 05 --------------------------------
# 2-year time interval 
# Set working directory
setwd("/Users/dondealban/Dropbox/Research/myanmar/simulation/validation/tanintharyi/bespoke/set 05/similarity/")

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
maxSet5 <- do.call(rbind, lapply(files, readmax))

# Add years as another column
row.names(maxSet5) <- c("1992-1994","1993-1995","1994-1996","1995-1997","1996-1998",
                        "1997-1999","1998-2000","1999-2001","2000-2002","2001-2003",
                        "2002-2004","2003-2005","2004-2006","2005-2007","2006-2008",
                        "2007-2009","2008-2010","2009-2011","2010-2012","2011-2013",
                        "2012-2014","2013-2015")

# Function to read minimum similarity data
readmin <- function(filename) {
  df <- read.csv(filename, sep=",")
  min <- df[, 2]           # Read column with minimum similarity values
  names(min) <- df[, 1]    # Read column with window sizes
  return(min)
}

# Combine as window sizes and similarity values in a matrix
minSet5 <- do.call(rbind, lapply(files, readmin))

# Add years as another column
row.names(minSet5) <- c("1992-1994","1993-1995","1994-1996","1995-1997","1996-1998",
                        "1997-1999","1998-2000","1999-2001","2000-2002","2001-2003",
                        "2002-2004","2003-2005","2004-2006","2005-2007","2006-2008",
                        "2007-2009","2008-2010","2009-2011","2010-2012","2011-2013",
                        "2012-2014","2013-2015")

# Convert wide format data frame into long format data frame
mxSet5 <- melt(maxSet5, id.vars="years", variable.name="windowsize", value.name="percentage")
mnSet5 <- melt(minSet5, id.vars="years", variable.name="windowsize", value.name="percentage")

# Add column to categorise maximum and minimum similarities
mxSet5$Similarity <- rep("Max", nrow(mxSet5)) # create new column with value of "Max"
mnSet5$Similarity <- rep("Min", nrow(mnSet5)) # create new column with value of "Min"

# Combine two data frames
dfSet5 <- rbind(mxSet5, mnSet5)
colnames(dfSet5) <- c("Time.Interval","Window.Size","Percentage","Similarity")

# Create line graphs
plotSet5 <- ggplot() + geom_line(data=dfSet5, aes(x=Window.Size, y=Percentage, colour=Similarity))
plotSet5 <- plotSet5 + facet_wrap(~ Time.Interval)
plotSet5 <- plotSet5 + labs(title="Observed vs Simulated Map Similarity", 
                            subtitle="Moving 2-year time interval from 1992 to 2015",
                            x="Window Size", y="% Similarity (x 100)")
plotSet5 <- plotSet5 + scale_colour_manual(values=c("#264d73","#b3cce6"), name="Similarity", labels = c("Maximum","Minimum"))
plotSet5 <- plotSet5 + theme_light()


# Set 06 --------------------------------
# 1-year time interval 
# Set working directory
setwd("/Users/dondealban/Dropbox/Research/myanmar/simulation/validation/tanintharyi/bespoke/set 06/similarity/")

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
maxSet6 <- do.call(rbind, lapply(files, readmax))

# Add years as another column
row.names(maxSet6) <- c("1992-1993","1993-1994","1994-1995","1995-1996","1996-1997",
                        "1997-1998","1998-1999","1999-2000","2000-2001","2001-2002",
                        "2002-2003","2003-2004","2004-2005","2005-2006","2006-2007",
                        "2007-2008","2008-2009","2009-2010","2010-2011","2011-2012",
                        "2012-2013","2013-2014","2014-2015")

# Function to read minimum similarity data
readmin <- function(filename) {
  df <- read.csv(filename, sep=",")
  min <- df[, 2]           # Read column with minimum similarity values
  names(min) <- df[, 1]    # Read column with window sizes
  return(min)
}

# Combine as window sizes and similarity values in a matrix
minSet6 <- do.call(rbind, lapply(files, readmin))

# Add years as another column
row.names(minSet6) <- c("1992-1993","1993-1994","1994-1995","1995-1996","1996-1997",
                        "1997-1998","1998-1999","1999-2000","2000-2001","2001-2002",
                        "2002-2003","2003-2004","2004-2005","2005-2006","2006-2007",
                        "2007-2008","2008-2009","2009-2010","2010-2011","2011-2012",
                        "2012-2013","2013-2014","2014-2015")

# Convert wide format data frame into long format data frame
mxSet6 <- melt(maxSet6, id.vars="years", variable.name="windowsize", value.name="percentage")
mnSet6 <- melt(minSet6, id.vars="years", variable.name="windowsize", value.name="percentage")

# Add column to categorise maximum and minimum similarities
mxSet6$Similarity <- rep("Max", nrow(mxSet6)) # create new column with value of "Max"
mnSet6$Similarity <- rep("Min", nrow(mnSet6)) # create new column with value of "Min"

# Combine two data frames
dfSet6 <- rbind(mxSet6, mnSet6)
colnames(dfSet6) <- c("Time.Interval","Window.Size","Percentage","Similarity")

# Create line graphs
plotSet6 <- ggplot() + geom_line(data=dfSet6, aes(x=Window.Size, y=Percentage, colour=Similarity))
plotSet6 <- plotSet6 + facet_wrap(~ Time.Interval)
plotSet6 <- plotSet6 + labs(title="Observed vs Simulated Map Similarity", 
                            subtitle="Moving 1-year time interval from 1992 to 2015",
                            x="Window Size", y="% Similarity (x 100)")
plotSet6 <- plotSet6 + scale_colour_manual(values=c("#264d73","#b3cce6"), name="Similarity", labels = c("Maximum","Minimum"))
plotSet6 <- plotSet6 + theme_light()


# Combined Line Graph -------------------

# Select maximum similarity data values from 11x11 window size in all sets
# Maximum
w11yi2max <- subset(dfSet5, Window.Size==11 & Similarity=="Max") # 11x11 2-year interval
w11yi3max <- subset(dfSet2, Window.Size==11 & Similarity=="Max") # 11x11 3-year interval
w11yi4max <- subset(dfSet3, Window.Size==11 & Similarity=="Max") # 11x11 4-year interval
w11yi5max <- subset(dfSet4, Window.Size==11 & Similarity=="Max") # 11x11 5-year interval
# Minimum
w11yi2min <- subset(dfSet5, Window.Size==11 & Similarity=="Min") # 11x11 2-year interval
w11yi3min <- subset(dfSet2, Window.Size==11 & Similarity=="Min") # 11x11 3-year interval
w11yi4min <- subset(dfSet3, Window.Size==11 & Similarity=="Min") # 11x11 4-year interval
w11yi5min <- subset(dfSet4, Window.Size==11 & Similarity=="Min") # 11x11 5-year interval

# Add "End Year" column
# Maximum
w11yi2max$End.Year <- as.numeric(word(w11yi2max$Time.Interval, 2, sep=fixed("-")))
w11yi3max$End.Year <- as.numeric(word(w11yi3max$Time.Interval, 2, sep=fixed("-")))
w11yi4max$End.Year <- as.numeric(word(w11yi4max$Time.Interval, 2, sep=fixed("-")))
w11yi5max$End.Year <- as.numeric(word(w11yi5max$Time.Interval, 2, sep=fixed("-")))
# Minimum
w11yi2min$End.Year <- as.numeric(word(w11yi2min$Time.Interval, 2, sep=fixed("-")))
w11yi3min$End.Year <- as.numeric(word(w11yi3min$Time.Interval, 2, sep=fixed("-")))
w11yi4min$End.Year <- as.numeric(word(w11yi4min$Time.Interval, 2, sep=fixed("-")))
w11yi5min$End.Year <- as.numeric(word(w11yi5min$Time.Interval, 2, sep=fixed("-")))

# Add "Interval" column
# Maximum
w11yi2max$Interval <- rep("2-year", nrow(w11yi2max)) 
w11yi3max$Interval <- rep("3-year", nrow(w11yi3max)) 
w11yi4max$Interval <- rep("4-year", nrow(w11yi4max))
w11yi5max$Interval <- rep("5-year", nrow(w11yi5max))
# Minimum
w11yi2min$Interval <- rep("2-year", nrow(w11yi2min)) 
w11yi3min$Interval <- rep("3-year", nrow(w11yi3min)) 
w11yi4min$Interval <- rep("4-year", nrow(w11yi4min))
w11yi5min$Interval <- rep("5-year", nrow(w11yi5min))

# Combine data frames
dfSetCombMax <- rbind(w11yi2max, w11yi3max, w11yi4max, w11yi5max) # Maximum
dfSetCombMax[dfSetCombMax==1] <- NA
dfSetCombMin <- rbind(w11yi2min, w11yi3min, w11yi4min, w11yi5min) # Minimum
dfSetCombMin[dfSetCombMin==0] <- NA

# Create combined line graphs
# Maximum
plotSetCombMax <- ggplot() + geom_rect(aes(xmin=1997, xmax=2004, ymin=-Inf, ymax=Inf), alpha=0.5, fill="#e6e6e6")
plotSetCombMax <- plotSetCombMax + geom_line(data=dfSetCombMax, aes(x=End.Year, y=Percentage, colour=Interval))
plotSetCombMax <- plotSetCombMax + geom_point(data=dfSetCombMax, aes(x=End.Year, y=Percentage, colour=Interval))
plotSetCombMax <- plotSetCombMax + scale_colour_brewer(type="qual", palette=2, name="Time Interval", labels = c("2-year","3-year","4-year","5-year"))
plotSetCombMax <- plotSetCombMax + scale_fill_manual(values=c("#e6e6e6"), name="", labels=c("Period of land use regime shift"))
plotSetCombMax <- plotSetCombMax + labs(title="Observed vs Simulated Maximum Map Similarities", 
                                  subtitle="Comparison of similarities at various time intervals from 1992 to 2015; 11x11 window size",
                                  x="Ending Year of Time Interval", y="% Similarity (x 100)")
plotSetCombMax <- plotSetCombMax + ylim(0.3,1.0)
plotSetCombMax <- plotSetCombMax + theme_light()
# Minimum
plotSetCombMin <- ggplot() + geom_rect(aes(xmin=1997, xmax=2004, ymin=-Inf, ymax=Inf), alpha=0.5, fill="#e6e6e6")
plotSetCombMin <- plotSetCombMin + geom_line(data=dfSetCombMin, aes(x=End.Year, y=Percentage, colour=Interval))
plotSetCombMin <- plotSetCombMin + geom_point(data=dfSetCombMin, aes(x=End.Year, y=Percentage, colour=Interval))
plotSetCombMin <- plotSetCombMin + scale_colour_brewer(type="qual", palette=2, name="Time Interval", labels = c("2-year","3-year","4-year","5-year"))
plotSetCombMin <- plotSetCombMin + scale_fill_manual(values=c("#e6e6e6"), name="", labels=c("Period of land use regime shift"))
plotSetCombMin <- plotSetCombMin + labs(title="Observed vs Simulated Minimum Map Similarities", 
                                        subtitle="Comparison of similarities at various time intervals from 1992 to 2015; 11x11 window size",
                                        x="Ending Year of Time Interval", y="% Similarity (x 100)")
plotSetCombMin <- plotSetCombMin + theme_light()


# Save Output Plots ---------------------
ggsave(plotSet1, file="MapSimilarity-LineGraph-Set1.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(plotSet2, file="MapSimilarity-LineGraph-Set2.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(plotSet3, file="MapSimilarity-LineGraph-Set3.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(plotSet4, file="MapSimilarity-LineGraph-Set4.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(plotSet5, file="MapSimilarity-LineGraph-Set5.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(plotSet6, file="MapSimilarity-LineGraph-Set6.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(plotSetCombMax, file="MapSimilarity-LineGraph-Max-Combined.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(plotSetCombMin, file="MapSimilarity-LineGraph-Min-Combined.pdf", width=19.89, height=15, units="cm", dpi=300)

