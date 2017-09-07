// first conduct ols 
eststo: quietly reg educch2013 D1 if gender4==1
eststo: quietly reg educch2013 D1 numch2013 if gender4==1
eststo: quietly reg educch2013 D1 numch2013 da041 diseases wesmed if gender4==1


// IV reg below
eststo: quietly ivregress 2sls educch2013 (D1=marry) if gender4==1,robust 
eststo: quietly ivregress 2sls educch2013 numch2013 (D1=marry) if gender4==1,robust 
eststo: quietly ivregress 2sls educch2013 numch2013 da041 diseases wesmed (D1=marry) if gender4==1,robust
eststo: quietly ivregress 2sls educch2013 numch2013 jc023 ja035 (D1=marry) if gender4==1,robust
esttab, se

// compare with girls and both 
eststo: quietly ivregress 2sls educch2013 numch2013 (D1=marry) if gender4==1,robust
eststo: quietly ivregress 2sls educch2013 numch2013 (D1=marry) if gender4==2,robust
eststo: quietly ivregress 2sls educch2013 numch2013 (D1=marry) if gender4==3,robust

// simple compare ols with IV 
eststo: quietly reg educch2013 D1 numch2013 if gender4==1
eststo: quietly ivregress 2sls educch2013 numch2013 (D1=marry) if gender4==1

// to produce a table 
ssc install outreg2, replace
* (1)
reg educch2013 D1 numch2013 if gender4==1,robust noheader
outreg2 using table.doc, replace keep(educch2013 D1 numch2013 da041 wesmed diseases jc023 ja035 marry) title(OLS and IV with boys, the causal effect of strategic under-investment of boys in rural areas China) ctitle(OLS) nocons label addtext(Family covariates, No, Community covariates, No) addnote("Data Source: China Health and Retirement Longitudinal Study, 2011 to 2013 wave. Sample size is 14603") 
* (2)
ivregress 2sls educch2013 numch2013 (D1=marry) if gender4==1,robust noheader
outreg2 using table.doc, ctitle(TSLS) append keep(educch2013 D1 numch2013 marry) nocons addtext(Family covariates, No, Community covariates, No) 
* (3) only add family covariates
reg educch2013 D1 numch2013 da041 wesmed diseases if gender4==1,robust noheader
outreg2 using Table.doc,append keep(educch2013 D1 numch2013 da041 wesmed diseases marry) ctitle(OLS) nocons addtext(Family covariates, Yes, Community covariates, No)
* (4)
ivregress 2sls educch2013 numch2013 da041 wesmed diseases (D1=marry) if gender4==1,robust noheader 
outreg2 using Table.doc,append keep(educch2013 D1 numch2013 da041 wesmed diseases marry) ctitle(TSLS) nocons addtext(Family covariates, Yes, Community covariates, No) 
* (5) add community covariates
reg educch2013 D1 numch2013 jc023 ja035 if gender4==1,robust noheader  
outreg2 using Table.doc,append keep(educch2013 D1 numch2013 da041 wesmed diseases jc023 ja035 ) ctitle(OLS) noaster nocons addtext(Family covariates, No, Community covariates, Yes) 
* (6)
ivregress 2sls educch2013 numch2013 jc023 ja035 (D1=marry) if gender4==1,robust noheader
outreg2 using Table.doc,append keep(educch2013 D1 numch2013 da041 wesmed diseases jc023 ja035 marry) ctitle(TSLS) nocons addtext(Family covariates, No, Community covariates, Yes) 
* (7) add both covariates in 7,8 column
reg educch2013 D1 numch2013 da041 wesmed diseases jc023 ja035 if gender4==1,robust noheader  
outreg2 using Table.doc,append keep(educch2013 D1 numch2013 da041 wesmed diseases jc023 ja035 marry) ctitle(OLS) nocons addtext(Family covariates, Yes, Community covariates, Yes) 
* (8)
ivregress 2sls educch2013 numch2013 da041 wesmed diseases jc023 ja035 (D1=marry) if gender4==1,robust noheader
outreg2 using Table.doc,append keep(educch2013 D1 numch2013 da041 wesmed diseases jc023 ja035 marry) ctitle(TSLS) nocons addtext(Family covariates, Yes, Community covariates, Yes) 



//see the education attainment of rural and urban 
sum educch2013 if gender2==1 & a001==1
sum educch2013 if gender3==2 & a001==1
sum educch2013 if a001==2


//decompose IV into two stage OLS  (jc023 ja035 wesmd diseases)
reg D1 marry numch2013 if gender4==1
// generate fitted value of D1 in Dhat
predict Dhat
eststo: quietly reg educch2013 Dhat numch2013 if gender4==1
eststo: quietly ivregress 2sls educch2013 numch2013 (D1=marry) if gender4==1
esttab, se

// Wald estimate
sum educch2013 if gender4==1 & marry==0
sum educch2013 if gender4==1 & marry==1










