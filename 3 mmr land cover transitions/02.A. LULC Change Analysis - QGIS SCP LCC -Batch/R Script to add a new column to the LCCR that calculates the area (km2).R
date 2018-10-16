setwd("C:/150918 all newest CSVs from QGIS SCP LCC batch/Added Area Col (km2) in R")

# These following .csv files were downloaded as separate sheets from Google Sheets, which allow for downloading each sheet as a .csv

# There is probably a way to extract multiple Sheets from an .xlsx using the "xlsx" package.

Int1LCCR <- read.csv(file = "05. Land Cover Change Reports (Google Sheets) - Interval 1.csv",
                              header = TRUE,
                              sep = ",")

Int2LCCR <- read.csv(file = "05. Land Cover Change Reports (Google Sheets) - Interval 2.csv",
                              header = TRUE,
                              sep = ",")
#head(Int1LCCR)

# Although we can merge them at this step already since the header names are the same for both dataframes, we will calculate the areas separately because I want to keep them as separate Sheets.

Int1LCCR ["Area (km2)"] <- Int1LCCR$PixelSum *30*30/1000/1000
Int2LCCR ["Area (km2)"] <- Int2LCCR$PixelSum *30*30/1000/1000
  
# Re-ordering the columns in a more meaningful way

Int1LCCR <- Int1LCCR[c(1,2,3,4,5,6,9,7,10,8)]
Int2LCCR <- Int2LCCR[c(1,2,3,4,5,6,9,7,10,8)]

# Saving these new outputs as .csv

write.csv(Int1LCCR, file = "C:/150918 all newest CSVs from QGIS SCP LCC batch/Added Area Col (km2) in R/Interval 1 LCCR Area calculated.csv")
write.csv(Int2LCCR, file = "C:/150918 all newest CSVs from QGIS SCP LCC batch/Added Area Col (km2) in R/Interval 2 LCCR Area calculated.csv")

# While the calculation was done in Rstudio, I had initial intentions of joining them as separate sheets in one Xlsx outside of Rstudio (i.e. through Excel)

# Apparently, this can be done using the "xlsx" package

install.packages("xlsx")

library(xlsx)

write.xlsx(Int1LCCR, file="Revised LCCR with Area(km2).xlsx", sheetName ="Interval 1")
write.xlsx(Int2LCCR, file="Revised LCCR with Area(km2).xlsx", sheetName ="Interval 2", append = TRUE)

RevisedLCCRwithArea_int1 <- read.xlsx(file = "Revised LCCR with Area(km2).xlsx", sheetIndex = 1)
RevisedLCCRwithArea_int2 <- read.xlsx(file = "Revised LCCR with Area(km2).xlsx", sheetIndex = 2)

# To read an .xlsx, you require the "xlsx" package, as well, in R, if you wish to load it as a dataframe, you need to include the sheetIndex, which specifies which sheet is read
# Even so, I am positive that there is a way to load multiple sheets at one go using this package.