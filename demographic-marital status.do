hist be001
// save the picture as png file
gen marry=0 if be001==5
replace marry=1 if be001==1 | be001==2

// note that ba002_1 is the family leader's birth year
keep ID  householdID  communityID  ba002_1   marry  
