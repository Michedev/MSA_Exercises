clear
set seed 1032299
set obs 150
gen x1 = runiform()
gen x2 = x1 + runiform()
gen x3 = runiform()
gen y = rnormal(-1 + 0.3 * x1 + 0.2*x3, 0.2^2)
regress y x1 x2 x3
regress y x1 x3
