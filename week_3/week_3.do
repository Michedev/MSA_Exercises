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
quietly line ln_y_age age if female == 0 & bachelor == 0,  saving(ln_y_age, replace) sort title("ln_ahe age male high school")
quietly line ln_y_ln_age age if female == 0 & bachelor == 0, saving(ln_y_ln_age, replace) sort title("ln_ahe ln_age male high school")
quietly line ln_y_age_2 age if female == 0 & bachelor == 0, saving(ln_y_age_2, replace) sort title("ln_ahe age age^2 male high school")

quietly line ln_y_age age if female == 1 & bachelor == 1,  saving(ln_y_age_f, replace) sort title("ln_ahe age female bachelor")
quietly line ln_y_ln_age age if female == 1 & bachelor == 1, saving(ln_y_ln_age_f, replace) sort title("ln_ahe ln_age female bachelor")
quietly line ln_y_age_2 age if female == 1 & bachelor == 1, saving(ln_y_age_2_f, replace) sort title("ln_ahe age age^2 female bachelor")

graph combine ln_y_age.gph ln_y_ln_age.gph ln_y_age_2.gph ln_y_age_f.gph ln_y_ln_age_f.gph ln_y_age_2_f.gph
//9
regress ln_ahe c.age##c.age i.female i.bachelor i.female##i.bachelor

//10
summ(age)
return list
gen age_center = age - r(mean)
regress ln_ahe c.age_center i.female c.age_center#i.female

//11
regress ln_ahe c.age_center i.bachelor c.age_center#i.bachelor

//12
histogram age
gen young = age <= 28
histogram ahe , by(young)
regress ln_ahe young female bachelor
