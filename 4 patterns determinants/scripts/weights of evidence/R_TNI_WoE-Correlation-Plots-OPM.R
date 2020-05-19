# This script generates plots from the results of the independence tests implemented
# in DINAMICA EGO to assess the independence (or association/correlation) of spatial
# determinants (e.g., biophysical and socio-economic variables) that can be used for
# calculating the location probabilities of land use/cover transitions related to
# agriculturalexpansion of major crop commodities (i.e., oil palm, rubber, rice) in
# Tanintharyi Region, Myanmar.
# 
# Script by:      Jose Don T. De Alban
# Date created:   19 May 2020
# Date modified:  19 May 2020   


# Load Libraries -------------------------
library(tidyverse)
library(reshape2)
library(plot.matrix)
library(viridis)
library(viridisLite)

# Set Working Directories ----------------
DirMAIN  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/"
DirDATA  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/"
DirOPMI1 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/opm/c_1996_2007/step04/"
DirOPMI2 <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/opm/c_2007_2016/step04/"

# Read Data Files ------------------------
# Correlation data for oil palm
setwd(DirOPMI1)
dfOPMi1 <- read.csv(file="tni_correlation.csv", header=TRUE, sep=",")
setwd(DirOPMI2)
dfOPMi2 <- read.csv(file="tni_correlation.csv", header=TRUE, sep=",")

# Extract Data Subsets -------------------

# OIL PALM transitions

# Replace character strings
dfOPMi1$First_Variable.  <- gsub(".*/", "", dfOPMi1$First_Variable.)
dfOPMi1$Second_Variable. <- gsub(".*/", "", dfOPMi1$Second_Variable.)
dfOPMi2$First_Variable.  <- gsub(".*/", "", dfOPMi2$First_Variable.)
dfOPMi2$Second_Variable. <- gsub(".*/", "", dfOPMi2$Second_Variable.)

# Extract Cramer's Coefficients
# FOR to OPM
df3to5i1CRM <- dfOPMi1 %>% filter(dfOPMi1$Transition_From. %in% "3" & dfOPMi1$First_Variable. != "distance_to_5") %>% select(3:4,6)
df3to5i2CRM <- dfOPMi2 %>% filter(dfOPMi2$Transition_From. %in% "3" & dfOPMi2$First_Variable. != "distance_to_5") %>% select(3:4,6)


# Extract Joint Information Uncertainty Coefficients
# FOR to OPM
df3to5i1JIU <- dfOPMi1 %>% filter(dfOPMi1$Transition_From. %in% "3" & dfOPMi1$First_Variable. != "distance_to_5") %>% select(3:4,9)
df3to5i2JIU <- dfOPMi2 %>% filter(dfOPMi2$Transition_From. %in% "3" & dfOPMi2$First_Variable. != "distance_to_5") %>% select(3:4,9)


# Convert dataframes to numeric matrix

df3to5i1CRM <- acast(df3to5i1CRM, First_Variable. ~ Second_Variable., value.var="Cramer")
df3to5i2CRM <- acast(df3to5i2CRM, First_Variable. ~ Second_Variable., value.var="Cramer")

df3to5i1JIU <- acast(df3to5i1JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")
df3to5i2JIU <- acast(df3to5i2JIU, First_Variable. ~ Second_Variable., value.var="Joint_Uncertainty")

# Convert NAs to 0
#df3to5i1CRM[is.na(df3to5i1CRM)] <- 0


# Generate and Save Plots ----------------

# FOR to OPM: Cramer's V
setwd(DirDATA)
pdf("df3to5i1CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to5i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df3to5i1CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df3to5i1CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to5i1CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's Coefficients: df3to5i1CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df3to5i2CRM_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to5i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's V Coefficients: df3to5i2CRM",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df3to5i2CRM_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to5i2CRM, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's Coefficients: df3to5i2CRM",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()

# FOR to OPM: Joint Information Uncertainty
setwd(DirDATA)
pdf("df3to5i1JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to5i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df3to5i1JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df3to5i1JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to5i1JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df3to5i1JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df3to5i2JIU_ALL.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to5i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df3to5i2JIU",
     col=viridis, breaks=c(0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()
pdf("df3to5i2JIU_REM.pdf")
par(mar=c(5, 5, 5, 5))
plot(df3to5i2JIU, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Joint Information Uncertainty Criterion: df3to5i2JIU",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))
dev.off()

