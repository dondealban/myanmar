# This script calculates the McNemar's test statistic to evaluate the statistical
# significance of the differences between the classification results.  
#
# Script By:      Jose Don T De Alban
# Date Created:   20 Mar 2017
# Last Modified:  


# LOAD LIBRARIES AND DATA

# Set working directory
setwd("/Users/dondealban/Dropbox/Research/myanmar/mcnemar test/")


# CREATE 2x2 CONTINGENCY MATRICES
# Note: value taken from separate spreadsheets

mat1 = matrix(c(756,42,5,38), ncol=2, byrow=TRUE) # SetA 1995: Landsat+SAR vs. Landsat


# CALCULATE CRITICAL VALUE OF THE TEST
# Note: this will determine the stringency of the test
# Formula: cv = qchisq(1-alpha,1)

cv99 <- qchisq(1-0.01, 1) # alpha=0.01
cv95 <- qchisq(1-0.05, 1) # alpha=0.05
cv90 <- qchisq(1-0.01, 1) # alpha=0.10


# CALCULATE McNEMAR's TEST STATISTIC (WITH CONTINUITY CORRECTION)
mcw1 <- mcnemar.test(mat1, correct=TRUE)


# CALCULATE McNEMAR's TEST STATISTIC (WITHOUT CONTINUITY CORRECTION)
mco1 <- mcnemar.test(mat1, correct=FALSE)


# SAVE OUTPUT FILES

sink("output-summary-mcnemar-test.txt", append=FALSE, split=TRUE)
print("McNemar's Test Statistics\n")
print("Critical Values:")
print("At alpha = 0.01, CV = ", cv01)
print("McNemar's Test with Continuity Correction")
sink()
