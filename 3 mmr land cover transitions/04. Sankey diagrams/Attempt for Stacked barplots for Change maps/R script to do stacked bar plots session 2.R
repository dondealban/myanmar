# Creator: J Johanness
# Date: 23-09-2018

# Purpose: 

# To create a way of repeating the previous script to calculate column percentages on more than one file within the local repository


# START

# - - -

# 1. Define path to folder

path <- "C:/150918 all newest CSVs from QGIS SCP LCC batch/4. QGIS SCP LCC_Change Maps and CSVs"

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


# - - -

# 4. Now to add the Domain and Interval Column (There must be a better way to do this, by inserting a column only if the file name has 1996_to_2007 etc)


# Preparing new Domain column for all Interval 1 files, where A refers to interval 1 (this is because it will overwrite each other if it is only 'Domain')

DomainA0  <- rep('A. Myanmar', nrow(`0Myanmar1996to2007`))
DomainA1  <- rep('B. Ayeyarwady', nrow(`1Ayeyarwady1996to2007`))
DomainA2  <- rep('C. Bago', nrow(`2Bago1996to2007`))
DomainA3  <- rep('D. Chin', nrow(`3Chin1996to2007`))
DomainA4  <- rep('E. Kachin', nrow(`4Kachin1996to2007`))
DomainA5  <- rep('F. Kayah', nrow(`5Kayah1996to2007`))
DomainA6  <- rep('G. Kayin', nrow(`6Kayin1996to2007`))
DomainA7  <- rep('H. Magway', nrow(`7Magway1996to2007`))
DomainA8  <- rep('I. Mandalay', nrow(`8Mandalay1996to2007`))
DomainA9  <- rep('J. Mon', nrow(`9Mon1996to2007`))
DomainA10 <- rep('K. Naypyitaw', nrow(`10Naypyitaw1996to2007`))
DomainA11 <- rep('L. Rakhine', nrow(`11Rakhine1996to2007`))
DomainA12 <- rep('M. Sagaing', nrow(`12Sagaing1996to2007`))
DomainA13 <- rep('N. Shan', nrow(`13Shan1996to2007`))
DomainA14 <- rep('O. Tanintharyi', nrow(`14Tanintharyi1996to2007`))
DomainA15 <- rep('P. Yangon', nrow(`15Yangon1996to2007`))

# Preparing new Domain column for all Interval 2 files, where B refers to Interval 2

DomainB0  <- rep('A. Myanmar', nrow(`0Myanmar2007to2016`))
DomainB1  <- rep('B. Ayeyarwady', nrow(`1Ayeyarwady2007to2016`))
DomainB2  <- rep('C. Bago', nrow(`2Bago2007to2016`))
DomainB3  <- rep('D. Chin', nrow(`3Chin2007to2016`))
DomainB4  <- rep('E. Kachin', nrow(`4Kachin2007to2016`))
DomainB5  <- rep('F. Kayah', nrow(`5Kayah2007to2016`))
DomainB6  <- rep('G. Kayin', nrow(`6Kayin2007to2016`))
DomainB7  <- rep('H. Magway', nrow(`7Magway2007to2016`))
DomainB8  <- rep('I. Mandalay', nrow(`8Mandalay2007to2016`))
DomainB9  <- rep('J. Mon', nrow(`9Mon2007to2016`))
DomainB10 <- rep('K. Naypyitaw', nrow(`10Naypyitaw2007to2016`))
DomainB11 <- rep('L. Rakhine', nrow(`11Rakhine2007to2016`))
DomainB12 <- rep('M. Sagaing', nrow(`12Sagaing2007to2016`))
DomainB13 <- rep('N. Shan', nrow(`13Shan2007to2016`))
DomainB14 <- rep('O. Tanintharyi', nrow(`14Tanintharyi2007to2016`))
DomainB15 <- rep('P. Yangon', nrow(`15Yangon2007to2016`))

# Preparing new Interval column for all Interval 1 files

IntervalA0  <- rep('1996 to 2007', nrow(`0Myanmar1996to2007`))
IntervalA1  <- rep('1996 to 2007', nrow(`1Ayeyarwady1996to2007`))
IntervalA2  <- rep('1996 to 2007', nrow(`2Bago1996to2007`))
IntervalA3  <- rep('1996 to 2007', nrow(`3Chin1996to2007`))
IntervalA4  <- rep('1996 to 2007', nrow(`4Kachin1996to2007`))
IntervalA5  <- rep('1996 to 2007', nrow(`5Kayah1996to2007`))
IntervalA6  <- rep('1996 to 2007', nrow(`6Kayin1996to2007`))
IntervalA7  <- rep('1996 to 2007', nrow(`7Magway1996to2007`))
IntervalA8  <- rep('1996 to 2007', nrow(`8Mandalay1996to2007`))
IntervalA9  <- rep('1996 to 2007', nrow(`9Mon1996to2007`))
IntervalA10 <- rep('1996 to 2007', nrow(`10Naypyitaw1996to2007`))
IntervalA11 <- rep('1996 to 2007', nrow(`11Rakhine1996to2007`))
IntervalA12 <- rep('1996 to 2007', nrow(`12Sagaing1996to2007`))
IntervalA13 <- rep('1996 to 2007', nrow(`13Shan1996to2007`))
IntervalA14 <- rep('1996 to 2007', nrow(`14Tanintharyi1996to2007`))
IntervalA15 <- rep('1996 to 2007', nrow(`15Yangon1996to2007`))

# Preparing new Interval column for all Interval 2 files

IntervalB0  <- rep('2007 to 2016', nrow(`0Myanmar2007to2016`))
IntervalB1  <- rep('2007 to 2016', nrow(`1Ayeyarwady2007to2016`))
IntervalB2  <- rep('2007 to 2016', nrow(`2Bago2007to2016`))
IntervalB3  <- rep('2007 to 2016', nrow(`3Chin2007to2016`))
IntervalB4  <- rep('2007 to 2016', nrow(`4Kachin2007to2016`))
IntervalB5  <- rep('2007 to 2016', nrow(`5Kayah2007to2016`))
IntervalB6  <- rep('2007 to 2016', nrow(`6Kayin2007to2016`))
IntervalB7  <- rep('2007 to 2016', nrow(`7Magway2007to2016`))
IntervalB8  <- rep('2007 to 2016', nrow(`8Mandalay2007to2016`))
IntervalB9  <- rep('2007 to 2016', nrow(`9Mon2007to2016`))
IntervalB10 <- rep('2007 to 2016', nrow(`10Naypyitaw2007to2016`))
IntervalB11 <- rep('2007 to 2016', nrow(`11Rakhine2007to2016`))
IntervalB12 <- rep('2007 to 2016', nrow(`12Sagaing2007to2016`))
IntervalB13 <- rep('2007 to 2016', nrow(`13Shan2007to2016`))
IntervalB14 <- rep('2007 to 2016', nrow(`14Tanintharyi2007to2016`))
IntervalB15 <- rep('2007 to 2016', nrow(`15Yangon2007to2016`))


# - - -

# 5. Cbind both DomainXX and IntervalXX columns for all interval 1 files

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


# - - -

# 6. Remove all rows that indicate land persistence, i.e. Reference class = X and New class = X, since I want to see contribution to change on the landscape

#Template Code: d<-d[!(d$A=="B" & d$E==0),], i.e. when ColA = ColB, remove that row.

#Removing all instances from Interval 1,

#`0Myanmar1996to2007` <- `0Myanmar1996to2007`[!(`0Myanmar1996to2007`$ReferenceClass==`0Myanmar1996to2007`$NewClass),]
#`1Ayeyarwady1996to2007` <- `1Ayeyarwady1996to2007`[!(`1Ayeyarwady1996to2007`$ReferenceClass==`1Ayeyarwady1996to2007`$NewClass),]
#`2Bago1996to2007` <- `2Bago1996to2007`[!(`2Bago1996to2007`$ReferenceClass==`2Bago1996to2007`$NewClass),]
#`3Chin1996to2007` <- `3Chin1996to2007`[!(`3Chin1996to2007`$ReferenceClass==`3Chin1996to2007`$NewClass),]
#`4Kachin1996to2007` <- `4Kachin1996to2007`[!(`4Kachin1996to2007`$ReferenceClass==`4Kachin1996to2007`$NewClass),]
#`5Kayah1996to2007` <- `5Kayah1996to2007`[!(`5Kayah1996to2007`$ReferenceClass==`5Kayah1996to2007`$NewClass),]
#`6Kayin1996to2007` <- `6Kayin1996to2007`[!(`6Kayin1996to2007`$ReferenceClass==`6Kayin1996to2007`$NewClass),]
#`7Magway1996to2007` <- `7Magway1996to2007`[!(`7Magway1996to2007`$ReferenceClass==`7Magway1996to2007`$NewClass),]
#`8Mandalay1996to2007` <- `8Mandalay1996to2007`[!(`8Mandalay1996to2007`$ReferenceClass==`8Mandalay1996to2007`$NewClass),]
#`9Mon1996to2007` <- `9Mon1996to2007`[!(`9Mon1996to2007`$ReferenceClass==`9Mon1996to2007`$NewClass),]
#`10Naypyitaw1996to2007` <- `10Naypyitaw1996to2007`[!(`10Naypyitaw1996to2007`$ReferenceClass==`10Naypyitaw1996to2007`$NewClass),]
#`11Rakhine1996to2007` <- `11Rakhine1996to2007`[!(`11Rakhine1996to2007`$ReferenceClass==`11Rakhine1996to2007`$NewClass),]
#`12Sagaing1996to2007` <- `12Sagaing1996to2007`[!(`12Sagaing1996to2007`$ReferenceClass==`12Sagaing1996to2007`$NewClass),]
#`13Shan1996to2007` <- `13Shan1996to2007`[!(`13Shan1996to2007`$ReferenceClass==`13Shan1996to2007`$NewClass),]
#`14Tanintharyi1996to2007` <- `14Tanintharyi1996to2007`[!(`14Tanintharyi1996to2007`$ReferenceClass==`14Tanintharyi1996to2007`$NewClass),]
#`15Yangon1996to2007` <- `15Yangon1996to2007`[!(`15Yangon1996to2007`$ReferenceClass==`15Yangon1996to2007`$NewClass),]

# Removing all instances from Interval 2,

#`0Myanmar2007to2016` <- `0Myanmar2007to2016`[!(`0Myanmar2007to2016`$ReferenceClass==`0Myanmar2007to2016`$NewClass),]
#`1Ayeyarwady2007to2016` <- `1Ayeyarwady2007to2016`[!(`1Ayeyarwady2007to2016`$ReferenceClass==`1Ayeyarwady2007to2016`$NewClass),]
#`2Bago2007to2016` <- `2Bago2007to2016`[!(`2Bago2007to2016`$ReferenceClass==`2Bago2007to2016`$NewClass),]
#`3Chin2007to2016` <- `3Chin2007to2016`[!(`3Chin2007to2016`$ReferenceClass==`3Chin2007to2016`$NewClass),]
#`4Kachin2007to2016` <- `4Kachin2007to2016`[!(`4Kachin2007to2016`$ReferenceClass==`4Kachin2007to2016`$NewClass),]
#`5Kayah2007to2016` <- `5Kayah2007to2016`[!(`5Kayah2007to2016`$ReferenceClass==`5Kayah2007to2016`$NewClass),]
#`6Kayin2007to2016` <- `6Kayin2007to2016`[!(`6Kayin2007to2016`$ReferenceClass==`6Kayin2007to2016`$NewClass),]
#`7Magway2007to2016` <- `7Magway2007to2016`[!(`7Magway2007to2016`$ReferenceClass==`7Magway2007to2016`$NewClass),]
#`8Mandalay2007to2016` <- `8Mandalay2007to2016`[!(`8Mandalay2007to2016`$ReferenceClass==`8Mandalay2007to2016`$NewClass),]
#`9Mon2007to2016` <- `9Mon2007to2016`[!(`9Mon2007to2016`$ReferenceClass==`9Mon2007to2016`$NewClass),]
#`10Naypyitaw2007to2016` <- `10Naypyitaw2007to2016`[!(`10Naypyitaw2007to2016`$ReferenceClass==`10Naypyitaw2007to2016`$NewClass),]
#`11Rakhine2007to2016` <- `11Rakhine2007to2016`[!(`11Rakhine2007to2016`$ReferenceClass==`11Rakhine2007to2016`$NewClass),]
#`12Sagaing2007to2016` <- `12Sagaing2007to2016`[!(`12Sagaing2007to2016`$ReferenceClass==`12Sagaing2007to2016`$NewClass),]
#`13Shan2007to2016` <- `13Shan2007to2016`[!(`13Shan2007to2016`$ReferenceClass==`13Shan2007to2016`$NewClass),]
#`14Tanintharyi2007to2016` <- `14Tanintharyi2007to2016`[!(`14Tanintharyi2007to2016`$ReferenceClass==`14Tanintharyi2007to2016`$NewClass),]
#`15Yangon2007to2016` <- `15Yangon2007to2016`[!(`15Yangon2007to2016`$ReferenceClass==`15Yangon2007to2016`$NewClass),]


# - - -

# 7. Adding the percentage of total landscape change column 

# For Interval 1,

#`0Myanmar1996to2007`      ["PercentOfTotalLandscapeChange"] <- prop.table(`0Myanmar1996to2007`$PixelSum)      *100
#`1Ayeyarwady1996to2007`   ["PercentOfTotalLandscapeChange"] <- prop.table(`1Ayeyarwady1996to2007`$PixelSum)   *100
#`2Bago1996to2007`         ["PercentOfTotalLandscapeChange"] <- prop.table(`2Bago1996to2007`$PixelSum)         *100
#`3Chin1996to2007`         ["PercentOfTotalLandscapeChange"] <- prop.table(`3Chin1996to2007`$PixelSum)         *100
#`4Kachin1996to2007`       ["PercentOfTotalLandscapeChange"] <- prop.table(`4Kachin1996to2007`$PixelSum)       *100
#`5Kayah1996to2007`        ["PercentOfTotalLandscapeChange"] <- prop.table(`5Kayah1996to2007`$PixelSum)        *100
#`6Kayin1996to2007`        ["PercentOfTotalLandscapeChange"] <- prop.table(`6Kayin1996to2007`$PixelSum)        *100
#`7Magway1996to2007`       ["PercentOfTotalLandscapeChange"] <- prop.table(`7Magway1996to2007`$PixelSum)       *100
#`8Mandalay1996to2007`     ["PercentOfTotalLandscapeChange"] <- prop.table(`8Mandalay1996to2007`$PixelSum)     *100
#`9Mon1996to2007`          ["PercentOfTotalLandscapeChange"] <- prop.table(`9Mon1996to2007`$PixelSum)          *100
#`10Naypyitaw1996to2007`   ["PercentOfTotalLandscapeChange"] <- prop.table(`10Naypyitaw1996to2007`$PixelSum)   *100
#`11Rakhine1996to2007`     ["PercentOfTotalLandscapeChange"] <- prop.table(`11Rakhine1996to2007`$PixelSum)     *100
#`12Sagaing1996to2007`     ["PercentOfTotalLandscapeChange"] <- prop.table(`12Sagaing1996to2007`$PixelSum)     *100
#`13Shan1996to2007`        ["PercentOfTotalLandscapeChange"] <- prop.table(`13Shan1996to2007`$PixelSum)        *100
#`14Tanintharyi1996to2007` ["PercentOfTotalLandscapeChange"] <- prop.table(`14Tanintharyi1996to2007`$PixelSum) *100
#`15Yangon1996to2007`      ["PercentOfTotalLandscapeChange"] <- prop.table(`15Yangon1996to2007`$PixelSum)      *100

# For Interval 2,

#`0Myanmar2007to2016`      ["PercentOfTotalLandscapeChange"] <- prop.table(`0Myanmar2007to2016`$PixelSum)      *100
#`1Ayeyarwady2007to2016`   ["PercentOfTotalLandscapeChange"] <- prop.table(`1Ayeyarwady2007to2016`$PixelSum)   *100
#`2Bago2007to2016`         ["PercentOfTotalLandscapeChange"] <- prop.table(`2Bago2007to2016`$PixelSum)         *100
#`3Chin2007to2016`         ["PercentOfTotalLandscapeChange"] <- prop.table(`3Chin2007to2016`$PixelSum)         *100
#`4Kachin2007to2016`       ["PercentOfTotalLandscapeChange"] <- prop.table(`4Kachin2007to2016`$PixelSum)       *100
#`5Kayah2007to2016`        ["PercentOfTotalLandscapeChange"] <- prop.table(`5Kayah2007to2016`$PixelSum)        *100
#`6Kayin2007to2016`        ["PercentOfTotalLandscapeChange"] <- prop.table(`6Kayin2007to2016`$PixelSum)        *100
#`7Magway2007to2016`       ["PercentOfTotalLandscapeChange"] <- prop.table(`7Magway2007to2016`$PixelSum)       *100
#`8Mandalay2007to2016`     ["PercentOfTotalLandscapeChange"] <- prop.table(`8Mandalay2007to2016`$PixelSum)     *100
#`9Mon2007to2016`          ["PercentOfTotalLandscapeChange"] <- prop.table(`9Mon2007to2016`$PixelSum)          *100
#`10Naypyitaw2007to2016`   ["PercentOfTotalLandscapeChange"] <- prop.table(`10Naypyitaw2007to2016`$PixelSum)   *100
#`11Rakhine2007to2016`     ["PercentOfTotalLandscapeChange"] <- prop.table(`11Rakhine2007to2016`$PixelSum)     *100
#`12Sagaing2007to2016`     ["PercentOfTotalLandscapeChange"] <- prop.table(`12Sagaing2007to2016`$PixelSum)     *100
#`13Shan2007to2016`        ["PercentOfTotalLandscapeChange"] <- prop.table(`13Shan2007to2016`$PixelSum)        *100
#`14Tanintharyi2007to2016` ["PercentOfTotalLandscapeChange"] <- prop.table(`14Tanintharyi2007to2016`$PixelSum) *100
#`15Yangon2007to2016`      ["PercentOfTotalLandscapeChange"] <- prop.table(`15Yangon2007to2016`$PixelSum)      *100

# Testing 01 x random domain in each interval if the sums add up to 100%

#sum(`9Mon1996to2007`$"PercentOfTotalLandscapeChange")
#sum(`1Ayeyarwady2007to2016`$"PercentOfTotalLandscapeChange")



# - - -

# 8. Renaming all the Domain and Interval columns for all domains both intervals
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


# - - -

# 9. Merging all domains for each interval into one dataframe

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

# - - -

# 10. Plotting the stacked bar plots for each interval

#df$customer_id <- ifelse(df$customer %in% c('paramount', 'pixar'), 99, df$customer_id)
# ifelse Template: ifelse(condition, result if TRUE, result if FALSE)


# - - -

# 11. Replacing the Reference/New Class numerals to their names

?replace

# Replacing for Reference Class column (Interval 1)

AllDomainsInterval1$ReferenceClass <- replace(AllDomainsInterval1$ReferenceClass,
                                              AllDomainsInterval1$ReferenceClass==1, "BUA")
AllDomainsInterval1$ReferenceClass <- replace(AllDomainsInterval1$ReferenceClass,
                                              AllDomainsInterval1$ReferenceClass==2, "FOR")
AllDomainsInterval1$ReferenceClass <- replace(AllDomainsInterval1$ReferenceClass,
                                              AllDomainsInterval1$ReferenceClass==3, "IAS")
AllDomainsInterval1$ReferenceClass <- replace(AllDomainsInterval1$ReferenceClass,
                                              AllDomainsInterval1$ReferenceClass==4, "MNG")
AllDomainsInterval1$ReferenceClass <- replace(AllDomainsInterval1$ReferenceClass,
                                              AllDomainsInterval1$ReferenceClass==5, "OPM")
AllDomainsInterval1$ReferenceClass <- replace(AllDomainsInterval1$ReferenceClass,
                                              AllDomainsInterval1$ReferenceClass==6, "RPD")
AllDomainsInterval1$ReferenceClass <- replace(AllDomainsInterval1$ReferenceClass,
                                              AllDomainsInterval1$ReferenceClass==7, "RBR")
AllDomainsInterval1$ReferenceClass <- replace(AllDomainsInterval1$ReferenceClass,
                                              AllDomainsInterval1$ReferenceClass==8, "SHB")
AllDomainsInterval1$ReferenceClass <- replace(AllDomainsInterval1$ReferenceClass,
                                              AllDomainsInterval1$ReferenceClass==9, "WTR")
AllDomainsInterval1$ReferenceClass <- replace(AllDomainsInterval1$ReferenceClass,
                                              AllDomainsInterval1$ReferenceClass==10, "BRG")

# Repeating for NewClass column (Interval 1)

AllDomainsInterval1$NewClass <- replace(AllDomainsInterval1$NewClass,
                                              AllDomainsInterval1$NewClass==1, "BUA")
AllDomainsInterval1$NewClass <- replace(AllDomainsInterval1$NewClass,
                                              AllDomainsInterval1$NewClass==2, "FOR")
AllDomainsInterval1$NewClass <- replace(AllDomainsInterval1$NewClass,
                                              AllDomainsInterval1$NewClass==3, "IAS")
AllDomainsInterval1$NewClass <- replace(AllDomainsInterval1$NewClass,
                                              AllDomainsInterval1$NewClass==4, "MNG")
AllDomainsInterval1$NewClass <- replace(AllDomainsInterval1$NewClass,
                                              AllDomainsInterval1$NewClass==5, "OPM")
AllDomainsInterval1$NewClass <- replace(AllDomainsInterval1$NewClass,
                                              AllDomainsInterval1$NewClass==6, "RPD")
AllDomainsInterval1$NewClass <- replace(AllDomainsInterval1$NewClass,
                                              AllDomainsInterval1$NewClass==7, "RBR")
AllDomainsInterval1$NewClass <- replace(AllDomainsInterval1$NewClass,
                                              AllDomainsInterval1$NewClass==8, "SHB")
AllDomainsInterval1$NewClass <- replace(AllDomainsInterval1$NewClass,
                                              AllDomainsInterval1$NewClass==9, "WTR")
AllDomainsInterval1$NewClass <- replace(AllDomainsInterval1$NewClass,
                                              AllDomainsInterval1$NewClass==10, "BRG")

# Repeating for Reference class column (Interval 2)

AllDomainsInterval2$ReferenceClass <- replace(AllDomainsInterval2$ReferenceClass,
                                              AllDomainsInterval2$ReferenceClass==1, "BUA")
AllDomainsInterval2$ReferenceClass <- replace(AllDomainsInterval2$ReferenceClass,
                                              AllDomainsInterval2$ReferenceClass==2, "FOR")
AllDomainsInterval2$ReferenceClass <- replace(AllDomainsInterval2$ReferenceClass,
                                              AllDomainsInterval2$ReferenceClass==3, "IAS")
AllDomainsInterval2$ReferenceClass <- replace(AllDomainsInterval2$ReferenceClass,
                                              AllDomainsInterval2$ReferenceClass==4, "MNG")
AllDomainsInterval2$ReferenceClass <- replace(AllDomainsInterval2$ReferenceClass,
                                              AllDomainsInterval2$ReferenceClass==5, "OPM")
AllDomainsInterval2$ReferenceClass <- replace(AllDomainsInterval2$ReferenceClass,
                                              AllDomainsInterval2$ReferenceClass==6, "RPD")
AllDomainsInterval2$ReferenceClass <- replace(AllDomainsInterval2$ReferenceClass,
                                              AllDomainsInterval2$ReferenceClass==7, "RBR")
AllDomainsInterval2$ReferenceClass <- replace(AllDomainsInterval2$ReferenceClass,
                                              AllDomainsInterval2$ReferenceClass==8, "SHB")
AllDomainsInterval2$ReferenceClass <- replace(AllDomainsInterval2$ReferenceClass,
                                              AllDomainsInterval2$ReferenceClass==9, "WTR")
AllDomainsInterval2$ReferenceClass <- replace(AllDomainsInterval2$ReferenceClass,
                                              AllDomainsInterval2$ReferenceClass==10, "BRG")

# Repeating for NewClass column (Interval 2)

AllDomainsInterval2$NewClass <- replace(AllDomainsInterval2$NewClass,
                                        AllDomainsInterval2$NewClass==1, "BUA")
AllDomainsInterval2$NewClass <- replace(AllDomainsInterval2$NewClass,
                                        AllDomainsInterval2$NewClass==2, "FOR")
AllDomainsInterval2$NewClass <- replace(AllDomainsInterval2$NewClass,
                                        AllDomainsInterval2$NewClass==3, "IAS")
AllDomainsInterval2$NewClass <- replace(AllDomainsInterval2$NewClass,
                                        AllDomainsInterval2$NewClass==4, "MNG")
AllDomainsInterval2$NewClass <- replace(AllDomainsInterval2$NewClass,
                                        AllDomainsInterval2$NewClass==5, "OPM")
AllDomainsInterval2$NewClass <- replace(AllDomainsInterval2$NewClass,
                                        AllDomainsInterval2$NewClass==6, "RPD")
AllDomainsInterval2$NewClass <- replace(AllDomainsInterval2$NewClass,
                                        AllDomainsInterval2$NewClass==7, "RBR")
AllDomainsInterval2$NewClass <- replace(AllDomainsInterval2$NewClass,
                                        AllDomainsInterval2$NewClass==8, "SHB")
AllDomainsInterval2$NewClass <- replace(AllDomainsInterval2$NewClass,
                                        AllDomainsInterval2$NewClass==9, "WTR")
AllDomainsInterval2$NewClass <- replace(AllDomainsInterval2$NewClass,
                                        AllDomainsInterval2$NewClass==10, "BRG")

# - - -

# 12. Adding a new column that states the transition from Reference class to New class

#AllDomainsInterval1$Transition <- paste(AllDomainsInterval1$ReferenceClass, " to ", AllDomainsInterval1$NewClass)
#AllDomainsInterval2$Transition <- paste(AllDomainsInterval2$ReferenceClass, " to ", AllDomainsInterval2$NewClass)

# The data is now ready to be plotted, we save it to a .csv first

# - - -

# 13. Exporting the dataframe as a csv

#write.csv(AllDomainsInterval1, file = 'All Domains in Interval 1.csv')
#write.csv(AllDomainsInterval2, file = 'All Domains in Interval 2.csv')

# - - -

# 14. Stacked Area Plots 
#library(ggplot2)
#StackedBarPlotInterval1 <- ggplot() + geom_bar(data=AllDomainsInterval1, 
#                               aes(x=AllDomainsInterval1$Interval, 
#                                   y=AllDomainsInterval1$PercentOfTotalLandscapeChange, 
#                                   fill = AllDomainsInterval1$Transition), 
#                               stat ="identity", 
#                               position = position_stack())
#StackedBarPlotInterval1 <- StackedBarPlotInterval1  + facet_wrap(~AllDomainsInterval1$Domain)

#ggsave(StackedAreaPlotInterval1, file="C:/150918 all newest CSVs from QGIS SCP LCC batch/4. QGIS SCP LCC_Change Maps and CSVs/Stacked Bar Plots/Stacked Area Plot for Interval 1.pdf", dpi=300)

#test2 <- g + geom_bar(aes(x=AllDomainsInterval1$Interval,
 #                         y=AllDomainsInterval1$PercentOfTotalLandscapeChange,
  #                        ))

#plotCAT <- plotCAT  + labs(x="Category", y="Category Intensity (% of Category)")
#plotCAT <- plotCAT  + scale_fill_manual(values=c("#b43507","#8acd66"), labels=c("Loss Intensity","Gain Intensity"))
#plotCAT <- plotCAT  + theme(panel.grid.minor=element_blank())
#plotCAT <- plotCAT  + theme(legend.title=element_blank(), legend.position=c(0.9,0.9), legend.box="vertical")

# ------
# Update
# ------

# The following earlier steps were removed (as comments "#") because their purpose is no longer required in the current script

# These steps are;

# - Removal of rows that indicate land persistence
# - Calculation of the percentage contribution of a transition to overall landscape change
# - Plotting of these stacked bar plots intended to highlight changes of highest contribution to change over the landscape

# Continuing on, now our 2 separate dataframes have all transitions + persistence, 

# The next few lines of code will add the Area (km2) and Area (ha) columns for them both, and merge them as separate Sheets in an Excel.

# Adding Area (km2)

AllDomainsInterval1 ["Area (km2)"] <- AllDomainsInterval1$PixelSum*30*30/1000/1000
AllDomainsInterval2 ["Area (km2)"] <- AllDomainsInterval2$PixelSum*30*30/1000/1000

# Adding Area (ha)

#AllDomainsInterval1 ["Area (ha)"] <- AllDomainsInterval1$PixelSum*30*30/10000
#AllDomainsInterval2 ["Area (ha)"] <- AllDomainsInterval2$PixelSum*30*30/10000

# Re-ordering the columns in both dataframes in a more meaningful way

AllDomainsInterval1 <- AllDomainsInterval1[c(1,5,6,2,3,4,7)]
AllDomainsInterval2 <- AllDomainsInterval2[c(1,5,6,2,3,4,7)]

# Using "xlsx" package

library(xlsx)

write.xlsx(AllDomainsInterval1, file="C:/150918 all newest CSVs from QGIS SCP LCC batch/Included Land Persistence Rows and Added Area (km2 only)/LCCR Final.xlsx", sheetName ="Interval 1")
write.xlsx(AllDomainsInterval2, file="C:/150918 all newest CSVs from QGIS SCP LCC batch/Included Land Persistence Rows and Added Area (km2 only)/LCCR Final.xlsx", sheetName ="Interval 2", append = TRUE)

# The operation was successfully completed.

