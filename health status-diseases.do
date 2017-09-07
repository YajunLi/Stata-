// open health_status_and_functioning.dta
// critical variables are 
sum da007_1_  da007_2_  da007_3_  da007_4_  da007_5_  da007_6_  da007_7_  da007_8_  da007_9_  da007_10_  da007_11_  da007_12_  da007_13_  da007_14_ 

// below is to generate an index of severeness of diseases 
// =0 means no problem, =1 means having that problem
replace  da007_1_ =0 if da007_1_==2
replace  da007_2_ =0 if da007_2_==2
replace  da007_3_ =0 if da007_3_==2
replace  da007_4_ =0 if da007_4_==2
replace  da007_5_ =0 if da007_5_==2
replace  da007_6_ =0 if da007_6_==2
replace  da007_7_ =0 if da007_7_==2
replace  da007_8_ =0 if da007_8_==2
replace  da007_9_ =0 if da007_9_==2
replace  da007_10_ =0 if da007_10_==2
replace  da007_11_ =0 if da007_11_==2
replace  da007_12_ =0 if da007_12_==2
replace  da007_13_ =0 if da007_13_==2
replace  da007_14_ =0 if da007_14_==2

gen diseases=da007_1_+ da007_2_+ da007_3_+ da007_4_+ da007_5_+ da007_6_+ da007_7_+ da007_8_+ da007_9_+ da007_10_+ da007_11_+ da007_12_+ da007_13_+ da007_14_ 

// da010_2_s2 da010_5_s2 da010_6_s2 da010_7_s2 da010_9_s2 da010_10_s2 da010_12_s2 da010_13_s2 da011s2
sum da010_2_s2 da010_5_s2 da010_6_s2 da010_7_s2 da010_9_s2 da010_10_s2 da010_12_s2 da010_13_s2 da011s2

replace da010_2_s2=0 if da010_2_s2!=2 
replace da010_5_s2=0 if da010_5_s2!=2 
replace da010_6_s2=0 if da010_6_s2!=2 
replace da010_7_s2=0 if da010_7_s2!=2 
replace da010_9_s2=0 if da010_9_s2!=2 
replace da010_10_s2=0 if da010_10_s2!=2 
replace da010_12_s2=0 if da010_12_s2!=2 
replace da010_13_s2=0 if da010_13_s2!=2 
replace da011s2=0 if da011s2!=2 

//only through above manipulation can I do summation below, or else, there will be error!
gen wesmed=da010_2_s2+ da010_5_s2+ da010_6_s2+ da010_7_s2+ da010_9_s2+ da010_10_s2+ da010_12_s2+ da010_13_s2+ da011s2
replace wesmed=wesmed/2

// let =0 means without problem, so I change below to make it clear
replace da041=0 if da041==2

keep ID householdID communityID diseases wesmed da041 de006 











