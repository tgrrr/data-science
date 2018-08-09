
/* QUESTION 4 */
proc iml;
reset print;

data iceland;
infile "/folders/myfolders/sasuser.v94/iceland.csv" delimiter=",";
input TEMP PSAL DOXY NTRA PHOS SLCA;
run;

/* ## b) Produce the appropriate univariate descriptive statistics for each variable in the dataset using SAS code. */

proc means data = iceland;
var TEMP PSAL DOXY NTRA PHOS SLCA;
run;

/* ## c) Choose an appropriate method to plot the dataset */

proc sgplot data=iceland;
var TEMP PSAL DOXY NTRA PHOS SLCA;
scatter x=TEMP y=DOXY;
run;

/* ## d) Produce the covariance matrix for the dataset */

proc CORR DATA=iceland COV;
var TEMP PSAL DOXY NTRA PHOS SLCA;
run;

/* ## e) Produce the correlation matrix for the dataset */

proc corr data = iceland;
var TEMP PSAL DOXY NTRA PHOS SLCA;
run;

/* ## f) Using your answers from part b) to part e) above, summarise your exploration of the dataset and identify any potential issues arising from this exploration. (5 marks) */