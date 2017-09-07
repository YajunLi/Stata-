// D1 indicates preference of living with or without children
gen D1=0 if cg001_1_==3 | cg001_1_==4
replace D1=1 if cg001_1_==1 | cg001_1_==2

gen D2=0 if cg002_1_==3 | cg002_1_==4
replace D2=1 if cg002_1_==1 | cg002_1_==2
sum D1 D2

keep householdID  ID  communityID  D1  D2
