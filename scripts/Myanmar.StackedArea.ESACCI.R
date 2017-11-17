# Script Description --------------------
# This script creates a stacked area graph of time-series land cover data. 
#
# Script By:      Jose Don T De Alban
# Date Created:   17 Nov 2017
# Last Modified:  


# Set Working Directory -----------------
setwd("/Users/dondealban/Dropbox/Research/myanmar/intensity analysis/stacked area/ipcc/")

# Load Libraries and Data ---------------
library(ggplot2)
library(reshape2)

# Read csv files in the directory and store as a list
filenames <- list.files()

# Function to read data
readdata <- function(filename) {
  df <- read.csv(filename, sep="\t")
  vec <- df[,3]           # Read column with percentage values
  names(vec) <- df[,1]    # Read column with class codes
  return(vec)
}

# Combine as class codes and percentage values in a matrix
temp <- do.call(rbind, lapply(filenames, readdata))

# Add years as another column
row.names(temp) <- c("1992","1993","1994","1995","1996","1997","1998","1999",
           "2000","2001","2002","2003","2004","2005","2006","2007",
           "2008","2009","2010","2011","2012","2013","2014","2015")
#years <- c("1992","1993","1994","1995","1996","1997","1998","1999",
#           "2000","2001","2002","2003","2004","2005","2006","2007",
#           "2008","2009","2010","2011","2012","2013","2014","2015")
#output <- cbind(years,temp)

# Convert wide format data frame into long format data frame
#melt(anthoming, id.vars="angle", variable.name="condition", value.name="count")

data <- melt(temp, id.vars="years", variable.name="class", value.name="percentage")
colnames(data) <- c("Years","Class","Percentage")
