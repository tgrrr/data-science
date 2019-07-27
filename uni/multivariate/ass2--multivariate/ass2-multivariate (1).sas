
/* 
* The data file `pollution.csv` (as on Canvas and SAS Studio) contains information on air pollution measurements. 
* Using the file examine the pair of measurements
* `X5=Nitrious Oxide` and
* `X6=Ozone` 
* for bivariate normality by completing the following: 
*/

/* Importing data */


Data pollutionData;
	infile "/folders/myshortcuts/assignment2/data/pollution.csv" delimiter=","; 
	input x1-x4 nitriousOxide ozone x7;
	run;

proc IML;
	use pollutionData;
	read all var { nitriousOxide ozone } into pollution;



centrePollution=mean(pollution); /*calculate mean vector*/
covariancePollution = cov(pollution); /*calculate covariance matrix*/
correlationPollution = corr(pollution); /*calculate correlation matrix*/
columnVectorPollution = t(pollution-centrePollution); /* column vector (because it's transposed) */
distanceMeanPollution = t(columnVectorPollution)*inv(covariancePollution)*columnVectorPollution; /* calculate distances */


print distanceMeanPollution;

mahalaPollution=vecdiag(distanceMeanPollution); /*produce mahalaPollutionnobis vector*/
ranksPollution=rank(mahalaPollution); /*order distances*/
pPolution=ncol(pollution); /*number of columns*/
nPollution=nrow(pollution); /*number of rows*/

/* Compute chi-square quantiles for Mahalanombis distances using vector id.*/
relativeFrequenciesPollution=(ranksPollution-0.5)/nPollution; /* Compute the relative frequency */

chiQuantile=cinv(f0,pPollution); /* Quantile using Chi-square distribution with p degrees of freedom */
chiPlot=mahalaPollution||chiQuantile;
create chiPlot from chiPlot[colname={'MAHDIST' 'CHISQ'}]; /*create a dataset to plot*/
append from chiPlot;
proc sgplot data=chiPlot; /* Run the plot procedure*/
scatter y=MAHDIST x=CHISQ;
run;


