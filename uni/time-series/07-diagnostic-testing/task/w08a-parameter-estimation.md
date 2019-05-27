# w08 Parameter estimation + Model diagnostics

2 parts
1. Parameter estimation - module 6
2. Model diagnostics - module 7



When:
- Right after the uni break
- the lecture we missed because of Ash's parent's, and Ash listened to separately
- watched it on old laptop in study

Includes
- method moments
- least squared
- maximum likelyhook
- unconditional least squares
- bootstrap arima (not in exam)

package:

`lmtest`

## Method of moments

### is:

Theoretical moments
- context of probability!



first, second, and third central moment

1. 1st estimator mu is first sample average moment
  estimator is sample average
2. variance is second sample moment sample



## How to implement methods in R

See Numerical examples slide 8/94

[numerical-example-ts](/assets/numerical-example-ts.png)

Assess Compare methods to true 

```R
estimate.ma.1.mom <- function(x) {
  r=acf(x, plot=F)$acf[1]
  
  if (abs(r)<0.5)
    return((-1+sqrt(1-4*r^2))/(2*r))
  else
    return(NA)
}

data(ma1.2.s)
data(ma1.1.s)
```

generate a series of 60 with lag of 0.9

```R
ma1.3.s= arima.sim(list(ma = c(0.9)), n = 60)
ma1.4.s= arima.sim(list(ma = c(-0.5)), n = 60)

estimate.ma1.mom(ma1.3.s)
```

```R
data(ar2)
# set method = yw => 
ar(ar1.s, order.max=1, AIC=F, method='yw')
```
- we need the Order = 1 for the ?adf test


This is the return series
r.cref=diff(log(CREF))


arch: slide 23

3 lags above line

4 onwards

arch will be skewed, and some kind of thin line indicator