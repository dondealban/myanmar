# This script calculates the McNemar's test statistic to evaluate the statistical
# significance of the differences between the classification results.  
#
# Script By:      Jose Don T De Alban
# Date Created:   20 Mar 2017
# Last Modified:  19 Apr 2017


# LOAD LIBRARIES AND DATA

# Set working directory
setwd("/Users/dondealban/Dropbox/Research/myanmar/mcnemar test/")


# CREATE 2x2 CONTINGENCY MATRICES
# Note: value taken from separate spreadsheets

mat01 = matrix(c(863,40,14,24), ncol=2, byrow=TRUE) # SetA 1995: Landsat+SAR vs. Landsat


# CALCULATE CRITICAL VALUE OF THE TEST
# Note: this will determine the stringency of the test
# Formula: cv = qchisq(1-alpha,df), where df=1 for 2x2 matrix  

cv99 <- qchisq(1-0.01, 1) # alpha=0.01
cv95 <- qchisq(1-0.05, 1) # alpha=0.05
cv90 <- qchisq(1-0.10, 1) # alpha=0.10


# CALCULATE McNEMAR's TEST STATISTIC (WITH CONTINUITY CORRECTION)
mcw01 <- mcnemar.test(mat01, correct=TRUE)


# CALCULATE McNEMAR's TEST STATISTIC (WITHOUT CONTINUITY CORRECTION)
mco01 <- mcnemar.test(mat01, correct=FALSE)


# SAVE OUTPUT FILES

sink("output-summary-mcnemar-test.txt", append=FALSE, split=TRUE)
cat("McNemar's Tests: Consolidated Results", sep="\n")
cat("Critical values:", sep="\n")
cat("For alpha = 0.01, critical value:")
print(cv99)
cat("For alpha = 0.05, critical value:")
print(cv95)
cat("For alpha = 0.10, critical value:")
print(cv90)
cat("\n")
cat("SET A 1995: LANDSAT+SAR vs. LANDSAT", sep="\n")
print(mcw01)
print(mco01)
sink()
