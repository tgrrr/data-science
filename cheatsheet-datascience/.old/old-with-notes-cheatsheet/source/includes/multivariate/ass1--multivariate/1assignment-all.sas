proc iml;
reset print;

/* QUESTION 1 */
 
A = {
     2 2,
    -1 1
};
 
B = {
     5  1,
     4 -2,
    -1  2
};
 
C = {
     6,
    -2,
     1  
};
 
A_transposed = T(A);
B_transposed = T(B);
C_transposed = T(C);

/* 1a.  */

Ctranspose_x_B = C_transposed * B;

/* 1b. */

A_transposed_x_B_transposed = A_transposed * B_transposed;

/* 1c. */

B_x_A = B * A;

/* 1d. */

B_x_A = B * A;

/* QUESTION 2 */

F = {
  4 0 0,
  0 9 0,
  0 0 1
};

F_transpose = T(F);

/* 2a. */
G = F * F_transpose;

q2b_G_eigenvalues = eigval(G);

q2b_G_eigenvector = eigvec(G);

/* QUESTION 3 */

/* d */

means = {
	4,
	3,
	2,
	1
};

A = {
	1, 
	-1
	};

X1mean = {
	4, 
	3 
};

/*  3 h. =  */

B = {
2 -1,
0  1
};

X_b = {
9 -2,
-2 4
};

q3_h_Cov_B_Xb = T(B) * X_b * B;

/* 3 i. */

q3_i_Cov_A_x_Xa_B_x_Xb = T(A) * B * {2 2, 1 0};



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