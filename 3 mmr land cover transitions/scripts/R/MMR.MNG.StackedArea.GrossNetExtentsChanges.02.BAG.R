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
dfBAG  <- mDATA %>% filter(Region %in% "Bago")
dfBAG1 <- dfBAG %>% filter((TimeInterval %in% "1") & Change != "Gross Loss" & Change != "Undisturbed")
dfBAG2 <- dfBAG %>% filter((TimeInterval %in% "2") & Change != "Gross Loss" & Change != "Undisturbed")

# Define Polygons -------------------------
dfGL1 <- data.frame(x=c(1996,2007,2007), y=c(267.7725, 267.7725, 34.2855))  # gross loss 1996-2007
dfGL2 <- data.frame(x=c(2007,2016,2016), y=c(152.4933, 152.4933, 13.9851))  # gross loss 2007-2016
dfUN1 <- data.frame(x=c(1996,1996,2007,2007), y=c(0,5.5660,5.5660,0))     # undisturbed mangroves
dfUN2 <- data.frame(x=c(2007,2007,2016,2016), y=c(0,5.5660,5.5660,0))     # undisturbed mangroves

# Define Plots ----------------------------

# Left panel
pBAG1 <- ggplot() + geom_area(aes(x=TimePoint, y=AreaSqKm, fill=factor(Change,
                                  labels=c("Net Loss",
                                           "Gross Gain",
                                           "Persistence"))), 
                                  data=dfBAG1, alpha=0.6)
pBAG1 <- pBAG1 + geom_polygon(aes(x=x, y=y, colour="#ff0000"), fill=NA, data=dfGL1)
pBAG1 <- pBAG1 + geom_polygon(aes(x=x, y=y, colour="#000000"), fill=NA, data=dfUN1)
pBAG1 <- pBAG1 + scale_colour_manual(values=c("#000000","#ff0000"), labels=c("Undisturbed","Gross Loss"))
pBAG1 <- pBAG1 + scale_fill_manual(values=c("#ff0000","#00b050","#6666ff"))
pBAG1 <- pBAG1 + guides(colour=guide_legend(reverse=TRUE))
pBAG1 <- pBAG1 + labs(x="Interval 1", y="Area (sq.km)")
pBAG1 <- pBAG1 + scale_x_continuous(breaks=c(1996,2007))
pBAG1 <- pBAG1 + scale_y_continuous(limits=c(0,300), breaks=c(0,100,200,300))
pBAG1 <- pBAG1 + theme_light() + theme(legend.position="none")

# Right panel
pBAG2 <- ggplot() + geom_area(aes(x=TimePoint, y=AreaSqKm, fill=factor(Change,
                                  labels=c("Net Loss",
                                           "Gross Gain",
                                           "Persistence"))), 
                                  data=dfBAG2, alpha=0.6)
pBAG2 <- pBAG2 + geom_polygon(aes(x=x, y=y, colour="#ff0000"), fill=NA, data=dfGL2)
pBAG2 <- pBAG2 + geom_polygon(aes(x=x, y=y, colour="#000000"), fill=NA, data=dfUN2)
pBAG2 <- pBAG2 + scale_colour_manual(values=c("#000000","#ff0000"), labels=c("Undisturbed","Gross Loss"))
pBAG2 <- pBAG2 + scale_fill_manual(values=c("#ff0000","#00b050","#6666ff"))
pBAG2 <- pBAG2 + guides(colour=guide_legend(reverse=TRUE))
pBAG2 <- pBAG2 + labs(x="Interval 2", fill=element_blank(), colour="")
pBAG2 <- pBAG2 + scale_x_continuous(breaks=c(2007,2016))
pBAG2 <- pBAG2 + scale_y_continuous(limits=c(0,300), breaks=c(0,100,200,300), position="right")
pBAG2 <- pBAG2 + theme_light() + theme(axis.title.y=element_blank())

# Expose ggplot2 Layouts ------------------
plotlayout <- lapply(list(pBAG1, pBAG2), expose_layout, FALSE, FALSE)
grid.arrange(
  grobs = plotlayout,
  widths = c(1,1.4),
  layout_matrix = rbind(c(1,2))
)

# Generate Plots --------------------------
mergeplot <- ggarrange(pBAG1, pBAG2, ncol=2)

# Save Output Plots -----------------------
ggsave(mergeplot, file="StackedArea-GrossNet-Mangroves-02-Bago.pdf", width=19.89, height=15, units="cm", dpi=300)

