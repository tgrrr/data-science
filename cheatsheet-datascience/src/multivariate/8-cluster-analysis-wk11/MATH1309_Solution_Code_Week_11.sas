/* Question 1 */
data ex1 (type=distance);
input x1-x5;
datalines;
0 4 6 1 6
4 0 9 7 3
6 9 0 10 5
1 7 10 0 8
6 3 5 8 0
;
run;

proc cluster nonorm method=single data=ex1;
run;

proc cluster nonorm method=complete data=ex1;
run;

proc cluster nonorm method=average data=ex1;
run;



/*Question 2*/
DATA Example17;
INFILE "/courses/dc373215ba27fe300/MATH1309/Example17.dat";
INPUT Site $ x1-x8;
run;

proc cluster method=single data=Example17;
var x1-x8;
id Site;
run;

proc cluster method=complete data=Example17;
var x1-x8;
id Site;
run;

proc cluster method=average data=Example17;
var x1-x8;
id Site;
run;

proc fastclus data=example17 maxclusters=3 list;
var x1-x8;
id Site;
run;
