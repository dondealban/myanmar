var geometry = ee.FeatureCollection("users/donwong9918/mmr_polbnda_adm0_250k_mimu"),
    dem = ee.Image("USGS/SRTMGL1_003"),
    geometry2 = /* color: #d63000 */ee.Geometry.MultiPoint();