MATH1309 – Practice Problems 5 

By hand

1. Evaluate T , for testing H0: μ’=[7, 11] using 

X = [
    2 12
    8 9
    6 9
    8 10
    ]

2. What distribution does T2 follow for this problem?
3. If we were using α=0.05, what conclusion do you reach?

# Hypothesis Test
We can use the code we have covered so far to conduct a hypothesis test for the mean vector.

Research Problem
Scores obtained by n=87 college students on the College Level Examination Program (CLEP) subtest X1 and College Qualification Test (CQT) subtest X2 and X3 are contained in the datafile Week_05.csv on Canvas and SAS Studio. The students underwent additional workshop training in preparation for the tests. We want to know if they have scored differently to the historical average for these tests,
μ′ = [500 50 30] (which represents the average scores for thousands of students over the last 20 years).

/*read in data*/
Data temp;
infile "/courses/dc373215ba27fe300/MATH1309/Week_05.csv" delimiter=","; 
input x1 x2 x3;
run;

proc IML;
use temp;
read all var _all_ into X;
/* 2) Calculate HotellingT^2 */
n=nrow(x); /* No. of observations */
p=ncol(x); /* No. of variables */
centre=t(mean(X));
cov_x=cov(X);
cor_x=corr(X);
incov=inv(cov_x); /* Inverse of the covariance matrix */
mu0={500,50,30}; /* Hypothesized values */
tsq=n*t(centre-mu0)*incov*(centre-mu0); /* Hoteling's T^2 */

/* 3) Find your critical value */
ccri=cinv(0.95,p);
print tsq ccri;

/* 4) Determine the lengths and directions for the axes of the 95% confidence ellipsoid for μ */
lam=eigval(cov_x); 
E=eigvec(cov_x);
length=2*sqrt(lam*ccri/n);
print length;
print E;
/* 5) Compute the simultaneous confidence interval CI of mean vector*/
sd=vecdiag(cov_x);
ubound1=centre+sqrt(ccri)*sqrt(sd/n);
lbound1=centre-sqrt(ccri)*sqrt(sd/n);
print lbound1 ubound1;

/* 6) Create a chi-square probability plot to assess all three variables, 
for multivariate normality. 
- Is the data set multivariate normal? */
/*test normality*/
mean_x=mean(x);
d2=(x-mean_x)*incov*t(x-mean_x);
mahala=vecdiag(d2);
ranks=rank(mahala);
f0=(ranks-0.5)/n;
chiq=cinv(f0,p);
chiplot=mahala||chiq;
create chiplot from chiplot[colname={'MAHDIST' 'CHISQ'}]; /*create a dataset to plot*/
append from chiplot;

proc sgplot data=chiplot; /* Run the plot procedure*/
scatter y=MAHDIST x=CHISQ;
run;

/* This used chi-square as it is considered a "large" sample. What results would you get if you considered this small and used F? */