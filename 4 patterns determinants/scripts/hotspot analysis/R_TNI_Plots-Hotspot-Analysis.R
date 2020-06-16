# This script generates plots from the results of the Getis-Ord Gi statistic or Hotspot
# analysis implemented in ArcGIS (Emerging Hotspots Toolbox) to assess the spatial 
# associations and distribution of the different gain transitions of major agricultural
# crop commodities (i.e., oil palm, rubber, rice) in Tanintharyi Region, Myanmar.
# 
# Script by:      Jose Don T. De Alban
# Date created:   16 Jun 2020
# Date modified:  


# Load Libraries -------------------------
library(tidyverse)

# Set Working Directories ----------------
DirMAIN <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/"
DirDATA <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/hotspot analysis/"
DirOPM  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/hotspot analysis/csv opm/"
DirRBR  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/hotspot analysis/csv rbr/"
DirRPD  <- "/Users/dondealban/Dropbox/Research/myanmar/4 patterns determinants/hotspot analysis/csv rpd/"
