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
MainDir  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/"
DataDir  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/weights of evidence/"
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
# Round off coefficients
dfOPMi1$RoundCRM <- round(dfOPMi1$Cramer, digit=2)
dfOPMi1$RoundJtU <- round(dfOPMi1$Joint_Uncertainty, digit=2)


#df3to5i1CRM <- dfOPMi1 %>% filter(dfOPMi1$Transition_From. %in% "3") %>% select(3:4,6)


df3to5i1CRM <- dfOPMi1 %>% filter(dfOPMi1$Transition_From. %in% "3" & dfOPMi1$First_Variable. != "distance_to_5") %>% select(3:4,6)


# Rename column names
# colnames(df3to5i1CRM) <- c("x","y","coefficient","label")

df3 <- acast(df3to5i1CRM, First_Variable. ~ Second_Variable., value.var="Cramer")
df3[is.na(df3)] <- 0
#ggcorrplot(df3, method="square")


#This!
df <- acast(df3to5i1CRM, First_Variable. ~ Second_Variable., value.var="Cramer")
df[is.na(df)] <- 0
plot(df, border=NA, col=viridis, breaks=10)

plot(df, border="lightgray", col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))


par(mar=c(5, 5, 5, 5))
plot(df, border="lightgray",
     key=list(side=4, cex.axis=0.7), 
     axis.col=list(side=1, cex.axis=0.6, las=2, tcl=-0.3),
     axis.row=list(side=2, cex.axis=0.6, las=2, tcl=-0.3),
     xlab='', ylab='', main="Cramer's Coefficients",
     col=viridis, breaks=c(0.5,0.6,0.7,0.8,0.9,1.0))



#ggcorrplot(df3, method="square")


# Generate Plots -------------------------

plot <- ggcorr(df3to5i1CRM, geom="blank", label=TRUE, hjust=0.75)
plot <- plot + geom_point(size=10, aes(color=coefficient > 0.45, alpha = abs(coefficient) > 0.5))
plot <- plot + scale_alpha_manual(values=c("TRUE"=0.25, "FALSE"=0))
plot <- plot + guides(color=FALSE, alpha=FALSE)


