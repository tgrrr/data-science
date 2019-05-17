/* ## 1 Bivariate normal distribution for `polution.csv` */

/* 
* The data file `pollution.csv` (as on Canvas and SAS Studio) contains information on air pollution measurements. 
* Using the file examine the pair of measurements
* `X5=Nitrious Oxide` and
* `X6=Ozone` 
* for bivariate normality by completing the following: 
*/

Data pollutionData;
	infile "/folders/myshortcuts/assignment2/data/pollution.csv" delimiter=","; 
	input x1-x4 nitriousOxide ozone x7;
	run;

proc IML;
	use pollutionData;
	read all var { nitriousOxide ozone } into pollution;

/* #### a) Calculate the distances of these observations from their means (2 marks) */

centrePollution=mean(pollution); /*calculate mean vector*/
covariancePollution = cov(pollution); /*calculate covariance matrix*/
correlationPollution = corr(pollution); /*calculate correlation matrix*/
columnVectorPollution = t(pollution-centrePollution); /* column vector (because it's transposed) */
distanceFromMeanPollution = t(columnVectorPollution)*inv(covariancePollution)*columnVectorPollution; /* calculate distances */

print distanceFromMeanPollution;

/* #### Mahala vector */
mahalaPollution=vecdiag(distanceFromMeanPollution); /*produce mahalaPollutionnobis vector*/
ranks=rank(mahalaPollution); /*order distances*/

/* #### b) Determine the proportion of the observations falling within the estimated 
* `50% probability contour` of a bivariate normal distribution (1 mark) 
*/



/* proc iml;
use timber;
read all var {x1 x2} into A; */
pollutionInv=inv(cov(pollution));
pollutionMean=mean(pollution);
values=(pollution-pollutionMean)*pollutionInv*t(pollution-pollutionMean);
numbers=vecdiag(values);
outside=numbers>1.39;
inside=numbers<=1.39;
o_count=sum(outside);
i_count=sum(inside);
print o_count;
print i_count;


/* #### c) Construct a chi-square plot of your distances from part a) above (2 marks) */

pPolution=ncol(pollution); /*number of columns*/
nPollution=nrow(pollution); /*number of rows*/

/* Compute chi-square quantiles for Mahalanombis distances using vector id.*/
relativeFrequenciesPollution=(ranks-0.5)/nPollution; /* Compute the relative frequency */
chiQuantile=cinv(f0,pPolution); /* Quantile using Chi-square distribution with p degrees of freedom */
chiPlot=mahalaPollution||chiQuantile;
create chiPlot from chiPlot[colname={'MAHDIST' 'CHISQ'}]; /*create a dataset to plot*/
append from chiPlot;


/* #### d) Given your results in part b) and part c) are these data approximately bivariate normal?  */
/* #### Explain. (3 marks) */


/* From Week 4:

/* data example4; */
/* infile "/courses/dc373215ba27fe300/MATH1309/Example_4.DAT"; */
/* input x1 x2 x3 x4; */
/* run; */
/*  */
/* proc iml; */
/* use example4; */
/* reset print; */
/* read all var _all_ into x; */

/* centre=mean(x); /*calculate mean vector */
/* cov=cov(x); /*calculate covariance matrix */
/* cor=corr(x); /*calculate correlation matrix */
/* print centre cov; */
/* y = t(x-centre); /* col vector */
/* d2 = t(y)*inv(cov)*y; /* calculate distances */
/* mahala=vecdiag(d2); /*produce mahalanobis vector */
/* ranks=rank(mahala); /*order distances */
/* p=ncol(x); /*number of columns */
/* n=nrow(x); /*number of rows */
/*  */
/* Compute chi-square quantiles for Mahalanombis distances using vector id. */
/* f0=(ranks-0.5)/n; /* Compute the relative frequency */
/* chiq=cinv(f0,p); /* Quantile using Chi-square distribution with p degrees of freedom */
/* chiplot=mahala||chiq; */
/* create chiplot from chiplot[colname={'MAHDIST' 'CHISQ'}]; /*create a dataset to plot */
/* append from chiplot; */
/*  */
/* proc sgplot data=chiplot; /* Run the plot procedure */
/* scatter y=MAHDIST x=CHISQ; */
/* run; */
/*  */
