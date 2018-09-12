var image = ee.Image("users/donwong9918/2007_HH_Shan_21to23_Spk_norm"),
    image2 = ee.Image("users/donwong9918/2007_HH_mosiac_19to23_Spk_norm"),
    image3 = ee.Image("users/donwong9918/2007_HH_mosiac_24to30_Spk_norm"),
    image4 = ee.Image("users/donwong9918/2007_HH_mosiac_til18_Spk_norm"),
    geometry = ee.FeatureCollection("users/donwong9918/mmr_polbnda_adm0_250k_mimu"),
    dem = ee.Image("USGS/SRTMGL1_003");