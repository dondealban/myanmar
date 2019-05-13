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
dfMMR  <- mDATA %>% filter(Region %in% "Myanmar")
dfMMR1 <- dfMMR %>% filter((TimeInterval %in% "1") & Change != "Gross Loss" & Change != "Undisturbed")
dfMMR2 <- dfMMR %>% filter((TimeInterval %in% "2") & Change != "Gross Loss" & Change != "Undisturbed")

# Define Polygons -------------------------
dfGL1 <- data.frame(x=c(1996,2007,2007), y=c(12380.8662, 12380.8662, 6206.2371))  # gross loss 1996-2007
dfGL2 <- data.frame(x=c(2007,2016,2016), y=c( 7438.2768,  7438.2768, 5168.6226))  # gross loss 2007-2016
dfUN1 <- data.frame(x=c(1996,1996,2007,2007), y=c(0,4646.2970,4646.2970,0))       # undisturbed mangroves
dfUN2 <- data.frame(x=c(2007,2007,2016,2016), y=c(0,4646.2970,4646.2970,0))       # undisturbed mangroves

# Define Plots ----------------------------

# Left panel
pMMR1 <- ggplot() + geom_area(aes(x=TimePoint, y=AreaSqKm, fill=factor(Change,
                                  labels=c("Net Loss",
                                           "Gross Gain",
                                           "Persistence"))), 
                                  data=dfMMR1, alpha=0.6)
pMMR1 <- pMMR1 + geom_polygon(aes(x=x, y=y, colour="#ff0000"), fill=NA, data=dfGL1)
pMMR1 <- pMMR1 + geom_polygon(aes(x=x, y=y, colour="#000000"), fill=NA, data=dfUN1)
pMMR1 <- pMMR1 + scale_colour_manual(values=c("#000000","#ff0000"), labels=c("Undisturbed","Gross Loss"))
pMMR1 <- pMMR1 + scale_fill_manual(values=c("#ff0000","#00b050","#6666ff"))
pMMR1 <- pMMR1 + guides(colour=guide_legend(reverse=TRUE))
pMMR1 <- pMMR1 + labs(x="Interval 1", y="Area (sq.km)")
pMMR1 <- pMMR1 + scale_x_continuous(breaks=c(1996,2007))
pMMR1 <- pMMR1 + scale_y_continuous(limits=c(0,12700), breaks=c(0,2500,5000,7500,10000,12500))
pMMR1 <- pMMR1 + theme_light() + theme(legend.position="none")

# Right panel
pMMR2 <- ggplot() + geom_area(aes(x=TimePoint, y=AreaSqKm, fill=factor(Change,
                                  labels=c("Net Loss",
                                           "Gross Gain",
                                           "Persistence"))), 
                              data=dfMMR2, alpha=0.6)
pMMR2 <- pMMR2 + geom_polygon(aes(x=x, y=y, colour="#ff0000"), fill=NA, data=dfGL2)
pMMR2 <- pMMR2 + geom_polygon(aes(x=x, y=y, colour="#000000"), fill=NA, data=dfUN2)
pMMR2 <- pMMR2 + scale_colour_manual(values=c("#000000","#ff0000"), labels=c("Undisturbed","Gross Loss"))
pMMR2 <- pMMR2 + scale_fill_manual(values=c("#ff0000","#00b050","#6666ff"))
pMMR2 <- pMMR2 + guides(colour=guide_legend(reverse=TRUE))
pMMR2 <- pMMR2 + labs(x="Interval 2", fill=element_blank(), colour="")
pMMR2 <- pMMR2 + scale_x_continuous(breaks=c(2007,2016))
pMMR2 <- pMMR2 + scale_y_continuous(limits=c(0,12700), breaks=c(0,2500,5000,7500,10000,12500), position="right")
pMMR2 <- pMMR2 + theme_light() + theme(axis.title.y=element_blank())

# Expose ggplot2 Layouts ------------------
plotlayout <- lapply(list(pMMR1, pMMR2), expose_layout, FALSE, FALSE)
grid.arrange(
  grobs = plotlayout,
  widths = c(1,1.4),
  layout_matrix = rbind(c(1,2))
)

# Generate Plots --------------------------
mergeplot <- ggarrange(pMMR1, pMMR2, ncol=2)

# Save Output Plots -----------------------
ggsave(mergeplot, file="StackedArea-GrossNet-Mangroves-00-Myanmar.pdf", width=19.89, height=15, units="cm", dpi=300)

