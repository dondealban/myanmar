# Creator: J Johanness

# Date: 2018-08-28


# 1. Define path to folder

path <- "C:/MMR-LCC-EndAugust/02-QGIS-SCP-LCC"

# - - -
# 2. Create file list

files <- list.files(path=path, pattern = "*.csv")

# - - -

# 3. Load each file as an individual data frame, and remove the "_" and ".csv"

for(file in files)
{
  perpos <- which(strsplit(file, "")[[1]]==".")
  assign(
    gsub("_","",substr(file, 1, perpos-1)), #removes the underscore "_"
    read.delim(paste(path,file,sep="/")))
}

# 4. Write each dataframe into an individual Excel worksheet, and append them back to back

install.packages("openxlsx")

library(openxlsx)

require(openxlsx)

dataframe_list_1996_2007 <- list(
  "1996-2007-AYE" = MMR19962007AYE,
  "1996-2007-BAG" = MMR19962007BAG,
  "1996-2007-CHI" = MMR19962007CHI,
  "1996-2007-KAC" = MMR19962007KAC,
  "1996-2007-KYH" = MMR19962007KYH,
  "1996-2007-KYN" = MMR19962007KYN,
  "1996-2007-MAG" = MMR19962007MAG,
  "1996-2007-MAN" = MMR19962007MAN,
  "1996-2007-MON" = MMR19962007MON,
  "1996-2007-NAY" = MMR19962007NAY,
  "1996-2007-RAK" = MMR19962007RAK,
  "1996-2007-SAG" = MMR19962007SAG,
  "1996-2007-SHA" = MMR19962007SHA,
  "1996-2007-TNI" = MMR19962007TNI,
  "1996-2007-YGN" = MMR19962007YGN
)

write.xlsx(dataframe_list_1996_2007, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/LCCR-PER-REGION-1996-2007.xlsx")

dataframe_list_2007_2016 <- list(
  "2007-2016-AYE" = MMR20072016AYE,
  "2007-2016-BAG" = MMR20072016BAG,
  "2007-2016-CHI" = MMR20072016CHI,
  "2007-2016-KAC" = MMR20072016KAC,
  "2007-2016-KYH" = MMR20072016KYH,
  "2007-2016-KYN" = MMR20072016KYN,
  "2007-2016-MAG" = MMR20072016MAG,
  "2007-2016-MAN" = MMR20072016MAN,
  "2007-2016-MON" = MMR20072016MON,
  "2007-2016-NAY" = MMR20072016NAY,
  "2007-2016-RAK" = MMR20072016RAK,
  "2007-2016-SAG" = MMR20072016SAG,
  "2007-2016-SHA" = MMR20072016SHA,
  "2007-2016-TNI" = MMR20072016TNI,
  "2007-2016-YGN" = MMR20072016YGN
)

write.xlsx(dataframe_list_2007_2016, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/LCCR-PER-REGION-2007-2016.xlsx")
