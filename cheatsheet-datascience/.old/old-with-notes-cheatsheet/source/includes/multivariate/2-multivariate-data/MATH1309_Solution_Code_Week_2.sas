x/*Code problems (week 1 by hand)*/
proc iml;
reset print;
A={-1 3,
4 2};
B={4 -3,
1 -2,
-2 0};
C={5,-4,2};

ans_a=5*A;
ans_b=B*A;
ans_c=t(A)*t(B);
ans_d=t(C)*B;
ans_e=A*B; /*gives error, matrices do not conform*/

A={9 -2,
  -2 6};

## 2 or 1 a) Find the eigenvalues and the eigenvectors of A

proc iml;
reset print;
A={9 -2,
-2 6};
lambda=eigval(A);
e=eigvec(A);

