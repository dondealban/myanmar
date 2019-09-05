
# Creator: J Johanness
# Date: 2018-10-08

# Purpose: To create the Sankey Diagrams using the network D3 package.


# Code works, currently the sankey works for 1 interval, now to expand with the 2nd interval
# and then brute-force through for each district.

# install.packages("networkD3")

library(networkD3)

setwd("C:/MMR-Land-Change-Dynamics-paper/Work pre-May 2019/MMR-LandChangeDynamics-InitialWork-GDrive/2018-10-08 Sankey")

# nodes <- read.csv("node-name.csv", header = TRUE, sep = ",")

links <- read.csv("source-target-value-v2.csv", header = TRUE, sep = ",")

nodes <- data.frame(name = unique(c(as.character(links$source), as.character(links$target))))

links$source <- match(links$source, nodes$name)-1 #to zero-index the Sankey, if not it cannot be generated
links$target <- match(links$target, nodes$name)-1

sankeyNetwork(Links = links, Nodes = nodes, Source = "source",
              Target = "target", Value = "value", NodeID = "name",
              width = 500, height = 500, nodeWidth = 25, iterations = 0)

#              colourScale = "d3.scaleOrdinal().range([
#              "#ff0000","#246a24","#a6cee3","#6666ff","#ff8000","#a65400","#ff00ff","#ccff66","#66ccff","#ffff66",
#              "#ff0000","#246a24","#a6cee3","#6666ff","#ff8000","#a65400","#ff00ff","#ccff66","#66ccff","#ffff66"])")

# Since classes 1 to 10 share the same colours as classes 11 to 20.

# I can only seem to get it to work if the node names are numbers i.e. 1 to 20 here,
# where 1 to 10 are classes 1 to 10 for timepoint 1, and 11 to 20 are the classes 1 to 10 for timepoint 2
# the 3rd timepoint would thus be 21 to 30

# Note: If you want the sankey to be ordered in the way the data/csv/excel is prepared,
# then you MUST include "... ,iterations=0)"
# if not the order would be jumbled up weirdly


# This following pasted section is to assist in doing the colouring scheme

# which is supposedly done as an argument in the final line, colourScale = d3scale.Ordinal("Colour1", "Colour2", etc)
# but I did not get it to work (yet)

#plot <- ggplot() + geom_area(aes(x=Years, y=Percentage, fill=factor(Class,
#                                                                   labels=c("Built-up",
#                                                                           "Forest",
#                                                                          "Ice and Snow",
#                                                                         "Mangrove",
#                                                                        "Oil Palm Mature",
#                                                                       "Rice Paddy",
#                                                                      "Rubber Mature",
#                                                                     "Shrubland",
#                                                                    "Water",
#                                                                   "Bare Ground"))),
#                  data=data)
#plot <- plot + labs(title="Net Land Cover Transitions: Myanmar", x="Year", y="Percentage of Landscape", fill="Land Cover Category")
#plot <- plot + guides(fill=guide_legend(ncol=1))
#plot <- plot + theme(legend.position="bottom")
#plot <- plot + theme_bw()
#plot <- plot + scale_fill_manual(values=c("#ff0000",
#                                         "#246a24",
#                                        "#a6cee3",
#                                       "#6666ff",
#                                      "#ff8000",
#                                     "#a65400",
#                                    "#ff00ff",
#                                   "#ccff66",
#                                  "#66ccff",
#                                 "#ffff66"))
#
