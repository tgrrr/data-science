proc iml;
reset print;

/* Cov(aX<sub>1</sub>, bX<sub>2</sub>) = abσ<sub>12</sub> */

/* 3 j) */

B = {
2 -1,
0  1
};

J = T(B) * COV(B) * B;

/* 3 h) */

