

TODOLATER: more here

estimate a suitable orthogonal factor model
/*Example 3*/
data ex3 (type=cov);
input _type_$ x1-x3;
datalines;
cov 19 30 2
cov 30 57 5
cov 2 5 38
n 25 25 25
mean 5 10 8
;

/*Explore adding different rotate= options in your proc factor code to get an orthogonal model*/
proc factor data=ex3 method=principal cov p=80 rotate=varimax;
run;


/*Example 4*/
data ex4 (type=cov);
input _type_$ x1-x4;
datalines;
cov 18.87 26.86 7.55 -5.15
cov 26.86 47.24 5.10 -15.23
cov 7.55 5.1 92.19 58.89
cov -5.15 -15.23 58.89 48.52
n 25 25 25 25
;

proc factor data=ex4 method=principal cov;
run;

/*Example 5*/
data ex5 (type=corr);
input _type_$ x1-x7;
datalines;
corr 1.00 0.55 0.40 0.53 0.45 0.47 0.28
corr 0.55 1.00 0.43 0.75 0.35 0.42 0.18
corr 0.40 0.43 1.00 0.31 0.45 0.21 0.15
corr 0.53 0.75 0.31 1.00 0.64 0.40 0.44
corr 0.45 0.35 0.45 0.64 1.00 0.48 0.25
corr 0.47 0.42 0.21 0.40 0.48 1.00 0.01
corr 0.28 0.18 0.15 0.44 0.25 0.01 1.00
n 30 30 30 30 30 30 30
;

proc factor data=ex5 method=m;
run;

/*Example 7*/
data ex6 (type=corr);
input _type_$ x1-x5;
datalines;
corr 1.00 0.79 0.42 0.71 0.50
corr 0.79 1.00 0.01 0.85 0.11
corr 0.42 0.01 1.00 0.02 0.96
corr 0.71 0.85 0.02 1.00 0.13
corr 0.50 0.11 0.96 0.13 1.00
n 50 50 50 50 50
;
run;

ods graphics on;

proc factor data=ex6 method=m rotate=varimax plots=all;
run;
