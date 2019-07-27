/*Example PC and CI*/
proc iml;
reset print;
s={4 1 1,
1 3 2,
1 2 2};
eig=eigval(s);
e_vec=eigvec(s);
CI_1_lower=eig[1]/(1+1.645*sqrt(2/9));
CI_1_upper=eig[1]/(1-1.645*sqrt(2/9));
CI_2_lower=eig[2]/(1+1.645*sqrt(2/9));
CI_2_upper=eig[2]/(1-1.645*sqrt(2/9));
CI_3_lower=eig[3]/(1+1.645*sqrt(2/9));
CI_3_upper=eig[3]/(1-1.645*sqrt(2/9));

/*Intraclass covariance test*/
proc iml;
reset print;
p=5;
n=14;
s=p-1;
k=0.5*s*(s+1)-1;
chi_critical=cinv(0.95,k);
lam_av=1/(p-1)*(1.7867+0.3892+0.2300+0.0143);
q=(p-1)*(n-1)*log(lam_av)-(n-1)*(log(1.7867)+log(0.3892)+log(0.2300)+log(0.0143));
run;





/*read in sample information*/
data bright;
input b1 b2 b3 b4;
datalines;
19 15 22 11
21 15 22 12
19 13 25 14
28 27 41 21
21 15 25 13
21 17 23 12
19 16 24 12
19 12 25 14
28 29 17 3
28 26 41 21
19 16 24 12
29 32 17 3
19 16 22 12
19 16 24 12
25 25 38 20
20 29 19 3
28 29 18 2
25 26 42 21
21 18 12 12
26 24 43 21
30 31 18 3
28 27 44 24
30 31 18 2
30 31 18 2
21 16 22 12
;
run;

/* find covariance and correlation for sample data */
proc corr data=bright cov;
run;
/* find principal components from covariance matrix */
proc princomp data=bright cov;
run;
/* find principal components from correlation matrix */
proc princomp data=bright;
run;

