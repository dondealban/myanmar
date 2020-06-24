# This script generates plots from the results of the independence tests implemented
# in DINAMICA EGO to assess the independence (or association/correlation) of spatial
# determinants (e.g., biophysical and socio-economic variables) that can be used for
# calculating the location probabilities of land use/cover transitions related to
# agriculturalexpansion of major crop commodities (i.e., oil palm, rubber, rice) in
# Tanintharyi Region, Myanmar.
# 
# Script by:      Jose Don T. De Alban
# Date created:   19 May 2020
# Date modified:  24 Jun 2020   


# Load Libraries -------------------------
library(tidyverse)
library(reshape2)
library(plot.matrix)
library(viridis)
library(viridisLite)

# Set Working Directories ----------------
DirMAIN  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/"
DirDATA  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/plots/"
DirRPDI1 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/rpd/c_1996_2007/step04/"
DirRPDI2 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/rpd/c_2007_2016/step04/"

# Read Data Files ------------------------
# Correlation data for RICE PADDY
setwd(DirRPDI1)
dfRPDi1 <- read.csv(file="tni_correlation.csv", header=TRUE, sep=",")
setwd(DirRPDI2)
dfRPDi2 <- read.csv(file="tni_correlation.csv", header=TRUE, sep=",")

# Extract Data Subsets -------------------

# Replace character strings
dfRPDi1$First_Variable.  <- gsub(".*/", "", dfRPDi1$First_Variable.)
dfRPDi1$Second_Variable. <- gsub(".*/", "", dfRPDi1$Second_Variable.)
dfRPDi2$First_Variable.  <- gsub(".*/", "", dfRPDi2$First_Variable.)
dfRPDi2$Second_Variable. <- gsub(".*/", "", dfRPDi2$Second_Variable.)

# Extract Cramer's V Coefficients
# FOR to RPD
df3to6i1CRM <- dfRPDi1 %>% filter(dfRPDi1$Transition_From. %in% "3" & dfRPDi1$First_Variable. != "distance_to_6") %>% select(3:4,6)
df3to6i2CRM <- dfRPDi2 %>% filter(dfRPDi2$Transition_From. %in% "3" & dfRPDi2$First_Variable. != "distance_to_6") %>% select(3:4,6)
# MNG to RPD
df4to6i1CRM <- dfRPDi1 %>% filter(dfRPDi1$Transition_From. %in% "4" & dfRPDi1$First_Variable. != "distance_to_6") %>% select(3:4,6)
df4to6i2CRM <- dfRPDi2 %>% filter(dfRPDi2$Transition_From. %in% "4" & dfRPDi2$First_Variable. != "distance_to_6") %>% select(3:4,6)
# OPM to RPD
df5to6i1CRM <- dfRPDi1 %>% filter(dfRPDi1$Transition_From. %in% "5" & dfRPDi1$First_Variable. != "distance_to_6") %>% select(3:4,6)
df5to6i2CRM <- dfRPDi2 %>% filter(dfRPDi2$Transition_From. %in% "5" & dfRPDi2$First_Variable. != "distance_to_6") %>% select(3:4,6)
# RBR to RPD
df7to6i1CRM <- dfRPDi1 %>% filter(dfRPDi1$Transition_From. %in% "7" & dfRPDi1$First_Variable. != "distance_to_6") %>% select(3:4,6)
df7to6i2CRM <- dfRPDi2 %>% filter(dfRPDi2$Transition_From. %in% "7" & dfRPDi2$First_Variable. != "distance_to_6") %>% select(3:4,6)
# SHB to RPD
df8to6i1CRM <- dfRPDi1 %>% filter(dfRPDi1$Transition_From. %in% "8" & dfRPDi1$First_Variable. != "distance_to_6") %>% select(3:4,6)
df8to6i2CRM <- dfRPDi2 %>% filter(dfRPDi2$Transition_From. %in% "8" & dfRPDi2$First_Variable. != "distance_to_6") %>% select(3:4,6)

# Extract Joint Information Uncertainty Coefficients
# FOR to RPD
df3to6i1JIU <- dfRPDi1 %>% filter(dfRPDi1$Transition_From. %in% "3" & dfRPDi1$First_Variable. != "distance_to_6") %>% select(3:4,9)
df3to6i2JIU <- dfRPDi2 %>% filter(dfRPDi2$Transition_From. %in% "3" & dfRPDi2$First_Variable. != "distance_to_6") %>% select(3:4,9)
# MNG to RPD
df4to6i1JIU <- dfRPDi1 %>% filter(dfRPDi1$Transition_From. %in% "4" & dfRPDi1$First_Variable. != "distance_to_6") %>% select(3:4,9)
df4to6i2JIU <- dfRPDi2 %>% filter(dfRPDi2$Transition_From. %in% "4" & dfRPDi2$First_Variable. != "distance_to_6") %>% select(3:4,9)
# OPM to RPD
df5to6i1JIU <- dfRPDi1 %>% filter(dfRPDi1$Transition_From. %in% "5" & dfRPDi1$First_Variable. != "distance_to_6") %>% select(3:4,9)
df5to6i2JIU <- dfRPDi2 %>% filter(dfRPDi2$Transition_From. %in% "5" & dfRPDi2$First_Variable. != "distance_to_6") %>% select(3:4,9)
# RBR to RPD
df7to6i1JIU <- dfRPDi1 %>% filter(dfRPDi1$Transition_From. %in% "7" & dfRPDi1$First_Variable. != "distance_to_6") %>% select(3:4,9)
df7to6i2JIU <- dfRPDi2 %>% filter(dfRPDi2$Transition_From. %in% "7" & dfRPDi2$First_Variable. != "distance_to_6") %>% select(3:4,9)
# SHB to RPD
df8to6i1JIU <- dfRPDi1 %>% filter(dfRPDi1$Transition_From. %in% "8" & dfRPDi1$First_Variable. != "distance_to_6") %>% select(3:4,9)
df8to6i2JIU <- dfRPDi2 %>% filter(dfRPDi2$Transition_From. %in% "8" & dfRPDi2$First_Variable. != "distance_to_6") %>% select(3:4,9)

# Convert Dataframes to Matrices ---------

# Cramer's V Coefficients
df3to6i1CRM <- acast(df3to6i1CRM, First_Variable. ~ Second_Variable., value.var="Cramer")
df3to6i2CRM <- acast(df3to6i2CRM, First_Variable. ~ Second_Variable., value.var="Cramer")
df4to6i1CRM <- acast(df4to6i1CRM, First_Variable. ~ Second_Variable., value.var="Cramer")
df4to6i2CRM <- acast(df4to6i2CRM, First_Variable. ~ Second_Variable., value.var="Cramer")
df5to6i1CRM <- acast(df5to6i1CRM, First_Variable. ~ Second_Variable., value.var="Cramer")
df5to6i2CRM <- acast(df5to6i2CRM, First_Variable. ~ Second_Variable., value.var="Cramer")
df7to6i1CRM <- acast(df7to6i1CRM, First_Variable. ~ Second_Variable., value.var="Cramer")
df7to6i2CRM <- acast(df7to6i2CRM, First_Variable. ~ Second_Variable., value.var="Cramer")
df8to6i1CRM <- acast(df8to6i1CRM, First_Variable. ~ Second_Variable., value.var="Cramer")
df8to6i2CRM <- acast(df8to6i2CRM, First_Variable. ~ Second_Variable., value.var="Cramer")

# Joint Information Uncertainty Coefficients
df3to6i1JIU <- acast(df3to6i1JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")
df3to6i2JIU <- acast(df3to6i2JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")
df4to6i1JIU <- acast(df4to6i1JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")
df4to6i2JIU <- acast(df4to6i2JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")
df5to6i1JIU <- acast(df5to6i1JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")
df5to6i2JIU <- acast(df5to6i2JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")
df7to6i1JIU <- acast(df7to6i1JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")
df7to6i2JIU <- acast(df7to6i2JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")
df8to6i1JIU <- acast(df8to6i1JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")
df8to6i2JIU <- acast(df8to6i2JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")

# Convert NAs to 0, if needed
#df3to6i1CRM[is.na(df3to6i1CRM)] <- 0

# Generate and Save Plots ----------------

# Cramer's V Coefficients
# FOR to RPD
setwd(DirDATA)
pdf("df3to6i1CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to6i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df3to6i1CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df3to6i1CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to6i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df3to6i1CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df3to6i2CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to6i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df3to6i2CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df3to6i2CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to6i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df3to6i2CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()

# MNG to RPD
setwd(DirDATA)
pdf("df4to6i1CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df4to6i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df4to6i1CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df4to6i1CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df4to6i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df4to6i1CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df4to6i2CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df4to6i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df4to6i2CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df4to6i2CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df4to6i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df4to6i2CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()

# OPM to RPD
setwd(DirDATA)
pdf("df5to6i1CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df5to6i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df5to6i1CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df5to6i1CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df5to6i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's Coefficients: df5to6i1CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df5to6i2CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df5to6i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df5to6i2CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df5to6i2CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df5to6i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's Coefficients: df5to6i2CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()

# RBR to RPD
setwd(DirDATA)
pdf("df7to6i1CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df7to6i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df7to6i1CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df7to6i1CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df7to6i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's Coefficients: df7to6i1CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df7to6i2CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df7to6i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df7to6i2CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df7to6i2CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df7to6i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's Coefficients: df7to6i2CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()

# SHB to RPD
setwd(DirDATA)
pdf("df8to6i1CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df8to6i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df8to6i1CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df8to6i1CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df8to6i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's Coefficients: df8to6i1CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df8to6i2CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df8to6i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df8to6i2CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df8to6i2CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df8to6i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's Coefficients: df8to6i2CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()

# Joint Information Uncertainty
# FOR to RPD
setwd(DirDATA)
pdf("df3to6i1JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to6i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df3to6i1JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df3to6i1JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to6i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df3to6i1JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df3to6i2JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to6i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df3to6i2JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df3to6i2JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to6i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df3to6i2JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()

# MNG to RPD
setwd(DirDATA)
pdf("df4to6i1JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df4to6i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df4to6i1JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df4to6i1JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df4to6i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df4to6i1JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df4to6i2JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df4to6i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df4to6i2JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df4to6i2JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df4to6i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df4to6i2JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()

# OPM to RPD
setwd(DirDATA)
pdf("df5to6i1JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df5to6i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df5to6i1JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df5to6i1JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df5to6i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df5to6i1JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df5to6i2JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df5to6i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df5to6i2JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df5to6i2JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df5to6i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df5to6i2JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()

# RBR to RPD
setwd(DirDATA)
pdf("df7to6i1JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df7to6i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df7to6i1JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df7to6i1JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df7to6i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df7to6i1JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df7to6i2JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df7to6i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df7to6i2JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df7to6i2JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df7to6i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df7to6i2JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()

# SHB to RPD
setwd(DirDATA)
pdf("df8to6i1JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df8to6i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df8to6i1JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df8to6i1JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df8to6i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df8to6i1JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df8to6i2JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df8to6i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df8to6i2JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df8to6i2JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df8to6i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df8to6i2JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()