# This R script generates barlots using ggplot2 package to visualise the results of
# intensity analysis of changes between 9 land cover types derived from combined
# Landsat and L-band SAR data covering Tanintharyi, Myanmar. This script plots SetA
# values consisting of 1995 and 2015 data from Landsat-5 (7 bands, 5 indices) and
# JERS-1 or ALOS/PALSAR-2 (1 polarisation and 8 GLCM textures). Intensity analysis
# was calculated for the following domains: within Tanintharyi Division; and then
# within and outside protected areas, oil palm concessions, and permanent forest
# estates that are located in Tanintharyi.
#
# Land cover types include: forest (FOR); mangrove (MNG); oil palm mature (OPM);
# rubber mature (RBM); shrub/orchard (SHB); rice paddy (RPD); built-up area (BUA);
# bare soil/ground (BSG); and water (WTR).
#
# Script By:      Jose Don T De Alban
# Date Created:   25 Apr 2017
# Last Modified:  15 May 2017


# LOAD LIBRARIES AND DATA

# Set working directory
setwd("/Users/dondealban/Dropbox/Research/myanmar/intensity analysis/")

# Load the required R libraries
library(ggplot2)
library(plyr)
library(reshape2)

# Read data, define variables, and store data in variables

# Category level
tniALL <- read.csv(file="Change_TNI_SetA_1995_2015_ALL_CATEGORY.csv", header=TRUE, sep=",")

# Transition level
tniFOR <- read.csv(file="Change_TNI_SetA_1995_2015_FOR.csv", header=TRUE, sep=",")
tniMNG <- read.csv(file="Change_TNI_SetA_1995_2015_MNG.csv", header=TRUE, sep=",")
tniOPM <- read.csv(file="Change_TNI_SetA_1995_2015_OPM.csv", header=TRUE, sep=",")
tniRBM <- read.csv(file="Change_TNI_SetA_1995_2015_RBM.csv", header=TRUE, sep=",")
tniSHB <- read.csv(file="Change_TNI_SetA_1995_2015_SHB.csv", header=TRUE, sep=",")
tniRPD <- read.csv(file="Change_TNI_SetA_1995_2015_RPD.csv", header=TRUE, sep=",")
tniBUA <- read.csv(file="Change_TNI_SetA_1995_2015_BUA.csv", header=TRUE, sep=",")
tniBSG <- read.csv(file="Change_TNI_SetA_1995_2015_BSG.csv", header=TRUE, sep=",")
tniWTR <- read.csv(file="Change_TNI_SetA_1995_2015_WTR.csv", header=TRUE, sep=",")


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

# Oil Palm Mature
mtOPM <- melt(tniOPM, id.vars="Category.Transitions")
frOPM <- subset(mtOPM, variable=="From.OPM")
toOPM <- subset(mtOPM, variable=="To.OPM")

# Rubber Mature
mtRBM <- melt(tniRBM, id.vars="Category.Transitions")
frRBM <- subset(mtRBM, variable=="From.RBM")
toRBM <- subset(mtRBM, variable=="To.RBM")

# Shrub/Orchard
mtSHB <- melt(tniSHB, id.vars="Category.Transitions")
frSHB <- subset(mtSHB, variable=="From.SHB")
toSHB <- subset(mtSHB, variable=="To.SHB")

# Rice Paddy
mtRPD <- melt(tniRPD, id.vars="Category.Transitions")
frRPD <- subset(mtRPD, variable=="From.RPD")
toRPD <- subset(mtRPD, variable=="To.RPD")

# Built-Up Area
mtBUA <- melt(tniBUA, id.vars="Category.Transitions")
frBUA <- subset(mtBUA, variable=="From.BUA")
toBUA <- subset(mtBUA, variable=="To.BUA")

# Bare Soil/Ground
mtBSG <- melt(tniBSG, id.vars="Category.Transitions")
frBSG <- subset(mtBSG, variable=="From.BSG")
toBSG <- subset(mtBSG, variable=="To.BSG")

# Water
mtWTR <- melt(tniWTR, id.vars="Category.Transitions")
frWTR <- subset(mtWTR, variable=="From.WTR")
toWTR <- subset(mtWTR, variable=="To.WTR")


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

# Oil Palm Mature
intOPM <- ggplot() + geom_bar(data=toOPM, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intOPM <- intOPM   + geom_bar(data=frOPM, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intOPM <- intOPM   + geom_hline(yintercept=0, colour="grey90")
intOPM <- intOPM   + geom_hline(aes(yintercept=0.22, colour="#009404"), linetype="dashed") # TO uniform line
intOPM <- intOPM   + geom_hline(aes(yintercept=-0.10, colour="#FF0000"), linetype="dashed") # FROM uniform line
intOPM <- intOPM   + labs(title="Transition Intensity for Oil Palm Mature", x="Transition Category", y="Transition Intensity (% of Category)")
intOPM <- intOPM   + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Oil Palm", "FROM Oil Palm"))
intOPM <- intOPM   + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intOPM <- intOPM   + theme_minimal()

# Rubber Mature
intRBM <- ggplot() + geom_bar(data=toRBM, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intRBM <- intRBM   + geom_bar(data=frRBM, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intRBM <- intRBM   + geom_hline(yintercept=0, colour="grey90")
intRBM <- intRBM   + geom_hline(aes(yintercept=0.43, colour="#009404"), linetype="dashed") # TO uniform line
intRBM <- intRBM   + geom_hline(aes(yintercept=-0.11, colour="#FF0000"), linetype="dashed") # FROM uniform line
intRBM <- intRBM   + labs(title="Transition Intensity for Rubber Mature", x="Transition Category", y="Transition Intensity (% of Category)")
intRBM <- intRBM   + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Rubber", "FROM Rubber"))
intRBM <- intRBM   + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intRBM <- intRBM   + theme_minimal()

# Shrubs/Orchard
intSHB <- ggplot() + geom_bar(data=toSHB, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intSHB <- intSHB   + geom_bar(data=frSHB, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intSHB <- intSHB   + geom_hline(yintercept=0, colour="grey90")
intSHB <- intSHB   + geom_hline(aes(yintercept=0.71, colour="#009404"), linetype="dashed") # TO uniform line
intSHB <- intSHB   + geom_hline(aes(yintercept=-0.75, colour="#FF0000"), linetype="dashed") # FROM uniform line
intSHB <- intSHB   + labs(title="Transition Intensity for Shrub/Orchard", x="Transition Category", y="Transition Intensity (% of Category)")
intSHB <- intSHB   + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Shrub/Orchard", "FROM Shrub/Orchard"))
intSHB <- intSHB   + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intSHB <- intSHB   + theme_minimal()

# Rice Paddy
intRPD <- ggplot() + geom_bar(data=toRPD, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intRPD <- intRPD   + geom_bar(data=frRPD, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intRPD <- intRPD   + geom_hline(yintercept=0, colour="grey90")
intRPD <- intRPD   + geom_hline(aes(yintercept=0.07, colour="#009404"), linetype="dashed") # TO uniform line
intRPD <- intRPD   + geom_hline(aes(yintercept=-0.06, colour="#FF0000"), linetype="dashed") # FROM uniform line
intRPD <- intRPD   + labs(title="Transition Intensity for Rice Paddy", x="Transition Category", y="Transition Intensity (% of Category)")
intRPD <- intRPD   + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Rice Paddy", "FROM Rice Paddy"))
intRPD <- intRPD   + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intRPD <- intRPD   + theme_minimal()

# Built-Up Area
intBUA <- ggplot() + geom_bar(data=toBUA, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intBUA <- intBUA   + geom_bar(data=frBUA, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intBUA <- intBUA   + geom_hline(yintercept=0, colour="grey90")
intBUA <- intBUA   + geom_hline(aes(yintercept=0.0005, colour="#009404"), linetype="dashed") # TO uniform line
intBUA <- intBUA   + geom_hline(aes(yintercept=-0.00185, colour="#FF0000"), linetype="dashed") # FROM uniform line
intBUA <- intBUA   + labs(title="Transition Intensity for Built-Up Area", x="Transition Category", y="Transition Intensity (% of Category)")
intBUA <- intBUA   + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Built-Up Area", "FROM Built-Up Area"))
intBUA <- intBUA   + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intBUA <- intBUA   + theme_minimal()

# Bare Soil/Ground
intBSG <- ggplot() + geom_bar(data=toBSG, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intBSG <- intBSG   + geom_bar(data=frBSG, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intBSG <- intBSG   + geom_hline(yintercept=0, colour="grey90")
intBSG <- intBSG   + geom_hline(aes(yintercept=0.01, colour="#009404"), linetype="dashed") # TO uniform line
intBSG <- intBSG   + geom_hline(aes(yintercept=-0.09, colour="#FF0000"), linetype="dashed") # FROM uniform line
intBSG <- intBSG   + labs(title="Transition Intensity for Bare Soil/Ground", x="Transition Category", y="Transition Intensity (% of Category)")
intBSG <- intBSG   + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Bare Soil/Ground", "FROM Bare Soil/Ground"))
intBSG <- intBSG   + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intBSG <- intBSG   + theme_minimal()

# Water
intWTR <- ggplot() + geom_bar(data=toWTR, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intWTR <- intWTR   + geom_bar(data=frWTR, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intWTR <- intWTR   + geom_hline(yintercept=0, colour="grey90")
intWTR <- intWTR   + geom_hline(aes(yintercept=0.01, colour="#009404"), linetype="dashed") # TO uniform line
intWTR <- intWTR   + geom_hline(aes(yintercept=-0.02, colour="#FF0000"), linetype="dashed") # FROM uniform line
intWTR <- intWTR   + labs(title="Transition Intensity for Water", x="Transition Category", y="Transition Intensity (% of Category)")
intWTR <- intWTR   + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Water", "FROM Water"))
intWTR <- intWTR   + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intWTR <- intWTR   + theme_minimal()


# OUTPUT PLOTS
# Output boxplots to a PNG file
ggsave(intALL, file="IntensityAnalysis-ALL.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intFOR, file="IntensityAnalysis-FOR.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intMNG, file="IntensityAnalysis-MNG.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intOPM, file="IntensityAnalysis-OPM.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intRBM, file="IntensityAnalysis-RBM.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intSHB, file="IntensityAnalysis-SHB.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intRPD, file="IntensityAnalysis-RPD.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intBUA, file="IntensityAnalysis-BUA.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intBSG, file="IntensityAnalysis-BSG.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intWTR, file="IntensityAnalysis-WTR.pdf", width=19.89, height=15, units="cm", dpi=300)

