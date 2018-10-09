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
# Creator: J Johanness
# Date: 2018-10-08

# Purpose: To create the Sankey Diagrams using the network D3 package.
install.packages("networkD3", "tidyverse")

library(networkD3)

setwd("C:/2018-10-08 Sankey")

# nodes <- read.csv("node-name.csv", header = TRUE, sep = ",")

links <- read.csv("source-target-value.csv", header = TRUE, sep = ",")

# nodes <- data.frame(name = unique(c(as.character(links$source), as.character(links$target))))
nodes <- data.frame(name=c(as.character(links$source), as.character(links$target)) %>% unique())

links$source <- match(links$source, nodes$name)-1 #to zero-index the Sankey, if not it cannot be generated
links$target <- match(links$target, nodes$name)-1

my_color <- 'd3.scaleOrdinal() .domain([
c(1:20)]).range([
"#ff0000",
"#246a24",
"#a6cee3",
"#6666ff",
"#ff8000",
"#a65400",
"#ff00ff",
"#ccff66",
"#66ccff",
"#ffff66"])'

sankeyNetwork(Links = links, Nodes = nodes, Source = "source", Target = "target", Value = "value", NodeID = "name", colourScale=my_color)

sankeyNetwork(Links = links, Nodes = nodes, Source = "source", 
              Target = "target", Value = "value", NodeID = "name",
              width = 400, height = 700, nodeWidth = 50, iterations =0,
              colourScale = d3.scaleOrdinal().range(["#ff0000",
                                                     "#246a24",
                                                     "#a6cee3",
                                                     "#6666ff",
                                                     "#ff8000",
                                                     "#a65400",
                                                     "#ff00ff",
                                                     "#ccff66",
                                                     "#66ccff",
                                                     "#ffff66",
                                                     "#ff0000",
                                                     "#246a24",
                                                     "#a6cee3",
                                                     "#6666ff",
                                                     "#ff8000",
                                                     "#a65400",
                                                     "#ff00ff",
                                                     "#ccff66",
                                                     "#66ccff",
                                                     "#ffff66"))


