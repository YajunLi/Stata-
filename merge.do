// Below is to merge data from different dataset 

// first open dta file family roster
merge 1:1 ID using "D:\Stata\my paper\demographic-birth year,marital status.dta"
keep if _merge==3
drop _merge

merge 1:1 ID using "D:\Stata\my paper\family transfer-preferences.dta"
keep if _merge==3 | _merge==1
drop _merge

merge 1:1 ID using "D:\Stata\my paper\health insurance.dta"
keep if _merge==3 | _merge==1
drop _merge

merge 1:1 ID using "D:\Stata\my paper\health status.dta"
keep if _merge==3 | _merge==1
drop _merge

// Save the merged dataset as new.dta

label variable gender "1=male highest edu child, 2=female, 3=both"
label variable j "highest edu of all children in a family"
label variable k "number of children in a family"
label variable marry "0=single living or spouse died, 1=living with spouse "
label variable D1 "0=prefer not live with children, 1=prefer live with children,conditional on having spouse "
label variable D2 "0=prefer not live with children, 1=prefer live with children,conditional on without spouse "
label variable diseases "the number of diseases one has"
label variable wesmed "number of diseases using western medicine"









