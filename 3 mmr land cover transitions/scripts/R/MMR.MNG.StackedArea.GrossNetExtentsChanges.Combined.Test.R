# Script Description --------------------
# This R script generates split stacked area plots to visualise gross+net extents and
# changes of mangroves in each sub-national administrative unit of Myanmar and combine
# each region/state plot into a combined plot.
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


# Subset Data into Regions/States ---------
# pipes require dplyr package

# AYEYARWADY REGION
dfAYE  <- mDATA %>% filter(Region %in% "Ayeyarwady")
dfAYE1 <- dfAYE %>% filter((TimeInterval %in% "1") & Change != "Gross Loss" & Change != "Undisturbed")
dfAYE2 <- dfAYE %>% filter((TimeInterval %in% "2") & Change != "Gross Loss" & Change != "Undisturbed")
# BAGO REGION
dfBAG  <- mDATA %>% filter(Region %in% "Bago")
dfBAG1 <- dfBAG %>% filter((TimeInterval %in% "1") & Change != "Gross Loss" & Change != "Undisturbed")
dfBAG2 <- dfBAG %>% filter((TimeInterval %in% "2") & Change != "Gross Loss" & Change != "Undisturbed")
# MON STATE
dfMON  <- mDATA %>% filter(Region %in% "Mon")
dfMON1 <- dfMON %>% filter((TimeInterval %in% "1") & Change != "Gross Loss" & Change != "Undisturbed")
dfMON2 <- dfMON %>% filter((TimeInterval %in% "2") & Change != "Gross Loss" & Change != "Undisturbed")
# RAKHINE STATE
dfRAK  <- mDATA %>% filter(Region %in% "Rakhine")
dfRAK1 <- dfRAK %>% filter((TimeInterval %in% "1") & Change != "Gross Loss" & Change != "Undisturbed")
dfRAK2 <- dfRAK %>% filter((TimeInterval %in% "2") & Change != "Gross Loss" & Change != "Undisturbed")
# TANINTHARYI REGION
dfTNI  <- mDATA %>% filter(Region %in% "Tanintharyi")
dfTNI1 <- dfTNI %>% filter((TimeInterval %in% "1") & Change != "Gross Loss" & Change != "Undisturbed")
dfTNI2 <- dfTNI %>% filter((TimeInterval %in% "2") & Change != "Gross Loss" & Change != "Undisturbed")
# YANGON REGION
dfYGN  <- mDATA %>% filter(Region %in% "Yangon")
dfYGN1 <- dfYGN %>% filter((TimeInterval %in% "1") & Change != "Gross Loss" & Change != "Undisturbed")
dfYGN2 <- dfYGN %>% filter((TimeInterval %in% "2") & Change != "Gross Loss" & Change != "Undisturbed")


# Define Variables for Polygon Nodes ------
# notation: chXY: ch = change; X = time-interval; Y = time-point (1=1996,2=2007,3=2016)
# ps = persistence; un = undisturbed

# AYEYARWADY REGION
ps11AYE <- dfAYE$AreaSqKm[dfAYE$TimeInterval=="1" & dfAYE$TimePoint=="1996" & dfAYE$Change=="Persistence"]
ps12AYE <- dfAYE$AreaSqKm[dfAYE$TimeInterval=="1" & dfAYE$TimePoint=="2007" & dfAYE$Change=="Persistence"]
ps22AYE <- dfAYE$AreaSqKm[dfAYE$TimeInterval=="2" & dfAYE$TimePoint=="2007" & dfAYE$Change=="Persistence"]
ps23AYE <- dfAYE$AreaSqKm[dfAYE$TimeInterval=="2" & dfAYE$TimePoint=="2016" & dfAYE$Change=="Persistence"]
unAYE   <- dfAYE$AreaSqKm[dfAYE$TimeInterval=="1" & dfAYE$TimePoint=="1996" & dfAYE$Change=="Undisturbed"]
# BAGO REGION
ps11BAG <- dfBAG$AreaSqKm[dfBAG$TimeInterval=="1" & dfBAG$TimePoint=="1996" & dfBAG$Change=="Persistence"]
ps12BAG <- dfBAG$AreaSqKm[dfBAG$TimeInterval=="1" & dfBAG$TimePoint=="2007" & dfBAG$Change=="Persistence"]
ps22BAG <- dfBAG$AreaSqKm[dfBAG$TimeInterval=="2" & dfBAG$TimePoint=="2007" & dfBAG$Change=="Persistence"]
ps23BAG <- dfBAG$AreaSqKm[dfBAG$TimeInterval=="2" & dfBAG$TimePoint=="2016" & dfBAG$Change=="Persistence"]
unBAG   <- dfBAG$AreaSqKm[dfBAG$TimeInterval=="1" & dfBAG$TimePoint=="1996" & dfBAG$Change=="Undisturbed"]
# MON STATE
ps11MON <- dfMON$AreaSqKm[dfMON$TimeInterval=="1" & dfMON$TimePoint=="1996" & dfMON$Change=="Persistence"]
ps12MON <- dfMON$AreaSqKm[dfMON$TimeInterval=="1" & dfMON$TimePoint=="2007" & dfMON$Change=="Persistence"]
ps22MON <- dfMON$AreaSqKm[dfMON$TimeInterval=="2" & dfMON$TimePoint=="2007" & dfMON$Change=="Persistence"]
ps23MON <- dfMON$AreaSqKm[dfMON$TimeInterval=="2" & dfMON$TimePoint=="2016" & dfMON$Change=="Persistence"]
unMON   <- dfMON$AreaSqKm[dfMON$TimeInterval=="1" & dfMON$TimePoint=="1996" & dfMON$Change=="Undisturbed"]
# RAKHINE STATE
ps11RAK <- dfRAK$AreaSqKm[dfRAK$TimeInterval=="1" & dfRAK$TimePoint=="1996" & dfRAK$Change=="Persistence"]
ps12RAK <- dfRAK$AreaSqKm[dfRAK$TimeInterval=="1" & dfRAK$TimePoint=="2007" & dfRAK$Change=="Persistence"]
ps22RAK <- dfRAK$AreaSqKm[dfRAK$TimeInterval=="2" & dfRAK$TimePoint=="2007" & dfRAK$Change=="Persistence"]
ps23RAK <- dfRAK$AreaSqKm[dfRAK$TimeInterval=="2" & dfRAK$TimePoint=="2016" & dfRAK$Change=="Persistence"]
unRAK   <- dfRAK$AreaSqKm[dfRAK$TimeInterval=="1" & dfRAK$TimePoint=="1996" & dfRAK$Change=="Undisturbed"]
# TANINTHARYI REGION
ps11TNI <- dfTNI$AreaSqKm[dfTNI$TimeInterval=="1" & dfTNI$TimePoint=="1996" & dfTNI$Change=="Persistence"]
ps12TNI <- dfTNI$AreaSqKm[dfTNI$TimeInterval=="1" & dfTNI$TimePoint=="2007" & dfTNI$Change=="Persistence"]
ps22TNI <- dfTNI$AreaSqKm[dfTNI$TimeInterval=="2" & dfTNI$TimePoint=="2007" & dfTNI$Change=="Persistence"]
ps23TNI <- dfTNI$AreaSqKm[dfTNI$TimeInterval=="2" & dfTNI$TimePoint=="2016" & dfTNI$Change=="Persistence"]
unTNI   <- dfTNI$AreaSqKm[dfTNI$TimeInterval=="1" & dfTNI$TimePoint=="1996" & dfTNI$Change=="Undisturbed"]
# YANGON REGION
ps11YGN <- dfYGN$AreaSqKm[dfYGN$TimeInterval=="1" & dfYGN$TimePoint=="1996" & dfYGN$Change=="Persistence"]
ps12YGN <- dfYGN$AreaSqKm[dfYGN$TimeInterval=="1" & dfYGN$TimePoint=="2007" & dfYGN$Change=="Persistence"]
ps22YGN <- dfYGN$AreaSqKm[dfYGN$TimeInterval=="2" & dfYGN$TimePoint=="2007" & dfYGN$Change=="Persistence"]
ps23YGN <- dfYGN$AreaSqKm[dfYGN$TimeInterval=="2" & dfYGN$TimePoint=="2016" & dfYGN$Change=="Persistence"]
unYGN   <- dfYGN$AreaSqKm[dfYGN$TimeInterval=="1" & dfYGN$TimePoint=="1996" & dfYGN$Change=="Undisturbed"]


# Define Polygon Nodes --------------------

# AYEYARWADY REGION
dfGL1AYE <- data.frame(x=c(1996,2007,2007), y=c(ps11AYE, ps11AYE, ps12AYE))  # gross loss 1996-2007
dfGL2AYE <- data.frame(x=c(2007,2016,2016), y=c(ps22AYE, ps22AYE, ps23AYE))  # gross loss 2007-2016
dfUN1AYE <- data.frame(x=c(1996,1996,2007,2007), y=c(0, unAYE, unAYE, 0)) # undisturbed mangroves
dfUN2AYE <- data.frame(x=c(2007,2007,2016,2016), y=c(0, unAYE, unAYE, 0)) # undisturbed mangroves
# BAGO REGION
dfGL1BAG <- data.frame(x=c(1996,2007,2007), y=c(ps11BAG, ps11BAG, ps12BAG))  # gross loss 1996-2007
dfGL2BAG <- data.frame(x=c(2007,2016,2016), y=c(ps22BAG, ps22BAG, ps23BAG))  # gross loss 2007-2016
dfUN1BAG <- data.frame(x=c(1996,1996,2007,2007), y=c(0, unBAG, unBAG, 0)) # undisturbed mangroves
dfUN2BAG <- data.frame(x=c(2007,2007,2016,2016), y=c(0, unBAG, unBAG, 0)) # undisturbed mangroves
# MON STATE
dfGL1MON <- data.frame(x=c(1996,2007,2007), y=c(ps11MON, ps11MON, ps12MON))  # gross loss 1996-2007
dfGL2MON <- data.frame(x=c(2007,2016,2016), y=c(ps22MON, ps22MON, ps23MON))  # gross loss 2007-2016
dfUN1MON <- data.frame(x=c(1996,1996,2007,2007), y=c(0, unMON, unMON, 0)) # undisturbed mangroves
dfUN2MON <- data.frame(x=c(2007,2007,2016,2016), y=c(0, unMON, unMON, 0)) # undisturbed mangroves
# RAKHINE STATE
dfGL1RAK <- data.frame(x=c(1996,2007,2007), y=c(ps11RAK, ps11RAK, ps12RAK))  # gross loss 1996-2007
dfGL2RAK <- data.frame(x=c(2007,2016,2016), y=c(ps22RAK, ps22RAK, ps23RAK))  # gross loss 2007-2016
dfUN1RAK <- data.frame(x=c(1996,1996,2007,2007), y=c(0, unRAK, unRAK, 0)) # undisturbed mangroves
dfUN2RAK <- data.frame(x=c(2007,2007,2016,2016), y=c(0, unRAK, unRAK, 0)) # undisturbed mangroves
# TANINTHARYI REGION
dfGL1TNI <- data.frame(x=c(1996,2007,2007), y=c(ps11TNI, ps11TNI, ps12TNI))  # gross loss 1996-2007
dfGL2TNI <- data.frame(x=c(2007,2016,2016), y=c(ps22TNI, ps22TNI, ps23TNI))  # gross loss 2007-2016
dfUN1TNI <- data.frame(x=c(1996,1996,2007,2007), y=c(0, unTNI, unTNI, 0)) # undisturbed mangroves
dfUN2TNI <- data.frame(x=c(2007,2007,2016,2016), y=c(0, unTNI, unTNI, 0)) # undisturbed mangroves
# YANGON REGION
dfGL1YGN <- data.frame(x=c(1996,2007,2007), y=c(ps11YGN, ps11YGN, ps12YGN))  # gross loss 1996-2007
dfGL2YGN <- data.frame(x=c(2007,2016,2016), y=c(ps22YGN, ps22YGN, ps23YGN))  # gross loss 2007-2016
dfUN1YGN <- data.frame(x=c(1996,1996,2007,2007), y=c(0, unYGN, unYGN, 0)) # undisturbed mangroves
dfUN2YGN <- data.frame(x=c(2007,2007,2016,2016), y=c(0, unYGN, unYGN, 0)) # undisturbed mangroves








# Define Plots ----------------------------

# EXTENSIVE MANGROVE REGIONS
# AYEYARWADY REGION
pAYE1 <- ggplot() + geom_area(aes(x=TimePoint, y=AreaSqKm, fill=factor(Change,
                                  labels=c("Net Loss","Gross Gain","Persistence"))), 
                              data=dfAYE1, alpha=0.6)
pAYE1 <- pAYE1 + geom_polygon(aes(x=x, y=y, colour="#ff0000"), fill=NA, data=dfGL1AYE)
pAYE1 <- pAYE1 + geom_polygon(aes(x=x, y=y, colour="#000000"), fill=NA, data=dfUN1AYE)
pAYE1 <- pAYE1 + scale_colour_manual(values=c("#000000","#ff0000"), labels=c("Undisturbed","Gross Loss"))
pAYE1 <- pAYE1 + scale_fill_manual(values=c("#ff0000","#00b050","#6666ff"))
pAYE1 <- pAYE1 + guides(colour=guide_legend(reverse=TRUE))
pAYE1 <- pAYE1 + labs(x="Interval 1", y="Area (sq.km)")
pAYE1 <- pAYE1 + scale_x_continuous(breaks=c(1996,2007))
pAYE1 <- pAYE1 + scale_y_continuous(limits=c(0,4500), breaks=c(0,1000,2000,3000,4000,4500))
pAYE1 <- pAYE1 + annotate("text", x=1996, y=4500, label="Ayeyarwady", hjust=0, vjust="bottom", size=4, fontface="bold")
pAYE1 <- pAYE1 + theme_light() + theme(legend.position="none")

pAYE2 <- ggplot() + geom_area(aes(x=TimePoint, y=AreaSqKm, fill=factor(Change,
                                  labels=c("Net Loss","Gross Gain","Persistence"))), 
                              data=dfAYE2, alpha=0.6)
pAYE2 <- pAYE2 + geom_polygon(aes(x=x, y=y, colour="#ff0000"), fill=NA, data=dfGL2AYE)
pAYE2 <- pAYE2 + geom_polygon(aes(x=x, y=y, colour="#000000"), fill=NA, data=dfUN2AYE)
pAYE2 <- pAYE2 + scale_colour_manual(values=c("#000000","#ff0000"), labels=c("Undisturbed","Gross Loss"))
pAYE2 <- pAYE2 + scale_fill_manual(values=c("#ff0000","#00b050","#6666ff"))
pAYE2 <- pAYE2 + guides(colour=guide_legend(reverse=TRUE))
pAYE2 <- pAYE2 + labs(x="Interval 2")
pAYE2 <- pAYE2 + scale_x_continuous(breaks=c(2007,2016))
pAYE2 <- pAYE2 + scale_y_continuous(limits=c(0,4500), breaks=c(0,1000,2000,3000,4000,4500))
pAYE2 <- pAYE2 + theme_light() + theme(axis.title.y=element_blank(), axis.text.y=element_blank(), legend.position="none")

# RAKHINE STATE
pRAK1 <- ggplot() + geom_area(aes(x=TimePoint, y=AreaSqKm, fill=factor(Change,
                                  labels=c("Net Loss","Gross Gain","Persistence"))), 
                              data=dfRAK1, alpha=0.6)
pRAK1 <- pRAK1 + geom_polygon(aes(x=x, y=y, colour="#ff0000"), fill=NA, data=dfGL1RAK)
pRAK1 <- pRAK1 + geom_polygon(aes(x=x, y=y, colour="#000000"), fill=NA, data=dfUN1RAK)
pRAK1 <- pRAK1 + scale_colour_manual(values=c("#000000","#ff0000"), labels=c("Undisturbed","Gross Loss"))
pRAK1 <- pRAK1 + scale_fill_manual(values=c("#ff0000","#00b050","#6666ff"))
pRAK1 <- pRAK1 + guides(colour=guide_legend(reverse=TRUE))
pRAK1 <- pRAK1 + labs(x="Interval 1", y="Area (sq.km)")
pRAK1 <- pRAK1 + scale_x_continuous(breaks=c(1996,2007))
pRAK1 <- pRAK1 + scale_y_continuous(limits=c(0,4500), breaks=c(0,1000,2000,3000,4000,4500))
pRAK1 <- pRAK1 + annotate("text", x=1996, y=4500, label="Rakhine", hjust=0, vjust="bottom", size=4, fontface="bold")
pRAK1 <- pRAK1 + theme_light() + theme(axis.title.y=element_blank(), axis.text.y=element_blank(), legend.position="none")

pRAK2 <- ggplot() + geom_area(aes(x=TimePoint, y=AreaSqKm, fill=factor(Change,
                                  labels=c("Net Loss","Gross Gain","Persistence"))), 
                              data=dfRAK2, alpha=0.6)
pRAK2 <- pRAK2 + geom_polygon(aes(x=x, y=y, colour="#ff0000"), fill=NA, data=dfGL2RAK)
pRAK2 <- pRAK2 + geom_polygon(aes(x=x, y=y, colour="#000000"), fill=NA, data=dfUN2RAK)
pRAK2 <- pRAK2 + scale_colour_manual(values=c("#000000","#ff0000"), labels=c("Undisturbed","Gross Loss"))
pRAK2 <- pRAK2 + scale_fill_manual(values=c("#ff0000","#00b050","#6666ff"))
pRAK2 <- pRAK2 + guides(colour=guide_legend(reverse=TRUE))
pRAK2 <- pRAK2 + labs(x="Interval 2")
pRAK2 <- pRAK2 + scale_x_continuous(breaks=c(2007,2016))
pRAK2 <- pRAK2 + scale_y_continuous(limits=c(0,4500), breaks=c(0,1000,2000,3000,4000,4500))
pRAK2 <- pRAK2 + theme_light() + theme(axis.title.y=element_blank(), axis.text.y=element_blank(), legend.position="none")

# TANINTHARYI REGION
pTNI1 <- ggplot() + geom_area(aes(x=TimePoint, y=AreaSqKm, fill=factor(Change,
                                  labels=c("Net Loss","Gross Gain","Persistence"))), 
                              data=dfTNI1, alpha=0.6)
pTNI1 <- pTNI1 + geom_polygon(aes(x=x, y=y, colour="#ff0000"), fill=NA, data=dfGL1TNI)
pTNI1 <- pTNI1 + geom_polygon(aes(x=x, y=y, colour="#000000"), fill=NA, data=dfUN1TNI)
pTNI1 <- pTNI1 + scale_colour_manual(values=c("#000000","#ff0000"), labels=c("Undisturbed","Gross Loss"))
pTNI1 <- pTNI1 + scale_fill_manual(values=c("#ff0000","#00b050","#6666ff"))
pTNI1 <- pTNI1 + guides(colour=guide_legend(reverse=TRUE))
pTNI1 <- pTNI1 + labs(x="Interval 1")
pTNI1 <- pTNI1 + scale_x_continuous(breaks=c(1996,2007))
pTNI1 <- pTNI1 + scale_y_continuous(limits=c(0,4500), breaks=c(0,1000,2000,3000,4000,4500))
pTNI1 <- pTNI1 + annotate("text", x=1996, y=4500, label="Tanintharyi", hjust=0, vjust="bottom", size=4, fontface="bold")
pTNI1 <- pTNI1 + theme_light() + theme(axis.title.y=element_blank(), axis.text.y=element_blank(), legend.position="none")

pTNI2 <- ggplot() + geom_area(aes(x=TimePoint, y=AreaSqKm, fill=factor(Change,
                                  labels=c("Net Loss","Gross Gain","Persistence"))), 
                              data=dfTNI2, alpha=0.6)
pTNI2 <- pTNI2 + geom_polygon(aes(x=x, y=y, colour="#ff0000"), fill=NA, data=dfGL2TNI)
pTNI2 <- pTNI2 + geom_polygon(aes(x=x, y=y, colour="#000000"), fill=NA, data=dfUN2TNI)
pTNI2 <- pTNI2 + scale_colour_manual(values=c("#000000","#ff0000"), labels=c("Undisturbed","Gross Loss"))
pTNI2 <- pTNI2 + scale_fill_manual(values=c("#ff0000","#00b050","#6666ff"))
pTNI2 <- pTNI2 + guides(colour=guide_legend(reverse=TRUE))
pTNI2 <- pTNI2 + labs(x="Interval 2", fill=element_blank(), colour="")
pTNI2 <- pTNI2 + scale_x_continuous(breaks=c(2007,2016))
pTNI2 <- pTNI2 + scale_y_continuous(limits=c(0,4500), breaks=c(0,1000,2000,3000,4000,4500))
pTNI2 <- pTNI2 + theme_light() + theme(axis.title.y=element_blank(), axis.text.y=element_blank())


# Expose ggplot2 Layouts ------------------
plotlayout <- lapply(list(pMMR1, pMMR2), expose_layout, FALSE, FALSE)
grid.arrange(
  grobs = plotlayout,
  widths = c(1,1.4),
  layout_matrix = rbind(c(1,2))
)

# Generate Plots --------------------------
plotAYE <- ggarrange(pAYE1, pAYE2, ncol=2)
plotRAK <- ggarrange(pRAK1, pRAK2, ncol=2)
plotTNI <- ggarrange(pTNI1, pTNI2, ncol=2)
mergeplot <- ggarrange(pAYE1, pAYE2, pRAK1, pRAK2, pTNI1, pTNI2, ncol=6)

# Save Output Plots -----------------------
ggsave(plotMMR, file="StackedArea-GrossNet-Mangroves-00-Myanmar.pdf", width=19.89, height=15, units="cm", dpi=300)

