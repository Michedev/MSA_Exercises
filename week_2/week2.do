use "Z:\home\mikedev\Downloads\hsb.dta", clear
drop if !inlist(schoolid, 1224, 1288, 1296, 1308, 1317)
keep mathach minority schoolid ses
summarize mathach ses
tabulate schoolid
tabulate minority
tabstat  ses mathach, stat(mean sd)
tabstat ses mathach, stat(mean sd) by(schoolid)
histogram mathach, bin(8)
graph box mathach
scatter mathach ses
twoway scatter mathach ses, by(schoolid)
regress mathach ses
predict yhat
twoway (scatter mathach ses) (lfit yhat ses)
twoway (scatter mathach ses) (lfit yhat ses), by(schoolid)
twoway (scatter mathach ses) (lfit yhat ses) (lfit mathach ses), by(schoolid)

tabulate schoolid, generate(schoolid_)
regress mathach schoolid_2 schoolid_3 schoolid_4 schoolid_5
testparm schoolid_*
regress mathach c.ses##i.schoolid_*
