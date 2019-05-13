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
library(egg)

# Read Input Data -------------------------
dfRAW <- read.csv(file="ForR_Data_Split-Stacked-Area-Plots.csv", header=TRUE, sep=",")

# Reorganise Data -------------------------
mDATA <- melt(dfRAW, id=c('TimeInterval','TimePoint','Change')) # requires reshape2 package
colnames(mDATA) <- c("TimeInterval","TimePoint","Change","Region","AreaSqKm")
mDATA$Change <- factor(mDATA$Change, levels=c("Gross Loss","Net Loss","Gross Gain","Persistence","Undisturbed"))

# Subset Data -----------------------------
# pipes require dplyr package
dfTNI  <- mDATA %>% filter(Region %in% "Tanintharyi")
dfTNI1 <- dfTNI %>% filter((TimeInterval %in% "1") & Change != "Gross Loss" & Change != "Undisturbed")
dfTNI2 <- dfTNI %>% filter((TimeInterval %in% "2") & Change != "Gross Loss" & Change != "Undisturbed")

# Define Polygons -------------------------
dfGL1 <- data.frame(x=c(1996,2007,2007), y=c(4253.0850, 4253.0850, 2879.3646))  # gross loss 1996-2007
dfGL2 <- data.frame(x=c(2007,2016,2016), y=c(3068.8749, 3068.8749, 2602.5507))  # gross loss 2007-2016
dfUN1 <- data.frame(x=c(1996,1996,2007,2007), y=c(0,2470.2400,2470.2400,0))     # undisturbed mangroves
dfUN2 <- data.frame(x=c(2007,2007,2016,2016), y=c(0,2470.2400,2470.2400,0))     # undisturbed mangroves

# Define Plots ----------------------------

# Left panel
pTNI1 <- ggplot() + geom_area(aes(x=TimePoint, y=AreaSqKm, fill=factor(Change,
                                  labels=c("Net Loss",
                                           "Gross Gain",
                                           "Persistence"))), 
                                  data=dfTNI1, alpha=0.6)
pTNI1 <- pTNI1 + geom_polygon(aes(x=x, y=y, colour="#ff0000"), fill=NA, data=dfGL1)
pTNI1 <- pTNI1 + geom_polygon(aes(x=x, y=y, colour="#000000"), fill=NA, data=dfUN1)
pTNI1 <- pTNI1 + scale_colour_manual(values=c("#000000","#ff0000"), labels=c("Undisturbed","Gross Loss"))
pTNI1 <- pTNI1 + scale_fill_manual(values=c("#ff0000","#00b050","#6666ff"))
pTNI1 <- pTNI1 + guides(colour=guide_legend(reverse=TRUE))
pTNI1 <- pTNI1 + labs(x="Interval 1", y="Area (sq.km)")
pTNI1 <- pTNI1 + scale_x_continuous(breaks=c(1996,2007))
pTNI1 <- pTNI1 + scale_y_continuous(limits=c(0,4500), breaks=c(0,1000,2000,3000,4000,4500))
pTNI1 <- pTNI1 + theme_light() + theme(legend.position="none")

# Right panel
pTNI2 <- ggplot() + geom_area(aes(x=TimePoint, y=AreaSqKm, fill=factor(Change,
                                  labels=c("Net Loss",
                                           "Gross Gain",
                                           "Persistence"))), 
                                  data=dfTNI2, alpha=0.6)
pTNI2 <- pTNI2 + geom_polygon(aes(x=x, y=y, colour="#ff0000"), fill=NA, data=dfGL2)
pTNI2 <- pTNI2 + geom_polygon(aes(x=x, y=y, colour="#000000"), fill=NA, data=dfUN2)
pTNI2 <- pTNI2 + scale_colour_manual(values=c("#000000","#ff0000"), labels=c("Undisturbed","Gross Loss"))
pTNI2 <- pTNI2 + scale_fill_manual(values=c("#ff0000","#00b050","#6666ff"))
pTNI2 <- pTNI2 + guides(colour=guide_legend(reverse=TRUE))
pTNI2 <- pTNI2 + labs(x="Interval 2", fill=element_blank(), colour="")
pTNI2 <- pTNI2 + scale_x_continuous(breaks=c(2007,2016))
pTNI2 <- pTNI2 + scale_y_continuous(limits=c(0,4500), breaks=c(0,1000,2000,3000,4000,4500), position="right")
pTNI2 <- pTNI2 + theme_light() + theme(axis.title.y=element_blank())

# Expose ggplot2 Layouts ------------------
plotlayout <- lapply(list(pTNI1, pTNI2), expose_layout, FALSE, FALSE)
grid.arrange(
  grobs = plotlayout,
  widths = c(1,1.4),
  layout_matrix = rbind(c(1,2))
)

# Generate Plots --------------------------
mergeplot <- ggarrange(pTNI1, pTNI2, ncol=2)

# Save Output Plots -----------------------
ggsave(mergeplot, file="StackedArea-GrossNet-Mangroves-05-Tanintharyi.pdf", width=19.89, height=15, units="cm", dpi=300)

