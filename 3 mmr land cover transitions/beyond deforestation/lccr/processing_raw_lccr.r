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

# 4.  Add a domain column for each file

Domain_01  <- rep('AYE', nrow(`MMR19962007AYE`))
Domain_02  <- rep('BAG', nrow(`MMR19962007BAG`))
Domain_03  <- rep('CHI', nrow(`MMR19962007CHI`))
Domain_04  <- rep('KAC', nrow(`MMR19962007KAC`))
Domain_05  <- rep('KYH', nrow(`MMR19962007KYH`))
Domain_06  <- rep('KYN', nrow(`MMR19962007KYN`))
Domain_07  <- rep('MAG', nrow(`MMR19962007MAG`))
Domain_08  <- rep('MAN', nrow(`MMR19962007MAN`))
Domain_09  <- rep('MON', nrow(`MMR19962007MON`))
Domain_10  <- rep('NAY', nrow(`MMR19962007NAY`))
Domain_11  <- rep('RAK', nrow(`MMR19962007RAK`))
Domain_12  <- rep('SAG', nrow(`MMR19962007SAG`))
Domain_13  <- rep('SHA', nrow(`MMR19962007SHA`))
Domain_14  <- rep('TNI', nrow(`MMR19962007TNI`))
Domain_15  <- rep('YGN', nrow(`MMR19962007YGN`))

Domain_16  <- rep('AYE', nrow(`MMR20072016AYE`))
Domain_17  <- rep('BAG', nrow(`MMR20072016BAG`))
Domain_18  <- rep('CHI', nrow(`MMR20072016CHI`))
Domain_19  <- rep('KAC', nrow(`MMR20072016KAC`))
Domain_20  <- rep('KYH', nrow(`MMR20072016KYH`))
Domain_21  <- rep('KYN', nrow(`MMR20072016KYN`))
Domain_22  <- rep('MAG', nrow(`MMR20072016MAG`))
Domain_23  <- rep('MAN', nrow(`MMR20072016MAN`))
Domain_24  <- rep('MON', nrow(`MMR20072016MON`))
Domain_25  <- rep('NAY', nrow(`MMR20072016NAY`))
Domain_26  <- rep('RAK', nrow(`MMR20072016RAK`))
Domain_27  <- rep('SAG', nrow(`MMR20072016SAG`))
Domain_28  <- rep('SHA', nrow(`MMR20072016SHA`))
Domain_29  <- rep('TNI', nrow(`MMR20072016TNI`))
Domain_30  <- rep('YGN', nrow(`MMR20072016YGN`))
