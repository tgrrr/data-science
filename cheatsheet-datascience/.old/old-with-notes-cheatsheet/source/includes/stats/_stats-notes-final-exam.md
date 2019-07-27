# STATS NOTES FINAL EXAM - modules

# 0. The basics

## Jargon and Greek / Latin terms (TODO)

| who | Mean | Standard deviation |
| --- | --- | --- |
| Population | µ (mu) | σ |
| Sample | x̄ | S |

## Greek / Latin Terms
- ɑ = significance level
- µ = mean
- P = proportion
- σ = Pop standard deviation

## Average

| character | mean |
| --- | --- |
| µ (mu) | Population mean |
| x̄ | Sample mean |

## Overall structure (to add to these notes)

- definitions and concepts?
- Data format?
- Data appearance - how data should look so you can test it?
- Types of tests - understand the types of ways you can test it?
- Decisions - how do you make decisions?
- Predictions - then how do make predictions?

## P-value

`p-value` is:

- the probability of observing a test statistic
  - that is as **extreme** or more extreme than currently observed
  - **assuming that the null hypothesis is true**
  
Can be expressed as `Pr(data|H<sub>0</sub>)`

- Pr"the probability of" and
- "|" is read as "given" or "conditional upon."
- NOT the probability of H<sub>0</sub> being true.

## P-value and type I error

Rejecting the null hypothesis when it is in fact true is called a Type I error.

## Significance level α
1. Significance level is an arbitrary `threshold` or point we set to reject our null hypothesis (providing `p < α`)
2. So, significance level is also the maximum p-value for which we will reject the null hypothesis. (because `p < α`)

<aside class="notice">
Significance level is sometimes defined as <strong>the probability we have a type I error</strong> (that we rejected the null hypothesis when it was true). <p />

<strong>But!</strong> That’s only when there’s a t-test and all of the assumptions hold, and the research was perfect. Only in that case, the probability of a type I error will be exactly equal to α.<p />

The reason? p-value is calculated based on the assumption H<sub>0</sub> is correct Pr(data|H<sub>0</sub>). So, the p-value can’t be used to prove that H<sub>a</sub> is true.<p />

Therefore, we don’t know that “there’s only a 5% chance that a Type I error has occurred”<p />

The long version <a href="http://www.stomponstep1.com/p-value-null-hypothesis-type-1-error-statistical-significance/">statistical significance</a> and here <a href="https://stats.stackexchange.com/questions/158351/p-value-vs-type-1-error">stats overflow</a>
</aside>

# 1. Types of variables

MUST CHECK:

- Variables
  - examples of variables
- Types of data investigation

TODOLATER:

- Design of analysis

**Qualitative** - category, values or percentage %

- Categorical
- Yes/ no
- Describe by values or percentages

**Quantitative** - count or interval

Discrete = countable
  - Countable
  - Finite number of variables

Continuous = interval
  - Measurement falls into an interval
  - eg. Time or Height

**Nominal** - aka categorical

no meaningful difference between categories

**Ordinal** - rank

**Interval** - equal interval

Eg. Temperature

**Ratio** - has absolute zero

Eg. Height

# 2. Summarising data

TODOLATER:

mean = x̅ = Σ x<sub>i</sub> / n
  Is sensitive to each data value
  
  - Graphical
- Numerical
  - Measures of central tendency

## Measures of central tendency

| Sensitive to Outliers | NOT sensitive |
| --- | --- |
| Mean (x̅) | Median |
| Range | Mode? |

- ? Location of data

### Quantitative data

**Mean (x̅)**

  - *Sensitive* to each individual data value
  - Outliers

**Median**

  - Divides data into two groups of equal sizes
  - *Not sensitive* - Not impacted that much by outliers
  - Two formulas – don’t need to know

**Mode**

  - Divides data into 2 groups of equal size
  - is: Maximum frequency value or repeated value
  - ? Frequency table/ histogram
  - Can be `bimodal` etc.
    - **Eg.** if 12 and 25 are both repeated in the dataset 10 times and 10 is the maximum frequency for both, then 12 and 25 are mode  

## Measures of variability

### Spread of your data

### Range
- Most common measure of variability
- `range = max value – min value`
- Not sensitive to individual data in the range
- Very sensitive to outliers

### Variance
> Variance: is Sensitive to each individual data point

```r
sqrt(  
  (xᵢ - x̅)²)
  / n-1
  )     

# OR

squareRootOf(  
  (eachValueInDataset - meanOfXᵢ)^2)
  / numberOfValues-1
  )     
```

- TODOLATER: formula
- Compared each sample to the mean
- Sensitive to each individual data point
- Remove outliers first?

> Remove outliers first?

### IQR
- Range of the middle 50% of data

```
IQR <- Q3 – Q1
```

### Outlier

```
# it's an outlier if:

outliers < Q1 – 1.5 x IQR
# or
outliers > Q3 – 1.5 x IQR
```



### Boxplot - Is data symmetric?
- No statistical package shows your fences (defined above)
- Use to decide if data is symmetric or not
  - Whiskers are the same size
  - Q2 (or median) middle of IQR
- Compare to histogram
- Use to compare (variability) of data
  - Can look at median value
  - Or length of positive skew
  - Or largest Q3, etc

### Skew

> Positive skew

```
mean > median
```

> Negative skew

```
mean < median
```

# 3. TODOLATER: Probability using contingency table

[] Copy stats symbols across



## TODOLATER: Probability using contingency table
## TODOLATER: Events occurrence

## Intersection (AND)

- Mutually exclusive event
```
Pr(  ∩  ) => mutually exclusive
```

## Union (OR)

```
Pr(1 serve ∪ < 1 serve)
```

## Conditional probability (given)

Pr(B|A) => conditional probability of B given A
The two events A and B are independent if and only if

> independent IF

```r
Pr(A|B) = Pr(A)
# OR
Pr(B|A) = Pr(B)
```

## Permutations

```r
factorial(6)/factorial(6-3)
> [1] 120
```

## Combinations

```r
choose(10,4)
> [1] 210
```

# 4. Binomial distribution

```r
binom(numberOfTrials,probability)
```

*Applies to discreet variables only*

- = bi => only 2 options for the outcome of each experiment
  - Eg. Either they survive, or they die.

- Estimate number of success after n experiments

> mean = expected value of success

```
E(x) = numberOfTrials * probability
```

> Variance

```shell
numberOfTrials * probability(1-probability)
```

### Standard Deviation (σ)

> Standard deviation

```shell
√numberOfTrials * probability(1-probability)
```

```r
standard.deviation <-
sqrt(numberOfTrials * probability(1-probability))
```

### Sample Standard Deviation (x̅)

> μ <- population mean

> x̅ <- sample mean

```r
sample.standard.deviation <-
sqrt(
  (x[i-n] - x̅)
  / (n-1))
```

## Poisson distribution (λ Lambda)

```
µ = λ * t
mean <- lambda * unitOfTime

variance σ^2^ <- Var(x) = λ

standard.deviation <- σ = √λ
```

The Poisson distribution has one parameter:
Lambda (λ) which can equal

Rate of occurrence:

- `E(x) = λ` the expected or
- `µ = λ` mean number of events
-  per unit time/distances

- Also Variance = λ ?

```r
dpois(x, lambda)
```

- Discrete random variables
- Or any factor of that time/ distance variable

### Example Poisson

```
mean <-
µ = E(x) = λ
mean.for.the.week <-
µ = λ * t = 16 * 7 = 112
```

Expected daily number of patients for a doctor during winter might be λ = 16 per day

> Pr(X <= x)

```r
> ppois(100, 16*7)
[1] 0.1378483
```

What is the probability that the doctor will see less than or equal to 100 patients in a week?

The questions asks

`Pr(X ≤ 100)`

We need to adjust the mean value to

`μ = 16*7 = 112`

### Plotting Poisson

TODOLATER:

```r
plotDist("pois",
  lambda = 16,
  xlab = "No. Patients",
  main = "Poisson Distribution, Mean = 16",
  ylab = "probability",
  groups= x==16)
```



## Normal distribution

- Used for continuous (interval) variables

- Goal: Calcu_stats-notes-final-exam.md'
g area under the curve

Is:

- Symmetric
- The centre is always the mean (μ)
- Is Bell shape
- Tail is almost touching X

TODOLATER:
1. X ~ N (mu, Σ (sigma) squared)

If given mu and Σ (sigma), we can calculate X When something is given to you

```
99.7% of values within µ ± 3σ
95% of values within µ ± 2σ
68% of values within µ ± σ
```

Z – standardised normal distribution
- Same bell shape
- Mean = 0
- Variance = 1

TODOLATER:

- formula here
- We don't care about >= or >
- Which should I report?
- ? Regardless of p or d

![Edge of the bell curve](../images/dating_pools.png)


# 5. TODOLATER: Mean of sample distribution and properties

## TODOLATER: Mean of sample distribution and properties

## TODOLATER: Observation in samples change

## TODOLATER: Mean random variable on its own

## TODOLATER: Population (should double check these equation)

```
Mean µ
Variance σ2
E(x̅) = n/x = µ
Var(x̅) = σ2/x = σ2/n
SE = σ/√x =  σ/√n
```
  - Standard error of mean
  - Reduces as n increases
  - Inversely proportional

## CLT - Central Limit Theorem

If a variables:
- population distribution is normally distributed
- sample distribution of the mean will be normally distributed

TODOLATER: add math formula

Assume:
`µ <- 193 seconds` = mean and standard.deviation of youtube video duration is
`n <- 100` sample size

What's the probability of randomly selecting a
`sample mean duration < 150 seconds` ?

`n > 30`, therefore:

```
x̅ ~ N(µ, σ/√n)
x̅ ~ N(193, σ/√n)
x̅ ~ N(193, 193/sqrt(100))
= N(193, 19.3)
```

> then to get Pr(x̅ < 150)
```r
pnorm(150, 193, 19.3)
[1] 0.01294
```

What's the probability of randomly selecting a
`sample mean duration > 240 seconds` ?

```r
pnorm(240, 193, 19.3, lower.tail = F)
[1] 0.007441098
```

- Distribution of sample mean
- If n > 3σ and keep drawing samples to calculate mean
- They will be different
- Will follow a normal distribution

TODOLATER:
```r
qqplot()
```
- For a normal population
- Doesn’t matter about sample size

```
x̅ ~ N(µ, σ2/n)
```

TODOLATER:
- add my notes
- Calculate the mean
- see if value is far from mean
- Far from mean, less likely it will happen
- Population with mean
- Not talking about distribution of population
- Population with mean Σ (sigma) variance Σ (sigma) squaredu

## Mine: Central limit theorum

If sample size large
and some other stuff
If sample is drawn from normal po
Then
Define Xbar
mean is
variance is Σ (sigma)^2 / n

#######################################################################

# 6. TODOLATER: Point estimates

`x̅ point estimate of µ (population mean) - Ṕ`

```
Error = σ/√n
```

> confidence.interval
> Define by ɑ significance level

```
(1 - ɑ)/ CI
(1 - significance.level)/confidence.interval
```

- larger sample = smaller Confidence Intervals
- Mean becomes closer to actual mean of population

TODOLATER:

- Increase level of CI (95 – 99.7), length of CI increases
- Proportion – didn’t do much
- Use z statistic to calculate
- Formula?
- Whether using z or n
- These are the true values
- If repeat sampling 100 times, get 100 CI
- Actual population mean (µ) would have CI 95 of these intervals
- Chance of not including value of µ is only 5%

![Correlation Interval](../images/significantxkcd882.png)


<!-- _______________________________________

  ### How to know if a sample is unusual enough to reject H<sub>0</sub>

  There are three related ways for doing this:
  - confidence interval approach
  - Critical value method (not used much)
  - P value

  ### Other terms

  - Confidence Interval (normally 95%) - How confident we are that if we re-sampled the population, we would get same results
  - s = sample standard deviation

  ## Approaches

  ## Critical value Approach
  - Dont know Pop standard deviation ( σ)
  - Use t-dist

  ```R
  > qt(0.05,130-1,lower.tail = TRUE)
  [1] -1.66
  This means the t*mean sits 1.66 SEs below the population mean of 37. We can write a short R program to convert this back to a critical mean.

  > t<-qt(0.05,130-1,lower.tail = TRUE) #save t-crit
  > mu <- 37 #Assign mu
  > s <- sd(Body_temp$Body_temp) #Assign sd
  > n <-length(Body_temp$Body_temp) #Assign n
  > se <-s/sqrt(n) #Calculate se
  > mu + (t*se) #Determine critical mean
  [1] 36.94079988
  ```



  _______________________________________

  ## 6.

  If Xbar is = point definition of

  If asked for error

  error is Σ (sigma) / square root of n


  P^ hat


  ## Confidence level

  Significance level alpha

  TODO copy formula here

  This is when we might use T

  If use T, we replace Σ (sigma) with S

  Every time I change the formula
  My confidence interval keeps changing

  If I increase size of sample
  Σ (sigma) divided by square root of n
  Confidence interval shrinks

  mean becomes closer to actual mu
  becomes more accurate

  If I increase the level of my confidence

  If I want a higher level of confidence
  then alpha is 1%.

  Then

  ## Confidence interval for proportion

  When sample size large, always normal distribution so use z

  --------------------------------------------
  ADD this from section 6

  ## Confidence Intervals
  ## Module 6 - Estimating Uncertainty Confidently

  Menu
  - Confidence intervals population known
  - Confidence intervals population known
  - Confidence intervals proportions
  - Confidence intervals rates

  ## tldr steps
  1. Get sample mean
  x̄(X̄
  2. Do we know the Population standard deviation σ ? , or unknown, s.

  1. Yes! We know pop standard deviation

  They'll say standard deviation (σ) = 15 or something

  ```R
  favstats(~BFP_Brozek | Sex, data=body)
  ```
  > Sex min     Q1 median    Q3  max     mean       sd   n missing
  > 1   Male 4.6 13.100  19.05 24.05 38.2 18.66000 7.348052 160       0
  > 2 Female 0.0 12.775  18.75 25.35 45.1 19.42283 8.425499  92       0

  TODOLATER: add maths formulas here

  2. Nope, don't know the population standard dev: ->
  Then:
  - Use t distribution
  - get the sample standard deviation (s)

  confint(t.test(~IQ, data = IQ))


  TODOLATER: add maths formulas here


  For an unknown standard deviation:



  Source: https://en.wikipedia.org/wiki/Confidence_interval
  _______________________________________

  Steps, Mainly From slides:

  1.
  ```R
  favstats(~Diameter | Store, data=Pizza)
  histogram(~Diameter | Store, data=Pizza,layout=c(1,2))
  ```
  > Sex min     Q1 median    Q3  max     mean       sd   n missing
  > 1   Male 4.6 13.100  19.05 24.05 38.2 18.66000 7.348052 160       0
  > 2 Female 0.0 12.775  18.75 25.35 45.1 19.42283 8.425499  92       0
  Then we do

  mean +- qnorm()


  2. Mean
  ```R
  mean(IQ$IQ) + qnorm(0.975) * (15/sqrt(1290))
  mean(IQ$IQ) - qnorm(0.975) * (15/sqrt(1290))
  ```
  3. Maybe this maths?
  ```R
  sd(Cars_4cylinder$Economy_highway)/sqrt(lengthCars_4cylinder$Economy_highway)
  ```
  4. Calculate t* critical value
  ```R
  qt(0.975, df = 1289)
  ```
  5. Grab favstats
  ```R
  favstats(~IQ, data = IQ)
  ```
  6. Confidence Interval from T Test
  ```R
  confint(t.test(~IQ, data = IQ))
  ```
  7.
  > np(1-p) <- more here

  ? Maybe
  ```R
  Mobilephone$SmartPhone
    <-factor(
      Mobilephone$SmartPhone,
      levels=c(1,2,3),
      labels=c("Cell, smartphone", "Cell, not a smartphone","No cell"))
  tally(~SmartPhone, data=Mobilephone, margins = TRUE)
  tally(~SmartPhone, data=Mobilephone, margins = TRUE, format = "proportion")
  ```

  8. some random binom and pois stuff onwards
  ```R
  binomial approx(44, 109, conf.level = 0.95)
  ```
  > pois.approximation (if lambda > 100)

  ```R
  binom.approx(6, 300, conf.level = 0.95)
  binom.exact(6, 20, conf.level = 0.95)
  pois.exact(56, pt = 1, conf.level = 0.95)
  pois.approx(145, pt = 1, conf.level = 0.95)
  ```

  _______________________________________

  From Class:
  ```R
  qt(.975,df) #calculate t* critical value
  sd(Cars_4cylinder$Economy_highway)/sqrt(lengthCars_4cylinder$Economy_highway)
  confint(t.test(~ Economy_highway, data = Cars_4cylinders)) #95% CI for mean
  Mobilephone$SmartPhone <-factor(Mobilephone$SmartPhone, levels=c(1,2,3),
                                  labels=c("Cell, smartphone", "Cell, not a smartphone","No cell"))
  tally(~SmartPhone, data=Mobilephone, margins = TRUE)
  tally(~SmartPhone, data=Mobilephone, margins = TRUE, format = "proportion")

  binom.approx(904, 2254, conf.level = 0.95)
  Homicide
  pois.exact(109, pt = 1, conf.level = 0.95)
  pois.approx(109, pt = 1, conf.level = 0.95)
  ```

  From longform
  ```R
  favstats(~Diameter | Store, data=Pizza)
  qnorm(.975)
  qt(0.975, df=125-1)
  confint(t.test( ~ Diameter, data = subset(Pizza,subset=(Store=="Dominos"))))
  mean of x     lower     upper     level
   27.44208  27.23512  27.64904   0.95000
   ggplot2 stuff here
   binom.approx(6, 300, conf.level = 0.95)
   binom.exact(6, 20, conf.level = 0.95)
   pois.exact(56, pt = 1, conf.level = 0.95)
   pois.approx(145, pt = 1, conf.level = 0.95)
  ```



# 7. TODOLATER: Hypothesis testing

## tldr
  
|  | **One-tail** | **Two-tail** | **Example** |
| --- | --- | --- | --- |
| AllofTheTings | H<sub>0</sub>: = | H<sub>0</sub>: = | Mean of group |
|  | H<sub>a</sub>: < OR H<sub>a</sub>: > | H<sub>0</sub>: not= reason:(because < or >) |  |
|  |  |  |  |
|  |  |  |  |
| One-Sample | **TODO** | **TODO** | Mean of group |
| Two-Sample | NA (generally) | H<sub>0</sub>: μ1 -μ2 = 0.0<br /><br /> H<sub>a</sub>: μ1 -μ2 ≠ 0.0 *or* μ1 -μ2 > 0.0 *or* μ1 -μ2 < 0.0 | Mean of men and women |
| Paired Sample | NA (generally) |  | Compare the same student when they study vs don't study |

**TODOLATER:**
add T vs Z here
refactor AllofTheTings

  -->
Hypothesis testing
Null hypothesis
Always value you have
Equal to something
Alternate hypothesis
Less than, greater than or not equal
Test whether it is significant or not
Significant at level ɑ if reject null
ɑ may differ
Making decisions
Use ɑ given to you
Usually not, then use 5%
Reject if
p < 0.05
µ doesn’t fall into 95% CI
Rejection region – not examinable
Type I and type II error
Every time you make a decision, bound to make an error
Type I error is when you reject null when not true
Sample may not be representative of the population
Type II error is when you accept null, falsely accept the null
ɓ
In experimental design
Work out whether type I or type II error is more of a risk
Design CI/ p value by reducing one error type
Reduce ɑ, increase ɓ

Two sample test
Two assumptions
Independent or not (paired t-test)
Variance equal
Levene test
σ12 = σ22
Have to test
Null hypothesis
Both populations are normal or n = 30
So can use the central limit theorem
Decision – testing th
Decision
Testing difference between mean of two populations
Accept if
p < ɑ
95% CI includes zero
Otherwise reject
Paired data
Problem should clearly state that it is a paired situation
Same population
Apply different conditions
Samples are not independent
One sample test
Only looking at different for each test subject
Null hypothesis: difference = 0
Alternat hypothesis: difference ≠ 0

Categorical data
Association
More than one categorical variable
Between them
In different levels
Formula expected =
Degrees of freedom = r1(c1 – 1)
Goodness of fit
Looking at proportions
Null assumptions
Categorical data has at least two variables
Pblack = 30%
Pblue = 20%
Alternat assumptions
For all categories together
Not for each category separately

## 7. Hypothesis testing

H<sub>0</sub>
If testing mean or proportion value
always have equal sign to value
Eg. mean is equal to 100

Write H<sub>0</sub> and H1

Write whether test is significance/or not
It's significant if we reject H<sub>0</sub>
Test is not significant when
at level alpha = 5%

If alpha is given to you, we have to use alpha.
If not, we can always assume alpha is 5%

! We reject if P value is less than alpha
If value of mu under H

We reject H<sub>0</sub> if 100 falls in Confidence something is

Rejection region (not examinable)

Didn't examine this
Type I errors - sample is wrong, and
Type II errors

TODOLATER: add pregnant and boy who cried wolf here

2 sample test

1. Assumption 1: 2 populations are independent
2. both populations are normal
3. Samples taken for two populations

We have to assume Σ (sigma)^2 = Σ (sigma)^2 of population

We muse Levene test

If p value is less than alpha

or 95%

We're testing the difference between mu1 and mu2
m1 - m2

This is where we're looking for if the value of something falls around zero
(one is plus, the other is negative)

## Paired Data
-

<!--
  ## Hypothesis Testing (TODO)
  - language / how to report your results

  ### Null Hypothesis Significance Testing (NHST)

  H<sub>0</sub> : - null hypothesis

  H<sub>a</sub> : - alternative

  - Explain the process and logic of Null Hypothesis Significance Testing (NHST).
  - Define one-tailed and two-tailed hypothesis testing.
  - State and test the assumptions behind the different t-tests.

  ### H<sub>0</sub> Null hypothesis

  *Eg. The population mean IQ score is 100.*

  H<sub>0</sub>: µ > µ0

  - H<sub>0</sub>: State an assumption about the world
  - That is bleak and uninteresting. It's the status quo. Nothing is happening.

  ### H<sub>a</sub> Alternate hypothesis

  *eg. The population mean IQ scores are not 100*

  - H<sub>a</sub> contradicts and rejects H<sub>0</sub>
  - Next, we state an opposing viewpoint that contradicts H0
  - To support HA we must rule out H0 beyond a reasonable doubt

  ## 1 tailed t-test

  Is:
  - evidence taken from a sample mean
  - suggest that the population mean is different to a previously assumed value

  Assumes:
  The one-sample t-test assumes
  - the data are normally distributed
  - the population standard deviation is unknown
  - BUT: Big sample means we don't need normal distribution

  Do this:
  - Determine when a one-sample t-test should be applied.
  - Use technology to compute and interpret a `one-sample t-test`.

  > How: 1. State hypothesis

  ```shell
  H0: μ = 37°C (μ is population mean)
  HA: μ < 37°C predicting that mean body temperature will be lower
  ```
  (μ is population mean)

  ? #### One sided test

  - H<sub>0</sub>: µ > µ0
  - H<sub>0</sub>: (mean) > (mean)0


  ## Two-tailed test

  - aka two-sided aka `non-directional hypothesis`

  Notes from Lecture notes:

  ```
  p = Pr(x̄ < 36.81|μ = 37)
  ```

  > eg. for a lower, one-tailed hypothesis

  All are based on significance level (α) (normally α = 0.05)
  - what we use to judge "unusualness".
  - minimum acceptable probability of committing a Type I Error


  #### Two sided test ?
  H<sub>a</sub>: µ ≠ µ0

  ## P value

  If P is very small

  We reject H<sub>0</sub>

  and then: H<sub>a</sub> is significant

  ```shell
  P-value = p = Pr(x̄ < 36.81|μ = 37)

  pt(t,df=n-1)

  P-value = p = Pr(t < 5.83|t = 0) + Pr(t > 5.83|t = 0)

  ```

  ## Samples

  ## 1 sample t-test (TODO)
  - maths
  - in R
  - Body temp example

  The `one-sample t-test` is used to test whether there is evidence taken from a sample mean to suggest that the population mean is different to a previously assumed value.

  The one-sample t-test assumes
  - the data are normally distributed and
  - the population standard deviation is unknown.

  If you have a large sample, the normality assumption is not generally needed (see CLT in Module 5).


  ## Two-sample t-tests
  - Body Temperatures example pt2

  - 1.4.1 Testing the Assumption of Normality
  - 1.4.2 Central Limit Theorem
  - 1.4.3 Homogeneity of Variance

  _______________________________________

  Notes from class while trying to do ass3

  ## from class: divide mean or something by square root of

  From class notes
  ```R
  Body_temp$Gender <- factor(Body_temp$Gender, levels = c(1,2),
                                 labels = c("Male","Female")) #Assign correct labels
  favstats(~ Body_temp | Gender,data = Body_temp)
  ```
    Gender  min   Q1 median   Q3  max   mean      sd  n missing
  1   Male 35.7 36.4   36.7 37.0 37.5 36.726 0.38822 65       0
  2 Female 35.8 36.7   36.9 37.1 38.2 36.889 0.41274 65       0

  ```R
  library(car)
  Body_temp_male <- subset(Body_temp,subset=Gender =="Male") #Subset male data
  qqPlot(Body_temp_male$Body_temp, dist="norm")
  leveneTest(Body_temp ~ Gender, data = Body_temp)
  ```
  > Levene's Test for Homogeneity of Variance (center = median)
  >        Df F value Pr(>F)
  > group   1    0.04   0.84
  >       128  

  ```R      
  t.test(Body_temp ~ Gender, data = Body_temp,
           var.equal=TRUE,
           alternative="two.sided")
  ```
   Two Sample t-test

  ```
  data:  Body_temp by Gender
  t = -2.32, df = 128, p-value = 0.022
  alternative hypothesis: true difference in means is not equal to 0
  95 percent confidence interval:
   -0.302140 -0.024014
  sample estimates:
    mean in group Male mean in group Female
                36.726               36.889
  ```
  _Write down your null and alternative hypothesis clearly, express your conclusion in words and provide your reason(s) for your final conclusion._

  ### null hypothesis

  > H<sub>a</sub> : μ male === μ female

  There is no difference between the mean bodyfat for males and females

  ### alternative hypothesis

  > H<sub>a</sub> : µ ≠ µ0

  Males mean body fat is ≠ (not equal to) females mean body fat

  ### Conclusion

  Females have a higher body mean body fat than males using both the Brozek and Siri equations

  ### Reasons
  TODOLATER:
  - Females have a min of 0
  -
  -

  ```R
  ## qnorm(body)
  favstats(~BFP_Brozek, data = body, groups = Sex)

  ```

  ```R
  subset(body, Sex == "male")$BFP_Brozek %>% mean() < subset(body, Sex == "female")$BFP_Brozek %>% mean()

  body_fat_male <-
    subset(x = body,
           select = BFP_Brozek,
      subset= (Sex =="male")) #Subset male data

  qqPlot(~ BFP_Brozek | Sex, dist="norm", data=body)
  qqPlot(body_fat_male, dist="norm")

  body_fat_male <-
    subset(
      body,
      subset=Sex=="Male") #Subset male data
  body_fat_male
  qqPlot(body_fat_male$Sex, dist="norm")

    leveneTest(body ~ Sex, data = body)
  ## leveneTest(Pulses ~ Brand, data = Battery_sub)

   leveneTest(BFP_Brozek, data = body)
    
  t.test(~BFP_Brozek | Sex, data = body)
  ```

  ______________________________________________________________________

  ## Paired sample t-tests

  - Identify and distinguish between the two-sample and paired sample research designs for continuous variables.
  - Use technology to compute a two-sample (independent samples) t-test and paired-samples (dependent samples) t-test.
  - Interpret a `two-sample` and `paired-samples t-test`.

  ## Two-sample t-test - Assuming Equal Variance
  ## Two-sample t-test - Assuming Unequal Variance

  ## Example writeups
  - Paired Samples t-test
  - Paired Samples t-test Visualisation
  - Example Write-up again?

  _______________________________________
 -->
# 8 Chi Squared test

## Goodness of fit

> How to do Chi Squared

> 1. Prep data:

```r
# Getting % or proportion that you want to test
pop_prop<-c(0.24,0.13,0.16,0.20,0.13,0.14)
# What you want to compare it to:
tally(
  ~Colour,
  data =mms,
#   format="proportion")
#   Blue     Brown     Green    Orange       Red    Yellow
# 0.1835878 0.1416031 0.1843511 0.2076336 # 0.1419847 0.1408397
  
```

```r
 2. Get X-squared 50.835

# xchisq.test(tally(~Colour, data = mms),p = pop_prop)

# Chi-squared test for given probabilities
# data:  x
> X-squared = 50.835, df = 5, p-value = 9.348e-10
#   481      371      483      544      372      369   
# (628.80) (340.60) (419.20) (524.00) (340.60) (366.80)
# [34.741] [ 2.713] [ 9.710] [ 0.763] [ 2.895] [ 0.013]
# <-5.89>  < 1.65>  < 3.12>  < 0.87>  < 1.70>  < 0.11>

```

```r
qchisq(0.05, df = 5, lower.tail = FALSE)
# [1] 11.0705
```
> If output > X-squared , we can reject Ho

```r
11.0705 > 50.835 => reject Ho
```
```r
# P-value of Chi squared
pchisq(50.83, df = 5,lower.tail = FALSE)
# [1] 9.370786e-10
```
> If p < 0.05, then we can reject Ho

Blue | Brown | Green | Orange | Red | Yellow |
-------------- | -------------- | -------------- | -------------- | -------------- | -------------- | --------------
What we have | 0.1835878 | 0.1416031 | 0.1843511 | 0.2076336 | 0.1419847 | 0.1408397
Compare it to this | 0.24 | 0.13 | 0.16 | 0.20 | 0.13 | 0.14

## TODOLATER: Chi-square Test of Association

```r
Breast.Cancer$Group <-
  factor(
    Breast.Cancer$Group,
    levels=c(1,2),
    labels = c("Case","Control"))
    
Breast.Cancer$Age_Cat <-
    factor
      (Breast.Cancer$Age_Cat,
        levels = c(1,2,3,4,5),
        labels = c("< 20","20 - 24","25 - 29","30 - 34", ">= 35"),
        ordered=TRUE)
        
tally( ~ Age_Cat | Group, margins=TRUE,data=Breast.Cancer)
         Group
# Age_Cat    Case Control
#   < 20      320    1422
#   20 - 24  1206    4432
#   25 - 29  1011    2893
#   30 - 34   463    1092
#   >= 35     220     406
#   Total    3220   10245

tally( ~ Age_Cat | Group, margins=TRUE, format = "proportion", data=Breast.Cancer)
         Group
# Age_Cat         Case    Control
#   < 20    0.09937888 0.13879941
#   20 - 24 0.37453416 0.43260127
#   25 - 29 0.31397516 0.28238165
#   30 - 34 0.14378882 0.10658858
#   >= 35   0.06832298 0.03962909
#   Total   1.00000000 1.00000000

table <- tally( ~ Age_Cat | Group, format = "proportion", data=Breast.Cancer)

barplot(table,ylab="Proportion Within Group",
          ylim=c(0,.6),legend=rownames(table),beside=TRUE,
          args.legend=c(x = "top",horiz=TRUE,title="Age Category"),
          xlab="Age Category", col=rainbow(5, start = .4, end = .7))
grid()
```

### TODO from Verity:
Χ2 – chi square test
Degrees of freedom: number of categories – one
Minimum value for each category must be more than 5

E = expected value if assumption correct (30% black)

## Mine: Module 8

Goodness of time

categorical variables

H<sub>0</sub> P black = 20 p blue = 30% P yellow = 50%

H<sub>a</sub> the above is not what is given under h0

Use chi squared test

df (degrees of freedom)

Called goodness of fit

## Mine Test of association

More than one categorical variable
- Want to know if there is relationship
- or relationship between levels

Expected value

Expected value = n(
  
  

  )
  
  
  Then degrees of freedom
  
  
  Then we get something about goodness of fit
  

# 9. Regression

Simple linear regression and correlation

  `y = ɑ (intercept) + ɓ(slope)x + ɛ (epsilon)`
  
  y is dependent variable

We like scatter plots here

## Test if there's a significant relationship between y and x
  H<sub>0</sub>: no significant relationship
  H<sub>a</sub>: is a significant relationship
  Look at p value for F statistic
  Small p, reject null

## Describe strength of relationship
  Look at R value
  if `R > 0.75` – yes there is a strong relationship
  R may be negative or positive

## ɓ = slope
  Can be positive or negative
  Change in y per unit x

## ɑ = significance in model
  `ɑ = 0 vs ɑ ≠ 0`
  Will be given p value in R

## Your residual must be normal

  `Mean = 0`
  `Variance = σ2`

## Fitting a linear regression in R
Ordinary least squares (OLS)
Minimise the sum of squared differences
Get rid of negatives

`ɛ(point 5) = y(5) – y(pred)`

Small σ2

- Good predictive ability
- Points closer to predicted line
- Large σ2 not so good

Checking these things:


Hypothesis

Test Assumptions
1. Regression
2. Independence
3. Normality of residue
4. Normal probability
5. Homoscedasticity

Heteroscedasticity
  Reject Ho if p-value for F-stats < ɑ


![Pearce Correlation](../images/pearceGhostsFire.gif)
