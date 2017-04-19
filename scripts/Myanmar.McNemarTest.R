# This script calculates the McNemar's test statistic to evaluate the statistical
# significance of the differences between the classification results.  
#
# Script By:      Jose Don T De Alban
# Date Created:   20 Mar 2017
# Last Modified:  19 Apr 2017


# LOAD LIBRARIES AND DATA

# Set working directory
setwd("/Users/dondealban/Dropbox/Research/myanmar/mcnemar test/")


# CALCULATE CRITICAL VALUE OF THE TEST
# Note: this will determine the stringency of the test
# Formula: cv = qchisq(1-alpha,df), where df=1 for 2x2 matrix  

cv99 <- qchisq(1-0.01, 1) # alpha=0.01
cv95 <- qchisq(1-0.05, 1) # alpha=0.05
cv90 <- qchisq(1-0.10, 1) # alpha=0.10


# CREATE 2x2 CONTINGENCY MATRICES
# Note: value taken from separate spreadsheets

# Compare using all predictor variables
mat01 = matrix(c(863,40,14,24), ncol=2, byrow=TRUE) # SetA 1995: Landsat+SAR vs. Landsat
mat02 = matrix(c(883,39,15,35), ncol=2, byrow=TRUE) # SetA 2015: Landsat+SAR vs. Landsat
mat03 = matrix(c(882,45,16,29), ncol=2, byrow=TRUE) # SetB 2015: Landsat+SAR vs. Landsat
mat04 = matrix(c(915, 7,12,38), ncol=2, byrow=TRUE) # SetA 2015 vs. SetB 2015: Landsat+SAR

# Compare using Landsat+SAR selected variables vs. all variables
mat05 = matrix(c(898, 5, 3,35), ncol=2, byrow=TRUE) # SetA 1995 Landsat+SAR: All vs. VI
mat06 = matrix(c(913, 9,10,40), ncol=2, byrow=TRUE) # SetA 2015 Landsat+SAR: All vs. VI
mat07 = matrix(c(906,21,13,32), ncol=2, byrow=TRUE) # SetB 2015 Landsat+SAR: All vs. VI

# Compare using all variables for Landsat vs. selected variables for Landsat+SAR
mat08 = matrix(c(866,35,11,29), ncol=2, byrow=TRUE) # SetA 1995: Landsat+SAR VI vs. Landsat All
mat09 = matrix(c(885,38,13,36), ncol=2, byrow=TRUE) # SetA 2015: Landsat+SAR VI vs. Landsat All
mat10 = matrix(c(885,34,13,40), ncol=2, byrow=TRUE) # SetB 2015: Landsat+SAR VI vs. Landsat All


# CALCULATE McNEMAR's TEST STATISTIC (WITH CONTINUITY CORRECTION)

# Compare using all predictor variables
mcw01 <- mcnemar.test(mat01, correct=TRUE)
mcw02 <- mcnemar.test(mat02, correct=TRUE)
mcw03 <- mcnemar.test(mat03, correct=TRUE)
mcw04 <- mcnemar.test(mat04, correct=TRUE)

# Compare using Landsat+SAR selected variables vs. all variables
mcw05 <- mcnemar.test(mat05, correct=TRUE)
mcw06 <- mcnemar.test(mat06, correct=TRUE)
mcw07 <- mcnemar.test(mat07, correct=TRUE)

# Compare using all variables for Landsat vs. selected variables for Landsat+SAR
mcw08 <- mcnemar.test(mat08, correct=TRUE)
mcw09 <- mcnemar.test(mat09, correct=TRUE)
mcw10 <- mcnemar.test(mat10, correct=TRUE)


# CALCULATE McNEMAR's TEST STATISTIC (WITHOUT CONTINUITY CORRECTION)

# Compare using all predictor variables
mco01 <- mcnemar.test(mat01, correct=FALSE)
mco02 <- mcnemar.test(mat02, correct=FALSE)
mco03 <- mcnemar.test(mat03, correct=FALSE)
mco04 <- mcnemar.test(mat04, correct=FALSE)

# Compare using Landsat+SAR selected variables vs. all variables
mco05 <- mcnemar.test(mat05, correct=FALSE)
mco06 <- mcnemar.test(mat06, correct=FALSE)
mco07 <- mcnemar.test(mat07, correct=FALSE)

# Compare using all variables for Landsat vs. selected variables for Landsat+SAR
mco08 <- mcnemar.test(mat08, correct=FALSE)
mco09 <- mcnemar.test(mat09, correct=FALSE)
mco10 <- mcnemar.test(mat10, correct=FALSE)


# SAVE OUTPUT FILES

sink("output-summary-mcnemar-test.txt", append=FALSE, split=TRUE)
cat("MCNEMAR'S TESTS: CONSOLIDATED RESULTS")
cat("\n")
cat("\n")
cat("Critical values:", sep="\n")
cat("For alpha = 0.01, critical value:")
print(cv99)
cat("For alpha = 0.05, critical value:")
print(cv95)
cat("For alpha = 0.10, critical value:")
print(cv90)
cat("\n")
cat("USING ALL PREDICTOR VARIABLES", sep="\n")
cat("SET A 1995: LANDSAT+SAR vs. LANDSAT", sep="\n")
print(mcw01)
print(mco01)
cat("USING ALL PREDICTOR VARIABLES", sep="\n")
cat("SET A 2015: LANDSAT+SAR vs. LANDSAT", sep="\n")
print(mcw02)
print(mco02)
cat("USING ALL PREDICTOR VARIABLES", sep="\n")
cat("SET B 2015: LANDSAT+SAR vs. LANDSAT", sep="\n")
print(mcw03)
print(mco03)
cat("USING ALL PREDICTOR VARIABLES", sep="\n")
cat("SET A 2015 vs SET B 2015: LANDSAT+SAR", sep="\n")
print(mcw04)
print(mco04)
cat("USING LANDSAT+SAR SELECTED VARIABLES vs. ALL VARIABLES", sep="\n")
cat("SET A 1995 LANDSAT+SAR: ALL vs. VI", sep="\n")
print(mcw05)
print(mco05)
cat("USING LANDSAT+SAR SELECTED VARIABLES VS. ALL VARIABLES", sep="\n")
cat("SET A 2015 LANDSAT+SAR: ALL vs. VI", sep="\n")
print(mcw06)
print(mco06)
cat("USING LANDSAT+SAR SELECTED VARIABLES VS. ALL VARIABLES", sep="\n")
cat("SET B 2015 LANDSAT+SAR: ALL vs. VI", sep="\n")
print(mcw07)
print(mco07)
cat("USING LANDSAT+SAR SELECTED VARIABLES vs. LANDSAT ALL VARIABLES", sep="\n")
cat("SET A 1995 LANDSAT+SAR VI vs. LANDSAT ALL", sep="\n")
print(mcw08)
print(mco08)
cat("USING LANDSAT+SAR SELECTED VARIABLES vs. LANDSAT ALL VARIABLES", sep="\n")
cat("SET A 2015 LANDSAT+SAR VI vs. LANDSAT ALL", sep="\n")
print(mcw09)
print(mco09)
cat("USING LANDSAT+SAR SELECTED VARIABLES vs. LANDSAT ALL VARIABLES", sep="\n")
cat("SET B 2015 LANDSAT+SAR VI vs. LANDSAT ALL", sep="\n")
print(mcw10)
print(mco10)
sink()