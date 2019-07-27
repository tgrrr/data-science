/* Example 3 */
data notes (type=cov);
input group$ _name_$ _type_$ x1 x2 x3;
datalines;
real x1 cov 3.1 2.2 5.1
real x2 cov 2.2 4.1 2.4
real x3 cov 5.1 2.4 15.1
real . mean 2.1 5.3 4.0
real . N 50 50 50
fake x1 cov 2.9 2.8 5.1
fake x2 cov 2.8 4.0 2.6
fake x3 cov 5.1 2.6 14.9
fake . mean 8 10.1 5.0
fake . N 26 26 26
;

/* first note */
data x0;
input x1 x2 x3;
datalines;
6 9 4.1
;
run;

proc discrim data=notes testdata=x0;
class group;
run;

/* second note */
data x0;
input x1 x2 x3;
datalines;
2.1 4.9 4.9
;
run;

proc discrim data=notes testdata=x0;
class group;
run;

/* Example 4 */
data ex4 (type=cov);
input group$ _name_$ _type_$ x1 x2;
datalines;
1 x1 cov 1 1
1 x2 cov 1 4
1 . mean 0 0
1 . N 10000 10000
2 x1 cov 4 -2
2 x2 cov -2 16
2 . mean 2 3
2 . N 10000 10000
;

/* first obs */
data x0;
input x1 x2;
datalines;
1 1
;
run;

proc discrim data=ex4 testdata=x0;
/*note that there is no separate argument for costs, so this is built into the priors
where psi=cost1*prior1/(cost1*prior1+cost2*prior2)*/
prior '1'=0.4 '2'=0.6;
class group;
run;

/* second obs */
data x0;
input x1 x2;
datalines;
2 -3
;
run;

proc discrim data=ex4 testdata=x0;
prior '1'=0.4 '2'=0.6;
class group;
run;

/*Example 5*/
data ex5 (type=cov);
input group$ _name_$ _type_$ x1 x2;
datalines;
1 x1 cov 1 -1
1 x2 cov -1 4
1 . mean -1 3
1 . N 10 10
2 x1 cov 4 1
2 x2 cov 1 9
2 . mean 0 -2
2 . N 15 15
;

/* first obs */
data x0;
input x1 x2;
datalines;
0.5 1
;
run;

proc discrim data=ex5 testdata=x0;
prior '1'=0.4 '2'=0.6;
class group;
run;

/* second obs */
data x0;
input x1 x2;
datalines;
-1 -3
;
run;

proc discrim data=ex5 testdata=x0;
prior '1'=0.4 '2'=0.6;
class group;
run;

/*Problem 6*/
Data eg15;
infile "/courses/dc373215ba27fe300/MATH1309/Example15.dat";
input gpa gmat Pop;
run;

proc discrim data=eg15 pool=yes listerr crosslisterr;
class pop;
run;

/* APER=4/57=7% */
/* E(AER)=5/57=8.8% */
