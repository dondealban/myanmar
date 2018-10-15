# Creator: J Johanness

# Date: 2018-10-15

# Purpose: This script serves to combine all the tab-delimited .csv's from the QGIS SCP CR function into 1 single .csv/.xlsx where it is easy to filter the number of pixels in a class per region, and the proportion/percentage that it makes up over the landscape. This is so that it is easily accessible when doing the results for the stacked bar plots, sankey diagrams and the intensity analysis. This will be most helpful at the 1st stage, when analysing the stacked bar plots, and can assist in understanding the trend of net gain/loss low net change for a certain class in each timepoint, as opposed to looking at the LCCRs and summing them all up together, to understand the gains/losses (which is more aplicable for the Sankey step). This is because at the stage of the stacked area plots, we are more interested in net changes for each class in each timepoint, as opposed to knowing what the targets to and from what classes are these changes happening (that is the Sankey and the LCCR)

# START

# - - -

# 1. Define path to folder

path <- "C:/2018-10-05 Download of CRs/3.1. QGIS SCP CR"

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

# 4. Adding a Domain column for each region at each timepoint

DomainA0  <- rep('A. Myanmar', nrow(`0Myanmar1996CR`))
DomainA1  <- rep('B. Ayeyarwady', nrow(`1Ayeyarwady1996CR`))
DomainA2  <- rep('C. Bago', nrow(`2Bago1996CR`))
DomainA3  <- rep('D. Chin', nrow(`3Chin1996CR`))
DomainA4  <- rep('E. Kachin', nrow(`4Kachin1996CR`))
DomainA5  <- rep('F. Kayah', nrow(`5Kayah1996CR`))
DomainA6  <- rep('G. Kayin', nrow(`6Kayin1996CR`))
DomainA7  <- rep('H. Magway', nrow(`7Magway1996CR`))
DomainA8  <- rep('I. Mandalay', nrow(`8Mandalay1996CR`))
DomainA9  <- rep('J. Mon', nrow(`9Mon1996CR`))
DomainA10 <- rep('K. Naypyitaw', nrow(`10Naypyitaw1996CR`))
DomainA11 <- rep('L. Rakhine', nrow(`11Rakhine1996CR`))
DomainA12 <- rep('M. Sagaing', nrow(`12Sagaing1996CR`))
DomainA13 <- rep('N. Shan', nrow(`13Shan1996CR`))
DomainA14 <- rep('O. Tanintharyi', nrow(`14Tanintharyi1996CR`))
DomainA15 <- rep('P. Yangon', nrow(`15Yangon1996CR`))

DomainA16  <- rep('A. Myanmar', nrow(`0Myanmar2007CR`))
DomainA17  <- rep('B. Ayeyarwady', nrow(`1Ayeyarwady2007CR`))
DomainA18  <- rep('C. Bago', nrow(`2Bago2007CR`))
DomainA19  <- rep('D. Chin', nrow(`3Chin2007CR`))
DomainA20  <- rep('E. Kachin', nrow(`4Kachin2007CR`))
DomainA21  <- rep('F. Kayah', nrow(`5Kayah2007CR`))
DomainA22  <- rep('G. Kayin', nrow(`6Kayin2007CR`))
DomainA23  <- rep('H. Magway', nrow(`7Magway2007CR`))
DomainA24  <- rep('I. Mandalay', nrow(`8Mandalay2007CR`))
DomainA25  <- rep('J. Mon', nrow(`9Mon2007CR`))
DomainA26  <- rep('K. Naypyitaw', nrow(`10Naypyitaw2007CR`))
DomainA27  <- rep('L. Rakhine', nrow(`11Rakhine2007CR`))
DomainA28  <- rep('M. Sagaing', nrow(`12Sagaing2007CR`))
DomainA29  <- rep('N. Shan', nrow(`13Shan2007CR`))
DomainA30  <- rep('O. Tanintharyi', nrow(`14Tanintharyi2007CR`))
DomainA31  <- rep('P. Yangon', nrow(`15Yangon2007CR`))

DomainA32  <- rep('A. Myanmar', nrow(`0Myanmar2016CR`))
DomainA33  <- rep('B. Ayeyarwady', nrow(`1Ayeyarwady2016CR`))
DomainA34  <- rep('C. Bago', nrow(`2Bago2016CR`))
DomainA35  <- rep('D. Chin', nrow(`3Chin2016CR`))
DomainA36  <- rep('E. Kachin', nrow(`4Kachin2016CR`))
DomainA37  <- rep('F. Kayah', nrow(`5Kayah2016CR`))
DomainA38  <- rep('G. Kayin', nrow(`6Kayin2016CR`))
DomainA39  <- rep('H. Magway', nrow(`7Magway2016CR`))
DomainA40  <- rep('I. Mandalay', nrow(`8Mandalay2016CR`))
DomainA41  <- rep('J. Mon', nrow(`9Mon2016CR`))
DomainA42  <- rep('K. Naypyitaw', nrow(`10Naypyitaw2016CR`))
DomainA43  <- rep('L. Rakhine', nrow(`11Rakhine2016CR`))
DomainA44  <- rep('M. Sagaing', nrow(`12Sagaing2016CR`))
DomainA45  <- rep('N. Shan', nrow(`13Shan2016CR`))
DomainA46  <- rep('O. Tanintharyi', nrow(`14Tanintharyi2016CR`))
DomainA47  <- rep('P. Yangon', nrow(`15Yangon2016CR`))

# 5. Adding a Year column for each region at each timepoint

IntervalA0  <- rep('1996', nrow(`0Myanmar1996CR`))
IntervalA1  <- rep('1996', nrow(`1Ayeyarwady1996CR`))
IntervalA2  <- rep('1996', nrow(`2Bago1996CR`))
IntervalA3  <- rep('1996', nrow(`3Chin1996CR`))
IntervalA4  <- rep('1996', nrow(`4Kachin1996CR`))
IntervalA5  <- rep('1996', nrow(`5Kayah1996CR`))
IntervalA6  <- rep('1996', nrow(`6Kayin1996CR`))
IntervalA7  <- rep('1996', nrow(`7Magway1996CR`))
IntervalA8  <- rep('1996', nrow(`8Mandalay1996CR`))
IntervalA9  <- rep('1996', nrow(`9Mon1996CR`))
IntervalA10 <- rep('1996', nrow(`10Naypyitaw1996CR`))
IntervalA11 <- rep('1996', nrow(`11Rakhine1996CR`))
IntervalA12 <- rep('1996', nrow(`12Sagaing1996CR`))
IntervalA13 <- rep('1996', nrow(`13Shan1996CR`))
IntervalA14 <- rep('1996', nrow(`14Tanintharyi1996CR`))
IntervalA15 <- rep('1996', nrow(`15Yangon1996CR`))

IntervalA16  <- rep('2007', nrow(`0Myanmar2007CR`))
IntervalA17  <- rep('2007', nrow(`1Ayeyarwady2007CR`))
IntervalA18  <- rep('2007', nrow(`2Bago2007CR`))
IntervalA19  <- rep('2007', nrow(`3Chin2007CR`))
IntervalA20  <- rep('2007', nrow(`4Kachin2007CR`))
IntervalA21  <- rep('2007', nrow(`5Kayah2007CR`))
IntervalA22  <- rep('2007', nrow(`6Kayin2007CR`))
IntervalA23  <- rep('2007', nrow(`7Magway2007CR`))
IntervalA24  <- rep('2007', nrow(`8Mandalay2007CR`))
IntervalA25  <- rep('2007', nrow(`9Mon2007CR`))
IntervalA26  <- rep('2007', nrow(`10Naypyitaw2007CR`))
IntervalA27  <- rep('2007', nrow(`11Rakhine2007CR`))
IntervalA28  <- rep('2007', nrow(`12Sagaing2007CR`))
IntervalA29  <- rep('2007', nrow(`13Shan2007CR`))
IntervalA30  <- rep('2007', nrow(`14Tanintharyi2007CR`))
IntervalA31  <- rep('2007', nrow(`15Yangon2007CR`))

IntervalA32  <- rep('2016', nrow(`0Myanmar2016CR`))
IntervalA33  <- rep('2016', nrow(`1Ayeyarwady2016CR`))
IntervalA34  <- rep('2016', nrow(`2Bago2016CR`))
IntervalA35  <- rep('2016', nrow(`3Chin2016CR`))
IntervalA36  <- rep('2016', nrow(`4Kachin2016CR`))
IntervalA37  <- rep('2016', nrow(`5Kayah2016CR`))
IntervalA38  <- rep('2016', nrow(`6Kayin2016CR`))
IntervalA39  <- rep('2016', nrow(`7Magway2016CR`))
IntervalA40  <- rep('2016', nrow(`8Mandalay2016CR`))
IntervalA41  <- rep('2016', nrow(`9Mon2016CR`))
IntervalA42  <- rep('2016', nrow(`10Naypyitaw2016CR`))
IntervalA43  <- rep('2016', nrow(`11Rakhine2016CR`))
IntervalA44  <- rep('2016', nrow(`12Sagaing2016CR`))
IntervalA45  <- rep('2016', nrow(`13Shan2016CR`))
IntervalA46  <- rep('2016', nrow(`14Tanintharyi2016CR`))
IntervalA47  <- rep('2016', nrow(`15Yangon2016CR`))

# 6. C-binding the DomainXX and IntervalXX columns

`0Myanmar1996CR`      <- cbind(`0Myanmar1996CR`, DomainA0)
`0Myanmar1996CR`      <- cbind(`0Myanmar1996CR`, IntervalA0)
`1Ayeyarwady1996CR`   <- cbind(`1Ayeyarwady1996CR`, DomainA1)
`1Ayeyarwady1996CR`   <- cbind(`1Ayeyarwady1996CR`, IntervalA1)
`2Bago1996CR`         <- cbind(`2Bago1996CR`, DomainA2)
`2Bago1996CR`         <- cbind(`2Bago1996CR`, IntervalA2)
`3Chin1996CR`         <- cbind(`3Chin1996CR`, DomainA3)
`3Chin1996CR`         <- cbind(`3Chin1996CR`, IntervalA3)
`4Kachin1996CR`       <- cbind(`4Kachin1996CR`, DomainA4)
`4Kachin1996CR`       <- cbind(`4Kachin1996CR`, IntervalA4)
`5Kayah1996CR`        <- cbind(`5Kayah1996CR`, DomainA5)
`5Kayah1996CR`        <- cbind(`5Kayah1996CR`, IntervalA5)
`6Kayin1996CR`        <- cbind(`6Kayin1996CR`, DomainA6)
`6Kayin1996CR`        <- cbind(`6Kayin1996CR`, IntervalA6)
`7Magway1996CR`       <- cbind(`7Magway1996CR`, DomainA7)
`7Magway1996CR`       <- cbind(`7Magway1996CR`, IntervalA7)
`8Mandalay1996CR`     <- cbind(`8Mandalay1996CR`, DomainA8)
`8Mandalay1996CR`     <- cbind(`8Mandalay1996CR`, IntervalA8)
`9Mon1996CR`          <- cbind(`9Mon1996CR`, DomainA9)
`9Mon1996CR`          <- cbind(`9Mon1996CR`, IntervalA9)
`10Naypyitaw1996CR`   <- cbind(`10Naypyitaw1996CR`, DomainA10)
`10Naypyitaw1996CR`   <- cbind(`10Naypyitaw1996CR`, IntervalA10)
`11Rakhine1996CR`     <- cbind(`11Rakhine1996CR`, DomainA11)
`11Rakhine1996CR`     <- cbind(`11Rakhine1996CR`, IntervalA11)
`12Sagaing1996CR`     <- cbind(`12Sagaing1996CR`, DomainA12)
`12Sagaing1996CR`     <- cbind(`12Sagaing1996CR`, IntervalA12)
`13Shan1996CR`        <- cbind(`13Shan1996CR`, DomainA13)
`13Shan1996CR`        <- cbind(`13Shan1996CR`, IntervalA13)
`14Tanintharyi1996CR` <- cbind(`14Tanintharyi1996CR`, DomainA14)
`14Tanintharyi1996CR` <- cbind(`14Tanintharyi1996CR`, IntervalA14)
`15Yangon1996CR`      <- cbind(`15Yangon1996CR`, DomainA15)
`15Yangon1996CR`      <- cbind(`15Yangon1996CR`, IntervalA15)

`0Myanmar2007CR`      <- cbind(`0Myanmar2007CR`, DomainA16)
`0Myanmar2007CR`      <- cbind(`0Myanmar2007CR`, IntervalA16)
`1Ayeyarwady2007CR`   <- cbind(`1Ayeyarwady2007CR`, DomainA17)
`1Ayeyarwady2007CR`   <- cbind(`1Ayeyarwady2007CR`, IntervalA17)
`2Bago2007CR`         <- cbind(`2Bago2007CR`, DomainA18)
`2Bago2007CR`         <- cbind(`2Bago2007CR`, IntervalA18)
`3Chin2007CR`         <- cbind(`3Chin2007CR`, DomainA19)
`3Chin2007CR`         <- cbind(`3Chin2007CR`, IntervalA19)
`4Kachin2007CR`       <- cbind(`4Kachin2007CR`, DomainA20)
`4Kachin2007CR`       <- cbind(`4Kachin2007CR`, IntervalA20)
`5Kayah2007CR`        <- cbind(`5Kayah2007CR`, DomainA21)
`5Kayah2007CR`        <- cbind(`5Kayah2007CR`, IntervalA21)
`6Kayin2007CR`        <- cbind(`6Kayin2007CR`, DomainA22)
`6Kayin2007CR`        <- cbind(`6Kayin2007CR`, IntervalA22)
`7Magway2007CR`       <- cbind(`7Magway2007CR`, DomainA23)
`7Magway2007CR`       <- cbind(`7Magway2007CR`, IntervalA23)
`8Mandalay2007CR`     <- cbind(`8Mandalay2007CR`, DomainA24)
`8Mandalay2007CR`     <- cbind(`8Mandalay2007CR`, IntervalA24)
`9Mon2007CR`          <- cbind(`9Mon2007CR`, DomainA25)
`9Mon2007CR`          <- cbind(`9Mon2007CR`, IntervalA25)
`10Naypyitaw2007CR`   <- cbind(`10Naypyitaw2007CR`, DomainA26)
`10Naypyitaw2007CR`   <- cbind(`10Naypyitaw2007CR`, IntervalA26)
`11Rakhine2007CR`     <- cbind(`11Rakhine2007CR`, DomainA27)
`11Rakhine2007CR`     <- cbind(`11Rakhine2007CR`, IntervalA27)
`12Sagaing2007CR`     <- cbind(`12Sagaing2007CR`, DomainA28)
`12Sagaing2007CR`     <- cbind(`12Sagaing2007CR`, IntervalA28)
`13Shan2007CR`        <- cbind(`13Shan2007CR`, DomainA29)
`13Shan2007CR`        <- cbind(`13Shan2007CR`, IntervalA29)
`14Tanintharyi2007CR` <- cbind(`14Tanintharyi2007CR`, DomainA30)
`14Tanintharyi2007CR` <- cbind(`14Tanintharyi2007CR`, IntervalA30)
`15Yangon2007CR`      <- cbind(`15Yangon2007CR`, DomainA31)
`15Yangon2007CR`      <- cbind(`15Yangon2007CR`, IntervalA31)

`0Myanmar2016CR`      <- cbind(`0Myanmar2016CR`, DomainA32)
`0Myanmar2016CR`      <- cbind(`0Myanmar2016CR`, IntervalA32)
`1Ayeyarwady2016CR`   <- cbind(`1Ayeyarwady2016CR`, DomainA33)
`1Ayeyarwady2016CR`   <- cbind(`1Ayeyarwady2016CR`, IntervalA33)
`2Bago2016CR`         <- cbind(`2Bago2016CR`, DomainA34)
`2Bago2016CR`         <- cbind(`2Bago2016CR`, IntervalA34)
`3Chin2016CR`         <- cbind(`3Chin2016CR`, DomainA35)
`3Chin2016CR`         <- cbind(`3Chin2016CR`, IntervalA35)
`4Kachin2016CR`       <- cbind(`4Kachin2016CR`, DomainA36)
`4Kachin2016CR`       <- cbind(`4Kachin2016CR`, IntervalA36)
`5Kayah2016CR`        <- cbind(`5Kayah2016CR`, DomainA37)
`5Kayah2016CR`        <- cbind(`5Kayah2016CR`, IntervalA37)
`6Kayin2016CR`        <- cbind(`6Kayin2016CR`, DomainA38)
`6Kayin2016CR`        <- cbind(`6Kayin2016CR`, IntervalA38)
`7Magway2016CR`       <- cbind(`7Magway2016CR`, DomainA39)
`7Magway2016CR`       <- cbind(`7Magway2016CR`, IntervalA39)
`8Mandalay2016CR`     <- cbind(`8Mandalay2016CR`, DomainA40)
`8Mandalay2016CR`     <- cbind(`8Mandalay2016CR`, IntervalA40)
`9Mon2016CR`          <- cbind(`9Mon2016CR`, DomainA41)
`9Mon2016CR`          <- cbind(`9Mon2016CR`, IntervalA41)
`10Naypyitaw2016CR`   <- cbind(`10Naypyitaw2016CR`, DomainA42)
`10Naypyitaw2016CR`   <- cbind(`10Naypyitaw2016CR`, IntervalA42)
`11Rakhine2016CR`     <- cbind(`11Rakhine2016CR`, DomainA43)
`11Rakhine2016CR`     <- cbind(`11Rakhine2016CR`, IntervalA43)
`12Sagaing2016CR`     <- cbind(`12Sagaing2016CR`, DomainA44)
`12Sagaing2016CR`     <- cbind(`12Sagaing2016CR`, IntervalA44)
`13Shan2016CR`        <- cbind(`13Shan2016CR`, DomainA45)
`13Shan2016CR`        <- cbind(`13Shan2016CR`, IntervalA45)
`14Tanintharyi2016CR` <- cbind(`14Tanintharyi2016CR`, DomainA46)
`14Tanintharyi2016CR` <- cbind(`14Tanintharyi2016CR`, IntervalA46)
`15Yangon2016CR`      <- cbind(`15Yangon2016CR`, DomainA47)
`15Yangon2016CR`      <- cbind(`15Yangon2016CR`, IntervalA47)

# Before I can merge them all together, I need to rename the DomainXX and IntervalXX to a common header so that the merge will be successfull

# 7. Renaming the headers for col 5 and 6 to Domain and Year respectively.

names(`0Myanmar1996CR`)     [5] <- "Domain"
names(`1Ayeyarwady1996CR`)  [5] <- "Domain"
names(`2Bago1996CR`)        [5] <- "Domain"
names(`3Chin1996CR`)        [5] <- "Domain"
names(`4Kachin1996CR`)      [5] <- "Domain"
names(`5Kayah1996CR`)       [5] <- "Domain"
names(`6Kayin1996CR`)       [5] <- "Domain"
names(`7Magway1996CR`)      [5] <- "Domain"
names(`8Mandalay1996CR`)    [5] <- "Domain"
names(`9Mon1996CR`)         [5] <- "Domain"
names(`10Naypyitaw1996CR`)  [5] <- "Domain"
names(`11Rakhine1996CR`)    [5] <- "Domain"
names(`12Sagaing1996CR`)    [5] <- "Domain"
names(`13Shan1996CR`)       [5] <- "Domain"
names(`14Tanintharyi1996CR`)[5] <- "Domain"
names(`15Yangon1996CR`)     [5] <- "Domain"

names(`0Myanmar2007CR`)     [5] <- "Domain"
names(`1Ayeyarwady2007CR`)  [5] <- "Domain"
names(`2Bago2007CR`)        [5] <- "Domain"
names(`3Chin2007CR`)        [5] <- "Domain"
names(`4Kachin2007CR`)      [5] <- "Domain"
names(`5Kayah2007CR`)       [5] <- "Domain"
names(`6Kayin2007CR`)       [5] <- "Domain"
names(`7Magway2007CR`)      [5] <- "Domain"
names(`8Mandalay2007CR`)    [5] <- "Domain"
names(`9Mon2007CR`)         [5] <- "Domain"
names(`10Naypyitaw2007CR`)  [5] <- "Domain"
names(`11Rakhine2007CR`)    [5] <- "Domain"
names(`12Sagaing2007CR`)    [5] <- "Domain"
names(`13Shan2007CR`)       [5] <- "Domain"
names(`14Tanintharyi2007CR`)[5] <- "Domain"
names(`15Yangon2007CR`)     [5] <- "Domain"

names(`0Myanmar2016CR`)     [5] <- "Domain"
names(`1Ayeyarwady2016CR`)  [5] <- "Domain"
names(`2Bago2016CR`)        [5] <- "Domain"
names(`3Chin2016CR`)        [5] <- "Domain"
names(`4Kachin2016CR`)      [5] <- "Domain"
names(`5Kayah2016CR`)       [5] <- "Domain"
names(`6Kayin2016CR`)       [5] <- "Domain"
names(`7Magway2016CR`)      [5] <- "Domain"
names(`8Mandalay2016CR`)    [5] <- "Domain"
names(`9Mon2016CR`)         [5] <- "Domain"
names(`10Naypyitaw2016CR`)  [5] <- "Domain"
names(`11Rakhine2016CR`)    [5] <- "Domain"
names(`12Sagaing2016CR`)    [5] <- "Domain"
names(`13Shan2016CR`)       [5] <- "Domain"
names(`14Tanintharyi2016CR`)[5] <- "Domain"
names(`15Yangon2016CR`)     [5] <- "Domain"

names(`0Myanmar1996CR`)     [6] <- "Year"
names(`1Ayeyarwady1996CR`)  [6] <- "Year"
names(`2Bago1996CR`)        [6] <- "Year"
names(`3Chin1996CR`)        [6] <- "Year"
names(`4Kachin1996CR`)      [6] <- "Year"
names(`5Kayah1996CR`)       [6] <- "Year"
names(`6Kayin1996CR`)       [6] <- "Year"
names(`7Magway1996CR`)      [6] <- "Year"
names(`8Mandalay1996CR`)    [6] <- "Year"
names(`9Mon1996CR`)         [6] <- "Year"
names(`10Naypyitaw1996CR`)  [6] <- "Year"
names(`11Rakhine1996CR`)    [6] <- "Year"
names(`12Sagaing1996CR`)    [6] <- "Year"
names(`13Shan1996CR`)       [6] <- "Year"
names(`14Tanintharyi1996CR`)[6] <- "Year"
names(`15Yangon1996CR`)     [6] <- "Year"

names(`0Myanmar2007CR`)     [6] <- "Year"
names(`1Ayeyarwady2007CR`)  [6] <- "Year"
names(`2Bago2007CR`)        [6] <- "Year"
names(`3Chin2007CR`)        [6] <- "Year"
names(`4Kachin2007CR`)      [6] <- "Year"
names(`5Kayah2007CR`)       [6] <- "Year"
names(`6Kayin2007CR`)       [6] <- "Year"
names(`7Magway2007CR`)      [6] <- "Year"
names(`8Mandalay2007CR`)    [6] <- "Year"
names(`9Mon2007CR`)         [6] <- "Year"
names(`10Naypyitaw2007CR`)  [6] <- "Year"
names(`11Rakhine2007CR`)    [6] <- "Year"
names(`12Sagaing2007CR`)    [6] <- "Year"
names(`13Shan2007CR`)       [6] <- "Year"
names(`14Tanintharyi2007CR`)[6] <- "Year"
names(`15Yangon2007CR`)     [6] <- "Year"

names(`0Myanmar2016CR`)     [6] <- "Year"
names(`1Ayeyarwady2016CR`)  [6] <- "Year"
names(`2Bago2016CR`)        [6] <- "Year"
names(`3Chin2016CR`)        [6] <- "Year"
names(`4Kachin2016CR`)      [6] <- "Year"
names(`5Kayah2016CR`)       [6] <- "Year"
names(`6Kayin2016CR`)       [6] <- "Year"
names(`7Magway2016CR`)      [6] <- "Year"
names(`8Mandalay2016CR`)    [6] <- "Year"
names(`9Mon2016CR`)         [6] <- "Year"
names(`10Naypyitaw2016CR`)  [6] <- "Year"
names(`11Rakhine2016CR`)    [6] <- "Year"
names(`12Sagaing2016CR`)    [6] <- "Year"
names(`13Shan2016CR`)       [6] <- "Year"
names(`14Tanintharyi2016CR`)[6] <- "Year"
names(`15Yangon2016CR`)     [6] <- "Year"

# 8. Merging them all into 1 dataframe

AllClassificationReports <- do.call("rbind", list(`0Myanmar1996CR`
                                             ,`1Ayeyarwady1996CR`
                                             ,`2Bago1996CR`
                                             ,`3Chin1996CR`
                                             ,`4Kachin1996CR`
                                             ,`5Kayah1996CR`
                                             ,`6Kayin1996CR`
                                             ,`7Magway1996CR`
                                             ,`8Mandalay1996CR`
                                             ,`9Mon1996CR`
                                             ,`10Naypyitaw1996CR`
                                             ,`11Rakhine1996CR`
                                             ,`12Sagaing1996CR`
                                             ,`13Shan1996CR`
                                             ,`14Tanintharyi1996CR`
                                             ,`15Yangon1996CR`
                                             ,`0Myanmar2007CR`
                                             ,`1Ayeyarwady2007CR`
                                             ,`2Bago2007CR`
                                             ,`3Chin2007CR`
                                             ,`4Kachin2007CR`
                                             ,`5Kayah2007CR`
                                             ,`6Kayin2007CR`
                                             ,`7Magway2007CR`
                                             ,`8Mandalay2007CR`
                                             ,`9Mon2007CR`
                                             ,`10Naypyitaw2007CR`
                                             ,`11Rakhine2007CR`
                                             ,`12Sagaing2007CR`
                                             ,`13Shan2007CR`
                                             ,`14Tanintharyi2007CR`
                                             ,`15Yangon2007CR`
                                             ,`0Myanmar2016CR`
                                             ,`1Ayeyarwady2016CR`
                                             ,`2Bago2016CR`
                                             ,`3Chin2016CR`
                                             ,`4Kachin2016CR`
                                             ,`5Kayah2016CR`
                                             ,`6Kayin2016CR`
                                             ,`7Magway2016CR`
                                             ,`8Mandalay2016CR`
                                             ,`9Mon2016CR`
                                             ,`10Naypyitaw2016CR`
                                             ,`11Rakhine2016CR`
                                             ,`12Sagaing2016CR`
                                             ,`13Shan2016CR`
                                             ,`14Tanintharyi2016CR`
                                             ,`15Yangon2016CR`))

# 9. Renaming all the numeric class categories to class names

AllClassificationReports$Class <- replace(AllClassificationReports$Class,
                                              AllClassificationReports$Class==1, "BUA")
AllClassificationReports$Class <- replace(AllClassificationReports$Class,
                                              AllClassificationReports$Class==2, "FOR")
AllClassificationReports$Class <- replace(AllClassificationReports$Class,
                                              AllClassificationReports$Class==3, "IAS")
AllClassificationReports$Class <- replace(AllClassificationReports$Class,
                                              AllClassificationReports$Class==4, "MNG")
AllClassificationReports$Class <- replace(AllClassificationReports$Class,
                                              AllClassificationReports$Class==5, "OPM")
AllClassificationReports$Class <- replace(AllClassificationReports$Class,
                                              AllClassificationReports$Class==6, "RPD")
AllClassificationReports$Class <- replace(AllClassificationReports$Class,
                                              AllClassificationReports$Class==7, "RBR")
AllClassificationReports$Class <- replace(AllClassificationReports$Class,
                                              AllClassificationReports$Class==8, "SHB")
AllClassificationReports$Class <- replace(AllClassificationReports$Class,
                                              AllClassificationReports$Class==9, "WTR")
AllClassificationReports$Class <- replace(AllClassificationReports$Class,
                                              AllClassificationReports$Class==10, "BRG")

# 10. Reordering the columns in a more meaningful sense

AllClassificationReports <- AllClassificationReports[c(5,6,1,2,3,4)]

# 11. Adding an area in hectares column

AllClassificationReports ["Area (ha)"] <- AllClassificationReports$PixelSum*30*30/10000
AllClassificationReports ["Area (km2)"] <- AllClassificationReports$PixelSum*30*30/1000/1000

# 12. Keeping every column except the Area(Degrees) that is calculated by default in QGIS SCP CR

AllClassificationReports <- subset(AllClassificationReports, select = c(1,2,3,4,5,7,8))

# 11. Saving this combined dataframe to a .csv

write.csv(AllClassificationReports, file = "C:/2018-10-05 Download of CRs/3.1. QGIS SCP CR/All Classification Reports.csv")

