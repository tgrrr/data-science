DATA Example_4;

  INFILE '/home/s37255470/my_courses/alice.johnstone0/MATH1309/Example_4.DAT';

   INPUT example4 $ x1 x2 x3 x4;

   if _n_ <= 30 then list ;

RUN;

/* X is N<sub>3</sub>(u, E) with u = [ -3, 1, 4 ] */

/* something =  */
/* { 1 -2 0, */
/*  -2 5 0, */
/*  0 0 2 } */
 
u = { -3, 1, 4 }


/* ------------------- */

proc iml;

use example4;

read all var _all_ into x;

reset print;

x_mean = mean(x);

x_covariance = cov(x);

x_corrolation = corr(x);


/* figuring out Madist?  */


dif = (x - x_mean)

/* Get mah */

mah = dif * s_inv * t(dif)

/* Get vector diagram */

D = vectordiag(mah);

/* getting ranks */

ranks=rank(D);
n=rows(x);
/*  get number of  */
f0=rank(ranks - 0.5)



/* Chi squared bit here */
