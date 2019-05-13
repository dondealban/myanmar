# Script Description --------------------
# This R script generates split stacked area plots to visualise gross+net extents and
# changes of mangroves in Myanmar and in each sub-national administrative unit.
#
# Script By:      Jose Don T De Alban
# Date Created:   10 May 2019
# Last Modified:  13 May 2019

# Set Working Directory -------------------
setwd("/Users/dondealban/Dropbox/Research/myanmar/3 mmr land cover transitions/mangroves/gross and net/")

# Load Libraries --------------------------
library(reshape2)
library(dplyr)
library(ggplot2)

# Read Input Data -------------------------
dfRAW <- read.csv(file="ForR_Data_Split-Stacked-Area-Plots.csv", header=TRUE, sep=",")

# Reorganise Data -------------------------
mDATA <- melt(dfRAW, id=c('TimePoint','Change')) # requires reshape2 package
colnames(mDATA) <- c("TimePoint","Change","Region","AreaSqKm")
mDATA$Change <- factor(mDATA$Change, levels=c("Gross Loss","Net Loss","Gross Gain","Persistence","Undisturbed"))


# Subset Data -----------------------------
# pipes require dplyr package
dfMMR  <- mDATA %>% filter(Region %in% "Myanmar")
dfMMR1 <- dfMMR %>% filter(TimePoint %in% "1996" | TimePoint %in% "2007")
dfMMR2 <- dfMMR %>% filter(TimePoint %in% "2007" | TimePoint %in% "2016")


dfAYE <- mDATA %>% filter(Region %in% "Ayeyarwady")
dfBAG <- mDATA %>% filter(Region %in% "Bago")
dfMON <- mDATA %>% filter(Region %in% "Mon")
dfRAK <- mDATA %>% filter(Region %in% "Rakhine")
dfTNI <- mDATA %>% filter(Region %in% "Tanintharyi")
dfYGN <- mDATA %>% filter(Region %in% "Yangon")

# Define Plots ----------------------------

# Plot: Myanmar
pMMR1 <- ggplot() + geom_area(aes(x=TimePoint, y=AreaSqKm, fill=factor(Change,
                                  labels=c("Gross Loss",
                                           "Net Loss",
                                           "Gross Gain",
                                           "Persistence",
                                           "Undisturbed"))), 
                                  data=dfMMR1, alpha=0.6)
pMMR1 <- pMMR1 + labs(title="Myanmar", x="Year", y="Area (sq.km)", fill="")
pMMR1 <- pMMR1 + guides(fill=guide_legend(ncol=1))
#pMMR1 <- pMMR1 + theme_bw()
pMMR1 <- pMMR1 + scale_fill_manual(values=c("#bfbfbf","#ff0000","#00b050","#6666ff","000000"))
pMMR1 <- pMMR1 + scale_x_continuous(breaks=c(1996,2007))
