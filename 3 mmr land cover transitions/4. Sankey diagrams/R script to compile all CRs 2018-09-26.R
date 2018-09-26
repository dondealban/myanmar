# Creator : J Johanness
# Date : 2018-09-26

# Purpose: 

# This script compiles all the Classification Reports (CRs) generated via QGIS SCP CR function which were stored in a local folder in a tab-delimited .csv format. The Area column calculated from QGIS is removed and replaced with Area in (km2) and (ha). The class numerics are also changed to represent the class names, compliant with the LCCS classification used in the raster maps that the QGIS SCP CR function was executed upon. 

# An alternate purpose of generating this in RStudio, is to remind myself to never touch the raw data, and more project-specifically, to easily browse through the CRs and compare such land cover statistics to those reported in other studies.


# 1. Define path to folder

path <- "C:/090918 MMR LULC/3.1. QGIS SCP CR/"

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

# 4.1 Create Domain columns for all 1996 CRs

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

# - - -

# 4.2 Create Domain columns for all 2007 CRs

DomainB0  <- rep('A. Myanmar', nrow(`0Myanmar2007CR`))
DomainB1  <- rep('B. Ayeyarwady', nrow(`1Ayeyarwady2007CR`))
DomainB2  <- rep('C. Bago', nrow(`2Bago2007CR`))
DomainB3  <- rep('D. Chin', nrow(`3Chin2007CR`))
DomainB4  <- rep('E. Kachin', nrow(`4Kachin2007CR`))
DomainB5  <- rep('F. Kayah', nrow(`5Kayah2007CR`))
DomainB6  <- rep('G. Kayin', nrow(`6Kayin2007CR`))
DomainB7  <- rep('H. Magway', nrow(`7Magway2007CR`))
DomainB8  <- rep('I. Mandalay', nrow(`8Mandalay2007CR`))
DomainB9  <- rep('J. Mon', nrow(`9Mon2007CR`))
DomainB10 <- rep('K. Naypyitaw', nrow(`10Naypyitaw2007CR`))
DomainB11 <- rep('L. Rakhine', nrow(`11Rakhine2007CR`))
DomainB12 <- rep('M. Sagaing', nrow(`12Sagaing2007CR`))
DomainB13 <- rep('N. Shan', nrow(`13Shan2007CR`))
DomainB14 <- rep('O. Tanintharyi', nrow(`14Tanintharyi2007CR`))
DomainB15 <- rep('P. Yangon', nrow(`15Yangon2007CR`))

# - - -

# 4.3 Create Domain columns for all 2016 CRs

DomainC0  <- rep('A. Myanmar', nrow(`0Myanmar2016CR`))
DomainC1  <- rep('B. Ayeyarwady', nrow(`1Ayeyarwady2016CR`))
DomainC2  <- rep('C. Bago', nrow(`2Bago2016CR`))
DomainC3  <- rep('D. Chin', nrow(`3Chin2016CR`))
DomainC4  <- rep('E. Kachin', nrow(`4Kachin2016CR`))
DomainC5  <- rep('F. Kayah', nrow(`5Kayah2016CR`))
DomainC6  <- rep('G. Kayin', nrow(`6Kayin2016CR`))
DomainC7  <- rep('H. Magway', nrow(`7Magway2016CR`))
DomainC8  <- rep('I. Mandalay', nrow(`8Mandalay2016CR`))
DomainC9  <- rep('J. Mon', nrow(`9Mon2016CR`))
DomainC10 <- rep('K. Naypyitaw', nrow(`10Naypyitaw2016CR`))
DomainC11 <- rep('L. Rakhine', nrow(`11Rakhine2016CR`))
DomainC12 <- rep('M. Sagaing', nrow(`12Sagaing2016CR`))
DomainC13 <- rep('N. Shan', nrow(`13Shan2016CR`))
DomainC14 <- rep('O. Tanintharyi', nrow(`14Tanintharyi2016CR`))
DomainC15 <- rep('P. Yangon', nrow(`15Yangon2016CR`))

# - - -

# 5.1. Binding the Domain A_ columns to the 1996 dataframes

`0Myanmar1996CR`     <- cbind(`0Myanmar1996CR`, DomainA0)
`1Ayeyarwady1996CR`  <- cbind(`1Ayeyarwady1996CR`, DomainA1)
`2Bago1996CR`        <- cbind(`2Bago1996CR`, DomainA2)
`3Chin1996CR`        <- cbind(`3Chin1996CR`, DomainA3)
`4Kachin1996CR`      <- cbind(`4Kachin1996CR`, DomainA4)
`5Kayah1996CR`       <- cbind(`5Kayah1996CR`, DomainA5)
`6Kayin1996CR`       <- cbind(`6Kayin1996CR`, DomainA6)
`7Magway1996CR`      <- cbind(`7Magway1996CR`, DomainA7)
`8Mandalay1996CR`    <- cbind(`8Mandalay1996CR`, DomainA8)
`9Mon1996CR`         <- cbind(`9Mon1996CR`, DomainA9)
`10Naypyitaw1996CR`  <- cbind(`10Naypyitaw1996CR`, DomainA10)
`11Rakhine1996CR`    <- cbind(`11Rakhine1996CR`, DomainA11)
`12Sagaing1996CR`    <- cbind(`12Sagaing1996CR`, DomainA12)
`13Shan1996CR`       <- cbind(`13Shan1996CR`, DomainA13)
`14Tanintharyi1996CR`<- cbind(`14Tanintharyi1996CR`, DomainA14)
`15Yangon1996CR`     <- cbind(`15Yangon1996CR`, DomainA15)

# - - -

# 5.2. Binding the Domain B_ columns to the 2007 dataframes

`0Myanmar2007CR`     <- cbind(`0Myanmar2007CR`, DomainB0)
`1Ayeyarwady2007CR`  <- cbind(`1Ayeyarwady2007CR`, DomainB1)
`2Bago2007CR`        <- cbind(`2Bago2007CR`, DomainB2)
`3Chin2007CR`        <- cbind(`3Chin2007CR`, DomainB3)
`4Kachin2007CR`      <- cbind(`4Kachin2007CR`, DomainB4)
`5Kayah2007CR`       <- cbind(`5Kayah2007CR`, DomainB5)
`6Kayin2007CR`       <- cbind(`6Kayin2007CR`, DomainB6)
`7Magway2007CR`      <- cbind(`7Magway2007CR`, DomainB7)
`8Mandalay2007CR`    <- cbind(`8Mandalay2007CR`, DomainB8)
`9Mon2007CR`         <- cbind(`9Mon2007CR`, DomainB9)
`10Naypyitaw2007CR`  <- cbind(`10Naypyitaw2007CR`, DomainB10)
`11Rakhine2007CR`    <- cbind(`11Rakhine2007CR`, DomainB11)
`12Sagaing2007CR`    <- cbind(`12Sagaing2007CR`, DomainB12)
`13Shan2007CR`       <- cbind(`13Shan2007CR`, DomainB13)
`14Tanintharyi2007CR`<- cbind(`14Tanintharyi2007CR`, DomainB14)
`15Yangon2007CR`     <- cbind(`15Yangon2007CR`, DomainB15)

# - - -

# 5.3. Binding the Domain C_ columns to the 2016 dataframes

`0Myanmar2016CR`     <- cbind(`0Myanmar2016CR`, DomainC0)
`1Ayeyarwady2016CR`  <- cbind(`1Ayeyarwady2016CR`, DomainC1)
`2Bago2016CR`        <- cbind(`2Bago2016CR`, DomainC2)
`3Chin2016CR`        <- cbind(`3Chin2016CR`, DomainC3)
`4Kachin2016CR`      <- cbind(`4Kachin2016CR`, DomainC4)
`5Kayah2016CR`       <- cbind(`5Kayah2016CR`, DomainC5)
`6Kayin2016CR`       <- cbind(`6Kayin2016CR`, DomainC6)
`7Magway2016CR`      <- cbind(`7Magway2016CR`, DomainC7)
`8Mandalay2016CR`    <- cbind(`8Mandalay2016CR`, DomainC8)
`9Mon2016CR`         <- cbind(`9Mon2016CR`, DomainC9)
`10Naypyitaw2016CR`  <- cbind(`10Naypyitaw2016CR`, DomainC10)
`11Rakhine2016CR`    <- cbind(`11Rakhine2016CR`, DomainC11)
`12Sagaing2016CR`    <- cbind(`12Sagaing2016CR`, DomainC12)
`13Shan2016CR`       <- cbind(`13Shan2016CR`, DomainC13)
`14Tanintharyi2016CR`<- cbind(`14Tanintharyi2016CR`, DomainC14)
`15Yangon2016CR`     <- cbind(`15Yangon2016CR`, DomainC15)

# - - -

# 6. Renaming all the domain column names to make them compatible for merging

# Note: there is probably a way to merge dataframes while ignoring the header names (to look into)

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

# - - -

# 7. Merging the dataframes for each domain to be under one timepoint

AllDomains1996CR <- do.call("rbind", list(`0Myanmar1996CR`
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
                                          ,`15Yangon1996CR`))

AllDomains2007CR <- do.call("rbind", list(`0Myanmar2007CR`
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
                                          ,`15Yangon2007CR`))

AllDomains2016CR <- do.call("rbind", list(`0Myanmar2016CR`
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

# Now that CRs per timepoint are merged, we can add a column that states which timepoint the CR is for

# - - -

# 8. Create 'Year' column first, before you can Cbind it

Timepoint1996  <- rep('1996', nrow(`AllDomains1996CR`))
Timepoint2007  <- rep('2007', nrow(`AllDomains2007CR`))
Timepoint2016  <- rep('2016', nrow(`AllDomains2016CR`))

# - - -

# 9. Cbinding this new column to each of the merged dataframes for all domains at each timepoint

`AllDomains1996CR`      <- cbind(`AllDomains1996CR`, Timepoint1996)
`AllDomains2007CR`      <- cbind(`AllDomains2007CR`, Timepoint2007)
`AllDomains2016CR`      <- cbind(`AllDomains2016CR`, Timepoint2016)

# - - -

# 10. Renaming all the Timepoint columns so that they are compatible for merging

names(`AllDomains1996CR`) [6] <- "Year"
names(`AllDomains2007CR`) [6] <- "Year"
names(`AllDomains2016CR`) [6] <- "Year"

# - - -

# 11. Merging these 3 dataframes into 1 dataframe that is ordered by their Domain then class, at each timepoint in chronological order

AllCR <- do.call("rbind", list(`AllDomains1996CR`, 
                               `AllDomains2007CR`, 
                               `AllDomains2016CR`))

# - - -

# 12. Now that all the dataframes are merged, we can rename all the classes in one-go

AllCR$Class <- replace(AllCR$Class, AllCR$Class==1, "BUA")
AllCR$Class <- replace(AllCR$Class, AllCR$Class==2, "FOR")
AllCR$Class <- replace(AllCR$Class, AllCR$Class==3, "IAS")
AllCR$Class <- replace(AllCR$Class, AllCR$Class==4, "MNG")
AllCR$Class <- replace(AllCR$Class, AllCR$Class==5, "OPM")
AllCR$Class <- replace(AllCR$Class, AllCR$Class==6, "RPD")
AllCR$Class <- replace(AllCR$Class, AllCR$Class==7, "RBR")
AllCR$Class <- replace(AllCR$Class, AllCR$Class==8, "SHB")
AllCR$Class <- replace(AllCR$Class, AllCR$Class==9, "WTR")
AllCR$Class <- replace(AllCR$Class, AllCR$Class==10, "BRG")

# - - -

# 13. Subset out the Area degree column
AllCR <- subset(AllCR, select=c(1,2,3,5,6))

# - - -

# 14. Create an area column that is for 'km2' and 'ha' using the pixel sum column

# this is done to facilitate easier comparison for Area values for a LULC class against other studies who use either 'km2' or 'ha'

AllCR ["Area (ha)"] <- AllCR$PixelSum*30*30/10000

AllCR ["Area (km2)"] <- AllCR$PixelSum*30*30/1000/1000

# - - -

# 15. Reorganize the column in a meaningful way that is intuitive to read laterally across for each row

# First, we see the current organisation of headers

head(AllCR)

# Let's use the col numbers instead of col names

AllCR <- AllCR[c(5,4,1,3,2,6,7)]

head(AllCR)

str(AllCR)

# 16. Exporting the dataframe as a csv

write.csv(AllCR, file = 'C:/090918 MMR LULC/3.1. QGIS SCP CR/All Classification Reports.csv')

# END