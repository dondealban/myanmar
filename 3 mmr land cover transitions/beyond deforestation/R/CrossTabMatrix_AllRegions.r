# Purpose :   Getting all cross-tabulation matrices per region per time-interval
# URL 1   :   https://www.rdocumentation.org/packages/intensity.analysis/versions/0.1.6/vignettes/README.Rmd
# URL 2   :   https://cran.r-project.org/web/packages/intensity.analysis/vignettes/README.html
# URL 3   :   https://github.com/dondealban/learning-intensity-analysis

# Author  :   J Johanness
# Date    :   2019-08-27

# Note    :   Script does not involve doing Intensity Analysis (IA) for all regions, since I may only want to use IA for select hotspots.

# --------------------------------------------------------------------------------------------------------------------------------------------------------
# Step 01 :   Install and load required packages
# --------------------------------------------------------------------------------------------------------------------------------------------------------

library(raster)
library(intensity.analysis)

# --------------------------------------------------------------------------------------------------------------------------------------------------------
# Step 02 :   Read all LC raster maps
# --------------------------------------------------------------------------------------------------------------------------------------------------------

r_1996_AYE = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_1996_AYE_RCL.tif')
r_2007_AYE = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2007_AYE_RCL.tif')
r_2016_AYE = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2016_AYE_RCL.tif')

r_1996_BAG = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_1996_BAG_RCL.tif')
r_2007_BAG = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2007_BAG_RCL.tif')
r_2016_BAG = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2016_BAG_RCL.tif')

r_1996_CHI = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_1996_CHI_RCL.tif')
r_2007_CHI = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2007_CHI_RCL.tif')
r_2016_CHI = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2016_CHI_RCL.tif')

r_1996_KAC = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_1996_KAC_RCL.tif')
r_2007_KAC = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2007_KAC_RCL.tif')
r_2016_KAC = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2016_KAC_RCL.tif')

r_1996_KYH = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_1996_KYH_RCL.tif')
r_2007_KYH = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2007_KYH_RCL.tif')
r_2016_KYH = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2016_KYH_RCL.tif')

r_1996_KYN = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_1996_KYN_RCL.tif')
r_2007_KYN = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2007_KYN_RCL.tif')
r_2016_KYN = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2016_KYN_RCL.tif')

r_1996_MAG = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_1996_MAG_RCL.tif')
r_2007_MAG = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2007_MAG_RCL.tif')
r_2016_MAG = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2016_MAG_RCL.tif')

r_1996_MAN = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_1996_MAN_RCL.tif')
r_2007_MAN = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2007_MAN_RCL.tif')
r_2016_MAN = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2016_MAN_RCL.tif')

r_1996_MON = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_1996_MON_RCL.tif')
r_2007_MON = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2007_MON_RCL.tif')
r_2016_MON = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2016_MON_RCL.tif')

r_1996_NAY = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_1996_NAY_RCL.tif')
r_2007_NAY = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2007_NAY_RCL.tif')
r_2016_NAY = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2016_NAY_RCL.tif')

r_1996_RAK = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_1996_RAK_RCL.tif')
r_2007_RAK = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2007_RAK_RCL.tif')
r_2016_RAK = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2016_RAK_RCL.tif')

r_1996_SAG = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_1996_SAG_RCL.tif')
r_2007_SAG = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2007_SAG_RCL.tif')
r_2016_SAG = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2016_SAG_RCL.tif')

r_1996_SHA = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_1996_SHA_RCL.tif')
r_2007_SHA = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2007_SHA_RCL.tif')
r_2016_SHA = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2016_SHA_RCL.tif')

r_1996_TNI = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_1996_TNI_RCL.tif')
r_2007_TNI = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2007_TNI_RCL.tif')
r_2016_TNI = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2016_TNI_RCL.tif')

r_1996_YGN = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_1996_YGN_RCL.tif')
r_2007_YGN = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2007_YGN_RCL.tif')
r_2016_YGN = raster('C:/MMR-LCC-EndAugust/01-GEE-exports-DonScripts/MMR_2016_YGN_RCL.tif')

# --------------------------------------------------------------------------------------------------------------------------------------------------------
# Step 03 :   Save the rasters as a separate variable (never touch RAW data e.g. r_1996_AYE)
# --------------------------------------------------------------------------------------------------------------------------------------------------------

lc_1996_AYE <- r_1996_AYE
lc_2007_AYE <- r_2007_AYE
lc_2016_AYE <- r_2016_AYE

lc_1996_BAG <- r_1996_BAG
lc_2007_BAG <- r_2007_BAG
lc_2016_BAG <- r_2016_BAG

lc_1996_CHI <- r_1996_CHI
lc_2007_CHI <- r_2007_CHI
lc_2016_CHI <- r_2016_CHI

lc_1996_KAC <- r_1996_KAC
lc_2007_KAC <- r_2007_KAC
lc_2016_KAC <- r_2016_KAC

lc_1996_KYH <- r_1996_KYH
lc_2007_KYH <- r_2007_KYH
lc_2016_KYH <- r_2016_KYH

lc_1996_KYN <- r_1996_KYN
lc_2007_KYN <- r_2007_KYN
lc_2016_KYN <- r_2016_KYN

lc_1996_MAG <- r_1996_MAG
lc_2007_MAG <- r_2007_MAG
lc_2016_MAG <- r_2016_MAG

lc_1996_MAN <- r_1996_MAN
lc_2007_MAN <- r_2007_MAN
lc_2016_MAN <- r_2016_MAN

lc_1996_MON <- r_1996_MON
lc_2007_MON <- r_2007_MON
lc_2016_MON <- r_2016_MON

lc_1996_NAY <- r_1996_NAY
lc_2007_NAY <- r_2007_NAY
lc_2016_NAY <- r_2016_NAY

lc_1996_RAK <- r_1996_RAK
lc_2007_RAK <- r_2007_RAK
lc_2016_RAK <- r_2016_RAK

lc_1996_SAG <- r_1996_SAG
lc_2007_SAG <- r_2007_SAG
lc_2016_SAG <- r_2016_SAG

lc_1996_SHA <- r_1996_SHA
lc_2007_SHA <- r_2007_SHA
lc_2016_SHA <- r_2016_SHA

lc_1996_TNI <- r_1996_TNI
lc_2007_TNI <- r_2007_TNI
lc_2016_TNI <- r_2016_TNI

lc_1996_YGN <- r_1996_YGN
lc_2007_YGN <- r_2007_YGN
lc_2016_YGN <- r_2016_YGN


# --------------------------------------------------------------------------------------------------------------------------------------------------------
# Step 04 :   Convert all '0' No Data values to NA
# --------------------------------------------------------------------------------------------------------------------------------------------------------

lc_1996_AYE[lc_1996_AYE <= 0] <- NA
lc_2007_AYE[lc_2007_AYE <= 0] <- NA
lc_2016_AYE[lc_2016_AYE <= 0] <- NA

lc_1996_BAG[lc_1996_BAG <= 0] <- NA
lc_2007_BAG[lc_2007_BAG <= 0] <- NA
lc_2016_BAG[lc_2016_BAG <= 0] <- NA

lc_1996_CHI[lc_1996_CHI <= 0] <- NA
lc_2007_CHI[lc_2007_CHI <= 0] <- NA
lc_2016_CHI[lc_2016_CHI <= 0] <- NA

lc_1996_KAC[lc_1996_KAC <= 0] <- NA
lc_2007_KAC[lc_2007_KAC <= 0] <- NA
lc_2016_KAC[lc_2016_KAC <= 0] <- NA

lc_1996_KYH[lc_1996_KYH <= 0] <- NA
lc_2007_KYH[lc_2007_KYH <= 0] <- NA
lc_2016_KYH[lc_2016_KYH <= 0] <- NA

lc_1996_KYN[lc_1996_KYN <= 0] <- NA
lc_2007_KYN[lc_2007_KYN <= 0] <- NA
lc_2016_KYN[lc_2016_KYN <= 0] <- NA

lc_1996_MAG[lc_1996_MAG <= 0] <- NA
lc_2007_MAG[lc_2007_MAG <= 0] <- NA
lc_2016_MAG[lc_2016_MAG <= 0] <- NA

lc_1996_MAN[lc_1996_MAN <= 0] <- NA
lc_2007_MAN[lc_2007_MAN <= 0] <- NA
lc_2016_MAN[lc_2016_MAN <= 0] <- NA

lc_1996_MON[lc_1996_MON <= 0] <- NA
lc_2007_MON[lc_2007_MON <= 0] <- NA
lc_2016_MON[lc_2016_MON <= 0] <- NA

lc_1996_NAY[lc_1996_NAY <= 0] <- NA
lc_2007_NAY[lc_2007_NAY <= 0] <- NA
lc_2016_NAY[lc_2016_NAY <= 0] <- NA

lc_1996_RAK[lc_1996_RAK <= 0] <- NA
lc_2007_RAK[lc_2007_RAK <= 0] <- NA
lc_2016_RAK[lc_2016_RAK <= 0] <- NA

lc_1996_SAG[lc_1996_SAG <= 0] <- NA
lc_2007_SAG[lc_2007_SAG <= 0] <- NA
lc_2016_SAG[lc_2016_SAG <= 0] <- NA

lc_1996_SHA[lc_1996_SHA <= 0] <- NA
lc_2007_SHA[lc_2007_SHA <= 0] <- NA
lc_2016_SHA[lc_2016_SHA <= 0] <- NA

lc_1996_TNI[lc_1996_TNI <= 0] <- NA
lc_2007_TNI[lc_2007_TNI <= 0] <- NA
lc_2016_TNI[lc_2016_TNI <= 0] <- NA

lc_1996_YGN[lc_1996_YGN <= 0] <- NA
lc_2007_YGN[lc_2007_YGN <= 0] <- NA
lc_2016_YGN[lc_2016_YGN <= 0] <- NA

# --------------------------------------------------------------------------------------------------------------------------------------------------------
# Step 05 :   List processed rasters per region
# --------------------------------------------------------------------------------------------------------------------------------------------------------

raster_list_AYE <- list(lc1996AYE,lc2007AYE,lc2016AYE)
raster_list_BAG <- list(lc1996BAG,lc2007BAG,lc2016BAG)
raster_list_CHI <- list(lc1996CHI,lc2007CHI,lc2016CHI)
raster_list_KAC <- list(lc1996KAC,lc2007KAC,lc2016KAC)
raster_list_KYH <- list(lc1996KYH,lc2007KYH,lc2016KYH)
raster_list_KYN <- list(lc1996KYN,lc2007KYN,lc2016KYN)
raster_list_MAG <- list(lc1996MAG,lc2007MAG,lc2016MAG)
raster_list_MAN <- list(lc1996MAN,lc2007MAN,lc2016MAN)
raster_list_MON <- list(lc1996MON,lc2007MON,lc2016MON)
raster_list_NAY <- list(lc1996NAY,lc2007NAY,lc2016NAY)
raster_list_RAK <- list(lc1996RAK,lc2007RAK,lc2016RAK)
raster_list_SAG <- list(lc1996SAG,lc2007SAG,lc2016SAG)
raster_list_SHA <- list(lc1996SHA,lc2007SHA,lc2016SHA)
raster_list_TNI <- list(lc1996TNI,lc2007TNI,lc2016TNI)
raster_list_YGN <- list(lc1996YGN,lc2007YGN,lc2016YGN)

# --------------------------------------------------------------------------------------------------------------------------------------------------------
# Step 06 :   Define time points and categories for cross tabulation matrices
# --------------------------------------------------------------------------------------------------------------------------------------------------------

time.points <- c("1996","2007","2016")

categories <- c("BRG","BUA","FOR","MNG","OPM","RPD","RBR","SHB","WTR")

# --------------------------------------------------------------------------------------------------------------------------------------------------------
# Step 07 :   Create cross-tabulation matroces per region and time-interval
# --------------------------------------------------------------------------------------------------------------------------------------------------------

crosstabulation_AYE <- multicrosstab(raster_list_AYE, time.points, categories)
crosstabulation_BAG <- multicrosstab(raster_list_BAG, time.points, categories)
crosstabulation_CHI <- multicrosstab(raster_list_CHI, time.points, categories)
crosstabulation_KAC <- multicrosstab(raster_list_KAC, time.points, categories)
crosstabulation_KYH <- multicrosstab(raster_list_KYH, time.points, categories)
crosstabulation_KYN <- multicrosstab(raster_list_KYN, time.points, categories)
crosstabulation_MAG <- multicrosstab(raster_list_MAG, time.points, categories)
crosstabulation_MAN <- multicrosstab(raster_list_MAN, time.points, categories)
crosstabulation_MON <- multicrosstab(raster_list_MON, time.points, categories)
crosstabulation_NAY <- multicrosstab(raster_list_NAY, time.points, categories)
crosstabulation_RAK <- multicrosstab(raster_list_RAK, time.points, categories)
crosstabulation_SAG <- multicrosstab(raster_list_SAG, time.points, categories)
crosstabulation_SHA <- multicrosstab(raster_list_SHA, time.points, categories)
crosstabulation_TNI <- multicrosstab(raster_list_TNI, time.points, categories)
crosstabulation_YGN <- multicrosstab(raster_list_YGN, time.points, categories)

# --------------------------------------------------------------------------------------------------------------------------------------------------------
# Step 08 :   Save cross-tabulation matrices individually (per region)
# --------------------------------------------------------------------------------------------------------------------------------------------------------

crosstab_AYE_1 <- crosstabulation_AYE[[1]]
write.csv(crosstab_1, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_AYE_1996_2007.csv")
crosstab_AYE_2 <- crosstabulation_AYE[[2]]
write.csv(crosstab_2, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_AYE_2007_2016.csv")

crosstab_BAG_1 <- crosstabulation_BAG[[1]]
write.csv(crosstab_1, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_BAG_1996_2007.csv")
crosstab_BAG_2 <- crosstabulation_BAG[[2]]
write.csv(crosstab_2, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_BAG_2007_2016.csv")

crosstab_CHI_1 <- crosstabulation_CHI[[1]]
write.csv(crosstab_1, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_CHI_1996_2007.csv")
crosstab_CHI_2 <- crosstabulation_CHI[[2]]
write.csv(crosstab_2, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_CHI_2007_2016.csv")

crosstab_KAC_1 <- crosstabulation_KAC[[1]]
write.csv(crosstab_1, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_KAC_1996_2007.csv")
crosstab_KAC_2 <- crosstabulation_KAC[[2]]
write.csv(crosstab_2, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_KAC_2007_2016.csv")

crosstab_KYH_1 <- crosstabulation_KYH[[1]]
write.csv(crosstab_1, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_KYH_1996_2007.csv")
crosstab_KYH_2 <- crosstabulation_KYH[[2]]
write.csv(crosstab_2, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_KYH_2007_2016.csv")

crosstab_KYN_1 <- crosstabulation_KYN[[1]]
write.csv(crosstab_1, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_KYN_1996_2007.csv")
crosstab_KYN_2 <- crosstabulation_KYN[[2]]
write.csv(crosstab_2, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_KYN_2007_2016.csv")

crosstab_MAG_1 <- crosstabulation_MAG[[1]]
write.csv(crosstab_1, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_MAG_1996_2007.csv")
crosstab_MAG_2 <- crosstabulation_MAG[[2]]
write.csv(crosstab_2, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_MAG_2007_2016.csv")

crosstab_MAN_1 <- crosstabulation_MAN[[1]]
write.csv(crosstab_1, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_MAN_1996_2007.csv")
crosstab_MAN_2 <- crosstabulation_MAN[[2]]
write.csv(crosstab_2, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_MAN_2007_2016.csv")

crosstab_MON_1 <- crosstabulation_MON[[1]]
write.csv(crosstab_1, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_MON_1996_2007.csv")
crosstab_MON_2 <- crosstabulation_MON[[2]]
write.csv(crosstab_2, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_MON_2007_2016.csv")

crosstab_RAK_1 <- crosstabulation_RAK[[1]]
write.csv(crosstab_1, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_RAK_1996_2007.csv")
crosstab_RAK_2 <- crosstabulation_RAK[[2]]
write.csv(crosstab_2, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_RAK_2007_2016.csv")

crosstab_SAG_1 <- crosstabulation_SAG[[1]]
write.csv(crosstab_1, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_SAG_1996_2007.csv")
crosstab_SAG_2 <- crosstabulation_SAG[[2]]
write.csv(crosstab_2, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_SAG_2007_2016.csv")

crosstab_SHA_1 <- crosstabulation_SHA[[1]]
write.csv(crosstab_1, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_SHA_1996_2007.csv")
crosstab_SHA_2 <- crosstabulation_SHA[[2]]
write.csv(crosstab_2, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_SHA_2007_2016.csv")

crosstab_TNI_1 <- crosstabulation_TNI[[1]]
write.csv(crosstab_1, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_TNI_1996_2007.csv")
crosstab_TNI_2 <- crosstabulation_TNI[[2]]
write.csv(crosstab_2, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_TNI_2007_2016.csv")

crosstab_YGN_1 <- crosstabulation_YGN[[1]]
write.csv(crosstab_1, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_YGN_1996_2007.csv")
crosstab_YGN_2 <- crosstabulation_YGN[[2]]
write.csv(crosstab_2, file = "C:/MMR-LCC-EndAugust/03-CROSSTAB/CROSSTAB_YGN_2007_2016.csv")

# END
