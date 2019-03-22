# Script Description --------------------
# This R script generates line graphs using tidyverse package to visualise estimates of
# areal extents of mangroves at specific time-points in Myanmar and its sub-national units
# reported from published studies.
#
# Script By:      Jose Don T De Alban
# Date Created:   15 Jan 2019
# Last Modified:  21 Feb 2019

# Set Working Directory -------------------
setwd("/Users/dondealban/Dropbox/Research/myanmar/3 mmr land cover transitions/mangroves/areal extent/")

# Load Libraries --------------------------
library(tidyverse)

# Read Input Data -------------------------
dfAREAL <- read.csv(file="Areal_Extents_Comparison.csv", header=TRUE, sep=",")

# Reorder Factor Levels -------------------
dfAREAL$Study_Area_Rev <- factor(dfAREAL$Study_Area, levels=c("Ayeyarwady",
                                                              "Bago",
                                                              "Mon",
                                                              "Rakhine",
                                                              "Tanintharyi",
                                                              "Yangon",
                                                              "Myanmar")) 

# Generate Plots --------------------------
# Plot #1: Same y-scales
plot1 <- ggplot() + geom_line(data=dfAREAL, aes(x=Time_Point, y=Areal_Extent_Km2, color=Reference), stat="identity")
plot1 <- plot1 + facet_wrap(~Study_Area_Rev)
plot1 <- plot1 + labs(x="Year", y="Areal Extent (sq.km)")
# Plot #2: Different y-scales
plot2 <- ggplot() + geom_line(data=dfAREAL, aes(x=Time_Point, y=Areal_Extent_Km2, color=Reference), stat="identity")
plot2 <- plot2 + facet_wrap(~Study_Area_Rev, scales="free")
plot2 <- plot2 + labs(x="Year", y="Areal Extent (sq.km)")

# Save Output Plots -----------------------
ggsave(plot1, file="Linegraph-Areal-Extent-Comparison-Mangroves-SameScale.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(plot2, file="Linegraph-Areal-Extent-Comparison-Mangroves-DiffScale.pdf", width=19.89, height=15, units="cm", dpi=300)

