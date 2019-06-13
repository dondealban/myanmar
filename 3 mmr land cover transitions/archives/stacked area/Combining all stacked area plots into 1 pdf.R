#install.packages("staplr")
library(staplr)

path <- "C:/Stacked Area (GitHub)"

files <- list.files(path=path, pattern = "*.pdf")

#output_filepath = file.path(path, paste('AllStackedAreaPlots.pdf', sep = ""))

MergedStackedArea <- staple_pdf(input_directory = path, input_files = NULL, output_filepath = path)

# Script was unsuccessfull
# Script can only work if PDF Toolkit (PDF Tk) is already installed in the systtem. However, It was a lot easier to just load the files into PDF Tk (outside of R) and merge the pdf's accordingly.

