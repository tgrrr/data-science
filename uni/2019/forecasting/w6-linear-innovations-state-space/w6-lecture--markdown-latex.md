# Module 6 - Linear Innovations State Space Models
### MATH1307 Forecasting

* Introduction
* Generalisation of State Space Model for All Exponential Smoothing Methods
* Model Selection
* The General Linear Innovations State Space Model
* Innovations and One-Step-Ahead Forecasts
* Model Properties
* Stability and Forecastability
* Stationarity
* Local Trend Model: ETS(A,A,N)
* Basic Special Cases
* Local Level Model: ETS(A,N,N)
* Local Additive Seasonal Model: ETS(A,A,A)
* Variations on the Common Models
* Local Level Model with Drift
* Damped Trend Model: ETS(A,Ad,N)
* Summary
* References

Prepared by: Dr. Haydar Demirhan based on the textbook by Hyndman et al., Forecasting with Exponential Smoothing: The State Space Approach. Springer, 2008

#### Introduction

tl;dr
**linear innovations state-space models** = ==6/15 exponential smoothing methods involved linear relationships.==

We will cover

*   the generalisation of state-space model for all exponential smoothing methods,
*   model selection
*   the general linear innovations state-space model
*   a simple algorithm for computing the one-step prediction errors (or innovations)
*   the properties of the models, including stationarity and stability
*   some basic innovations state-space models, and
*   variations of the basic innovations state-space models.

#### Generalisation of State Space Model for All Exponential Smoothing Methods

The general model involves a state vector $\boldsymbol{X}_{t} = (\ell_{t}, b_{t}, s_{t}, s_{t−1}, \dots , s_{t−m+1})'$ and state space equations of the form

$$
\begin{array}{rl} Y_{t}&= w(\boldsymbol{X}_{t-1})+r(\boldsymbol{X}_{t-1})\epsilon_{t},\\ \boldsymbol{X}_{t}&=f(\boldsymbol{X}_{t-1})+g(\boldsymbol{X}_{t-1})\epsilon_{t}. \end{array}
$$


- where $\{\epsilon_{t}\}$ is a white noise process with
- $N(o,\sigma^{2})$ and 
- $\mu_{t}=w(\boldsymbol{X}_{t-1})$. 

We have the following generalizations:

*   The model with additive errors has $r(\boldsymbol{X}_{t-1})=1$,so that $Y_{t} =\mu_{t}+\epsilon_{t}$.
*   The model with multiplicative errors has $r(\boldsymbol{X}_{t-1})= \mu_{t}$, so that $Y_{t} =\mu_{t}(1+\epsilon_{t})$.


Thus, the relative error for the multiplicative model is $\epsilon_{t} = (Y_{t} − \mu_{t})/\mu_{t}$. Any value of $r(\boldsymbol{X}_{t-1})$ yields identical point forecasts for $Y_{t}$.

All the models for the methods considered in Table 1 are given in Table 2.1. of the Textbook shown below (Hyndman et al., 2008, p. 18)

<!-- <img width="808" height="509" src=":/e51e017b866343799d5ce22478ed0035"/> -->

So, any of the methods in Table 2.1 of the Textbook can be formulated with equations in (19). Multiplicative error models are given in Table 2.2 of the Textbook shown below (Hyndman et al., 2008, p. 21)

<!-- <img width="808" height="747" src=":/de6bc0f73e144410b187a76ffdb2e9c6"/> -->

The resulting multiplicative error equations are given in Table 2.3 of the Textbook shown below (Hyndman et al., 2008, p. 22)

<!-- <img width="808" height="538" src=":/08a5efd9a6a24e2cbc45e17ec85d04ce"/> -->

Some of the combinations of trend, seasonality and error can occasionally lead to numerical difficulties; specifically, any model equation that requires division by a state component could involve division by zero. This is a problem for models with additive errors and either multiplicative trend or multiplicative seasonality, as well as the model with multiplicative errors, multiplicative trend and additive seasonality. These models should therefore be used with caution.

Notice that if the time series is not strictly positive, only the six fully additive models may be applied.

#### Model Selection

The forecast accuracy measures can be used to select a model from a set of candidate models, provided the errors are computed from data in a hold-out set and not from the same data as were used for model estimation. However, there are often too few out-of-sample errors to draw reliable conclusions. Consequently, a penalized method based on in-sample fit is usually better. Frequently used penalized measures are AIC, its corrected version AICc, and BIC. We can use AIC and BIC for the models with additive and multiplicative errors.

Using the forecast accuracy measures and penalized measures, we can create a model selection algorithm which will run automatically. Out Textbook gives the following algorithm for auto-exponential smoothing:

1.  For each series, apply all models that are appropriate, optimizing the parameters of the model in each case.
2.  Select the best of the models according to the AIC.
3.  Producepointforecastsusingthebestmodel(with optimized parameters) for as many steps ahead as required.
4.  Obtain prediction intervals for the best model either using the analytical results or by simulating future sample paths for $\{Y_{n+1},\dots , Y_{n+h}\}$ and finding the $\alpha/2$ and $1 − \alpha/2$ percentiles of the simulated data at each forecasting horizon. If the simulation is used, the sample paths may be generated using the Gaussian distribution for errors (parametric bootstrap) or using the resampled errors (ordinary bootstrap).

Implementation of this algorithm is done by the [`ets()`](https://www.rdocumentation.org/packages/forecast/versions/7.3/topics/ets) function of the `forecast` package. To trigger auto-search, we set the argument `model` to `"ZZZ"`. We can choose the penalised measure to use for auto-selection using the argument `ic=c("aicc","aic","bic")`.

We will illustrate the implementation of this algorithm over monthly US 10-year bond yields series, annual US net electricity generation series, quarterly UK passenger vehicle production series and monthly Australian overseas visitors series.

```r
fit.auto.bonds = ets(bonds,model="ZZZ",ic="bic") # Use BIC
fit.auto.bonds$method # Simple exponential smoothing with additive errors is selected 
```

```r
## [1] "ETS(A,N,N)"
```

```r
fit.auto.elec = ets(usnetelec,model="ZZZ",ic="aic") # Use AIC
fit.auto.elec$method # Holt's linear model with multiple errors is selected 
```

```r
## [1] "ETS(M,A,N)"
```

```r
fit.auto.cars = ets(ukcars,model="ZZZ",ic="aicc") # Use AICc
fit.auto.cars$method # The method includes not trend component and additive seasonal component with additive errors is selected 
```

```r
## [1] "ETS(A,N,A)"
```

```r
fit.auto.visitors = ets(visitors,model="ZZZ") # Use the default
fit.auto.visitors$method # Holt-Winters' multiplicative method with multiple errors is selected 
```

```r
## [1] "ETS(M,A,M)"
```

We can force the auto-search algorithm to consider, for example, damped trend models by setting the `damped=TRUE`.

```r
fit.auto.damped.cars = ets(ukcars,model="ZZZ",damped = TRUE, ic="aicc") # Use AICc and restrict to damped trend models
fit.auto.damped.cars$method # The method includes a damped trend component and additive seasonal component with additive errors is selected 
```

```r
## [1] "ETS(A,Ad,A)"
```

The following visualisation displays the 5-time steps ahead forecasts for each series.

```r
par(mfrow=c(2,2))
plot(forecast(fit.auto.bonds), ylab="US bond yields (percent per annum)",plot.conf=FALSE, type="l", xlab="Year")
plot(forecast(fit.auto.elec), ylab="US electricity generation (billion kwh)",plot.conf=FALSE, type="l", xlab="Year")
plot(forecast(fit.auto.cars), ylab="Vehicles in the UK (thousands of cars)",plot.conf=FALSE, type="l", xlab="Year")
plot(forecast(fit.auto.visitors), ylab="Number of visitors to Australia",plot.conf=FALSE, type="l", xlab="Year")
```

<!-- <img width="672" height="480" src=":/867a9c7ac072498da2abfde3760d4a21"/> -->

#### The General Linear Innovations State Space Model

The general characteristic of the state-space model is that the observed time series $(Y_{t})$ is supplemented by unobserved auxiliary variables called _states_ represented by _state vector_ $\boldsymbol{X}_{t}$. The general1 linear innovations state-space model is written as

$$
\begin{array}{rl} Y_{t}&= \boldsymbol{\omega}'\boldsymbol{X}_{t-1}+\epsilon_{t},\\ \boldsymbol{X}_{t}&=\boldsymbol{F}\boldsymbol{X}_{t-1}+\boldsymbol{g}\epsilon_{t}. \end{array}
$$ In exponential smoothing, the state vector contains information about the level, growth and seasonal patterns. The state variables help to define large complex models by first breaking them into smaller, more manageable parts, thus reducing the chance of model specification errors and the components of the state vector enable us to gain a better understanding of the structure of the series.

The first line of Eq. (1) is called the _measurement equation_. The term $\boldsymbol{\omega}'\boldsymbol{X}_{t-1}$ describes the effect of the past on $Y_{t}$. It is usually assumed to be from a $N(0,\sigma^{2})$ distribution, so it is also called _Gaussian innovations state space model_. $\epsilon_{t}$ represents what is new and unpredictable, and celled the _innovation_. The innovations are the only source of randomness for the observed time series.

The second line of Eq. (2) is called the _transition equation_. It is a first-order recurrence relationship that describes how the state vectors evolve over time. $\boldsymbol{F}$ is the _transition matrix_ and $\boldsymbol{F}\boldsymbol{X}_{t-1}$ shows the effect of past on the current state $\boldsymbol{X}_{t}$. The term $\boldsymbol{g}\epsilon_{t}$ shows the unpredictable change in $\boldsymbol{X}_{t}$. The vector $\boldsymbol{g}$ determines the extent of the effect of the innovation on the state. It is referred to as a _persistence vector_. The transition equation is the mechanism for creating the inter-temporal dependencies between the values of a time series.

The vectors $\boldsymbol{\omega}$, $\boldsymbol{g}$, and the matrix $\boldsymbol{F}$ all include the parameters to be estimated. The starting value $\boldsymbol{X}_{0}$ for the transition equation may be fixed or random. If it must be random, the _infinite start-up assumption_ applies. It is fixed the _finite start-up assumption_ applies.

#### Innovations and One-Step-Ahead Forecasts

If the value for $\boldsymbol{X}_{0}$ is known, the innovation $\epsilon_{t}$ corresponds to a one-step-ahead prediction error. If we denote the prediction by $\hat{Y}_{t}|{t−1}$, the innovations can be computed recursively from the series values using the relationships

$$
\begin{array}{rl} \hat{Y}_{t}|{t−1} & = \boldsymbol{\omega}'\boldsymbol{X}_{t-1},\\ \epsilon_{t} & = Y_{t}- \hat{Y}_{t}|{t−1},\\ \boldsymbol{X}_{t} & = \boldsymbol{F}\boldsymbol{X}_{t-1}+\boldsymbol{g}\epsilon_{t}. \end{array}
$$

This transformation will be called _general exponential smoothing_. If we substitute the first and second lines of Eq. (2) into the last line, we get

$$
\boldsymbol{X}_{t} = \boldsymbol{D}\boldsymbol{X}_{t-1}+\boldsymbol{g}Y_{t},
$$ where $\boldsymbol{D} = \boldsymbol{F} - \boldsymbol{g}\boldsymbol{\omega}'$. If we solve it back, we get

$$
\boldsymbol{X}_{t} = \boldsymbol{D}^{t}\boldsymbol{X}_{0}+\sum_{j=0}^{t-1}\boldsymbol{D}^{j}\boldsymbol{g}Y_{t-j}.
$$ If we substitute Eq. (4), lagged by one period, into the first line of Eq. (2), we get

$$
\hat{Y}_{t}|{t−1}=a_{t}+\sum_{j=1}^{t-1}c_{j}Y_{t-j},
$$ where $a_{t}=\boldsymbol{\omega}'\boldsymbol{D}^{t}\boldsymbol{X}_{0}$ and $c_{j}=\boldsymbol{\omega}'\boldsymbol{D}^{j-1}\boldsymbol{g}$ Thus, the forecast is a linear function of the past observations and the seed state vector.

The importance of these equations is that these equations demonstrate an important feature of the state space models.

When a new observation becomes available, the state vector is updated using Eq. (3), and the new one-step-ahead forecast is immediately available.

#### Model Properties

## Stability and Forecastability

As usual there are some condition for the stability and forecastability of the state space models. If the forecasts of $Y_{t}$ are unaffected by observations in the distant past, we describe the model as _forecastable_.The following are the properties of a _forecastable_ model:

$$
\sum_{j=1}^{\infty}|c_{j}|<\infty\text{ and }\lim_{t\leftarrow\infty}a_{t} = a.
$$

The _stability_ condition is that the eigenvalues of $\boldsymbol{D}$ lie inside the unit circle. In a stable model, the coefficients of the observations in (5) decay exponentially.

## Stationarity

To get stationarity conditions, we can represent the first line of (2) as follows:

$$
Y_{t}=d_{t}+\sum_{j=0}^{t-1}k_{j}\epsilon_{t-j},
$$ where $d_{t}=\boldsymbol{\omega}' \boldsymbol{F}^{t-1} \boldsymbol{X}_{0}$, $k_{0}=1$ and $k_{j}=\boldsymbol{\omega}'\boldsymbol{F}^{j-1}\boldsymbol{g}$, for $j=1,2,\dots$. Then, the model is _stationary_2_ if

$$
\sum_{j=0}^{\infty}|k_{j}|<\infty\text{ and }\lim_{t\leftarrow\infty}d_{t} = d.
$$ Stationarity is a rare property in exponential smoothing state space models. None of the models discussed in Module 5 are stationary.

#### Basic Special Cases

The linear innovations state-space model effectively contains an infinite number of special cases that can potentially be used to model a time series. However, in practice, we use only a handful of special cases that possess the capacity to represent commonly occurring patterns such as trends, seasonality and business cycles.

The first special case to be considered, the _local level model_. In this model, at any point along the data path, the values in the neighbourhood of the point are approximated by a short flat line representing what is referred to as a local level. This case is illustrated in part (a) of the following figure.

<!-- <img width="565" height="572" src=":/3b091ae729834a5eac46c55aec3d2468"/> -->

As its height changes over time, it is necessary to approximate the data path by many local levels. Thus, the local level effectively represents the state of a process generating a time series.

The gap between successive levels is treated as a Normal distributed random variable. The final local level is projected into the future to give predictions. As the approximation is only effective in a small neighbourhood, predictions generated this way are only likely to be reliable in the shorter term.

The second special case involves a _first-order polynomial approximation_. At each point, the data path is approximated by a tangential line in the deterministic case. In the stochastic case, it can only be said that the line has a similar height and a similar slope to the data path. Randomness means that the line is not exactly tangential. The approximating line changes over time, as seen in part (b) of the above figure, to reflect the changing shape of the data path. The state of the process is now summarized by the level and the slope at each point of the path. The stochastic representation is based on the assumption that the gaps between successive slopes are Normal distributed random variables with a zero mean. Note that the prediction is obtained by projecting the last linear approximation into the future.

### Local Level Model: ETS(A,N,N)

The corresponding ETS(A,N,N) state space model is formulated as follows:

$$
\begin{array}{rl} Y_{t}&= \ell_{t-1}+\epsilon_{t},\\ \ell_{t} &= \ell_{t-1}+\alpha\epsilon_{t},\\ \end{array}
$$ where $\epsilon_{t}\stackrel{\text{iid}}{\sim} N(0,\sigma^{2})$. When we set $X_{t}=\ell_{t}, \omega=1, F=1,$ and $g=\alpha$, we obtain this model from the general form. Here the level is controlled by $\ell_{t}$. Extreme values of $\alpha$ give special dependence cases.

*   If $\alpha=0$, the local levels do not change at all. Their common level is then referred to as the global level. Successive values of the series $Y_{t}$ are independently and identically distributed. Its moments do not change over time.
*   If $\alpha=1$, the model reverts to a random walk $Y_{t} = Y_{t−1} + \epsilon_{t}$. Successive values of the time series $Y_{t} are dependent.

This model corresponds to the simple exponential smoothing model with additive error terms. We use the `ets()` function to fit the model. Let’s revisit the annual US new freight cars series to illustrate the model. We have fitted a simple exponential smoothing model to this series.

```r
fit.ANN = ets(freight,model="ANN") 
summary(fit.ANN)
```

```r
## ETS(A,N,N) 
## 
## Call:
##  ets(y = freight, model = "ANN") 
## 
##   Smoothing parameters:
##     alpha = 0.4183 
## 
##   Initial states:
##     l = 3615.4904 
## 
##   sigma:  1451.738
## 
##      AIC     AICc      BIC 
## 869.2817 869.8398 874.8321 
## 
## Training set error measures:
##                    ME     RMSE     MAE       MPE     MAPE     MASE
## Training set -90.3855 1420.514 1123.33 -51.64303 81.33062 1.073404
##                   ACF1
## Training set 0.2182539
```

To compare the forecast performance of the ANN model to the simple exponential smoothing (SES) model, we can refer to RMSE and MASE values. We obtained RMSE=1634.026 and MASE=1.279911 from SES and RMSE = 1420.514 and MASE = 1.073496 from the ANN model. So, we can conclude that the inclusion of additive error terms improves the forecast performance of the model.

```r
plot(forecast(fit.ANN), ylab="US new freight cars",plot.conf=FALSE, type="l",  xlab="Year")
```

<!-- <img width="672" height="480" src=":/23cda59e3daf4f4d9d3468a851d09d96"/> -->

## Local Trend Model: ETS(A,A,N)

The local level model can be augmented by a growth rate of $b_{t}$ to give

$$
\begin{array}{rl} Y_{t}&= \ell_{t-1}+b_{t-1}+\epsilon_{t},\\ \ell_{t} &= \ell_{t-1}+b_{t-1}+\alpha\epsilon_{t},\\ b_{t}&=b_{t-1}+\beta\epsilon_{t}. \end{array}
$$ In this model, we have two smoothing parameters $\alpha$ and $\beta$. The state space structure yielding this model is set by

$$
\boldsymbol{X}_{t}=\left[ \begin{array}{cc} \ell_{t}&b_{t} \end{array}\right]', \boldsymbol{\omega}\left[ \begin{array}{cc} 1 & 1 \end{array}\right]', \boldsymbol{F}=\left[ \begin{array}{cc} 1 & 1\\ 0 & 1\\ \end{array}\right]'\text{ and } \boldsymbol{g}=\left[ \begin{array}{cc} \alpha & \beta \end{array}\right]'.
$$

The size of the smoothing parameters reflects the impact of the innovations on the level and growth rate. As the smoothing parameters increase in size, there is a tendency for the series to become smoother.

This model is Holt’s linear model with additive errors. We have fitted Holt’s linear model to the annual US net electricity generation series. Let’s see the effect of the inclusion of additive error terms in the model. We use the `ets()` function to fit the model.

```r
fit.AAN = ets(usnetelec, model="AAN")
summary(fit.AAN)
```

```r
## ETS(A,A,N) 
## 
## Call:
##  ets(y = usnetelec, model = "AAN") 
## 
##   Smoothing parameters:
##     alpha = 0.9985 
##     beta  = 1e-04 
## 
##   Initial states:
##     l = 244.2092 
##     b = 65.5768 
## 
##   sigma:  51.8636
## 
##      AIC     AICc      BIC 
## 660.5982 661.8227 670.6349 
## 
## Training set error measures:
##                       ME     RMSE      MAE        MPE     MAPE      MASE
## Training set -0.04060982 49.94203 36.44997 -0.8111995 2.440206 0.5164647
##                   ACF1
## Training set 0.1263413
```

```r
fit.AAN.damped = ets(usnetelec, model="AAN",damped = TRUE)
summary(fit.AAN.damped)
```

```r
## ETS(A,Ad,N) 
## 
## Call:
##  ets(y = usnetelec, model = "AAN", damped = TRUE) 
## 
##   Smoothing parameters:
##     alpha = 0.9999 
##     beta  = 0.1565 
##     phi   = 0.98 
## 
##   Initial states:
##     l = 247.3489 
##     b = 60.1566 
## 
##   sigma:  54.3966
## 
##      AIC     AICc      BIC 
## 666.7543 668.5043 678.7983 
## 
## Training set error measures:
##                    ME     RMSE      MAE      MPE     MAPE     MASE
## Training set 6.679144 51.86508 38.11248 0.238989 2.244731 0.540021
##                    ACF1
## Training set 0.04500634
```

The following table shows the values of model selection criteria for Holt’s linear model and AAN model with and without a damped trend.

<!-- <img width="565" height="179" src=":/1d435d9adb3c423fba37e5b7398f7521"/> -->

According to all criteria, Holt’s linear model is slightly better than the one with additive error terms. The following displays the forecast and fits from four candidate models.

```r
fit11 <- holt(usnetelec, h=5) # Holt's linear model
fit12 <- holt(usnetelec, h=5,damped = TRUE) # Holt's linear model with damped trend
plot(forecast(fit.AAN,h=5), type="l", ylab="US net electricity generation (billion kwh)", xlab="Year",fcol="cyan", plot.conf=FALSE)
lines(fitted(fit11), col="blue") 
lines(fitted(fit12), col="red")
lines(fitted(fit.AAN.damped), col="green")
lines(fit11$mean, col="blue", type="l") 
lines(fit12$mean, col="red", type="l")
lines(forecast(fit.AAN.damped,h=5)$mean, col="green", type="l")
legend("topleft", lty=1, col=c("black","blue","red","cyan","green"), 
       c("Data","Holt's linear trend","Holt's linear damped trend","AAN", "AAN damped trend"))
```

<!-- <img width="672" height="480" src=":/78ab77d350c3432cbe88d061c58873c4"/> -->

## Local Additive Seasonal Model: ETS(A,A,A)

For time series that exhibit seasonal patterns, the local trend model can be augmented by seasonal effects, denoted by $s_{t}$. Often the structure of the seasonal pattern changes over time in response to changes in tastes and technology. For example, electricity demand used to peak in winter, but in some locations, it now peaks in summer due to the growing prevalence of air conditioning. Thus, the formulae used to represent the seasonal effects should allow for the possibility of changing seasonal patterns. The ETS(A,A,A) model is

$$
\begin{array}{rl} Y_{t}&= \ell_{t-1}+b_{t-1}+s_{t-m}+\epsilon_{t},\\ \ell_{t} &= \ell_{t-1}+b_{t-1}+\alpha\epsilon_{t},\\ b_{t}&=b_{t-1}+\beta\epsilon_{t},\\ s_{t}&=s_{t-m}+\gamma\epsilon_{t}. \end{array}
$$

This model corresponds to the general state-space model with

$$
\boldsymbol{\omega}=\left[ \begin{array}{cccccc} 1 & 1 & 0 &\cdots &0 &1 \end{array}\right]',
$$

$$
\boldsymbol{X}_{t}=\left[ \begin{array}{c} \ell_{t}\\ b_{t}\\ s_{t-1}\\ s_{t-2}\\ \vdots\\ s_{t-m+1} \end{array}\right], \boldsymbol{F}=\left[ \begin{array}{ccccccc} 1 & 1 & 0 & 0 &\cdots & 0 & 0\\ 0 & 1 & 0 & 0 &\cdots & 0 & 0\\ 0 & 0 & 0 & 0 &\cdots & 0 & 1\\ 0 & 0 & 1 & 0 &\cdots & 0 & 0\\ 0 & 0 & 0 & 1 &\cdots & 0 & 0\\ \vdots & \vdots & \vdots & \vdots &\ddots & \cdots & \vdots\\ 0 & 0 & 0 & 0 &\cdots & 1 & 0\\ \end{array}\right]\text{ and } \boldsymbol{g}=\left[ \begin{array}{c} \alpha \\ \beta\\ \gamma\\ 0\\ \vdots\\ 0 \end{array}\right].
$$

This model corresponds to the Holt-Winters’ additive exponential smoothing model with additive errors. Let’s revisit the quarterly motor vehicle production in the UK series to illustrate the model. We use the `ets()` function to fit the model.

```r
fit.AAA = ets(ukcars, model="AAA")
summary(fit.AAA)
```

```r
## ETS(A,Ad,A) 
## 
## Call:
##  ets(y = ukcars, model = "AAA") 
## 
##   Smoothing parameters:
##     alpha = 0.5814 
##     beta  = 1e-04 
##     gamma = 1e-04 
##     phi   = 0.9284 
## 
##   Initial states:
##     l = 343.6012 
##     b = -5.3444 
##     s = -1.1652 -45.1153 21.2507 25.0298
## 
##   sigma:  26.2512
## 
##      AIC     AICc      BIC 
## 1283.319 1285.476 1310.593 
## 
## Training set error measures:
##                    ME     RMSE      MAE     MPE     MAPE      MASE
## Training set 2.009896 25.18409 20.44382 0.10939 6.683841 0.6662543
##                    ACF1
## Training set 0.03323651
```

```r
fit.AAA.damped = ets(ukcars, model="AAA",damped = TRUE)
summary(fit.AAA.damped)
```

```r
## ETS(A,Ad,A) 
## 
## Call:
##  ets(y = ukcars, model = "AAA", damped = TRUE) 
## 
##   Smoothing parameters:
##     alpha = 0.5814 
##     beta  = 1e-04 
##     gamma = 1e-04 
##     phi   = 0.9284 
## 
##   Initial states:
##     l = 343.6012 
##     b = -5.3444 
##     s = -1.1652 -45.1153 21.2507 25.0298
## 
##   sigma:  26.2512
## 
##      AIC     AICc      BIC 
## 1283.319 1285.476 1310.593 
## 
## Training set error measures:
##                    ME     RMSE      MAE     MPE     MAPE      MASE
## Training set 2.009896 25.18409 20.44382 0.10939 6.683841 0.6662543
##                    ACF1
## Training set 0.03323651
```

The following table shows the values of model selection criteria for Holt-Winters’ additive model and AAA model with and without a damped trend.

<!-- <img width="565" height="148" src=":/2d9f8df695b94a5dae1a99400caa0d0f"/> -->

According to all criteria, all the candidate models are very very close to each other in terms of predictive performance. Holt-Winters’ additive model with additive errors is so slightly better than the others. The following displays the forecast and fits from four candidate models.

```r
fit21 <- hw(ukcars,seasonal="additive", h=5*frequency(ukcars))
fit22 <- hw(ukcars,seasonal="additive",damped = TRUE, h=5*frequency(ukcars))
plot(forecast(fit.AAA,h=5), type="l", ylab="UK motor vehicles (thousands of cars)", xlab="Year",fcol="cyan", plot.conf=FALSE)
lines(fitted(fit21), col="blue") 
lines(fitted(fit.AAA.damped), col="green")
lines(fitted(fit22), col="red")
lines(fit21$mean, col="blue", type="l") 
lines(fit22$mean, col="red", type="l")
lines(forecast(fit.AAA.damped,h=5)$mean, col="green", type="l")
legend("topleft", lty=1, col=c("black","blue","red","cyan","green"), 
       c("Data","Holt-Winters' additive","Holt-Winters' additive damped trend","AAA", "AAA damped trend"))
```

<!-- <img width="672" height="480" src=":/93a58047681d4801b1b2f2f36206a328"/> -->

#### Variations on the Common Models

We will study some variations of the model discussed in the previous section.

## Local Level Model with Drift

A local trend model allows the growth rate to change stochastically over time. If $\beta = 0$, the growth rate is constant and equal to a value that will be denoted by $b$. The local level model then reduces to

$$
\begin{array}{rl} Y_{t}&= \ell_{t-1}+b+\epsilon_{t},\\ \ell_{t} &= \ell_{t-1}+b+\alpha\epsilon_{t},\\ \end{array}
$$ where $\epsilon_{t}\stackrel{\text{iid}}{\sim} N(0,\sigma^{2})$. This model is called _local level model with drift_ and originates to the state space structure with

$$
\boldsymbol{X}_{t}=\left[ \begin{array}{cc} \ell_{t}&b \end{array}\right]', \boldsymbol{\omega}\left[ \begin{array}{cc} 1 & 1 \end{array}\right]', \boldsymbol{F}=\left[ \begin{array}{cc} 1 & 1\\ 0 & 1\\ \end{array}\right]'\text{ and } \boldsymbol{g}=\left[ \begin{array}{cc} \alpha & 0 \end{array}\right]'.
$$

This model can be applied to economic time series that display an upward (or downward) drift. The local level model with drift is also known as _simple exponential smoothing with drift_. We use `ets()` function with `beta=0` to fit this model.

Let’s fit this model to the annual US net electricity generation (billion kWh) series. We set the argument `beta` to a value very close to zero.

```r
fit.drift = ets(usnetelec, model="AAN", beta = 1E-4)
summary(fit.drift)
```

```r
## ETS(A,A,N) 
## 
## Call:
##  ets(y = usnetelec, model = "AAN", beta = 1e-04) 
## 
##   Smoothing parameters:
##     alpha = 0.9999 
##     beta  = 1e-04 
## 
##   Initial states:
##     l = 246.48 
##     b = 65.974 
## 
##   sigma:  51.8699
## 
##      AIC     AICc      BIC 
## 658.6116 659.4116 666.6409 
## 
## Training set error measures:
##                      ME     RMSE      MAE       MPE     MAPE      MASE
## Training set -0.4796838 49.94809 36.48702 -0.858204 2.465155 0.5169896
##                   ACF1
## Training set 0.1254151
```

```r
plot(forecast(fit.drift,h=5), type="l", ylab="US electricity generation (billion kwh)", xlab="Year", plot.conf=FALSE)
```

<!-- <img width="672" height="480" src=":/4ef3c919c74f494cb3ec4864e6a823fb"/> -->

## Damped Trend Model: ETS(A,Ad,N)

When we take the local trend model and dampen its growth rate with a factor $\phi$ in the region $0 \leq \phi < 1$. The resulting model is

$$
\begin{array}{rl} Y_{t}&= \ell_{t-1}+\phi b_{t-1}+\epsilon_{t},\\ \ell_{t} &= \ell_{t-1}+phi b_{t-1}+\alpha\epsilon_{t},\\ b_{t}&=phi b_{t-1}+\beta\epsilon_{t}. \end{array}
$$

The characteristics of the damped local trend model are compatible with features observed in many business and economic time series. It sometimes yields better forecasts than the local trend model. Note that the local trend model is a special case where $\phi = 1$. The ETS(A,Ad,N) model performs remarkably well when forecasting real data.

We will fit this model to US net electricity generation (billion kWh) series as well.

```r
fit.AAdN = ets(usnetelec, model="AAN", damped = TRUE)
summary(fit.AAdN)
```

```r
## ETS(A,Ad,N) 
## 
## Call:
##  ets(y = usnetelec, model = "AAN", damped = TRUE) 
## 
##   Smoothing parameters:
##     alpha = 0.9999 
##     beta  = 0.1565 
##     phi   = 0.98 
## 
##   Initial states:
##     l = 247.3489 
##     b = 60.1566 
## 
##   sigma:  54.3966
## 
##      AIC     AICc      BIC 
## 666.7543 668.5043 678.7983 
## 
## Training set error measures:
##                    ME     RMSE      MAE      MPE     MAPE     MASE
## Training set 6.679144 51.86508 38.11248 0.238989 2.244731 0.540021
##                    ACF1
## Training set 0.04500634
```

```r
plot(forecast(fit.drift,h=5), type="l", ylab="US electricity generation (billion kwh)", xlab="Year", plot.conf=FALSE)
lines(fitted(fit.drift), col="blue") 
lines(fitted(fit.AAdN), col="red")
lines(forecast(fit.AAdN,h=5)$mean, col="red", type="l")
legend("topleft", lty=1, col=c("black","blue","red"), 
       c("Data","ES with drift","AAdN"))
```

<!-- <img width="672" height="480" src=":/04def7faab354a4389c04f341a6ac4ad"/> -->

Exponential smoothing with drift model performs better for this series in terms of RMSE, MASA and AIC.

#### Summary

In this module, we introduced a general form for the state-space models and studied the state-space models in a comparative way to the exponential smoothing models. We illustrated the relationships between the state-space models and exponential smoothing methods in terms of their parameters.

#### References

Hyndman, R.J., Koehler, A.B., Ord, J.K., and Snyder, R.D. (2008). [Forecasting with exponential smoothing: the state space approach](http://www.exponentialsmoothing.net), Springer-Verlag.

Hyndman, R.J., Athanasopoulos, G. (2014). _Forecasting: Principles and Practice_. OTEXTS.