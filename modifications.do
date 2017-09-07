// some harmless modifications 
gen educ=j
label variable educ "highest edu of all children in a family"
drop j

gen num=k
label variable num "number of children in a family"
drop k

gen yearbirth=ba002_1
label variable yearbirth "birth year of family holder"
drop ba002_1

// to drop missing data below
drop if D1!=0 & D1!=1
drop if D2!=0 & D2!=1

// check to find out the educ data is too small (around 3000 to 4000 or so)
// So I look up info of child in 2013. Open dataset 2013-child.dta
list ID childID gender age cb060

// In 2013 wave, the ID and householdID has been changed, below is to modify
// in the baseline data
replace householdID=householdID+"0"
help substr
replace ID=householdID+substr(ID,-2,2)


// to practice, open the dataset practice.dta
// change variable format from chara to numeric
destring, replace

egen nchild=total(age<=17), by(family)
gen y=(age<=17)
list

replace nchild=nchild-(age<=17)

// to count number of sisters in a family
egen nsisters = total(age <= 17 & sex == 1), by(family), if age<=17
replace nsisters = nsisters - (age <= 17 & sex == 1) 

// caution: age>=18 includes data age=. which is missing, to be safe, I have 
egen nadults=total(age>=18 & age<.),by(family)

egen totalage=total(age) if age<=17,by(family)
replace totalage=totalage-age

// mean age of other children in a family
gen meanage=totalage/nchild

// below is the syntex of meanage assigned to all observations
egen totalage = total(age * (age <= 17)), by(family) 
replace totalage = totalage - age * (age <= 17) 
generate meanage = totalage/nchild


//
by family, sort: gen pid=_n
sum pid

// open 2013 Child.dta
sum cb058
keep ID householdID childID cb060 gender age communityID 

egen numch=total(childID<=12), by(householdID)
label variable numch "the number of children within a family"

egen educch=max(cb060), by(householdID)
gen gender1=gender if educch==cb060

// to generate gender2=1 if highest edu child is male
egen gender2=total((gender==1)*(educch==cb060)), by(householdID)
replace gender2=1 if gender2>=1

// to generate gender3=2 if highest edu child is female
egen gender3=total((gender==2)*(educch==cb060)), by(householdID)
replace gender3=2 if gender3>=1

gen gender4=3 if gender2==1 & gender3==2
replace gender4=1 if gender2==1 & gender3!=2
replace gender4=2 if gender3==2 & gender2!=1

// do some rename and refinement of 2013 child data, save a new dataset named 2013child refined.dta

// open data clearing.dta
merge 1:m ID householdID using "D:\Stata\my paper\2013child refined.dta"

// save and overwriting into data clearing.dta

// open 2011, household_roster.dta
merge 1:1 ID householdID using "D:\Stata\my paper\rural1.dta"

// transform education variable into year of education 
replace educch2013=0 if educch2013==1
replace educch2013=4 if educch2013==2
replace educch2013=5 if educch2013==3
replace educch2013=6 if educch2013==4
replace educch2013=9 if educch2013==5
replace educch2013=12 if educch2013==6
replace educch2013=14 if educch2013==7
replace educch2013=15 if educch2013==8
replace educch2013=16 if educch2013==9
replace educch2013=18 if educch2013==10
replace educch2013=22 if educch2013==11


// to create bar chart by gender
graph bar (count) gender2 gender3, over(educch2013) bargap(0) legend(label(1 "male") label(2 "female")) 
ytitle("number") title("education level by gender") bar(1, color(edkblue)) bar(2, color(maroon))

//
tabulate marry D1
tabulate marry D2

// open community chara.dta
// drop below because communityID can not identify community
drop if communityID=="2986311"
drop if communityID=="2986313"
merge 1:m communityID using "D:\Stata\my paper\rural1.dta"
keep if _merge==3
drop _merge

sum jf014
gen insurance=1 if jf014!=.  // indicator whether a community enrolled in medical insurance
label variable insurance "1=have new rural  cooperative medical insurance, 0=otherwise"
replace jb008=0 if jb008==2
label variable jb008 "whether have central heating, 1=yes, 0=no"

replace ja035=0 if ja035==2
label variable ja035 "1=land procurement, 0=otherwise"

// below is to keep only one data for each communityID
by communityID, sort:gen pid=_n
keep if pid==1
drop pid

//save data, open data clearing.dta
merge m:1 communityID using "D:\Stata\my paper\community chara.dta"
keep if _merge==3
drop _merge

drop if a001==2  // now this dataset is purely rural

hist yearbirth

// the central regression below
ivregress 2sls educch2013 numch2013 (D1=marry) if gender4==1
























