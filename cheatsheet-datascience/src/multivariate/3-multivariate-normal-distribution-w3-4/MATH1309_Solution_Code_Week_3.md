data example4;
infile "/courses/dc373215ba27fe300/MATH1309/Example_4.DAT";
input x1 x2 x3 x4;
run;

proc iml;
use example4;
reset print;
read all var _all_ into x;
centre=mean(x); /*calculate mean vector*/
cov=cov(x); /*calculate covariance matrix*/
cor=corr(x); /*calculate correlation matrix*/
print centre cov;
y = t(x-centre); /* col vector */
d2 = t(y)*inv(cov)*y; /* calculate distances */
mahala=vecdiag(d2); /*produce mahalanobis vector*/
ranks=rank(mahala); /*order distances*/
p=ncol(x); /*number of columns*/
n=nrow(x); /*number of rows*/

/* Compute chi-square quantiles for Mahalanombis distances using vector id.*/
f0=(ranks-0.5)/n; /* Compute the relative frequency */
chiq=cinv(f0,p); /* Quantile using Chi-square distribution with p degrees of freedom */
chiplot=mahala||chiq;
create chiplot from chiplot[colname={'MAHDIST' 'CHISQ'}]; /*create a dataset to plot*/
append from chiplot;



proc sgplot data=chiplot; /* Run the plot procedure*/
scatter y=MAHDIST x=CHISQ;
run;

