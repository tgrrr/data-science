/* ## 4 PCA's with - `track.csv` */
/* The data file `track.csv` contains information on female national track records. 
Using the file completing the following: */

proc IML;
print "a) Read the datafile";
run;
%web_drop_table(R);
FILENAME REFFILE '/folders/myshortcuts/ass2--multivariate/data/track.csv';
PROC IMPORT DATAFILE=REFFILE 
	DBMS=CSV
	OUT=R; /* this is where we get the output with the PCA's */
	GETNAMES=YES;
/* 	DATAROW=2; */
RUN;
PROC CONTENTS DATA=R; 
RUN;
%web_open_table(R);

/*A***********************************************************************/
proc IML;
proc princomp data=R OUT=prinR; 
     title3 '4 a) Obtain the sample correlation matrix R, and determine the eigenvalue/eigenvector pairs.';
run;

proc IML; /* fix printing error */
   *';*"; run;
proc iml;
title3 '4 b) pt1) State the first two principal components for the standardized variables';
print 'PCA1 Y1 = 0.377766X1 + 0.383210X2 + 0.368036X3 + 0.394781X4 + 0.389261X5 + 0.376094X6 + 0.355203X7';
print 'PCA2 Y2 = -0.407176X1 - 0.413629X2 - 0.459353X3 + 0.161246X4 + 0.309088X5 + 0.423190X6 + 0.389215X7';
run;

data Cumulative;
length CumulativePercent $ 2;
/* title '4 b) pt2: Calculate the cumulative percentages of the total (standardized) sample variance explained. (2 marks)'; */
input X $1-15 Eigenvalue $1-15 CumulativePercentCol;
CumulativePercent = substr(X,1,2);
datalines;

X   Eigenvalue  Cumulative 
X1  5.80762446  82.97
X2  0.62869342  91.95
X3  0.27933457  95.94
X4  0.12455472  97.72
X5  0.09097174  99.02
X6  0.05451882  99.80
X7  0.01430226  100.00
;
proc print data=Cumulative;
/* var CumulativePercent Eigenvalue CumulativePercentCol; */
title3 '4 b) pt2. Calculate the cumulative percentages of the total (standardized) sample variance explained. (2 marks)';
run;

/*C***********************************************************************/
proc princomp data=R n=2 outstat=standardVariablesCorr noprint;
run;
proc print data = standardVariablesCorr;
	title3 "c) Prepare a table showing the correlation of the standardized variables with the first two components.";
 	where _TYPE_ = 'SCORE';
run;

/* proc print data=R; */
/* run;  */
/* proc print data=prinR; */
/* run;  */

proc print data=prinR;
var Country Prin1 Prin2; /* filter to only display country and first Principle Component
run; 

/*D***********************************************************************/

/* #### TODOLATER: d) Interpret the two principal components from Part b).(2 marks) */

/************************************************************************/

/* #### e) Rank the nations based on their score on the first principal component. */

proc sort data=prinR; /* rank by principle component #1 */ 
by Prin1; run;
proc print data=prinR;
var Country Prin1; /* filter to only display country and first Principle Component */
title 'e) Rank the nations based on their score on the first principal component'; 
run;