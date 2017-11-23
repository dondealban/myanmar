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

# ---------------------------
# LOAD LIBRARIES AND DATA
# ---------------------------

# Set working directory
setwd("/Users/dondealban/Dropbox/Research/myanmar/intensity analysis/")

# Load the required R libraries
library(ggplot2)
library(plyr)
library(reshape2)

# Read data, define variables, and store data in variables

# Permanent forest estates in Tanintharyi Division

# Category level
wPfeALL <- read.csv(file="Change_wPFE_SetA_1995_2015_ALL_CATEGORY.csv", header=TRUE, sep=",")
oPfeALL <- read.csv(file="Change_oPFE_SetA_1995_2015_ALL_CATEGORY.csv", header=TRUE, sep=",")

# Transition level (within permanent forest estates)
wPfeFOR <- read.csv(file="Change_wPFE_SetA_1995_2015_FOR.csv", header=TRUE, sep=",")
wPfeMNG <- read.csv(file="Change_wPFE_SetA_1995_2015_MNG.csv", header=TRUE, sep=",")
wPfeOPM <- read.csv(file="Change_wPFE_SetA_1995_2015_OPM.csv", header=TRUE, sep=",")
wPfeRBM <- read.csv(file="Change_wPFE_SetA_1995_2015_RBM.csv", header=TRUE, sep=",")
wPfeSHB <- read.csv(file="Change_wPFE_SetA_1995_2015_SHB.csv", header=TRUE, sep=",")
wPfeRPD <- read.csv(file="Change_wPFE_SetA_1995_2015_RPD.csv", header=TRUE, sep=",")
wPfeBUA <- read.csv(file="Change_wPFE_SetA_1995_2015_BUA.csv", header=TRUE, sep=",")
wPfeBSG <- read.csv(file="Change_wPFE_SetA_1995_2015_BSG.csv", header=TRUE, sep=",")
wPfeWTR <- read.csv(file="Change_wPFE_SetA_1995_2015_WTR.csv", header=TRUE, sep=",")

# Transition level (outside permanent forest estates)
oPfeFOR <- read.csv(file="Change_oPFE_SetA_1995_2015_FOR.csv", header=TRUE, sep=",")
oPfeMNG <- read.csv(file="Change_oPFE_SetA_1995_2015_MNG.csv", header=TRUE, sep=",")
oPfeOPM <- read.csv(file="Change_oPFE_SetA_1995_2015_OPM.csv", header=TRUE, sep=",")
oPfeRBM <- read.csv(file="Change_oPFE_SetA_1995_2015_RBM.csv", header=TRUE, sep=",")
oPfeSHB <- read.csv(file="Change_oPFE_SetA_1995_2015_SHB.csv", header=TRUE, sep=",")
oPfeRPD <- read.csv(file="Change_oPFE_SetA_1995_2015_RPD.csv", header=TRUE, sep=",")
oPfeBUA <- read.csv(file="Change_oPFE_SetA_1995_2015_BUA.csv", header=TRUE, sep=",")
oPfeBSG <- read.csv(file="Change_oPFE_SetA_1995_2015_BSG.csv", header=TRUE, sep=",")
oPfeWTR <- read.csv(file="Change_oPFE_SetA_1995_2015_WTR.csv", header=TRUE, sep=",")


# ---------------------------
# MELT AND SUBSET DATA
# ---------------------------

# Within permanent forest estates in Tanintharyi Division

# Category Level
meltALLw <- melt(wPfeALL, id.vars="Categories")
lossALLw <- subset(meltALLw, variable=="Loss.Intensity")
gainALLw <- subset(meltALLw, variable=="Gain.Intensity")

# Forest
mtFORw <- melt(wPfeFOR, id.vars="Category.Transitions")
frFORw <- subset(mtFORw, variable=="From.FOR")
toFORw <- subset(mtFORw, variable=="To.FOR")

# Mangrove
mtMNGw <- melt(wPfeMNG, id.vars="Category.Transitions")
frMNGw <- subset(mtMNGw, variable=="From.MNG")
toMNGw <- subset(mtMNGw, variable=="To.MNG")

# Oil Palm Mature
mtOPMw <- melt(wPfeOPM, id.vars="Category.Transitions")
frOPMw <- subset(mtOPMw, variable=="From.OPM")
toOPMw <- subset(mtOPMw, variable=="To.OPM")

# Rubber Mature
mtRBMw <- melt(wPfeRBM, id.vars="Category.Transitions")
frRBMw <- subset(mtRBMw, variable=="From.RBM")
toRBMw <- subset(mtRBMw, variable=="To.RBM")

# Shrub/Orchard
mtSHBw <- melt(wPfeSHB, id.vars="Category.Transitions")
frSHBw <- subset(mtSHBw, variable=="From.SHB")
toSHBw <- subset(mtSHBw, variable=="To.SHB")

# Rice Paddy
mtRPDw <- melt(wPfeRPD, id.vars="Category.Transitions")
frRPDw <- subset(mtRPDw, variable=="From.RPD")
toRPDw <- subset(mtRPDw, variable=="To.RPD")

# Built-Up Area
mtBUAw <- melt(wPfeBUA, id.vars="Category.Transitions")
frBUAw <- subset(mtBUAw, variable=="From.BUA")
toBUAw <- subset(mtBUAw, variable=="To.BUA")

# Bare Soil/Ground
mtBSGw <- melt(wPfeBSG, id.vars="Category.Transitions")
frBSGw <- subset(mtBSGw, variable=="From.BSG")
toBSGw <- subset(mtBSGw, variable=="To.BSG")

# Water
mtWTRw <- melt(wPfeWTR, id.vars="Category.Transitions")
frWTRw <- subset(mtWTRw, variable=="From.WTR")
toWTRw <- subset(mtWTRw, variable=="To.WTR")

# Outside permanent forest estates in Tanintharyi Division

# Category Level
meltALLo <- melt(oPfeALL, id.vars="Categories")
lossALLo <- subset(meltALLo, variable=="Loss.Intensity")
gainALLo <- subset(meltALLo, variable=="Gain.Intensity")

# Forest
mtFORo <- melt(oPfeFOR, id.vars="Category.Transitions")
frFORo <- subset(mtFORo, variable=="From.FOR")
toFORo <- subset(mtFORo, variable=="To.FOR")

# Mangrove
mtMNGo <- melt(oPfeMNG, id.vars="Category.Transitions")
frMNGo <- subset(mtMNGo, variable=="From.MNG")
toMNGo <- subset(mtMNGo, variable=="To.MNG")

# Oil Palm Mature
mtOPMo <- melt(oPfeOPM, id.vars="Category.Transitions")
frOPMo <- subset(mtOPMo, variable=="From.OPM")
toOPMo <- subset(mtOPMo, variable=="To.OPM")

# Rubber Mature
mtRBMo <- melt(oPfeRBM, id.vars="Category.Transitions")
frRBMo <- subset(mtRBMo, variable=="From.RBM")
toRBMo <- subset(mtRBMo, variable=="To.RBM")

# Shrub/Orchard
mtSHBo <- melt(oPfeSHB, id.vars="Category.Transitions")
frSHBo <- subset(mtSHBo, variable=="From.SHB")
toSHBo <- subset(mtSHBo, variable=="To.SHB")

# Rice Paddy
mtRPDo <- melt(oPfeRPD, id.vars="Category.Transitions")
frRPDo <- subset(mtRPDo, variable=="From.RPD")
toRPDo <- subset(mtRPDo, variable=="To.RPD")

# Built-Up Area
mtBUAo <- melt(oPfeBUA, id.vars="Category.Transitions")
frBUAo <- subset(mtBUAo, variable=="From.BUA")
toBUAo <- subset(mtBUAo, variable=="To.BUA")

# Bare Soil/Ground
mtBSGo <- melt(oPfeBSG, id.vars="Category.Transitions")
frBSGo <- subset(mtBSGo, variable=="From.BSG")
toBSGo <- subset(mtBSGo, variable=="To.BSG")

# Water
mtWTRo <- melt(oPfeWTR, id.vars="Category.Transitions")
frWTRo <- subset(mtWTRo, variable=="From.WTR")
toWTRo <- subset(mtWTRo, variable=="To.WTR")


# ---------------------------
# GENERATE CATEGORY PLOTS
# ---------------------------

# Generate category level intensity analysis barplots for each land cover type

# Within permanent forest estates in Tanintharyi Division
intALLw <- ggplot() + geom_bar(data=gainALLw, aes(x=Categories, y=value, fill="#8ACD66"),  stat="identity")
intALLw <- intALLw  + geom_bar(data=lossALLw, aes(x=Categories, y=-value, fill="#B43507"), stat="identity")
intALLw <- intALLw  + geom_hline(yintercept=0, colour="grey90")
intALLw <- intALLw  + geom_hline(aes(yintercept=1.17, colour="#009404"), linetype="dashed") # TO uniform line
intALLw <- intALLw  + geom_hline(aes(yintercept=-1.17, colour="#FF0000"), linetype="dashed") # FROM uniform line
intALLw <- intALLw  + labs(title="Intensity of Gains and Losses by Category (within permanent forest estates)", x="Category", y="Category Intensity (% of Category)")
intALLw <- intALLw  + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("Category Gain", "Category Loss"))
intALLw <- intALLw  + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intALLw <- intALLw  + theme_minimal()

# Outside permanent forest estates in Tanintharyi Division
intALLo <- ggplot() + geom_bar(data=gainALLo, aes(x=Categories, y=value, fill="#8ACD66"),  stat="identity")
intALLo <- intALLo  + geom_bar(data=lossALLo, aes(x=Categories, y=-value, fill="#B43507"), stat="identity")
intALLo <- intALLo  + geom_hline(yintercept=0, colour="grey90")
intALLo <- intALLo  + geom_hline(aes(yintercept=1.78, colour="#009404"), linetype="dashed") # TO uniform line
intALLo <- intALLo  + geom_hline(aes(yintercept=-1.78, colour="#FF0000"), linetype="dashed") # FROM uniform line
intALLo <- intALLo  + labs(title="Intensity of Gains and Losses by Category (outside permanent forest estates)", x="Category", y="Category Intensity (% of Category)")
intALLo <- intALLo  + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("Category Gain", "Category Loss"))
intALLo <- intALLo  + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intALLo <- intALLo  + theme_minimal()


# ---------------------------
# GENERATE TRANSITION PLOTS
# ---------------------------

# Generate transition level intensity analysis barplots for each land cover type

# Within permanent forest estates in Tanintharyi Division

# Forest
intFORw <- ggplot() + geom_bar(data=toFORw, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intFORw <- intFORw  + geom_bar(data=frFORw, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intFORw <- intFORw  + geom_hline(yintercept=0, colour="grey90")
intFORw <- intFORw  + geom_hline(aes(yintercept=0.68, colour="#009404"), linetype="dashed") # TO uniform line
intFORw <- intFORw  + geom_hline(aes(yintercept=-1.60, colour="#FF0000"), linetype="dashed") # FROM uniform line
intFORw <- intFORw  + labs(title="Transition Intensity for Forest (within permanent forest estates)", x="Transition Category", y="Transition Intensity (% of Category)")
intFORw <- intFORw  + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Forest", "FROM Forest"))
intFORw <- intFORw  + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intFORw <- intFORw  + theme_minimal()

# Mangrove
intMNGw <- ggplot() + geom_bar(data=toMNGw, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intMNGw <- intMNGw  + geom_bar(data=frMNGw, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intMNGw <- intMNGw  + geom_hline(yintercept=0, colour="grey90")
intMNGw <- intMNGw  + geom_hline(aes(yintercept=0.02, colour="#009404"), linetype="dashed") # TO uniform line
intMNGw <- intMNGw  + geom_hline(aes(yintercept=-0.04, colour="#FF0000"), linetype="dashed") # FROM uniform line
intMNGw <- intMNGw  + labs(title="Transition Intensity for Mangrove (within permanent forest estates)", x="Transition Category", y="Transition Intensity (% of Category)")
intMNGw <- intMNGw  + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Mangrove", "FROM Mangrove"))
intMNGw <- intMNGw  + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intMNGw <- intMNGw  + theme_minimal()

# Oil Palm Mature
intOPMw <- ggplot() + geom_bar(data=toOPMw, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intOPMw <- intOPMw  + geom_bar(data=frOPMw, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intOPMw <- intOPMw  + geom_hline(yintercept=0, colour="grey90")
intOPMw <- intOPMw  + geom_hline(aes(yintercept=0.12, colour="#009404"), linetype="dashed") # TO uniform line
intOPMw <- intOPMw  + geom_hline(aes(yintercept=-0.07, colour="#FF0000"), linetype="dashed") # FROM uniform line
intOPMw <- intOPMw  + labs(title="Transition Intensity for Oil Palm Mature (within permanent forest estates)", x="Transition Category", y="Transition Intensity (% of Category)")
intOPMw <- intOPMw  + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Oil Palm", "FROM Oil Palm"))
intOPMw <- intOPMw  + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intOPMw <- intOPMw  + theme_minimal()

# Rubber Mature
intRBMw <- ggplot() + geom_bar(data=toRBMw, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intRBMw <- intRBMw  + geom_bar(data=frRBMw, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intRBMw <- intRBMw  + geom_hline(yintercept=0, colour="grey90")
intRBMw <- intRBMw  + geom_hline(aes(yintercept=0.36, colour="#009404"), linetype="dashed") # TO uniform line
intRBMw <- intRBMw  + geom_hline(aes(yintercept=-0.09, colour="#FF0000"), linetype="dashed") # FROM uniform line
intRBMw <- intRBMw  + labs(title="Transition Intensity for Rubber Mature (within permanent forest estates)", x="Transition Category", y="Transition Intensity (% of Category)")
intRBMw <- intRBMw  + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Rubber", "FROM Rubber"))
intRBMw <- intRBMw  + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intRBMw <- intRBMw  + theme_minimal()

# Shrubs/Orchard
intSHBw <- ggplot() + geom_bar(data=toSHBw, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intSHBw <- intSHBw  + geom_bar(data=frSHBw, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intSHBw <- intSHBw  + geom_hline(yintercept=0, colour="grey90")
intSHBw <- intSHBw  + geom_hline(aes(yintercept=0.54, colour="#009404"), linetype="dashed") # TO uniform line
intSHBw <- intSHBw  + geom_hline(aes(yintercept=-0.44, colour="#FF0000"), linetype="dashed") # FROM uniform line
intSHBw <- intSHBw  + labs(title="Transition Intensity for Shrub/Orchard (within permanent forest estates)", x="Transition Category", y="Transition Intensity (% of Category)")
intSHBw <- intSHBw  + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Shrub/Orchard", "FROM Shrub/Orchard"))
intSHBw <- intSHBw  + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intSHBw <- intSHBw  + theme_minimal()

# Rice Paddy
intRPDw <- ggplot() + geom_bar(data=toRPDw, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intRPDw <- intRPDw  + geom_bar(data=frRPDw, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intRPDw <- intRPDw  + geom_hline(yintercept=0, colour="grey90")
intRPDw <- intRPDw  + geom_hline(aes(yintercept=0.02, colour="#009404"), linetype="dashed") # TO uniform line
intRPDw <- intRPDw  + geom_hline(aes(yintercept=-0.01, colour="#FF0000"), linetype="dashed") # FROM uniform line
intRPDw <- intRPDw  + labs(title="Transition Intensity for Rice Paddy (within permanent forest estates)", x="Transition Category", y="Transition Intensity (% of Category)")
intRPDw <- intRPDw  + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Rice Paddy", "FROM Rice Paddy"))
intRPDw <- intRPDw  + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intRPDw <- intRPDw  + theme_minimal()

# Built-Up Area
intBUAw <- ggplot() + geom_bar(data=toBUAw, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intBUAw <- intBUAw  + geom_bar(data=frBUAw, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intBUAw <- intBUAw  + geom_hline(yintercept=0, colour="grey90")
intBUAw <- intBUAw  + geom_hline(aes(yintercept=0.0004, colour="#009404"), linetype="dashed") # TO uniform line
intBUAw <- intBUAw  + geom_hline(aes(yintercept=-0.0005, colour="#FF0000"), linetype="dashed") # FROM uniform line
intBUAw <- intBUAw  + labs(title="Transition Intensity for Built-Up Area (within permanent forest estates)", x="Transition Category", y="Transition Intensity (% of Category)")
intBUAw <- intBUAw  + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Built-Up Area", "FROM Built-Up Area"))
intBUAw <- intBUAw  + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intBUAw <- intBUAw  + theme_minimal()

# Bare Soil/Ground
intBSGw <- ggplot() + geom_bar(data=toBSGw, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intBSGw <- intBSGw  + geom_bar(data=frBSGw, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intBSGw <- intBSGw  + geom_hline(yintercept=0, colour="grey90")
intBSGw <- intBSGw  + geom_hline(aes(yintercept=0.01, colour="#009404"), linetype="dashed") # TO uniform line
intBSGw <- intBSGw  + geom_hline(aes(yintercept=-0.03, colour="#FF0000"), linetype="dashed") # FROM uniform line
intBSGw <- intBSGw  + labs(title="Transition Intensity for Bare Soil/Ground (within permanent forest estates)", x="Transition Category", y="Transition Intensity (% of Category)")
intBSGw <- intBSGw  + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Bare Soil/Ground", "FROM Bare Soil/Ground"))
intBSGw <- intBSGw  + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intBSGw <- intBSGw  + theme_minimal()

# Water
intWTRw <- ggplot() + geom_bar(data=toWTRw, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intWTRw <- intWTRw  + geom_bar(data=frWTRw, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intWTRw <- intWTRw  + geom_hline(yintercept=0, colour="grey90")
intWTRw <- intWTRw  + geom_hline(aes(yintercept=0.01, colour="#009404"), linetype="dashed") # TO uniform line
intWTRw <- intWTRw  + geom_hline(aes(yintercept=-0.004, colour="#FF0000"), linetype="dashed") # FROM uniform line
intWTRw <- intWTRw  + labs(title="Transition Intensity for Water (within permanent forest estates)", x="Transition Category", y="Transition Intensity (% of Category)")
intWTRw <- intWTRw  + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Water", "FROM Water"))
intWTRw <- intWTRw  + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intWTRw <- intWTRw  + theme_minimal()

# Outside permanent forest estates in Tanintharyi Division

# Forest
intFORo <- ggplot() + geom_bar(data=toFORo, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intFORo <- intFORo  + geom_bar(data=frFORo, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intFORo <- intFORo  + geom_hline(yintercept=0, colour="grey90")
intFORo <- intFORo  + geom_hline(aes(yintercept=0.46, colour="#009404"), linetype="dashed") # TO uniform line
intFORo <- intFORo  + geom_hline(aes(yintercept=-0.81, colour="#FF0000"), linetype="dashed") # FROM uniform line
intFORo <- intFORo  + labs(title="Transition Intensity for Forest (outside permanent forest estates)", x="Transition Category", y="Transition Intensity (% of Category)")
intFORo <- intFORo  + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Forest", "FROM Forest"))
intFORo <- intFORo  + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intFORo <- intFORo  + theme_minimal()

# Mangrove
intMNGo <- ggplot() + geom_bar(data=toMNGo, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intMNGo <- intMNGo  + geom_bar(data=frMNGo, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intMNGo <- intMNGo  + geom_hline(yintercept=0, colour="grey90")
intMNGo <- intMNGo  + geom_hline(aes(yintercept=0.11, colour="#009404"), linetype="dashed") # TO uniform line
intMNGo <- intMNGo  + geom_hline(aes(yintercept=-0.14, colour="#FF0000"), linetype="dashed") # FROM uniform line
intMNGo <- intMNGo  + labs(title="Transition Intensity for Mangrove (outside permanent forest estates)", x="Transition Category", y="Transition Intensity (% of Category)")
intMNGo <- intMNGo  + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Mangrove", "FROM Mangrove"))
intMNGo <- intMNGo  + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intMNGo <- intMNGo  + theme_minimal()

# Oil Palm Mature
intOPMo <- ggplot() + geom_bar(data=toOPMo, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intOPMo <- intOPMo  + geom_bar(data=frOPMo, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intOPMo <- intOPMo  + geom_hline(yintercept=0, colour="grey90")
intOPMo <- intOPMo  + geom_hline(aes(yintercept=0.29, colour="#009404"), linetype="dashed") # TO uniform line
intOPMo <- intOPMo  + geom_hline(aes(yintercept=-0.12, colour="#FF0000"), linetype="dashed") # FROM uniform line
intOPMo <- intOPMo  + labs(title="Transition Intensity for Oil Palm Mature (outside permanent forest estates)", x="Transition Category", y="Transition Intensity (% of Category)")
intOPMo <- intOPMo  + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Oil Palm", "FROM Oil Palm"))
intOPMo <- intOPMo  + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intOPMo <- intOPMo  + theme_minimal()

# Rubber Mature
intRBMo <- ggplot() + geom_bar(data=toRBMo, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intRBMo <- intRBMo  + geom_bar(data=frRBMo, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intRBMo <- intRBMo  + geom_hline(yintercept=0, colour="grey90")
intRBMo <- intRBMo  + geom_hline(aes(yintercept=0.48, colour="#009404"), linetype="dashed") # TO uniform line
intRBMo <- intRBMo  + geom_hline(aes(yintercept=-0.12, colour="#FF0000"), linetype="dashed") # FROM uniform line
intRBMo <- intRBMo  + labs(title="Transition Intensity for Rubber Mature (outside permanent forest estates)", x="Transition Category", y="Transition Intensity (% of Category)")
intRBMo <- intRBMo  + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Rubber", "FROM Rubber"))
intRBMo <- intRBMo  + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intRBMo <- intRBMo  + theme_minimal()

# Shrubs/Orchard
intSHBo <- ggplot() + geom_bar(data=toSHBo, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intSHBo <- intSHBo  + geom_bar(data=frSHBo, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intSHBo <- intSHBo  + geom_hline(yintercept=0, colour="grey90")
intSHBo <- intSHBo  + geom_hline(aes(yintercept=0.85, colour="#009404"), linetype="dashed") # TO uniform line
intSHBo <- intSHBo  + geom_hline(aes(yintercept=-1.00, colour="#FF0000"), linetype="dashed") # FROM uniform line
intSHBo <- intSHBo  + labs(title="Transition Intensity for Shrub/Orchard (outside permanent forest estates)", x="Transition Category", y="Transition Intensity (% of Category)")
intSHBo <- intSHBo  + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Shrub/Orchard", "FROM Shrub/Orchard"))
intSHBo <- intSHBo  + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intSHBo <- intSHBo  + theme_minimal()

# Rice Paddy
intRPDo <- ggplot() + geom_bar(data=toRPDo, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intRPDo <- intRPDo  + geom_bar(data=frRPDo, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intRPDo <- intRPDo  + geom_hline(yintercept=0, colour="grey90")
intRPDo <- intRPDo  + geom_hline(aes(yintercept=0.10, colour="#009404"), linetype="dashed") # TO uniform line
intRPDo <- intRPDo  + geom_hline(aes(yintercept=-0.09, colour="#FF0000"), linetype="dashed") # FROM uniform line
intRPDo <- intRPDo  + labs(title="Transition Intensity for Rice Paddy (outside permanent forest estates)", x="Transition Category", y="Transition Intensity (% of Category)")
intRPDo <- intRPDo  + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Rice Paddy", "FROM Rice Paddy"))
intRPDo <- intRPDo  + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intRPDo <- intRPDo  + theme_minimal()

# Built-Up Area
intBUAo <- ggplot() + geom_bar(data=toBUAo, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intBUAo <- intBUAo  + geom_bar(data=frBUAo, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intBUAo <- intBUAo  + geom_hline(yintercept=0, colour="grey90")
intBUAo <- intBUAo  + geom_hline(aes(yintercept=0.0006, colour="#009404"), linetype="dashed") # TO uniform line
intBUAo <- intBUAo  + geom_hline(aes(yintercept=-0.0028, colour="#FF0000"), linetype="dashed") # FROM uniform line
intBUAo <- intBUAo  + labs(title="Transition Intensity for Built-Up Area (outside permanent forest estates)", x="Transition Category", y="Transition Intensity (% of Category)")
intBUAo <- intBUAo  + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Built-Up Area", "FROM Built-Up Area"))
intBUAo <- intBUAo  + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intBUAo <- intBUAo  + theme_minimal()

# Bare Soil/Ground
intBSGo <- ggplot() + geom_bar(data=toBSGo, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intBSGo <- intBSGo  + geom_bar(data=frBSGo, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intBSGo <- intBSGo  + geom_hline(yintercept=0, colour="grey90")
intBSGo <- intBSGo  + geom_hline(aes(yintercept=0.02, colour="#009404"), linetype="dashed") # TO uniform line
intBSGo <- intBSGo  + geom_hline(aes(yintercept=-0.14, colour="#FF0000"), linetype="dashed") # FROM uniform line
intBSGo <- intBSGo  + labs(title="Transition Intensity for Bare Soil/Ground (outside permanent forest estates)", x="Transition Category", y="Transition Intensity (% of Category)")
intBSGo <- intBSGo  + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Bare Soil/Ground", "FROM Bare Soil/Ground"))
intBSGo <- intBSGo  + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intBSGo <- intBSGo  + theme_minimal()

# Water
intWTRo <- ggplot() + geom_bar(data=toWTRo, aes(x=Category.Transitions, y=value, fill="#8ACD66"),  stat="identity")
intWTRo <- intWTRo  + geom_bar(data=frWTRo, aes(x=Category.Transitions, y=-value, fill="#B43507"), stat="identity")
intWTRo <- intWTRo  + geom_hline(yintercept=0, colour="grey90")
intWTRo <- intWTRo  + geom_hline(aes(yintercept=0.01, colour="#009404"), linetype="dashed") # TO uniform line
intWTRo <- intWTRo  + geom_hline(aes(yintercept=-0.03, colour="#FF0000"), linetype="dashed") # FROM uniform line
intWTRo <- intWTRo  + labs(title="Transition Intensity for Water (outside permanent forest estates)", x="Transition Category", y="Transition Intensity (% of Category)")
intWTRo <- intWTRo  + scale_fill_manual(values=c("#8ACD66", "#B43507"), name="Change Direction", labels = c("TO Water", "FROM Water"))
intWTRo <- intWTRo  + scale_colour_manual(values=c("#009404", "#FF0000"), name="Uniform Line", labels = c("Gain", "Loss"))
intWTRo <- intWTRo  + theme_minimal()


# ---------------------------
# OUTPUT PLOTS
# ---------------------------

# Output boxplots to a PDF file

# Within permanent forest estates in Tanintharyi Division
ggsave(intALLw, file="IntensityAnalysis-wPFE-ALL.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intFORw, file="IntensityAnalysis-wPFE-FOR.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intMNGw, file="IntensityAnalysis-wPFE-MNG.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intOPMw, file="IntensityAnalysis-wPFE-OPM.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intRBMw, file="IntensityAnalysis-wPFE-RBM.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intSHBw, file="IntensityAnalysis-wPFE-SHB.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intRPDw, file="IntensityAnalysis-wPFE-RPD.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intBUAw, file="IntensityAnalysis-wPFE-BUA.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intBSGw, file="IntensityAnalysis-wPFE-BSG.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intWTRw, file="IntensityAnalysis-wPFE-WTR.pdf", width=19.89, height=15, units="cm", dpi=300)

# Outside permanent forest estates in Tanintharyi Division
ggsave(intALLo, file="IntensityAnalysis-oPFE-ALL.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intFORo, file="IntensityAnalysis-oPFE-FOR.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intMNGo, file="IntensityAnalysis-oPFE-MNG.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intOPMo, file="IntensityAnalysis-oPFE-OPM.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intRBMo, file="IntensityAnalysis-oPFE-RBM.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intSHBo, file="IntensityAnalysis-oPFE-SHB.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intRPDo, file="IntensityAnalysis-oPFE-RPD.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intBUAo, file="IntensityAnalysis-oPFE-BUA.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intBSGo, file="IntensityAnalysis-oPFE-BSG.pdf", width=19.89, height=15, units="cm", dpi=300)
ggsave(intWTRo, file="IntensityAnalysis-oPFE-WTR.pdf", width=19.89, height=15, units="cm", dpi=300)
