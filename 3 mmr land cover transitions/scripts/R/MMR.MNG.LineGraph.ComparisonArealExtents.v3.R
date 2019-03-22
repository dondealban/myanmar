# Script Description --------------------
# This R script generates line graphs using tidyverse package to visualise estimates of
# areal extents of mangroves at specific time-points in Myanmar and its sub-national units
# reported from published studies.
#
# Script By:      Jose Don T De Alban
# Date Created:   15 Jan 2019
# Last Modified:  22 Mar 2019

# Set Working Directory -------------------
setwd("/Users/dondealban/Dropbox/Research/myanmar/3 mmr land cover transitions/mangroves/areal extent/")

# Load Libraries --------------------------
library(plyr)
library(dplyr)
library(ggplot2)
library(egg)

# Read Input Data -------------------------
dfAREAL <- read.csv(file="Areal_Extents_Comparison.csv", header=TRUE, sep=",")

# Reorganise Data -------------------------
RefID <- c("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q")
Reference <- c("This study",
               "Blasco & Aizpuru, 2002",
               "Blasco et al., 2001",
               "Connette et al., 2016",
               "De Alban et al., 2018",
               "Estoque et al., 2018",
               "FAO, 2010",
               "Gaw et al., 2018",
               "Giri et al., 2008",
               "IUCN, 1983",
               "Maung, 2012",
               "Oo, 2002",
               "Richards & Friess, 2015",
               "Spalding et al., 1997",
               "Webb et al., 2014",
               "Weber et al., 2014",
               "Zockler et al., 2013")
lookup <- as.data.frame(cbind(Reference,RefID), stringsAsFactors=TRUE)

# Match time interval with year in new column based on lookup table 
dfAREAL <- join(dfAREAL, lookup, by='Reference') # Need plyr package

# Subset Data -----------------------------
dfSUB1 <- dfAREAL %>% filter(Study_Area %in% "Myanmar")
dfSUB2 <- dfAREAL %>% filter(Study_Area %in% c("Ayeyarwady","Rakhine","Tanintharyi"))
dfSUB3 <- dfAREAL %>% filter(Study_Area %in% c("Bago","Mon","Yangon"))

# Define Plots ----------------------------

# Plot #1: Myanmar
plot1 <- ggplot() + geom_line(data=dfSUB1, aes(x=Time_Point, y=Areal_Extent_Km2, color=Reference), stat="identity")
plot1 <- plot1 + facet_wrap(~Study_Area)
plot1 <- plot1 + theme(legend.position="none", axis.title.x=element_blank()) + labs(y=" ")

# Plot #2: Extensive mangrove regions
plot2 <- ggplot() + geom_line(data=dfSUB2, aes(x=Time_Point, y=Areal_Extent_Km2, color=Reference), stat="identity")
plot2 <- plot2 + facet_wrap(~Study_Area, nrow=1) 
plot2 <- plot2 + theme(legend.position="none", axis.title.x=element_blank()) + labs(y="Areal Extent (sq.km)")

# Plot #3: Non-extensive mangrove regions
plot3 <- ggplot() + geom_line(data=dfSUB3, aes(x=Time_Point, y=Areal_Extent_Km2, color=Reference), stat="identity")
plot3 <- plot3 + facet_wrap(~Study_Area, nrow=1)
plot3 <- plot3 + theme(legend.position="none") + labs(x="Year", y=" ")

# Expose ggplot2 Layouts ------------------
plotlayout <- lapply(list(plot1, plot2, plot3), expose_layout, FALSE, FALSE)
grid.arrange(
  grobs = plotlayout,
  widths = c(1),
  layout_matrix = rbind(c(1),
                        c(2),
                        c(3))
)

# Generate Plots --------------------------
mergeplot <- ggarrange(plot1, plot2, plot3)



# Save Output Plots -----------------------
ggsave(mergeplot, file="Linegraph-Areal-Extent-Comparison-Mangroves-MergePlot-Draft.pdf", width=19.89, height=15, units="cm", dpi=300)

