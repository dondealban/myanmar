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
ps11 <- dfAYE$AreaSqKm[dfAYE$TimeInterval=="1" & dfAYE$TimePoint=="1996" & dfAYE$Change=="Persistence"]
ps12 <- dfAYE$AreaSqKm[dfAYE$TimeInterval=="1" & dfAYE$TimePoint=="2007" & dfAYE$Change=="Persistence"]
ps22 <- dfAYE$AreaSqKm[dfAYE$TimeInterval=="2" & dfAYE$TimePoint=="2007" & dfAYE$Change=="Persistence"]
ps23 <- dfAYE$AreaSqKm[dfAYE$TimeInterval=="2" & dfAYE$TimePoint=="2016" & dfAYE$Change=="Persistence"]
un   <- dfAYE$AreaSqKm[dfAYE$TimeInterval=="1" & dfAYE$TimePoint=="1996" & dfAYE$Change=="Undisturbed"]

# Define Polygon Nodes --------------------
dfGL1 <- data.frame(x=c(1996,2007,2007), y=c(ps11, ps11, ps12))  # gross loss 1996-2007
dfGL2 <- data.frame(x=c(2007,2016,2016), y=c(ps22, ps22, ps23))  # gross loss 2007-2016
dfUN1 <- data.frame(x=c(1996,1996,2007,2007), y=c(0, un, un, 0)) # undisturbed mangroves
dfUN2 <- data.frame(x=c(2007,2007,2016,2016), y=c(0, un, un, 0)) # undisturbed mangroves

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
plotMMR <- ggarrange(pMMR1, pMMR2, ncol=2)

# Save Output Plots -----------------------
ggsave(plotMMR, file="StackedArea-GrossNet-Mangroves-00-Myanmar.pdf", width=19.89, height=15, units="cm", dpi=300)

