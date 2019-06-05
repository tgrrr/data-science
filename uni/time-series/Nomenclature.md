# Nomenclature
## MATH1318 Time Series Analysis
- see html doc for better version

Prepared by: Dr. Haydar Demirhan based on the textbook by Cryer and Chan, Time Series Analysis with R, Springer, 2008.
Module 1

rv
: Random variable.
{Yt,t=1,2,…,n}: Representation of a time series.
E(⋅): Expected value of inner rv.
Var(⋅): Variance value of inner rv.
Cov(⋅,⋅): Covariance of inner rvs.
Corr(⋅,⋅): Correlation between inner rvs.
ρt,s: Correlation between lags t and s of a time series data.
γt,s: Covariance between lags t and s of a time series data.
| ⋅   | : Absolute value. |
| --- | ----------------- |
σ2e: Variance of random series e.
e1,e2,…: a sequence of independent, identically distributed random variables each with zero mean and variance σ2e.
∇Yt: First difference of successive Y

-series.
Module 2

μ
: Mean of series.
μt: Mean at time point t.
ρk: Autocorrelation of series at lag k.
γk: Autocovariance of series at lag k.
β: Regression coefficient.
β̂: Estimate of regression coefficient.
⋅¯: Average of inner expression.
⋅̂ : Estimate of inner expression.
f: frequency of a curve.
Phi: phase of the curve.
π: the Pi number.
s: Standard deviation.
R2: coefficient of determination.
rk: sample autocorrelation function at lag k

.
Module 3

μ
: Mean of series.
Ψi: Coefficients of general linear process.
{et}: Sequence of uncorrelated rvs.
ϕ: Coefficients of general linear process defined in between -1 and 1.
θi: Coefficients of moving average process.
MA(q): Moving average process of order q.
ϕi: Coefficients of autoregressive process.
AR(p): Autoregressive process of order q.
ARMA(p,q): Autoregressive moving average process of order p and q

.
Module 4

{Xt}
: A zero-mean time series.
∇dYt: The dth difference of successive Y-series.
d: Consistently with the above definition, the order of differencing.
Mt: A stochastic or deterministic series.
ARIMA(p,d,q): Integrated autoregressive moving average process of order p, q and d times of differencing.
IMA(d,q): Integrated moving average process of order q and d times of differencing.
ARI(p,d): Integrated autoregressive process of order p and d times of differencing.
g(x): Box-Cox transformed rv.
λ: The parameter of Box-Cox transformation.
log(⋅)

: Natural logarithm of inner experssion.
Module 5

{Xt}
: A zero-mean time series.
ϕkk: Partial autocorrelation at lag k.
AIC:Akaike’s Information Criterion.
AIC:Corrected version of Akaike’s Information Criterion.
BIC

: Bayesian Information Cariterion.
Module 6

Sc(⋅)
: Conditional sum of squares function for inner parameters.
S(⋅): Unconditional sum of squares function for inner parameters.
L(⋅): Likelihood function of inner parameters.
ℓ(⋅): Natural logarithm of likelihood function of inner parameters.
Y∗t

: Bootstap time series.
Module 7

πi
: Coefficients of residual series.
Q: Box and Pierce statistic.
r̂ k: Sample autocorrelation at lag k

.
Module 8

Θ⋅
: Seasonal moving average parameter.
Φ⋅: Seasonal autoregressive parameter.
s: Seasonal period.
∇DsYt: the dth seasonal difference of period s.
St: Seasonal random walk series.
ϵt: White noise series.
ξt: White noise series.
≪: Too much less than. <brSARIMA(p,d,q)×(P,D,Q)s: Seasonal integrated autoregressive moving average process if reqular orders p,d, and q, and seasonal ordes P,D, and Q

.
Module 9

{rt}
: Return series.
σ2t|t−1: Conditional volatility of return series.
ηt: Zero-mean series.
ARCH(p): Autoregressive Conditional Heteroskedasticity model of order p.
GARCH(p,q): Generalised Autoregressive Conditional Heteroskedasticity model of orders p and q.
ω: Coefficient of ARCH/GARC models.
αi

: Coefficients of GARCH model.
