/* ## 4 PCA's with - `track.csv` */
/* The data file `track.csv` contains information on female national track records. 
Using the file completing the following: */

proc IML;
print "a) Read the datafile";
run;
/* #### 4 a) Read the datafile */
%web_drop_table(R);
FILENAME REFFILE '/folders/myshortcuts/ass2--multivariate/data/track.csv';
PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=R;
	GETNAMES=YES;
/* 	DATAROW=2; */
RUN;

PROC CONTENTS DATA=R; 
RUN;
%web_open_table(R);

proc IML;
proc princomp data=R OUT=out; 
     title3 '4 a) Obtain the sample correlation matrix R, and determine the eigenvalue/eigenvector pairs.';
run;

data out1;
set out;
varname=scan(_name_,1,'_');
stat=scan(_name_,2,'_');
drop _name_;
run;
 
proc sort data=out1;
by varname;
run;

proc print data=out1;
title 'Looks like default printed output';
run;

/* #### b) State the first two principal components for the standardized variables and  */
/* TODO fix print */
/* PROC IML; */
/* print " */
/* PCA1 Y1 = 0.377766X1 + 0.383210X2 + 0.368036X3 + 0.394781X4 + 0.389261X5 + 0.376094X6 + 0.355203X7 */
/* PCA2 Y2 = -0.407176X1 - 0.413629X2 - 0.459353X3 + 0.161246X4 + 0.309088X5 + 0.423190X6 + 0.389215X7  */
/* Where:  */
/* X1 = 100ms */
/* X2 = 200ms */
/* X3 = 400ms */
/* X4 = 800mmin */
/* X5 = 1500mmin */
/* X6 = 3000mmin */
/* X7 = Marathonmin" */

/* calculate the cumulative percentages of the total (standardized) sample variance explained. (2 marks) */
proc princomp data=R; 
     title3 '4 b) Calculate the cumulative percentages of the total (standardized) sample variance explained. (2 marks)';
run;

/* From Eigenvalue Table */
/* X   Eigenvalue  Cumulative % */
/* X1  5.80762446  82.97% */
/* X2  0.62869342  91.95% */
/* X3  0.27933457  95.94% */
/* X4  0.12455472  97.72% */
/* X5  0.09097174  99.02% */
/* X6  0.05451882  99.80% */
/* X7  0.01430226  100.00% */


/* #### c) Prepare a table showing the correlation of the standardized variables with the first two components. */


proc iml;
	print "HERE: c) Prepare a table showing the correlation of the standardized variables with the first two components.";
run;

proc princomp data=R out=bar;
	title3 '4 b) Calculate the cumulative percentages of the total (standardized) sample variance explained. (2 marks)';
run;

proc iml;
use foo;
run;
print foo;

/* proc sort data=R; */
/* by Prin1; */
/* run; */
/* proc print; */
/* var Country Prin1; */
/* title ’Pre-Season 1985 College Basketball Rankings’; */
/* title2 ’College Teams as Ordered by PROC PRINCOMP’; */
/* run; */

/* proc iml; */
/* 	print MaxRank; */
/* run; */


/* #### d) Interpret the two principal components from Part b).(2 marks) (3 marks) */

/* #### e) Rank the nations based on their score on the first principal component.  */

proc print data=R label;run;



/* #### Discuss whether this meets your expectations. */
/* (2 marks) */