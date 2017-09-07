// open household roster,2011
// select rural area families, this is rural subsample, it serves as merge master dataset later
drop if a001==2
// to see whether a child is still in school
sum a013_i_  if a006_i==7  $ a006_i_=7 means this is a child of the family
// I find most of the children do not attend school at the time of observation, 
// so I do not drop anything

gen e1=a015_1_  if a006_1_==7
gen e2=a015_2_  if a006_2_==7
gen e3=a015_3_  if a006_3_==7
gen e4=a015_4_  if a006_4_==7
gen e5=a015_5_  if a006_5_==7
gen e6=a015_6_  if a006_6_==7
gen e7=a015_7_  if a006_7_==7
gen e8=a015_8_  if a006_8_==7

gen e9=a015_9_  if a006_9_==7
gen e10=a015_10_  if a006_10_==7
gen e11=a015_11_  if a006_11_==7
gen e12=a015_12_  if a006_12_==7
gen e13=a015_13_  if a006_13_==7
gen e14=a015_14_  if a006_14_==7
gen e15=a015_15_  if a006_15_==7

// below is the maximum of child's education level, restored in "j"
gen j=max(e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15)
// below is the number of children of each rural family
gen k=1*(a006_1_==7)+1*(a006_2_==7)+1*(a006_3_==7)+1*(a006_4_==7)+1*(a006_5_==7)+1*(a006_6_==7)+1*(a006_7_==7)+1*(a006_8_==7)+1*(a006_9_==7)+1*(a006_10_==7)+1*(a006_11_==7)+1*(a006_12_==7)+1*(a006_13_==7)+1*(a006_14_==7)+1*(a006_15_==7)+1*(a006_16_==7)

// belwo is to create gender variable of the child with highest education
gen m=a002_1_*(e1==j)+a002_2_*(e2==j)+a002_3_*(e3==j)+a002_4_*(e4==j)+a002_5_*(e5==j)+a002_6_*(e6==j)+a002_7_*(e7==j)+a002_8_*(e8==j)+a002_9_*(e9==j)+a002_10_*(e10==j)+a002_11_*(e11==j)+a002_12_*(e12==j)
// however, above expression undergoes problem because of missing value, I have below instead
gen mmm3=a002_3_ if e3==j
gen mmm4=a002_4_ if e4==j
gen mmm5=a002_5_ if e5==j
gen mmm6=a002_6_ if e6==j
gen mmm7=a002_7_ if e7==j
gen mmm8=a002_8_ if e8==j
gen mmm9=a002_9_ if e9==j
gen mmm10=a002_10_ if e10==j
gen mmm2=a002_2_ if e2==j
gen mmm1=a002_1_ if e1==j

// below is to generate gender of the child with highest education, restored in "gender"
gen u1=2 if max(mmm3,mmm4,mmm5,mmm6,mmm7,mmm8,mmm9,mmm10,mmm1,mmm2)==2
gen u2=1 if max(mmm3,mmm4,mmm5,mmm6,mmm7,mmm8,mmm9,mmm10,mmm1,mmm2)==1
gen u3=1 if min(mmm3,mmm4,mmm5,mmm6,mmm7,mmm8,mmm9,mmm10,mmm1,mmm2)==1
gen u4=2 if min(mmm3,mmm4,mmm5,mmm6,mmm7,mmm8,mmm9,mmm10,mmm1,mmm2)==2

gen gender=1 if u2==1 & u3==1  //meaning this family has only male highest edu child
replace gender=2 if u1==2 & u4==2  //meaning this famliy has only female highest edu child
replace gender=3 if u1==2 & u3==1  //meaning this family has both male and female highest edu child

// below is to have small adjustment of gender information considering subgroup 13,14 and 15
replace gender=1 if e13==5
replace gender=1 if e14==5
replace gender=2 if e15==5
// Now we have complete information of child's gender

// I kept those variables that I need in the future below, save it in separate dta file
keep householdID  ID  communityID  j  gender  k




