MATH1309 – Practice Problems 4

<div>
$$
\begin{array}{cc}
  a & b \\\\
  c & c
\end{array}
$$ 
</div>

TODOLATER:
By hand (note that after Week 4 lecture you should be able to answer the last two
questions from Practice Problem 3)

### 1. Let X be 𝑁v3(𝝁, 𝚺) 

with 𝝁′ = [−3,1,4] 

and 𝚺 = [ <br />
  1 -2 0, <br />
  -2 5 0, <br />
  0 0 2 <br />
]

Which of the following random variables are independent? Explain.

#### d. todolater:

Xv1 + Xv2     and Xv3
________
   2

#### e. TODOLATER:

`X2 andX2 − (5/2)X1 −𝑋3`

# SAS

PROC IML
Adding in the line `Use` allows you to refer to a dataset that already exists in SAS. 
This may be a data set that you have read in from a file using a DATA step first.
You can also specify the variables that you want to read in by listing them in the curly brackets.

## Test for Bivariate Normality

### Confidence ellipse
- We can determine the number of observations that occur inside the contour or outside using PROC IML. 
- This can help to determine if we have multivariate normality, due to the properties of subsets of a multivariate normally distributed random vector.

1. Read in the Data file Timber.DAT as on SAS Studio and Canvas

```SAS
/* Importing data */
Data pollutionData;
	infile "./data/pollution.csv" delimiter=","; 
	input x1-x4 NITRIOUSOXIDE OZONE x7;
	run;

proc IML;
	use pollutionData;
	read all var { NITRIOUSOXIDE OZONE } into pollution;

```

assignment:
```SAS
/* Importing data */
Data pollutionData;
	infile "./data/pollution.csv" delimiter=","; 
	input x1-x4 NITRIOUSOXIDE OZONE x7;
	run;
    
proc iml;
use pollutionData;
read all var { NITRIOUSOXIDE OZONE } into pollution;
```

2. Create a scatter matrix of the variables

```SAS
proc sgscatter data=timber;
matrix x1 x2 x3 x4;
run;
```

3. Determine if there is bivariate normality by finding where the observations lie in relation to the confidence ellipse

##### a. Find the Mahalanobis distances for x1 and x2

###### i. Determine how many observations are outside the ellipse, ie larger than χv2(0.5)=1.39

TODOLATER: where are we getting 1.39 from?

```SAS
/* x1 and x2 */
proc iml;
use timber;
read all var {x1 x2} into A;
S_inv=inv(cov(A));
A_mean=mean(A);
values=(A-A_mean)*S_inv*t(A-A_Mean);
numbers=vecdiag(values);
outside=numbers>1.39;
inside=numbers<=1.39;
o_count=sum(outside);
i_count=sum(inside);
print o_count;
print i_count;
```

###### ii. Determine how many observations are smaller (or equal to) χ2(0.5)=1.39 and inside the ellipse

###### b. Find the Mahalanobis distances for x2 and x3

###### i. Determine how many observations are outside the ellipse, ie larger than χ22(0.5)=1.39

```SAS
/* all */
proc iml;
use timber;
read all var {x1 x2 x3 x4} into A;
centre=mean(A);  /*calculate mean vector*/
cov=cov(A);  /*calculate cov matrix*/
cor=corr(A);  /*calculate correlation matrix*/
y = t(A-centre); /* col vector */
d2 = t(y)*inv(cov)*y; /* calculate distances */
D=vecdiag(d2); /* produce Mahalanobis vector */
```

assignment:
```SAS
centrePollution=mean(pollution); /*calculate mean vector*/
covariancePollution=cov(pollution); /*calculate cov matrix*/
correlationPollution=corr(pollution); /*calculate correlation matrix*/
/* print centrePollution covariancePollution; */
columnVectorPollution = t(pollution-centrePollution); /* col vector */
distancesPollution = t(columnVectorPollution)*inv(covariancePollution)*columnVectorPollution; /* calculate distances */
/* print distancesPollution; */
mahalaPollution=vecdiag(distancesPollution); /*produce Mahalanobis vector*/
/* print mahalaPollution; /*produce Mahalanobis vector*/ */
```


###### ii. Determine how many observations are smaller (or equal to) χ22(0.5)=1.39 and inside the ellipse

```SAS
/* x2 and x3 */
proc iml;
use timber;
read all var {x2 x3} into A;
S_inv=inv(cov(A));
A_mean=mean(A);
values=(A-A_mean)*S_inv*t(A-A_Mean);
numbers=vecdiag(values);
outside=numbers>1.39;
inside=numbers<=1.39;
o_count=sum(outside);
i_count=sum(inside);
print o_count;
print i_count;
```

#### 4. Create a chi-square probability plot to assess the random vector, with all four variables, for multivariate normality.

```SAS

ranks=rank(D);
p=ncol(A);
n=nrow(A);
f0=(ranks-0.5)/n; 
chiq=cinv(f0,p); 
chiplot=D||chiq;
create chiplot from chiplot[colname={'MAHDIST' 'CHISQ'}]; 
append from chiplot;

proc sgplot data=chiplot;
scatter y=MAHDIST x=CHISQ;
run;

```

TODOLATER:
#### Is the data set multivariate normal?
