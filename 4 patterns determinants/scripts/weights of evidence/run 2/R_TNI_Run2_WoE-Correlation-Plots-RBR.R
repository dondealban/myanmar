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
DirPLOT  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/plots/"
DirRBRI1 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/rbr/c_1996_2007/step04/"
DirRBRI2 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/run 2/rbr/c_2007_2016/step04/"

# Read Data Files ------------------------
# Correlation data for OIL PALM
setwd(DirRBRI1)
dfRBRi1 <- read.csv(file="tni_correlation.csv", header=TRUE, sep=",")
setwd(DirRBRI2)
dfRBRi2 <- read.csv(file="tni_correlation.csv", header=TRUE, sep=",")

# Extract Data Subsets -------------------

# Replace character strings
dfRBRi1$First_Variable.  <- gsub(".*/", "", dfRBRi1$First_Variable.)
dfRBRi1$Second_Variable. <- gsub(".*/", "", dfRBRi1$Second_Variable.)
dfRBRi2$First_Variable.  <- gsub(".*/", "", dfRBRi2$First_Variable.)
dfRBRi2$Second_Variable. <- gsub(".*/", "", dfRBRi2$Second_Variable.)

# Extract Cramer's V Coefficients
# FOR to RBR
df3to7i1CRM <- dfRBRi1 %>% filter(dfRBRi1$Transition_From. %in% "3" & dfRBRi1$First_Variable. != "distance_to_7") %>% select(3:4,6)
df3to7i2CRM <- dfRBRi2 %>% filter(dfRBRi2$Transition_From. %in% "3" & dfRBRi2$First_Variable. != "distance_to_7") %>% select(3:4,6)
# MNG to RBR
df4to7i1CRM <- dfRBRi1 %>% filter(dfRBRi1$Transition_From. %in% "4" & dfRBRi1$First_Variable. != "distance_to_7") %>% select(3:4,6)
df4to7i2CRM <- dfRBRi2 %>% filter(dfRBRi2$Transition_From. %in% "4" & dfRBRi2$First_Variable. != "distance_to_7") %>% select(3:4,6)
# OPM to RBR
df5to7i1CRM <- dfRBRi1 %>% filter(dfRBRi1$Transition_From. %in% "5" & dfRBRi1$First_Variable. != "distance_to_7") %>% select(3:4,6)
df5to7i2CRM <- dfRBRi2 %>% filter(dfRBRi2$Transition_From. %in% "5" & dfRBRi2$First_Variable. != "distance_to_7") %>% select(3:4,6)
# RPD to RBR
df6to7i1CRM <- dfRBRi1 %>% filter(dfRBRi1$Transition_From. %in% "6" & dfRBRi1$First_Variable. != "distance_to_7") %>% select(3:4,6)
df6to7i2CRM <- dfRBRi2 %>% filter(dfRBRi2$Transition_From. %in% "6" & dfRBRi2$First_Variable. != "distance_to_7") %>% select(3:4,6)
# SHB to RBR
df8to7i1CRM <- dfRBRi1 %>% filter(dfRBRi1$Transition_From. %in% "8" & dfRBRi1$First_Variable. != "distance_to_7") %>% select(3:4,6)
df8to7i2CRM <- dfRBRi2 %>% filter(dfRBRi2$Transition_From. %in% "8" & dfRBRi2$First_Variable. != "distance_to_7") %>% select(3:4,6)

# Extract Joint Information Uncertainty Coefficients
# FOR to RBR
df3to7i1JIU <- dfRBRi1 %>% filter(dfRBRi1$Transition_From. %in% "3" & dfRBRi1$First_Variable. != "distance_to_7") %>% select(3:4,9)
df3to7i2JIU <- dfRBRi2 %>% filter(dfRBRi2$Transition_From. %in% "3" & dfRBRi2$First_Variable. != "distance_to_7") %>% select(3:4,9)
# MNG to RBR
df4to7i1JIU <- dfRBRi1 %>% filter(dfRBRi1$Transition_From. %in% "4" & dfRBRi1$First_Variable. != "distance_to_7") %>% select(3:4,9)
df4to7i2JIU <- dfRBRi2 %>% filter(dfRBRi2$Transition_From. %in% "4" & dfRBRi2$First_Variable. != "distance_to_7") %>% select(3:4,9)
# OPM to RBR
df5to7i1JIU <- dfRBRi1 %>% filter(dfRBRi1$Transition_From. %in% "5" & dfRBRi1$First_Variable. != "distance_to_7") %>% select(3:4,9)
df5to7i2JIU <- dfRBRi2 %>% filter(dfRBRi2$Transition_From. %in% "5" & dfRBRi2$First_Variable. != "distance_to_7") %>% select(3:4,9)
# RPD to RBR
df6to7i1JIU <- dfRBRi1 %>% filter(dfRBRi1$Transition_From. %in% "6" & dfRBRi1$First_Variable. != "distance_to_7") %>% select(3:4,9)
df6to7i2JIU <- dfRBRi2 %>% filter(dfRBRi2$Transition_From. %in% "6" & dfRBRi2$First_Variable. != "distance_to_7") %>% select(3:4,9)
# SHB to RBR
df8to7i1JIU <- dfRBRi1 %>% filter(dfRBRi1$Transition_From. %in% "8" & dfRBRi1$First_Variable. != "distance_to_7") %>% select(3:4,9)
df8to7i2JIU <- dfRBRi2 %>% filter(dfRBRi2$Transition_From. %in% "8" & dfRBRi2$First_Variable. != "distance_to_7") %>% select(3:4,9)

# Convert Dataframes to Matrices ---------

# Cramer's V Coefficients
df3to7i1CRM <- acast(df3to7i1CRM, First_Variable. ~ Second_Variable., value.var="Cramer")
df3to7i2CRM <- acast(df3to7i2CRM, First_Variable. ~ Second_Variable., value.var="Cramer")
df4to7i1CRM <- acast(df4to7i1CRM, First_Variable. ~ Second_Variable., value.var="Cramer")
df4to7i2CRM <- acast(df4to7i2CRM, First_Variable. ~ Second_Variable., value.var="Cramer")
df5to7i1CRM <- acast(df5to7i1CRM, First_Variable. ~ Second_Variable., value.var="Cramer")
df5to7i2CRM <- acast(df5to7i2CRM, First_Variable. ~ Second_Variable., value.var="Cramer")
df6to7i1CRM <- acast(df6to7i1CRM, First_Variable. ~ Second_Variable., value.var="Cramer")
df6to7i2CRM <- acast(df6to7i2CRM, First_Variable. ~ Second_Variable., value.var="Cramer")
df8to7i1CRM <- acast(df8to7i1CRM, First_Variable. ~ Second_Variable., value.var="Cramer")
df8to7i2CRM <- acast(df8to7i2CRM, First_Variable. ~ Second_Variable., value.var="Cramer")

# Joint Information Uncertainty Coefficients
df3to7i1JIU <- acast(df3to7i1JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")
df3to7i2JIU <- acast(df3to7i2JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")
df4to7i1JIU <- acast(df4to7i1JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")
df4to7i2JIU <- acast(df4to7i2JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")
df5to7i1JIU <- acast(df5to7i1JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")
df5to7i2JIU <- acast(df5to7i2JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")
df6to7i1JIU <- acast(df6to7i1JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")
df6to7i2JIU <- acast(df6to7i2JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")
df8to7i1JIU <- acast(df8to7i1JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")
df8to7i2JIU <- acast(df8to7i2JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")

# Convert NAs to 0, if needed
#df3to7i1CRM[is.na(df3to7i1CRM)] <- 0

# Generate and Save Plots ----------------

# Cramer's V Coefficients
# FOR to RBR
setwd(DirPLOT)
pdf("df3to7i1CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to7i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df3to7i1CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df3to7i1CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to7i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df3to7i1CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df3to7i2CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to7i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df3to7i2CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df3to7i2CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to7i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df3to7i2CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()

# MNG to RBR
setwd(DirPLOT)
pdf("df4to7i1CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df4to7i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df4to7i1CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df4to7i1CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df4to7i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df4to7i1CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df4to7i2CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df4to7i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df4to7i2CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df4to7i2CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df4to7i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df4to7i2CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()

# OPM to RBR
setwd(DirPLOT)
pdf("df5to7i1CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df5to7i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df5to7i1CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df5to7i1CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df5to7i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's Coefficients: df5to7i1CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df5to7i2CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df5to7i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df5to7i2CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df5to7i2CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df5to7i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's Coefficients: df5to7i2CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()

# RPD to RBR
setwd(DirPLOT)
pdf("df6to7i1CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df6to7i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df6to7i1CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df6to7i1CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df6to7i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's Coefficients: df6to7i1CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df6to7i2CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df6to7i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df6to7i2CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df6to7i2CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df6to7i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's Coefficients: df6to7i2CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()

# SHB to RBR
setwd(DirPLOT)
pdf("df8to7i1CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df8to7i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df8to7i1CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df8to7i1CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df8to7i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's Coefficients: df8to7i1CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df8to7i2CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df8to7i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df8to7i2CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df8to7i2CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df8to7i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's Coefficients: df8to7i2CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()

# Joint Information Uncertainty
# FOR to RBR
setwd(DirPLOT)
pdf("df3to7i1JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to7i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df3to7i1JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df3to7i1JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to7i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df3to7i1JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df3to7i2JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to7i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df3to7i2JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df3to7i2JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to7i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df3to7i2JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()

# MNG to RBR
setwd(DirPLOT)
pdf("df4to7i1JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df4to7i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df4to7i1JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df4to7i1JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df4to7i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df4to7i1JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df4to7i2JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df4to7i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df4to7i2JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df4to7i2JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df4to7i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df4to7i2JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()

# OPM to RBR
setwd(DirPLOT)
pdf("df5to7i1JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df5to7i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df5to7i1JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df5to7i1JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df5to7i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df5to7i1JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df5to7i2JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df5to7i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df5to7i2JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df5to7i2JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df5to7i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df5to7i2JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()

# RPD to RBR
setwd(DirPLOT)
pdf("df6to7i1JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df6to7i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df6to7i1JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df6to7i1JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df6to7i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df6to7i1JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df6to7i2JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df6to7i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df6to7i2JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df6to7i2JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df6to7i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df6to7i2JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()

# SHB to RBR
setwd(DirPLOT)
pdf("df8to7i1JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df8to7i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df8to7i1JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df8to7i1JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df8to7i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df8to7i1JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df8to7i2JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df8to7i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df8to7i2JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df8to7i2JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df8to7i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df8to7i2JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()