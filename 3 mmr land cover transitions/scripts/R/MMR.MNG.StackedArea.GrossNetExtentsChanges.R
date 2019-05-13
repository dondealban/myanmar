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
mDATA <- melt(dfRAW, id=c('TimeInterval','TimePoint','Change')) # requires reshape2 package
colnames(mDATA) <- c("TimeInterval","TimePoint","Change","Region","AreaSqKm")
mDATA$Change <- factor(mDATA$Change, levels=c("Gross Loss","Net Loss","Gross Gain","Persistence","Undisturbed"))


# Subset Data -----------------------------
# pipes require dplyr package
dfMMR  <- mDATA %>% filter(Region %in% "Myanmar")
dfMMR1 <- dfMMR %>% filter((TimePoint %in% "1996" | TimePoint %in% "2007") & Change != "Gross Loss" & Change != "Undisturbed")
dfMMR2 <- dfMMR %>% filter((TimePoint %in% "2007" | TimePoint %in% "2016") & Change != "Gross Loss" & Change != "Undisturbed")

# Define Polygons -------------------------
dfGL1 <- data.frame(x=c(1996,2007,2007), y=c(12380.8662, 12380.8662, 6206.2371))  # gross loss 1996-2007
dfGL2 <- data.frame(x=c(2007,2007,2016), y=c( 6206.2371,  6206.2371, 2269.6542))  # gross loss 2007-2016
dfUND <- data.frame(x=c(1996,1996,2007,2007), y=c(0,4646.2970,4646.2970,0))       # undisturbed mangroves

dfAYE <- mDATA %>% filter(Region %in% "Ayeyarwady")
dfBAG <- mDATA %>% filter(Region %in% "Bago")
dfMON <- mDATA %>% filter(Region %in% "Mon")
dfRAK <- mDATA %>% filter(Region %in% "Rakhine")
dfTNI <- mDATA %>% filter(Region %in% "Tanintharyi")
dfYGN <- mDATA %>% filter(Region %in% "Yangon")

# Define Plots ----------------------------

# Plot: Myanmar
pMMR1 <- ggplot() + geom_area(aes(x=TimePoint, y=AreaSqKm, fill=factor(Change,
                                  labels=c("Net Loss",
                                           "Gross Gain",
                                           "Persistence"))), 
                                  data=dfMMR1, alpha=0.6)
pMMR1 <- pMMR1 + geom_polygon(aes(x=x, y=y, colour="#ff0000"), fill=NA, data=dfGL1)
pMMR1 <- pMMR1 + geom_polygon(aes(x=x, y=y, colour="#000000"), fill=NA, data=dfUND)

pMMR1 <- pMMR1 + scale_colour_manual(values=c("#000000","#ff0000"), labels=c("Undisturbed","Gross Loss"))
pMMR1 <- pMMR1 + scale_fill_manual(values=c("#ff0000","#00b050","#6666ff"))
pMMR1 <- pMMR1 + guides(colour=guide_legend(reverse=TRUE))
pMMR1 <- pMMR1 + labs(title="Myanmar", x="Year", y="Area (sq.km)", fill="", colour="")
pMMR1 <- pMMR1 + scale_x_continuous(breaks=c(1996,2007))
pMMR1 <- pMMR1 + theme_light()


pMMR2 <- ggplot() + geom_area(aes(x=TimePoint, y=AreaSqKm, fill=factor(Change,
                                  labels=c("Net Loss",
                                           "Gross Gain",
                                           "Persistence"))), 
                              data=dfMMR2, alpha=0.6)
pMMR2 <- pMMR2 + geom_polygon(aes(x=x, y=y, colour="#ff0000"), fill=NA, data=dfGL2)
pMMR2 <- pMMR2 + geom_polygon(aes(x=x, y=y, colour="#000000"), fill=NA, data=dfUND)

pMMR2 <- pMMR2 + scale_colour_manual(values=c("#000000","#ff0000"), labels=c("Undisturbed","Gross Loss"))
pMMR2 <- pMMR2 + scale_fill_manual(values=c("#ff0000","#00b050","#6666ff"))
pMMR2 <- pMMR2 + guides(colour=guide_legend(reverse=TRUE))
pMMR2 <- pMMR2 + labs(fill="", colour="")
pMMR2 <- pMMR2 + scale_x_continuous(breaks=c(2007,2016))
pMMR2 <- pMMR2 + theme_light()







pMMR1 <- pMMR1 + geom_polygon(aes(x=x, y=y, colour="#800000"), linetype=3, fill=NA, data=dfGL1)
#pMMR1 <- pMMR1 + scale_colour_manual(values=c("#800000"), name="", labels=c("Gross Loss"))
pMMR1 <- pMMR1 + geom_polygon(aes(x=x, y=y, colour="#000000"), linetype=1, fill=NA, data=dfUND)
#pMMR1 <- pMMR1 + scale_colour_manual(values=c("#000000"), name="", labels=c("Undisturbed"))


pMMR1 <- pMMR1 + labs(title="Myanmar", x="Year", y="Area (sq.km)", fill="")
#pMMR1 <- pMMR1 + guides(fill=guide_legend(ncol=1))
#pMMR1 <- pMMR1 + geom_polygon(aes(x=x, y=y), fill="#bfbfbf", linetype=3, data=dfGL1)
#pMMR1 <- pMMR1 + geom_polygon(aes(x=x, y=y, color="#ff0000"), fill=NA, data=dfGL1)
#pMMR1 <- pMMR1 + theme_bw()
pMMR1 <- pMMR1 + scale_fill_manual(values=c("#ff0000","#00b050","#6666ff"))
pMMR1 <- pMMR1 + scale_colour_manual(values=c("#000000","#800000"), labels=c("Undisturbed","Gross Loss"))
#pMMR1 <- pMMR1 + scale_colour_manual(values=c("#800000"), name="", labels=c("Gross Loss"))
pMMR1 <- pMMR1 + scale_x_continuous(breaks=c(1996,2007))

# Plot: Myanmar
#pMMR1 <- ggplot() + geom_area(aes(x=TimePoint, y=AreaSqKm, fill=factor(Change,
#                                                                       labels=c("Gross Loss",
#                                                                                "Net Loss",
#                                                                                "Gross Gain",
#                                                                                "Persistence",
#                                                                                "Undisturbed"))), 
#                              data=dfMMR1, alpha=0.6)
#pMMR1 <- pMMR1 + labs(title="Myanmar", x="Year", y="Area (sq.km)", fill="")
#pMMR1 <- pMMR1 + guides(fill=guide_legend(ncol=1))
#pMMR1 <- pMMR1 + theme_bw()
#pMMR1 <- pMMR1 + scale_fill_manual(values=c("#bfbfbf","#ff0000","#00b050","#6666ff","#000000"))
#pMMR1 <- pMMR1 + scale_x_continuous(breaks=c(1996,2007))
