# Script Description --------------------
# This R script generates barplots using ggplot2 package to visualise the which land cover
# categories are mangroves losing to and gaining from the most in each time-interval across
# all mangrove regions in Myanmar.
#
# Script By:      Jose Don T De Alban
# Date Created:   13 Dec 2018
# Last Modified:  

# Set Working Directory -------------------
setwd("/Users/dondealban/Dropbox/Research/myanmar/3 mmr land cover transitions/mangroves/")

# Load Libraries --------------------------
library(tidyverse)

# Read Input Data -------------------------
dfGROSS <- read.csv(file="Loss & Gain Totals.csv", header=TRUE, sep=",")

# Generate Plots --------------------------
plot <- ggplot() + geom_bar(data=dfGROSS, aes(x=Change, y=AreaKm2, fill=Category), stat="identity")
plot <- plot + facet_wrap(~Interval)
plot <- plot + labs(x="Mangrove Change per Time-Interval", y="Areal Extent (sq.km)", fill="Category")
plot <- plot + scale_fill_manual(values=c("#ffff66","#ff0000","#246a24","#ff8000",
                                          "#ff00ff","#a65400","#ccff66","#66ccff"))

# Save Output Plots -----------------------

ggsave(plot, file="Barplot-Total-Gross-Loss-Gain-Mangroves.pdf", width=19.89, height=15, units="cm", dpi=300)



