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
dfAYE  <- mDATA %>% filter(Region %in% "Ayeyarwady")
dfAYE1 <- dfAYE %>% filter((TimeInterval %in% "1") & Change != "Gross Loss" & Change != "Undisturbed")
dfAYE2 <- dfAYE %>% filter((TimeInterval %in% "2") & Change != "Gross Loss" & Change != "Undisturbed")

# Define Polygons -------------------------
dfGL1 <- data.frame(x=c(1996,2007,2007), y=c(4149.8883, 4149.8883, 1669.0383))  # gross loss 1996-2007
dfGL2 <- data.frame(x=c(2007,2016,2016), y=c(2324.7666, 2324.7666, 1318.2435))  # gross loss 2007-2016
dfUN1 <- data.frame(x=c(1996,1996,2007,2007), y=c(0,1115.1100,1115.1100,0))     # undisturbed mangroves
dfUN2 <- data.frame(x=c(2007,2007,2016,2016), y=c(0,1115.1100,1115.1100,0))     # undisturbed mangroves

# Define Plots ----------------------------

# Left panel
pAYE1 <- ggplot() + geom_area(aes(x=TimePoint, y=AreaSqKm, fill=factor(Change,
                                  labels=c("Net Loss",
                                           "Gross Gain",
                                           "Persistence"))), 
                                  data=dfAYE1, alpha=0.6)
pAYE1 <- pAYE1 + geom_polygon(aes(x=x, y=y, colour="#ff0000"), fill=NA, data=dfGL1)
pAYE1 <- pAYE1 + geom_polygon(aes(x=x, y=y, colour="#000000"), fill=NA, data=dfUN1)
pAYE1 <- pAYE1 + scale_colour_manual(values=c("#000000","#ff0000"), labels=c("Undisturbed","Gross Loss"))
pAYE1 <- pAYE1 + scale_fill_manual(values=c("#ff0000","#00b050","#6666ff"))
pAYE1 <- pAYE1 + guides(colour=guide_legend(reverse=TRUE))
pAYE1 <- pAYE1 + labs(x="Interval 1", y="Area (sq.km)")
pAYE1 <- pAYE1 + scale_x_continuous(breaks=c(1996,2007))
pAYE1 <- pAYE1 + scale_y_continuous(limits=c(0,4500), breaks=c(0,1000,2000,3000,4000,4500))
pAYE1 <- pAYE1 + theme_light() + theme(legend.position="none")

# Right panel
pAYE2 <- ggplot() + geom_area(aes(x=TimePoint, y=AreaSqKm, fill=factor(Change,
                                  labels=c("Net Loss",
                                           "Gross Gain",
                                           "Persistence"))), 
                                  data=dfAYE2, alpha=0.6)
pAYE2 <- pAYE2 + geom_polygon(aes(x=x, y=y, colour="#ff0000"), fill=NA, data=dfGL2)
pAYE2 <- pAYE2 + geom_polygon(aes(x=x, y=y, colour="#000000"), fill=NA, data=dfUN2)
pAYE2 <- pAYE2 + scale_colour_manual(values=c("#000000","#ff0000"), labels=c("Undisturbed","Gross Loss"))
pAYE2 <- pAYE2 + scale_fill_manual(values=c("#ff0000","#00b050","#6666ff"))
pAYE2 <- pAYE2 + guides(colour=guide_legend(reverse=TRUE))
pAYE2 <- pAYE2 + labs(x="Interval 2", fill=element_blank(), colour="")
pAYE2 <- pAYE2 + scale_x_continuous(breaks=c(2007,2016))
pAYE2 <- pAYE2 + scale_y_continuous(limits=c(0,4500), breaks=c(0,1000,2000,3000,4000,4500), position="right")
pAYE2 <- pAYE2 + theme_light() + theme(axis.title.y=element_blank())

# Expose ggplot2 Layouts ------------------
plotlayout <- lapply(list(pAYE1, pAYE2), expose_layout, FALSE, FALSE)
grid.arrange(
  grobs = plotlayout,
  widths = c(1,1.4),
  layout_matrix = rbind(c(1,2))
)

# Generate Plots --------------------------
mergeplot <- ggarrange(pAYE1, pAYE2, ncol=2)

# Save Output Plots -----------------------
ggsave(mergeplot, file="StackedArea-GrossNet-Mangroves-01-Ayeyarwady.pdf", width=19.89, height=15, units="cm", dpi=300)

