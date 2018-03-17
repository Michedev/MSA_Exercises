use "C:\users\mikedev\My Documents\modelli_statistici_avanzati\exercises\week_3\cps98.dta", clear

//1
regress ahe age female bachelor
//2
gen ln_ahe = ln(ahe)
regress ln_ahe age female bachelor
predict ln_y_age
predict res_ln_y_age, res

//3
gen ln_age = ln(age)
regress ln_ahe ln_age female bachelor
predict ln_y_ln_age
//4
regress ln_ahe c.age##c.age female bachelor
predict ln_y_age_2
predict res_ln_y_age_2, res

//8
quietly line ln_y_age age if female == 0 & bachelor == 0,  saving(ln_y_age, replace) sort title("ln_ahe age")
quietly line ln_y_ln_age age if female == 0 & bachelor == 0, saving(ln_y_ln_age, replace) sort title("ln_ahe ln_age")
quietly line ln_y_age_2 age if female == 0 & bachelor == 0, saving(ln_y_age_2, replace) sort title("ln_ahe age age^2")
graph combine ln_y_age.gph ln_y_ln_age.gph ln_y_age_2.gph
