# Creator: J Johanness

# Date: 21-09-2018 - 23-09-2018

# Purpose: This is to experiment with creating and commiting an R script to test if
# its changes will be documented by GitHub, GitHub Desktop, and Atom
# and which of these can we manipulate the R Script directly (not R Markdown, unless they are interchangeably linked in some way)

# Firstly, this Script was done via Ctrl + Shift + N (New R Script), which I believe once I save, I will need to Commit and Push to the repo

# Script Example

# This test/experimentation for R Scripts for GitHub, will be done for the calculation of the proportions for each change from the QGIS SCP LCCR .csv's to generate a stacked area chart to see which transitions contributed the most to overall change in the landscape

#Note that if you try to open a .zip folder in R (through Git), it will open up WinRAR, unlike in Atom, where it opens up immediately

#So, of course, you can edit the code in Atom, but unlike in RStudio, you cannot "Run" the script

# My suggestion is: If you need to write a code and run it, just use RStudio, because the syntax is slightly different, and if you type an R-script in Atom, you may have to end up editing the script much more than if you just worked on RStudio from the start. But, yes, you can write an R script in Atom if you wish, especially if you are already extremely proficient in using RStudio.

# Start

# - - - - - - - - - - - - - - - - - - - - - - - - - - -

setwd("C:/150918 all newest CSVs from QGIS SCP LCC batch/4. QGIS SCP LCC_Change Maps and CSVs")

Myanmar_Interval_1 <- read.csv(file="0_Myanmar_1996_to_2007.csv", header = TRUE, sep = "\t")
names(Myanmar_Interval_1)
str(Myanmar_Interval_1)

Domain <- rep("1", nrow(Myanmar_Interval_1))
Myanmar_Interval_1 <- cbind(Myanmar_Interval_1, Domain)

Interval <- rep("1", nrow(Myanmar_Interval_1))
Myanmar_Interval_1 <- cbind(Myanmar_Interval_1, Interval)

head(Myanmar_Interval_1)

Myanmar_Interval_1 ["PercentOfTotalLandscapeChange"] <- prop.table(Myanmar_Interval_1$PixelSum) *100
head(Myanmar_Interval_1)

sum(Myanmar_Interval_1$PercentOfTotalLandscapeChange)
# The sum is 100%.

# END



