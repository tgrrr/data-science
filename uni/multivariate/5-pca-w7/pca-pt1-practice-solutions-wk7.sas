/* 1 */
proc iml;
sigma={1 4,
4 100};
eigvals=eigval(sigma);
eigvec=eigvec(sigma);
print eigvals;
print eigvec;

/* 2 State the Principal Components */
/* PC1 Y1=0.0403055X1+0.9991874X2 */
/* PC2 Y2=-0.999187X1+0.0403055X2 */

/* 3 Find the correlation of each Principal Component with each variable */
reset print;
cor_y1_x1=eigvec[1,1]*sqrt(100.16)/sqrt(1);
cor_y1_x2=eigvec[2,1]*sqrt(100.16)/sqrt(100);
cor_y2_x1=eigvec[1,2]*sqrt(0.84)/sqrt(1);
cor_y2_x2=eigvec[1,1]*sqrt(0.84)/sqrt(100);
/* note that y2 is not required as y1 explains almost 100% of the variance */

/* 4 Find the eigenvalue and eigenvectors for the corresponding correlation matrix (either by hand or using PROC IML) */
rho={1 0.4,
0.4 1};
eigvals_rho=eigval(rho);
eigvec_rho=eigvec(rho);

/* 5 State the Principal Components */
/* PC1 U1=0.7071068X1+0.7071068X2 */
/* PC2 U2=0.7071068X1-0.7071068X2 */

/* 6 Find the correlation of each Principal Component with each variable */
cor_u1_x1=eigvec_rho[1,1]*sqrt(1.4)/sqrt(1);
cor_u1_x2=eigvec_rho[2,1]*sqrt(1.4)/sqrt(1);
cor_u2_x1=eigvec_rho[1,2]*sqrt(0.6)/sqrt(1);
cor_u2_x2=eigvec_rho[1,1]*sqrt(0.6)/sqrt(1);

/* Problem 2 */
proc iml;
reset print;
sigma={9 1 2 3,
1 9 3 2,
2 3 9 1,
3 2 1 9};
eigvals=eigval(sigma);
eigvec=eigvec(sigma);

 Prove that ...
 TODOLATER:
 are the eigval eigenvector pairs of Sigma

/* PC1 Y1=-0.5X1-0.5X2-0.5X3-0.5X4 variance=15 */
/* PC2 Y2=0.5X1-0.5X2-0.5X3+0.5X4 variance=9 */
/* PC3 Y3=0.5X1-0.5X2+0.5X3-0.5X4 variance=7 */
/* PC4 Y4=-0.5X1-0.5X2+0.5X3+0.5X4 variance=5 */
/* note that these are based on the eigenvectors in the question. 
The SAS output shows some of these with reversed signs. */
/* Possibly the first three components here are important. 
However they all show an equal contribution of the variables,  */
/* some just work in different directions. */