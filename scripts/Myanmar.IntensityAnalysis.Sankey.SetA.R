# This R script generates a Sankey diagram using riverplot package to visualise the
# land use transitions from the change analysis between 9 land cover types derived from
# combined Landsat and L-band SAR data covering Tanintharyi, Myanmar. This script plots
# SetA values consisting of 1995 and 2015 data from Landsat-5 (7 bands, 5 indices) and
# JERS-1 or ALOS/PALSAR-2 (1 polarisation and 8 GLCM textures).
#
# Land cover types include: forest (FOR); mangrove (MNG); oil palm mature (OPM);
# rubber mature (RBM); shrub/orchard (SHB); rice paddy (RPD); built-up area (BUA);
# bare soil/ground (BSG); and water (WTR).
#
# Script By:      Jose Don T De Alban
# Date Created:   25 Apr 2017
# Last Modified:


# LOAD LIBRARIES AND DATA

# Set working directory
setwd("/Users/dondealban/Dropbox/Research/myanmar/intensity analysis/")

# Load the required R libraries
library(dplyr)
library(riverplot)
library(RColorBrewer)

# Read data, define variables, and store data in variables

edges <- read.csv(file="Change_TNI_SetA_1995_2015_ALL_SANKEY_EDGES.csv", header=TRUE, sep=",")
nodes <- read.csv(file="Change_TNI_SetA_1995_2015_ALL_SANKEY_NODES.csv", header=TRUE, sep=",")

colnames(edges) <- c("N1", "N2", "Value")
colnames(nodes) <- c("ID", "x", "y")

# Generate the riverplot object
river <- makeRiver(nodes, edges)
style <- list( edgestyle= "straight", nodestyle= "invisible" )

# Plot the generated object
plot( river, lty= 1, default.style= style )

