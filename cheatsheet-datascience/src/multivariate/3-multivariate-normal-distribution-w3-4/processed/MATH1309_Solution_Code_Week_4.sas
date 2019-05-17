data timber;
infile "/courses/dc373215ba27fe300/MATH1309/Timber.DAT";
input x1-x4;
run;

proc sgscatter data=timber;
matrix x1 x2 x3 x4;
run;

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

/* all */
proc iml;
use timber;
read all var {x1 x2 x3 x4} into A;
centre=mean(A);
cov=cov(A);
cor=corr(A);
y = t(A-centre);
d2 = t(y)*inv(cov)*y;
D=vecdiag(d2); 
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