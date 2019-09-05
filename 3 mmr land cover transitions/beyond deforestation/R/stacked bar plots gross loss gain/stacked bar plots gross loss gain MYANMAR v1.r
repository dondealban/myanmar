
library(reshape2)

library(ggplot2)

loss.gain.int.1.percent <- read.table(text = "Category	Interval	Region	Percent	LossGain
                                      01-BRG	1996-2007	MYANMAR	0.29003374	1-Loss
                                      02-BUA	1996-2007	MYANMAR	0.058883074	1-Loss
                                      03-FOR	1996-2007	MYANMAR	5.397581587	1-Loss
                                      04-MNG	1996-2007	MYANMAR	1.080808493	1-Loss
                                      05-OPM	1996-2007	MYANMAR	0.051152391	1-Loss
                                      06-RPD	1996-2007	MYANMAR	3.646319277	1-Loss
                                      07-RBR	1996-2007	MYANMAR	0.210730632	1-Loss
                                      08-SHB	1996-2007	MYANMAR	5.602944066	1-Loss
                                      09-WTR	1996-2007	MYANMAR	0.314276356	1-Loss
                                      01-BRG	1996-2007	MYANMAR	1.267421369	2-Gain
                                      02-BUA	1996-2007	MYANMAR	0.34343038	2-Gain
                                      03-FOR	1996-2007	MYANMAR	4.239608306	2-Gain
                                      04-MNG	1996-2007	MYANMAR	0.329837878	2-Gain
                                      05-OPM	1996-2007	MYANMAR	0.713229746	2-Gain
                                      06-RPD	1996-2007	MYANMAR	2.818126144	2-Gain
                                      07-RBR	1996-2007	MYANMAR	0.436585241	2-Gain
                                      08-SHB	1996-2007	MYANMAR	6.116084567	2-Gain
                                      09-WTR	1996-2007	MYANMAR	0.388405984	2-Gain
                                      ", header = TRUE)

loss.gain.int.2.percent <- read.table(text = "Category	Interval	Region	Percent	LossGain
01-BRG	2007-2016	MYANMAR	1.154159964	1-Loss
02-BUA	2007-2016	MYANMAR	0.31650342	1-Loss
03-FOR	2007-2016	MYANMAR	4.992293658	1-Loss
04-MNG	2007-2016	MYANMAR	0.580514827	1-Loss
05-OPM	2007-2016	MYANMAR	0.408604091	1-Loss
06-RPD	2007-2016	MYANMAR	2.276393889	1-Loss
07-RBR	2007-2016	MYANMAR	0.238932233	1-Loss
08-SHB	2007-2016	MYANMAR	5.138380493	1-Loss
09-WTR	2007-2016	MYANMAR	0.209984966	1-Loss
01-BRG	2007-2016	MYANMAR	0.367120928	2-Gain
02-BUA	2007-2016	MYANMAR	0.088790954	2-Gain
03-FOR	2007-2016	MYANMAR	2.798573815	2-Gain
04-MNG	2007-2016	MYANMAR	0.145482945	2-Gain
05-OPM	2007-2016	MYANMAR	0.647085488	2-Gain
06-RPD	2007-2016	MYANMAR	4.60905095	2-Gain
07-RBR	2007-2016	MYANMAR	0.793409154	2-Gain
08-SHB	2007-2016	MYANMAR	5.298425145	2-Gain
09-WTR	2007-2016	MYANMAR	0.567828161	2-Gain

                                                                            ", header = TRUE)

loss.gain.int.1.area <- read.table(text = "Category	Interval	Region	Areapix	Areakm2	LossGain
01-BRG	1996-2007	MYANMAR	2160279	1944.2511	1-Loss
02-BUA	1996-2007	MYANMAR	438583	394.7247	1-Loss
03-FOR	1996-2007	MYANMAR	40203192	36182.8728	1-Loss
04-MNG	1996-2007	MYANMAR	8050263	7245.2367	1-Loss
05-OPM	1996-2007	MYANMAR	381002	342.9018	1-Loss
06-RPD	1996-2007	MYANMAR	27159140	24443.226	1-Loss
07-RBR	1996-2007	MYANMAR	1569600	1412.64	1-Loss
08-SHB	1996-2007	MYANMAR	41732808	37559.5272	1-Loss
09-WTR	1996-2007	MYANMAR	2340847	2106.7623	1-Loss
01-BRG	1996-2007	MYANMAR	9440225	8496.2025	2-Gain
02-BUA	1996-2007	MYANMAR	2557997	2302.1973	2-Gain
03-FOR	1996-2007	MYANMAR	31578177	28420.3593	2-Gain
04-MNG	1996-2007	MYANMAR	2456755	2211.0795	2-Gain
05-OPM	1996-2007	MYANMAR	5312400	4781.16	2-Gain
06-RPD	1996-2007	MYANMAR	20990450	18891.405	2-Gain
07-RBR	1996-2007	MYANMAR	3251849	2926.6641	2-Gain
08-SHB	1996-2007	MYANMAR	45554869	40999.3821	2-Gain
09-WTR	1996-2007	MYANMAR	2892992	2603.6928	2-Gain

                                   ", header = TRUE)

loss.gain.int.2.area <- read.table(text = "Category	Interval	Region	Areapix	Areakm2	LossGain
                                   01-BRG	2007-2016	MYANMAR	8596612	7736.9508	1-Loss
                                   02-BUA	2007-2016	MYANMAR	2357435	2121.6915	1-Loss
                                   03-FOR	2007-2016	MYANMAR	37184457	33466.0113	1-Loss
                                   04-MNG	2007-2016	MYANMAR	4323890	3891.501	1-Loss
                                   05-OPM	2007-2016	MYANMAR	3043435	2739.0915	1-Loss
                                   06-RPD	2007-2016	MYANMAR	16955427	15259.8843	1-Loss
                                   07-RBR	2007-2016	MYANMAR	1779656	1601.6904	1-Loss
                                   08-SHB	2007-2016	MYANMAR	38272566	34445.3094	1-Loss
                                   09-WTR	2007-2016	MYANMAR	1564046	1407.6414	1-Loss
                                   01-BRG	2007-2016	MYANMAR	2734453	2461.0077	2-Gain
                                   02-BUA	2007-2016	MYANMAR	661348	595.2132	2-Gain
                                   03-FOR	2007-2016	MYANMAR	20844817	18760.3353	2-Gain
                                   04-MNG	2007-2016	MYANMAR	1083611	975.2499	2-Gain
                                   05-OPM	2007-2016	MYANMAR	4819733	4337.7597	2-Gain
                                   06-RPD	2007-2016	MYANMAR	34329923	30896.9307	2-Gain
                                   07-RBR	2007-2016	MYANMAR	5909606	5318.6454	2-Gain
                                   08-SHB	2007-2016	MYANMAR	39464638	35518.1742	2-Gain
                                   09-WTR	2007-2016	MYANMAR	4229395	3806.4555	2-Gain

                                   ", header = TRUE)

#ggplot(tips2, aes(x = reorder(day, -perc), y = perc)) + geom_bar(stat = "identity")
# x=reorder(Region,-Percent
plot.loss.gain.int.1.percent  <- ggplot(loss.gain.int.1.percent, aes(x=LossGain,y=Percent, fill=Category)) + geom_bar(stat="identity")
plot.loss.gain.int.2.percent  <- ggplot(loss.gain.int.2.percent, aes(x=LossGain,y=Percent, fill=Category)) + geom_bar(stat="identity")
plot.loss.gain.int.1.area     <- ggplot(loss.gain.int.1.area, aes(x=LossGain,y=Areakm2, fill=Category)) + geom_bar(stat="identity")
plot.loss.gain.int.2.area     <- ggplot(loss.gain.int.2.area, aes(x=LossGain,y=Areakm2, fill=Category)) + geom_bar(stat="identity")

plot.loss.gain.int.1.percent   <- plot.loss.gain.int.1.percent + scale_y_continuous(breaks = seq(0,25,5))
plot.loss.gain.int.2.percent   <- plot.loss.gain.int.2.percent + scale_y_continuous(breaks = seq(0,25,5))

plot.loss.gain.int.1.percent  <- plot.loss.gain.int.1.percent + coord_cartesian(ylim = c(0,25))
plot.loss.gain.int.1.percent  <- plot.loss.gain.int.1.percent + expand_limits(x=0,y=0)

plot.loss.gain.int.2.percent  <- plot.loss.gain.int.2.percent + coord_cartesian(ylim = c(0,25))
plot.loss.gain.int.2.percent  <- plot.loss.gain.int.2.percent + expand_limits(x=0,y=0)

plot.loss.gain.int.1.area   <- plot.loss.gain.int.1.area + scale_y_continuous(breaks = seq(0,125000,25000))
plot.loss.gain.int.2.area   <- plot.loss.gain.int.2.area + scale_y_continuous(breaks = seq(0,125000,25000))

plot.loss.gain.int.1.area  <- plot.loss.gain.int.1.area + coord_cartesian(ylim = c(0,125000))
plot.loss.gain.int.1.area  <- plot.loss.gain.int.1.area + expand_limits(x=0,y=0)
1
plot.loss.gain.int.2.area  <- plot.loss.gain.int.2.area + coord_cartesian(ylim = c(0,125000))
plot.loss.gain.int.2.area  <- plot.loss.gain.int.2.area + expand_limits(x=0,y=0)

# the -Percent argument for the Y-axis is what reorders the barplots in descending order of the Y-var

# [Original Code, before rank ordering them in descending order]

# plot.loss.gain.int.1.percent  <- ggplot() + geom_bar(data=loss.gain.int.1.percent, aes(x=Region, y=Percent, fill=Category), stat="identity")
# plot.loss.gain.int.2.percent  <- ggplot() + geom_bar(data=loss.gain.int.2.percent, aes(x=Region, y=Percent, fill=Category), stat="identity")
# plot.loss.gain.int.1.area     <- ggplot() + geom_bar(data=loss.gain.int.1.area, aes(x=Region, y=Areakm2, fill=Category), stat="identity")
# plot.loss.gain.int.2.area     <- ggplot() + geom_bar(data=loss.gain.int.2.area, aes(x=Region, y=Areakm2, fill=Category), stat="identity")

# plot.loss.gain.int.1.percent  <- plot.loss.gain.int.1.percent + facet_wrap(~LossGain)
# plot.loss.gain.int.2.percent  <- plot.loss.gain.int.2.percent + facet_wrap(~LossGain)
# plot.loss.gain.int.1.area     <- plot.loss.gain.int.1.area + facet_wrap(~LossGain)
# plot.loss.gain.int.2.area     <- plot.loss.gain.int.2.area + facet_wrap(~LossGain)

plot.loss.gain.int.1.percent  <- plot.loss.gain.int.1.percent + labs(x=" ", y="Change (% of landscape)", fill="Category")
plot.loss.gain.int.2.percent  <- plot.loss.gain.int.2.percent + labs(x=" ", y="Change (% of landscape)", fill="Category")
plot.loss.gain.int.1.area     <- plot.loss.gain.int.1.area + labs(x=" ", y="Change (in km2)", fill="Category")
plot.loss.gain.int.2.area     <- plot.loss.gain.int.2.area + labs(x=" ", y="Change (in km2)", fill="Category")


plot.loss.gain.int.1.percent  <- plot.loss.gain.int.1.percent + scale_fill_manual(values=c("#ffff66","#ff0000","#246a24","#6666ff","#ff8000","#a65400","#ff00ff","#ccff66","#66ccff"))
plot.loss.gain.int.2.percent  <- plot.loss.gain.int.2.percent + scale_fill_manual(values=c("#ffff66","#ff0000","#246a24","#6666ff","#ff8000","#a65400","#ff00ff","#ccff66","#66ccff"))
plot.loss.gain.int.1.area     <- plot.loss.gain.int.1.area + scale_fill_manual(values=c("#ffff66","#ff0000","#246a24","#6666ff","#ff8000","#a65400","#ff00ff","#ccff66","#66ccff"))
plot.loss.gain.int.2.area     <- plot.loss.gain.int.2.area + scale_fill_manual(values=c("#ffff66","#ff0000","#246a24","#6666ff","#ff8000","#a65400","#ff00ff","#ccff66","#66ccff"))

plot.loss.gain.int.1.percent  <- plot.loss.gain.int.1.percent + theme_light()
plot.loss.gain.int.2.percent  <- plot.loss.gain.int.2.percent + theme_light()
plot.loss.gain.int.1.area     <- plot.loss.gain.int.1.area + theme_light()
plot.loss.gain.int.2.area     <- plot.loss.gain.int.2.area + theme_light()



# p + coord_cartesian(xlim = c(5, 20), ylim = (0, 50))
# p + expand_limits(x = 0, y = 0)
#plot <- plot  + theme(legend.title=element_blank(), legend.position="bottom", legend.box="horizontal")
#
ggsave(plot.loss.gain.int.1.percent, file="C:/MMR-LCC-EndAugust/03-CROSSTAB/Loss-Gain-Percentage-1997-2007-MYANMAR.pdf", width=30, height=15, units="cm", dpi=300)
ggsave(plot.loss.gain.int.2.percent, file="C:/MMR-LCC-EndAugust/03-CROSSTAB/Loss-Gain-Percentage-2007-2016-MYANMAR.pdf", width=30, height=15, units="cm", dpi=300)
ggsave(plot.loss.gain.int.1.area, file="C:/MMR-LCC-EndAugust/03-CROSSTAB/Loss-Gain-Area-1997-2007-MYANMAR.pdf", width=30, height=15, units="cm", dpi=300)
ggsave(plot.loss.gain.int.2.area, file="C:/MMR-LCC-EndAugust/03-CROSSTAB/Loss-Gain-Area-2007-2016-MYANMAR.pdf", width=30, height=15, units="cm", dpi=300)
