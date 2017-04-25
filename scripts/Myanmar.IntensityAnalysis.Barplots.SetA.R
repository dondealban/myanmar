# This R script generates barlots using ggplot2 package to visualise the results of
# intensity analysis of changes between 9 land cover types derived from combined
# Landsat and L-band SAR data covering Tanintharyi, Myanmar. This script plots SetA
# values consisting of 1995 and 2015 data from Landsat-5 (7 bands, 5 indices) and
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
setwd("/Users/dondealban/Dropbox/Research/myanmar/intensity analysis/tanintharyi/")

# Load the required R libraries
library(ggplot2)
library(plyr)

# Read data, define variables, and store data in variables
tniFOR <- read.csv(file="Change_TNI_SetA_1995_2015_FOR.csv", header=TRUE, sep=",")


# MELT AND SUBSET DATA
mtFOR <- melt(tniFOR, id.vars="Category.Transitions")
frFOR <- subset(mtFOR, variable=="From.FOR")
toFOR <- subset(mtFOR, variable=="To.FOR")


# GENERATE PLOTS
# Generate intensity analysis barplots for each land cover type

# Forest
intFOR <- ggplot() + geom_bar(data=toFOR, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intFOR <- intFOR   + geom_bar(data=frFOR, aes(x=Category.Transitions, y=-value, fill="#C9400E"), stat="identity")
intFOR <- intFOR   + geom_hline(yintercept=0, colour="grey90")
intFOR <- intFOR   + geom_hline(yintercept=-1.03, linetype="dashed", colour="gray30") # FROM uniform line
intFOR <- intFOR   + geom_hline(yintercept=0.52, linetype="dashed", colour="gray30") # TO uniform line
intFOR <- intFOR   + geom_text() + annotate("text", label="uniform loss", x=1, y=-1.13, colour="gray30")
intFOR <- intFOR   + geom_text() + annotate("text", label="uniform gain", x=1, y=0.62, colour="gray30")
intFOR <- intFOR   + labs(title="Transition Intensity for Forest", x="Transition Category", y="Transition Intensity (% of Category)")
intFOR <- intFOR   + scale_fill_manual(values=c("#8ACD66", "#C9400E"), name="", labels = c("FROM Forest", "TO Forest"))
intFOR <- intFOR   + theme_minimal()




# OUTPUT PLOTS
# Output boxplots to a PNG file

ggsave(intFOR, file="IntensityAnalysis-FOR.pdf", width=19.89, height=15, units="cm", dpi=300)
