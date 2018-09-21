# Script purpose:
# Generate panelled barplots for the Interval level of the Intensity Analysis 
# for Myanmar country (national level)

# Set Working Directory -------------------
setwd("C:/150918 MMR Barplots/1-Interval")


# Load Libraries --------------------------

library(ggplot2)
library(plyr)

# Read Input Data -------------------------

dataINT <- read.csv(file="Interval Level (All Domains).csv", header=TRUE, sep=",")

# Clean and Subset Data -------------------

# Select columns: include all columns except Category ID
dfINT <- subset(dataINT, select=c(5,7,9,10))


# Change column names for easier reference

# Note the following description of category level column names
# ColA - Domain_name
# ColB - Time_interval
# ColC - Annual_Change_percent_of_interval's_domain
# ColD - Uniform_Annual_Change_percrent_of_all_domains

list <- c("ColA","ColB","ColC","ColD")
colnames(dfINT) <- c(list)


# Generate Plots ------------------------

# Plot 1: Interval Level all domains for both intervals
plotINT <- ggplot() + geom_bar(data=dfINT, aes(x=ColB, y=ColC), stat="identity", position=position_dodge())
plotINT <- plotINT  + geom_hline(data=dfINT, aes(yintercept=ColD, colour="#000000"), linetype="dashed") # Uniform line
plotINT <- plotINT  + facet_wrap(~ColA)
plotINT <- plotINT  + labs(x="Time Interval", y="Change Intensity (%)")
#plotINT <- plotINT  + scale_x_discrete(labels=c("1996 to 2007", "2007 to 2016"))
#plotINT <- plotINT  + scale_fill_manual(values=c("#b43507","#8acd66"), labels=c("Loss Intensity","Gain Intensity"))
plotINT <- plotINT  + scale_colour_manual(values=c("#000000"), labels=c("Uniform Intensity"))
plotINT <- plotINT  + theme(panel.grid.minor=element_blank())
plotINT <- plotINT  + theme(legend.title=element_blank(), legend.position=c(0.94,0.975), legend.box="horizontal")


# Save Outputs --------------------------

# Output boxplots to a PDF file
ggsave(plotINT, file="IA-Interval-All Domains.pdf", width=29.89, height=25, units="cm", dpi=300)

# Export dataframe to CSV file
write.csv(dfINT, file="IA-Interval-All Domains-Rscript-output.csv")
