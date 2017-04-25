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
setwd("/Users/dondealban/Dropbox/Research/myanmar/intensity analysis/")

# Load the required R libraries
library(ggplot2)
library(plyr)

# Read data, define variables, and store data in variables

# Category level
tniALL <- read.csv(file="Change_TNI_SetA_1995_2015_ALL_CATEGORY.csv", header=TRUE, sep=",")

# Transition level
tniFOR <- read.csv(file="Change_TNI_SetA_1995_2015_FOR.csv", header=TRUE, sep=",")
tniMNG <- read.csv(file="Change_TNI_SetA_1995_2015_MNG.csv", header=TRUE, sep=",")


# MELT AND SUBSET DATA

# Category Level
meltALL <- melt(tniALL, id.vars="Categories")
lossALL <- subset(meltALL, variable=="Loss.Intensity")
gainALL <- subset(meltALL, variable=="Gain.Intensity")

# Forest
mtFOR <- melt(tniFOR, id.vars="Category.Transitions")
frFOR <- subset(mtFOR, variable=="From.FOR")
toFOR <- subset(mtFOR, variable=="To.FOR")

# Mangrove
mtMNG <- melt(tniMNG, id.vars="Category.Transitions")
frMNG <- subset(mtMNG, variable=="From.MNG")
toMNG <- subset(mtMNG, variable=="To.MNG")


# GENERATE PLOTS
# Generate category level intensity analysis barplots for each land cover type

# Category Level
intALL <- ggplot() + geom_bar(data=gainALL, aes(x=Categories, y=value, fill="#8ACD66"),  stat="identity")
intALL <- intALL   + geom_bar(data=lossALL, aes(x=Categories, y=-value, fill="#B43507"), stat="identity")
intALL <- intALL   + geom_hline(yintercept=0, colour="grey90")
intALL <- intALL   + geom_hline(aes(yintercept=1.54, colour="#009404"), linetype="dashed") # TO uniform line
intALL <- intALL   + geom_hline(aes(yintercept=-1.54, colour="#FF0000"), linetype="dashed") # FROM uniform line
intALL <- intALL   + labs(title="Intensity of Gains and Losses by Category", x="Category", y="Category Intensity (% of Category)")
intALL <- intALL   + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("Category Gain", "Category Loss"))
intALL <- intALL   + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intALL <- intALL   + theme_minimal()


# Generate transition level intensity analysis barplots for each land cover type

# Forest
intFOR <- ggplot() + geom_bar(data=toFOR, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intFOR <- intFOR   + geom_bar(data=frFOR, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intFOR <- intFOR   + geom_hline(yintercept=0, colour="grey90")
intFOR <- intFOR   + geom_hline(aes(yintercept=0.52, colour="#009404"), linetype="dashed") # TO uniform line
intFOR <- intFOR   + geom_hline(aes(yintercept=-1.03, colour="#FF0000"), linetype="dashed") # FROM uniform line
intFOR <- intFOR   + labs(title="Transition Intensity for Forest", x="Transition Category", y="Transition Intensity (% of Category)")
intFOR <- intFOR   + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Forest", "FROM Forest"))
intFOR <- intFOR   + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intFOR <- intFOR   + theme_minimal()

# Mangrove
intMNG <- ggplot() + geom_bar(data=toMNG, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intMNG <- intMNG   + geom_bar(data=frMNG, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intMNG <- intMNG   + geom_hline(yintercept=0, colour="grey90")
intMNG <- intMNG   + geom_hline(aes(yintercept=0.07, colour="#009404"), linetype="dashed") # TO uniform line
intMNG <- intMNG   + geom_hline(aes(yintercept=-0.10, colour="#FF0000"), linetype="dashed") # FROM uniform line
intMNG <- intMNG   + labs(title="Transition Intensity for Mangrove", x="Transition Category", y="Transition Intensity (% of Category)")
intMNG <- intMNG   + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Mangrove", "FROM Mangrove"))
intMNG <- intMNG   + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intMNG <- intMNG   + theme_minimal()


# OUTPUT PLOTS
# Output boxplots to a PNG file
ggsave(intALL, file="IntensityAnalysis-ALL.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intFOR, file="IntensityAnalysis-FOR.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intMNG, file="IntensityAnalysis-MNG.pdf", width=19.89, height=15, units="cm", dpi=300)

