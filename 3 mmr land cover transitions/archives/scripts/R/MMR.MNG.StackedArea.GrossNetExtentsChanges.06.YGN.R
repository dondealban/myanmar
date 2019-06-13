# Script Description --------------------
# This R script generates split stacked area plots to visualise gross+net extents and
# changes of mangroves in Myanmar and in each sub-national administrative unit.
#
# Script By:      Jose Don T De Alban
# Date Created:   10 May 2019
# Last Modified:  14 May 2019

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
dfYGN  <- mDATA %>% filter(Region %in% "Yangon")
dfYGN1 <- dfYGN %>% filter((TimeInterval %in% "1") & Change != "Gross Loss" & Change != "Undisturbed")
dfYGN2 <- dfYGN %>% filter((TimeInterval %in% "2") & Change != "Gross Loss" & Change != "Undisturbed")

# Define Variables for Polygon Nodes ------
# notation: chXY: ch = change; X = time-interval; Y = time-point (1=1996,2=2007,3=2016)
# ps = persistence; un = undisturbed
ps11 <- dfYGN$AreaSqKm[dfYGN$TimeInterval=="1" & dfYGN$TimePoint=="1996" & dfYGN$Change=="Persistence"]
ps12 <- dfYGN$AreaSqKm[dfYGN$TimeInterval=="1" & dfYGN$TimePoint=="2007" & dfYGN$Change=="Persistence"]
ps22 <- dfYGN$AreaSqKm[dfYGN$TimeInterval=="2" & dfYGN$TimePoint=="2007" & dfYGN$Change=="Persistence"]
ps23 <- dfYGN$AreaSqKm[dfYGN$TimeInterval=="2" & dfYGN$TimePoint=="2016" & dfYGN$Change=="Persistence"]
un   <- dfYGN$AreaSqKm[dfYGN$TimeInterval=="1" & dfYGN$TimePoint=="1996" & dfYGN$Change=="Undisturbed"]

# Define Polygon Nodes --------------------
dfGL1 <- data.frame(x=c(1996,2007,2007), y=c(ps11, ps11, ps12))  # gross loss 1996-2007
dfGL2 <- data.frame(x=c(2007,2016,2016), y=c(ps22, ps22, ps23))  # gross loss 2007-2016
dfUN1 <- data.frame(x=c(1996,1996,2007,2007), y=c(0, un, un, 0)) # undisturbed mangroves
dfUN2 <- data.frame(x=c(2007,2007,2016,2016), y=c(0, un, un, 0)) # undisturbed mangroves

# Define Plots ----------------------------

# Left panel
pYGN1 <- ggplot() + geom_area(aes(x=TimePoint, y=AreaSqKm, fill=factor(Change,
                                  labels=c("Net Loss",
                                           "Gross Gain",
                                           "Persistence"))), 
                                  data=dfYGN1, alpha=0.6)
pYGN1 <- pYGN1 + geom_polygon(aes(x=x, y=y, colour="#ff0000"), fill=NA, data=dfGL1)
pYGN1 <- pYGN1 + geom_polygon(aes(x=x, y=y, colour="#000000"), fill=NA, data=dfUN1)
pYGN1 <- pYGN1 + scale_colour_manual(values=c("#000000","#ff0000"), labels=c("Undisturbed","Gross Loss"))
pYGN1 <- pYGN1 + scale_fill_manual(values=c("#ff0000","#00b050","#6666ff"))
pYGN1 <- pYGN1 + guides(colour=guide_legend(reverse=TRUE))
pYGN1 <- pYGN1 + labs(x="Interval 1", y="Area (sq.km)")
pYGN1 <- pYGN1 + scale_x_continuous(breaks=c(1996,2007))
pYGN1 <- pYGN1 + scale_y_continuous(limits=c(0,250), breaks=c(0,100,200,250))
pYGN1 <- pYGN1 + theme_light() + theme(legend.position="none")

# Right panel
pYGN2 <- ggplot() + geom_area(aes(x=TimePoint, y=AreaSqKm, fill=factor(Change,
                                  labels=c("Net Loss",
                                           "Gross Gain",
                                           "Persistence"))), 
                                  data=dfYGN2, alpha=0.6)
pYGN2 <- pYGN2 + geom_polygon(aes(x=x, y=y, colour="#ff0000"), fill=NA, data=dfGL2)
pYGN2 <- pYGN2 + geom_polygon(aes(x=x, y=y, colour="#000000"), fill=NA, data=dfUN2)
pYGN2 <- pYGN2 + scale_colour_manual(values=c("#000000","#ff0000"), labels=c("Undisturbed","Gross Loss"))
pYGN2 <- pYGN2 + scale_fill_manual(values=c("#ff0000","#00b050","#6666ff"))
pYGN2 <- pYGN2 + guides(colour=guide_legend(reverse=TRUE))
pYGN2 <- pYGN2 + labs(x="Interval 2", fill=element_blank(), colour="")
pYGN2 <- pYGN2 + scale_x_continuous(breaks=c(2007,2016))
pYGN2 <- pYGN2 + scale_y_continuous(limits=c(0,250), breaks=c(0,100,200,250), position="right")
pYGN2 <- pYGN2 + theme_light() + theme(axis.title.y=element_blank())

# Expose ggplot2 Layouts ------------------
plotlayout <- lapply(list(pYGN1, pYGN2), expose_layout, FALSE, FALSE)
grid.arrange(
  grobs = plotlayout,
  widths = c(1,1.4),
  layout_matrix = rbind(c(1,2))
)

# Generate Plots --------------------------
mergeplot <- ggarrange(pYGN1, pYGN2, ncol=2)

# Save Output Plots -----------------------
ggsave(mergeplot, file="StackedArea-GrossNet-Mangroves-06-Yangon.pdf", width=19.89, height=15, units="cm", dpi=300)

