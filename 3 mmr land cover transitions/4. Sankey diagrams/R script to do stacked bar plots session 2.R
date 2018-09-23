# Creator: J Johanness
# Date: 23-09-2018

# Purpose: 

# To create a way of repeating the previous script to calculate column percentages on more than one file within the local repository


# START

# 1. Define path to folder

path <- "C:/150918 all newest CSVs from QGIS SCP LCC batch/4. QGIS SCP LCC_Change Maps and CSVs"

# 2. Create file list

files <- list.files(path=path, pattern = "*.csv")

# 3. Load each file as an individual data frame, and remove the "_" and ".csv"

for(file in files)
{
  perpos <- which(strsplit(file, "")[[1]]==".")
  assign(
    gsub("_","",substr(file, 1, perpos-1)), #removes the underscore "_"
    read.delim(paste(path,file,sep="/")))
}


# 4. Now to add the Domain and Interval Column (There must be a better way to do this, by inserting a column only if the file name has 1996_to_2007 etc)


# Preparing new Domain column for all Interval 1 files, where A refers to interval 1 (this is because it will overwrite each other if it is only 'Domain')

DomainA0  <- rep('0', nrow(`0Myanmar1996to2007`))
DomainA1  <- rep('1', nrow(`1Ayeyarwady1996to2007`))
DomainA2  <- rep('2', nrow(`2Bago1996to2007`))
DomainA3  <- rep('3', nrow(`3Chin1996to2007`))
DomainA4  <- rep('4', nrow(`4Kachin1996to2007`))
DomainA5  <- rep('5', nrow(`5Kayah1996to2007`))
DomainA6  <- rep('6', nrow(`6Kayin1996to2007`))
DomainA7  <- rep('7', nrow(`7Magway1996to2007`))
DomainA8  <- rep('8', nrow(`8Mandalay1996to2007`))
DomainA9  <- rep('9', nrow(`9Mon1996to2007`))
DomainA10 <- rep('10', nrow(`10Naypyitaw1996to2007`))
DomainA11 <- rep('11', nrow(`11Rakhine1996to2007`))
DomainA12 <- rep('12', nrow(`12Sagaing1996to2007`))
DomainA13 <- rep('13', nrow(`13Shan1996to2007`))
DomainA14 <- rep('14', nrow(`14Tanintharyi1996to2007`))
DomainA15 <- rep('15', nrow(`15Yangon1996to2007`))

# Preparing new Domain column for all Interval 2 files, where B refers to Interval 2

DomainB0  <- rep('0', nrow(`0Myanmar2007to2016`))
DomainB1  <- rep('1', nrow(`1Ayeyarwady2007to2016`))
DomainB2  <- rep('2', nrow(`2Bago2007to2016`))
DomainB3  <- rep('3', nrow(`3Chin2007to2016`))
DomainB4  <- rep('4', nrow(`4Kachin2007to2016`))
DomainB5  <- rep('5', nrow(`5Kayah2007to2016`))
DomainB6  <- rep('6', nrow(`6Kayin2007to2016`))
DomainB7  <- rep('7', nrow(`7Magway2007to2016`))
DomainB8  <- rep('8', nrow(`8Mandalay2007to2016`))
DomainB9  <- rep('9', nrow(`9Mon2007to2016`))
DomainB10 <- rep('10', nrow(`10Naypyitaw2007to2016`))
DomainB11 <- rep('11', nrow(`11Rakhine2007to2016`))
DomainB12 <- rep('12', nrow(`12Sagaing2007to2016`))
DomainB13 <- rep('13', nrow(`13Shan2007to2016`))
DomainB14 <- rep('14', nrow(`14Tanintharyi2007to2016`))
DomainB15 <- rep('15', nrow(`15Yangon2007to2016`))

# Preparing new Interval column for all Interval 1 files

IntervalA0  <- rep('1', nrow(`0Myanmar1996to2007`))
IntervalA1  <- rep('1', nrow(`1Ayeyarwady1996to2007`))
IntervalA2  <- rep('1', nrow(`2Bago1996to2007`))
IntervalA3  <- rep('1', nrow(`3Chin1996to2007`))
IntervalA4  <- rep('1', nrow(`4Kachin1996to2007`))
IntervalA5  <- rep('1', nrow(`5Kayah1996to2007`))
IntervalA6  <- rep('1', nrow(`6Kayin1996to2007`))
IntervalA7  <- rep('1', nrow(`7Magway1996to2007`))
IntervalA8  <- rep('1', nrow(`8Mandalay1996to2007`))
IntervalA9  <- rep('1', nrow(`9Mon1996to2007`))
IntervalA10 <- rep('1', nrow(`10Naypyitaw1996to2007`))
IntervalA11 <- rep('1', nrow(`11Rakhine1996to2007`))
IntervalA12 <- rep('1', nrow(`12Sagaing1996to2007`))
IntervalA13 <- rep('1', nrow(`13Shan1996to2007`))
IntervalA14 <- rep('1', nrow(`14Tanintharyi1996to2007`))
IntervalA15 <- rep('1', nrow(`15Yangon1996to2007`))

# Preparing new Interval column for all Interval 2 files

IntervalB0  <- rep('2', nrow(`0Myanmar2007to2016`))
IntervalB1  <- rep('2', nrow(`1Ayeyarwady2007to2016`))
IntervalB2  <- rep('2', nrow(`2Bago2007to2016`))
IntervalB3  <- rep('2', nrow(`3Chin2007to2016`))
IntervalB4  <- rep('2', nrow(`4Kachin2007to2016`))
IntervalB5  <- rep('2', nrow(`5Kayah2007to2016`))
IntervalB6  <- rep('2', nrow(`6Kayin2007to2016`))
IntervalB7  <- rep('2', nrow(`7Magway2007to2016`))
IntervalB8  <- rep('2', nrow(`8Mandalay2007to2016`))
IntervalB9  <- rep('2', nrow(`9Mon2007to2016`))
IntervalB10 <- rep('2', nrow(`10Naypyitaw2007to2016`))
IntervalB11 <- rep('2', nrow(`11Rakhine2007to2016`))
IntervalB12 <- rep('2', nrow(`12Sagaing2007to2016`))
IntervalB13 <- rep('2', nrow(`13Shan2007to2016`))
IntervalB14 <- rep('2', nrow(`14Tanintharyi2007to2016`))
IntervalB15 <- rep('2', nrow(`15Yangon2007to2016`))


# Cbind both DomainXX and IntervalXX columns for all interval 1 files

`0Myanmar1996to2007`      <- cbind(`0Myanmar1996to2007`, DomainA0)
`0Myanmar1996to2007`      <- cbind(`0Myanmar1996to2007`, IntervalA0)

`1Ayeyarwady1996to2007`   <- cbind(`1Ayeyarwady1996to2007`, DomainA1)
`1Ayeyarwady1996to2007`   <- cbind(`1Ayeyarwady1996to2007`, IntervalA1)

`2Bago1996to2007`         <- cbind(`2Bago1996to2007`, DomainA2)
`2Bago1996to2007`         <- cbind(`2Bago1996to2007`, IntervalA2)

`3Chin1996to2007`         <- cbind(`3Chin1996to2007`, DomainA3)
`3Chin1996to2007`         <- cbind(`3Chin1996to2007`, IntervalA3)

`4Kachin1996to2007`       <- cbind(`4Kachin1996to2007`, DomainA4)
`4Kachin1996to2007`       <- cbind(`4Kachin1996to2007`, IntervalA4)

`5Kayah1996to2007`        <- cbind(`5Kayah1996to2007`, DomainA5)
`5Kayah1996to2007`        <- cbind(`5Kayah1996to2007`, IntervalA5)

`6Kayin1996to2007`        <- cbind(`6Kayin1996to2007`, DomainA6)
`6Kayin1996to2007`        <- cbind(`6Kayin1996to2007`, IntervalA6)

`7Magway1996to2007`       <- cbind(`7Magway1996to2007`, DomainA7)
`7Magway1996to2007`       <- cbind(`7Magway1996to2007`, IntervalA7)

`8Mandalay1996to2007`     <- cbind(`8Mandalay1996to2007`, DomainA8)
`8Mandalay1996to2007`     <- cbind(`8Mandalay1996to2007`, IntervalA8)

`9Mon1996to2007`          <- cbind(`9Mon1996to2007`, DomainA9)
`9Mon1996to2007`          <- cbind(`9Mon1996to2007`, IntervalA9)

`10Naypyitaw1996to2007`   <- cbind(`10Naypyitaw1996to2007`, DomainA10)
`10Naypyitaw1996to2007`   <- cbind(`10Naypyitaw1996to2007`, IntervalA10)

`11Rakhine1996to2007`     <- cbind(`11Rakhine1996to2007`, DomainA11)
`11Rakhine1996to2007`     <- cbind(`11Rakhine1996to2007`, IntervalA11)

`12Sagaing1996to2007`     <- cbind(`12Sagaing1996to2007`, DomainA12)
`12Sagaing1996to2007`     <- cbind(`12Sagaing1996to2007`, IntervalA12)

`13Shan1996to2007`        <- cbind(`13Shan1996to2007`, DomainA13)
`13Shan1996to2007`        <- cbind(`13Shan1996to2007`, IntervalA13)

`14Tanintharyi1996to2007` <- cbind(`14Tanintharyi1996to2007`, DomainA14)
`14Tanintharyi1996to2007` <- cbind(`14Tanintharyi1996to2007`, IntervalA14)

`15Yangon1996to2007`      <- cbind(`15Yangon1996to2007`, DomainA15)
`15Yangon1996to2007`      <- cbind(`15Yangon1996to2007`, IntervalA15)

# Cbind both DomainXX and IntervalXX columns for all interval 2 files

`0Myanmar2007to2016`      <- cbind(`0Myanmar2007to2016`, DomainB0)
`0Myanmar2007to2016`      <- cbind(`0Myanmar2007to2016`, IntervalB0)

`1Ayeyarwady2007to2016`   <- cbind(`1Ayeyarwady2007to2016`, DomainB1)
`1Ayeyarwady2007to2016`   <- cbind(`1Ayeyarwady2007to2016`, IntervalB1)

`2Bago2007to2016`         <- cbind(`2Bago2007to2016`, DomainB2)
`2Bago2007to2016`         <- cbind(`2Bago2007to2016`, IntervalB2)

`3Chin2007to2016`         <- cbind(`3Chin2007to2016`, DomainB3)
`3Chin2007to2016`         <- cbind(`3Chin2007to2016`, IntervalB3)

`4Kachin2007to2016`       <- cbind(`4Kachin2007to2016`, DomainB4)
`4Kachin2007to2016`       <- cbind(`4Kachin2007to2016`, IntervalB4)

`5Kayah2007to2016`        <- cbind(`5Kayah2007to2016`, DomainB5)
`5Kayah2007to2016`        <- cbind(`5Kayah2007to2016`, IntervalB5)

`6Kayin2007to2016`        <- cbind(`6Kayin2007to2016`, DomainB6)
`6Kayin2007to2016`        <- cbind(`6Kayin2007to2016`, IntervalB6)

`7Magway2007to2016`       <- cbind(`7Magway2007to2016`, DomainB7)
`7Magway2007to2016`       <- cbind(`7Magway2007to2016`, IntervalB7)

`8Mandalay2007to2016`     <- cbind(`8Mandalay2007to2016`, DomainB8)
`8Mandalay2007to2016`     <- cbind(`8Mandalay2007to2016`, IntervalB8)

`9Mon2007to2016`          <- cbind(`9Mon2007to2016`, DomainB9)
`9Mon2007to2016`          <- cbind(`9Mon2007to2016`, IntervalB9)

`10Naypyitaw2007to2016`   <- cbind(`10Naypyitaw2007to2016`, DomainB10)
`10Naypyitaw2007to2016`   <- cbind(`10Naypyitaw2007to2016`, IntervalB10)

`11Rakhine2007to2016`     <- cbind(`11Rakhine2007to2016`, DomainB11)
`11Rakhine2007to2016`     <- cbind(`11Rakhine2007to2016`, IntervalB11)

`12Sagaing2007to2016`     <- cbind(`12Sagaing2007to2016`, DomainB12)
`12Sagaing2007to2016`     <- cbind(`12Sagaing2007to2016`, IntervalB12)

`13Shan2007to2016`        <- cbind(`13Shan2007to2016`, DomainB13)
`13Shan2007to2016`        <- cbind(`13Shan2007to2016`, IntervalB13)

`14Tanintharyi2007to2016` <- cbind(`14Tanintharyi2007to2016`, DomainB14)
`14Tanintharyi2007to2016` <- cbind(`14Tanintharyi2007to2016`, IntervalB14)

`15Yangon2007to2016`      <- cbind(`15Yangon2007to2016`, DomainB15)
`15Yangon2007to2016`      <- cbind(`15Yangon2007to2016`, IntervalB15)


# 5. Remove all rows that indicate land persistence, i.e. Reference class = X and New class = X, since I want to see contribution to change on the landscape

#Template Code: d<-d[!(d$A=="B" & d$E==0),], i.e. when ColA = ColB, remove that row.

#Removing all instances from Interval 1,

`0Myanmar1996to2007` <- `0Myanmar1996to2007`[!(`0Myanmar1996to2007`$ReferenceClass==`0Myanmar1996to2007`$NewClass),]
`1Ayeyarwady1996to2007` <- `1Ayeyarwady1996to2007`[!(`1Ayeyarwady1996to2007`$ReferenceClass==`1Ayeyarwady1996to2007`$NewClass),]
`2Bago1996to2007` <- `2Bago1996to2007`[!(`2Bago1996to2007`$ReferenceClass==`2Bago1996to2007`$NewClass),]
`3Chin1996to2007` <- `3Chin1996to2007`[!(`3Chin1996to2007`$ReferenceClass==`3Chin1996to2007`$NewClass),]
`4Kachin1996to2007` <- `4Kachin1996to2007`[!(`4Kachin1996to2007`$ReferenceClass==`4Kachin1996to2007`$NewClass),]
`5Kayah1996to2007` <- `5Kayah1996to2007`[!(`5Kayah1996to2007`$ReferenceClass==`5Kayah1996to2007`$NewClass),]
`6Kayin1996to2007` <- `6Kayin1996to2007`[!(`6Kayin1996to2007`$ReferenceClass==`6Kayin1996to2007`$NewClass),]
`7Magway1996to2007` <- `7Magway1996to2007`[!(`7Magway1996to2007`$ReferenceClass==`7Magway1996to2007`$NewClass),]
`8Mandalay1996to2007` <- `8Mandalay1996to2007`[!(`8Mandalay1996to2007`$ReferenceClass==`8Mandalay1996to2007`$NewClass),]
`9Mon1996to2007` <- `9Mon1996to2007`[!(`9Mon1996to2007`$ReferenceClass==`9Mon1996to2007`$NewClass),]
`10Naypyitaw1996to2007` <- `10Naypyitaw1996to2007`[!(`10Naypyitaw1996to2007`$ReferenceClass==`10Naypyitaw1996to2007`$NewClass),]
`11Rakhine1996to2007` <- `11Rakhine1996to2007`[!(`11Rakhine1996to2007`$ReferenceClass==`11Rakhine1996to2007`$NewClass),]
`12Sagaing1996to2007` <- `12Sagaing1996to2007`[!(`12Sagaing1996to2007`$ReferenceClass==`12Sagaing1996to2007`$NewClass),]
`13Shan1996to2007` <- `13Shan1996to2007`[!(`13Shan1996to2007`$ReferenceClass==`13Shan1996to2007`$NewClass),]
`14Tanintharyi1996to2007` <- `14Tanintharyi1996to2007`[!(`14Tanintharyi1996to2007`$ReferenceClass==`14Tanintharyi1996to2007`$NewClass),]
`15Yangon1996to2007` <- `15Yangon1996to2007`[!(`15Yangon1996to2007`$ReferenceClass==`15Yangon1996to2007`$NewClass),]

# Removing all instances from Interval 2,

`0Myanmar2007to2016` <- `0Myanmar2007to2016`[!(`0Myanmar2007to2016`$ReferenceClass==`0Myanmar2007to2016`$NewClass),]
`1Ayeyarwady2007to2016` <- `1Ayeyarwady2007to2016`[!(`1Ayeyarwady2007to2016`$ReferenceClass==`1Ayeyarwady2007to2016`$NewClass),]
`2Bago2007to2016` <- `2Bago2007to2016`[!(`2Bago2007to2016`$ReferenceClass==`2Bago2007to2016`$NewClass),]
`3Chin2007to2016` <- `3Chin2007to2016`[!(`3Chin2007to2016`$ReferenceClass==`3Chin2007to2016`$NewClass),]
`4Kachin2007to2016` <- `4Kachin2007to2016`[!(`4Kachin2007to2016`$ReferenceClass==`4Kachin2007to2016`$NewClass),]
`5Kayah2007to2016` <- `5Kayah2007to2016`[!(`5Kayah2007to2016`$ReferenceClass==`5Kayah2007to2016`$NewClass),]
`6Kayin2007to2016` <- `6Kayin2007to2016`[!(`6Kayin2007to2016`$ReferenceClass==`6Kayin2007to2016`$NewClass),]
`7Magway2007to2016` <- `7Magway2007to2016`[!(`7Magway2007to2016`$ReferenceClass==`7Magway2007to2016`$NewClass),]
`8Mandalay2007to2016` <- `8Mandalay2007to2016`[!(`8Mandalay2007to2016`$ReferenceClass==`8Mandalay2007to2016`$NewClass),]
`9Mon2007to2016` <- `9Mon2007to2016`[!(`9Mon2007to2016`$ReferenceClass==`9Mon2007to2016`$NewClass),]
`10Naypyitaw2007to2016` <- `10Naypyitaw2007to2016`[!(`10Naypyitaw2007to2016`$ReferenceClass==`10Naypyitaw2007to2016`$NewClass),]
`11Rakhine2007to2016` <- `11Rakhine2007to2016`[!(`11Rakhine2007to2016`$ReferenceClass==`11Rakhine2007to2016`$NewClass),]
`12Sagaing2007to2016` <- `12Sagaing2007to2016`[!(`12Sagaing2007to2016`$ReferenceClass==`12Sagaing2007to2016`$NewClass),]
`13Shan2007to2016` <- `13Shan2007to2016`[!(`13Shan2007to2016`$ReferenceClass==`13Shan2007to2016`$NewClass),]
`14Tanintharyi2007to2016` <- `14Tanintharyi2007to2016`[!(`14Tanintharyi2007to2016`$ReferenceClass==`14Tanintharyi2007to2016`$NewClass),]
`15Yangon2007to2016` <- `15Yangon2007to2016`[!(`15Yangon2007to2016`$ReferenceClass==`15Yangon2007to2016`$NewClass),]


# 6. Adding the percentage of total landscape change column 

# For Interval 1,

`0Myanmar1996to2007`      ["PercentOfTotalLandscapeChange"] <- prop.table(`0Myanmar1996to2007`$PixelSum)      *100
`1Ayeyarwady1996to2007`   ["PercentOfTotalLandscapeChange"] <- prop.table(`1Ayeyarwady1996to2007`$PixelSum)   *100
`2Bago1996to2007`         ["PercentOfTotalLandscapeChange"] <- prop.table(`2Bago1996to2007`$PixelSum)         *100
`3Chin1996to2007`         ["PercentOfTotalLandscapeChange"] <- prop.table(`3Chin1996to2007`$PixelSum)         *100
`4Kachin1996to2007`       ["PercentOfTotalLandscapeChange"] <- prop.table(`4Kachin1996to2007`$PixelSum)       *100
`5Kayah1996to2007`        ["PercentOfTotalLandscapeChange"] <- prop.table(`5Kayah1996to2007`$PixelSum)        *100
`6Kayin1996to2007`        ["PercentOfTotalLandscapeChange"] <- prop.table(`6Kayin1996to2007`$PixelSum)        *100
`7Magway1996to2007`       ["PercentOfTotalLandscapeChange"] <- prop.table(`7Magway1996to2007`$PixelSum)       *100
`8Mandalay1996to2007`     ["PercentOfTotalLandscapeChange"] <- prop.table(`8Mandalay1996to2007`$PixelSum)     *100
`9Mon1996to2007`          ["PercentOfTotalLandscapeChange"] <- prop.table(`9Mon1996to2007`$PixelSum)          *100
`10Naypyitaw1996to2007`   ["PercentOfTotalLandscapeChange"] <- prop.table(`10Naypyitaw1996to2007`$PixelSum)   *100
`11Rakhine1996to2007`     ["PercentOfTotalLandscapeChange"] <- prop.table(`11Rakhine1996to2007`$PixelSum)     *100
`12Sagaing1996to2007`     ["PercentOfTotalLandscapeChange"] <- prop.table(`12Sagaing1996to2007`$PixelSum)     *100
`13Shan1996to2007`        ["PercentOfTotalLandscapeChange"] <- prop.table(`13Shan1996to2007`$PixelSum)        *100
`14Tanintharyi1996to2007` ["PercentOfTotalLandscapeChange"] <- prop.table(`14Tanintharyi1996to2007`$PixelSum) *100
`15Yangon1996to2007`      ["PercentOfTotalLandscapeChange"] <- prop.table(`15Yangon1996to2007`$PixelSum)      *100

# For Interval 2,

`0Myanmar2007to2016`      ["PercentOfTotalLandscapeChange"] <- prop.table(`0Myanmar2007to2016`$PixelSum)      *100
`1Ayeyarwady2007to2016`   ["PercentOfTotalLandscapeChange"] <- prop.table(`1Ayeyarwady2007to2016`$PixelSum)   *100
`2Bago2007to2016`         ["PercentOfTotalLandscapeChange"] <- prop.table(`2Bago2007to2016`$PixelSum)         *100
`3Chin2007to2016`         ["PercentOfTotalLandscapeChange"] <- prop.table(`3Chin2007to2016`$PixelSum)         *100
`4Kachin2007to2016`       ["PercentOfTotalLandscapeChange"] <- prop.table(`4Kachin2007to2016`$PixelSum)       *100
`5Kayah2007to2016`        ["PercentOfTotalLandscapeChange"] <- prop.table(`5Kayah2007to2016`$PixelSum)        *100
`6Kayin2007to2016`        ["PercentOfTotalLandscapeChange"] <- prop.table(`6Kayin2007to2016`$PixelSum)        *100
`7Magway2007to2016`       ["PercentOfTotalLandscapeChange"] <- prop.table(`7Magway2007to2016`$PixelSum)       *100
`8Mandalay2007to2016`     ["PercentOfTotalLandscapeChange"] <- prop.table(`8Mandalay2007to2016`$PixelSum)     *100
`9Mon2007to2016`          ["PercentOfTotalLandscapeChange"] <- prop.table(`9Mon2007to2016`$PixelSum)          *100
`10Naypyitaw2007to2016`   ["PercentOfTotalLandscapeChange"] <- prop.table(`10Naypyitaw2007to2016`$PixelSum)   *100
`11Rakhine2007to2016`     ["PercentOfTotalLandscapeChange"] <- prop.table(`11Rakhine2007to2016`$PixelSum)     *100
`12Sagaing2007to2016`     ["PercentOfTotalLandscapeChange"] <- prop.table(`12Sagaing2007to2016`$PixelSum)     *100
`13Shan2007to2016`        ["PercentOfTotalLandscapeChange"] <- prop.table(`13Shan2007to2016`$PixelSum)        *100
`14Tanintharyi2007to2016` ["PercentOfTotalLandscapeChange"] <- prop.table(`14Tanintharyi2007to2016`$PixelSum) *100
`15Yangon2007to2016`      ["PercentOfTotalLandscapeChange"] <- prop.table(`15Yangon2007to2016`$PixelSum)      *100

# Testing 01 x random domain in each interval if the sums add up to 100%

sum(`9Mon1996to2007`$"PercentOfTotalLandscapeChange")
sum(`1Ayeyarwady2007to2016`$"PercentOfTotalLandscapeChange")



# 7. Renaming all the Domain and Interval columns for all domains both intervals
# Note: merging will not work because the column headers are different, thus they have to be standardized

# For Interval 1, 

names(`0Myanmar1996to2007`)     [5] <- "Domain"
names(`1Ayeyarwady1996to2007`)  [5] <- "Domain"
names(`2Bago1996to2007`)        [5] <- "Domain"
names(`3Chin1996to2007`)        [5] <- "Domain"
names(`4Kachin1996to2007`)      [5] <- "Domain"
names(`5Kayah1996to2007`)       [5] <- "Domain"
names(`6Kayin1996to2007`)       [5] <- "Domain"
names(`7Magway1996to2007`)      [5] <- "Domain"
names(`8Mandalay1996to2007`)    [5] <- "Domain"
names(`9Mon1996to2007`)         [5] <- "Domain"
names(`10Naypyitaw1996to2007`)  [5] <- "Domain"
names(`11Rakhine1996to2007`)    [5] <- "Domain"
names(`12Sagaing1996to2007`)    [5] <- "Domain"
names(`13Shan1996to2007`)       [5] <- "Domain"
names(`14Tanintharyi1996to2007`)[5] <- "Domain"
names(`15Yangon1996to2007`)     [5] <- "Domain"

names(`0Myanmar1996to2007`)     [6] <- "Interval"
names(`1Ayeyarwady1996to2007`)  [6] <- "Interval"
names(`2Bago1996to2007`)        [6] <- "Interval"
names(`3Chin1996to2007`)        [6] <- "Interval"
names(`4Kachin1996to2007`)      [6] <- "Interval"
names(`5Kayah1996to2007`)       [6] <- "Interval"
names(`6Kayin1996to2007`)       [6] <- "Interval"
names(`7Magway1996to2007`)      [6] <- "Interval"
names(`8Mandalay1996to2007`)    [6] <- "Interval"
names(`9Mon1996to2007`)         [6] <- "Interval"
names(`10Naypyitaw1996to2007`)  [6] <- "Interval"
names(`11Rakhine1996to2007`)    [6] <- "Interval"
names(`12Sagaing1996to2007`)    [6] <- "Interval"
names(`13Shan1996to2007`)       [6] <- "Interval"
names(`14Tanintharyi1996to2007`)[6] <- "Interval"
names(`15Yangon1996to2007`)     [6] <- "Interval"

# For Interval 2,

names(`0Myanmar2007to2016`)     [5] <- "Domain"
names(`1Ayeyarwady2007to2016`)  [5] <- "Domain"
names(`2Bago2007to2016`)        [5] <- "Domain"
names(`3Chin2007to2016`)        [5] <- "Domain"
names(`4Kachin2007to2016`)      [5] <- "Domain"
names(`5Kayah2007to2016`)       [5] <- "Domain"
names(`6Kayin2007to2016`)       [5] <- "Domain"
names(`7Magway2007to2016`)      [5] <- "Domain"
names(`8Mandalay2007to2016`)    [5] <- "Domain"
names(`9Mon2007to2016`)         [5] <- "Domain"
names(`10Naypyitaw2007to2016`)  [5] <- "Domain"
names(`11Rakhine2007to2016`)    [5] <- "Domain"
names(`12Sagaing2007to2016`)    [5] <- "Domain"
names(`13Shan2007to2016`)       [5] <- "Domain"
names(`14Tanintharyi2007to2016`)[5] <- "Domain"
names(`15Yangon2007to2016`)     [5] <- "Domain"

names(`0Myanmar2007to2016`)     [6] <- "Interval"
names(`1Ayeyarwady2007to2016`)  [6] <- "Interval"
names(`2Bago2007to2016`)        [6] <- "Interval"
names(`3Chin2007to2016`)        [6] <- "Interval"
names(`4Kachin2007to2016`)      [6] <- "Interval"
names(`5Kayah2007to2016`)       [6] <- "Interval"
names(`6Kayin2007to2016`)       [6] <- "Interval"
names(`7Magway2007to2016`)      [6] <- "Interval"
names(`8Mandalay2007to2016`)    [6] <- "Interval"
names(`9Mon2007to2016`)         [6] <- "Interval"
names(`10Naypyitaw2007to2016`)  [6] <- "Interval"
names(`11Rakhine2007to2016`)    [6] <- "Interval"
names(`12Sagaing2007to2016`)    [6] <- "Interval"
names(`13Shan2007to2016`)       [6] <- "Interval"
names(`14Tanintharyi2007to2016`)[6] <- "Interval"
names(`15Yangon2007to2016`)     [6] <- "Interval"


# 8. Merging all domains for each interval into one dataframe

AllDomainsInterval1 <- do.call("rbind", list(`0Myanmar1996to2007`
                                             ,`1Ayeyarwady1996to2007`
                                             ,`2Bago1996to2007`
                                             ,`3Chin1996to2007`
                                             ,`4Kachin1996to2007`
                                             ,`5Kayah1996to2007`
                                             ,`6Kayin1996to2007`
                                             ,`7Magway1996to2007`
                                             ,`8Mandalay1996to2007`
                                             ,`9Mon1996to2007`
                                             ,`10Naypyitaw1996to2007`
                                             ,`11Rakhine1996to2007`
                                             ,`12Sagaing1996to2007`
                                             ,`13Shan1996to2007`
                                             ,`14Tanintharyi1996to2007`
                                             ,`15Yangon1996to2007`))

AllDomainsInterval2 <- do.call("rbind", list(`0Myanmar2007to2016`
                                             ,`1Ayeyarwady2007to2016`
                                             ,`2Bago2007to2016`
                                             ,`3Chin2007to2016`
                                             ,`4Kachin2007to2016`
                                             ,`5Kayah2007to2016`
                                             ,`6Kayin2007to2016`
                                             ,`7Magway2007to2016`
                                             ,`8Mandalay2007to2016`
                                             ,`9Mon2007to2016`
                                             ,`10Naypyitaw2007to2016`
                                             ,`11Rakhine2007to2016`
                                             ,`12Sagaing2007to2016`
                                             ,`13Shan2007to2016`
                                             ,`14Tanintharyi2007to2016`
                                             ,`15Yangon2007to2016`))

# 9. Exporting the dataframe as a csv

write.csv(AllDomainsInterval1, file = 'All Domains in Interval 1.csv')
write.csv(AllDomainsInterval2, file = 'All Domains in Interval 2.csv')

# 10. Plotting the stacked bar plots for each interval

# Before this, the code still needs to be refined, when calculating the percentages using prop.table, we should be removing all the change codes that reflect persistence.