# VERITY NOTES
Introduction to Statistics (MATH1324)
General Introduction
R
Why use?
Free
Widely available
No R commands/ code in exam
Assumes you can always google code in real life
Need for quizzes/ assignments though

## Lecture 1: Dealing Confidently with Uncertainty

  What is statistics and why do we need it?
  To draw conclusions from data
  Can get a different range of summary statistics from different types of data
  How do we use it?
  Referring to actual population
  Data is everything
  In all industries
  This course gives a basic introduction
  Gives enough detail for you to then extend your knowledge
  Statistics is the ‘discipline and science of obtaining, understanding, modelling, interpreting, and using data in all real and complex systems and processes that involve uncertainty and variation (MacGillivray)
  Conclusion never certain but best we can do
  Data, variation and uncertainty at the core of statistics

  Random variables and sources of variation
  Variables
  Characteristic that defines the process of product
  Price of shares
  Temperature
  Key performance variable
  Data
  Measurement of variables
  Random
  Get different value every time you measure
  Natural or real variation
  Height
  Weight
  Number of texts sent per day
  Explainable variation
  Ability to compare
  Quality of a computer
  Exam mark
  Sampling error
  Mean of a sample as an estimate for population mean
  Sampling may not be 100% representative of population
  Average salary of MSc (Analytics) as an estimate of average salary in Melbourne
  Reduce by increasing size of your population (can never be zero)
  Population size <> sample size
  Non-sampling variation
  Artificial variability
  This refers to any artificial variability induced by the research process
  Measurement
  Data recorder has an error
  Measurement used has some error
  Accident
  Just silly mistake that can invalidate your data
  At different levels
  During collection
  Typo
  Wrong measurement
  During processing
  Entering data
  Major types of variables
  Qualitative
  Categorical
  Yes/ no
  Describe by values or percentages
  Quantitative
  Discrete
  Countable
  Finite number of variables
  Continuous
  Measurement falls into an interval
  Time
  Height
  Levels of measurement
  Categorical or nominal
  No meaningful differences between categories
  Binary
  Male or female
  Yes or no
  Multinomial variables
  Religion
  Hair colour
  Ethnicity
  Ordinal
  Qualitative
  Rank
  Difference between ranks has no meaning
  Between 1st and 2nd and 3rd not the same time gap
  Know that they are faster but not by how much
  Interval
  Quantitative
  Vales of the interval scale are equally spaced
  Arbitrary zero
  Doesn’t mean anything
  No meaningful zeros
  Temperature
  Ratio
  Quantitative
  Similar to interval
  Is a meaningful zero
  Implies absence of a value
  Ratios are meaningful
  Time
  Length
  Heart beats per minute

  Not same as diagram from lecture notes but contains the same information

  Statistical inference – the big idea of statistics
  ‘Statistical inference moves beyond the data in hand to draw conclusions about some wider universe, taking into account that variation is everywhere and the conclusions are uncertain’ Moore
  Beyond data to draw conclusions
  Statistics has been referred to as the discipline involved with dealing confidently with uncertainty
  Distortions relative to sample size
  Bigger sample size
  Better overview of population
  More expensive to undertake


  Statistical data investigation process
  The entire process of a statistical data investigation involves everything from
  Initial thoughts
  Starts with a question
  Starts with a hypothesis
  Starts with a problem
  Starts with a general situation to be explored
  Planning
  Collection and exploration of data
  Report findings
  Statistical questions and problems are the same as mathematical questions and problems
  Statistics differentiated by
  Use of context and data collection
  Measurement decisions
  Omnipresence of variability
  Dealing with uncertainty
  Mathematics differentiated by
  Can exist without context
  Measurements exact
  No variability
  Deterministic answer
  Major types
  Understand the strengths and weaknesses of each type as these have an impact on the conclusions you draw
  Surveys
  Can be carried out on a sample of the population
  How do you select a good sample?
  Census
  Survey of whole population
  Good questions
  Response rate
  Response bias
  Experiments
  Sample split into 2 parts (not told which group you are in)
  Control – placebo
  Treatment group
  Assess significance of treatment
  Keep everything else the same
  Compare the two groups

  Observational or correlational studies
  Investigate the relationship between two variables
  Relationship between income and education

## Lecture 2: Descriptive Statistics Through Visualisations
  Summarising the data
  Contingency tables
  Describing data
  Descriptive statistics
  Summarises characteristics of data using numbers such as mean, range, mode or percentage
  Statistics is a science
  Also a word we use
  Calculate value
  Statistical visualisation
  Visual displays of descriptive statistics or data, that summarise important features or trends
  Most commonly graphs or plots
  Categorical data
  Best way to visualise/ display data is a pie chart
  Describing data with numbers
  favstats(price, data=Diamonds)
  Gives us
  Min
  Q1 (25 percentile)
  Median (Q2 – 50 percentile)
  Q3 (75 percentile)
  Max
  Mean
  Standard deviation
  Number of records
  Missing values
  Mean and variance
  Mean and variance measure the centre and variability of the sample data
  Influenced by each individual data point in the sample
  Can also find the middle using the median
  Mean
  Equation:
  Sum of each individual value in the data and then divide by the number of values
  Can be highly dependant on extreme values
  May be a good thing
  Truly represents the centre of your data
  Bad for skewed data
  Variability
  Variance
  Unitless
  Standard deviation
  Can use to define variability
  True variability – not like range
  Square root
  Converts back to original scale
  Equation:
  Distance between individual data points and the mean
  Small variance if the majority of the data is close to the mean
  Range
  Max minus the min
  Quartiles and the Median
  Quartiles are values that break a distribution into four parts
  Q1
  Lower quartile or 25 percentile value
  25% of the data lies to its left
  Q2
  Median
  50 percentile
  50% of data to its left
  Q3
  Upper quartile or 75 percentile value
  75% of data lies to its left
  Lots of applications in social science
  Almost ignore impact of extreme values
  Examples
  IQ
  House price
  Used when making a very general statement
  Whether you use a median or mean depends on the circumstances
  Calculating the median
  Depends on whether there are an even or odd number of data points

  Don’t need to be able to do this – just use R
  Good to have an understanding of how it is done though
  Odd number of samples
  Median sitting in position of (see equation above)
  Location of a value in your data
  Must be an integer
  Rank from smallest to largest and take middle value
  Even number of samples
  Median is the mean of the two middle values
  See equation above
  Calculating quartiles
  Q1 & Q3 are calculated in a similar fashion after the dataset is split at the median value
  Q1: median of bottom 50% of data
  Q3: median of top 50% of data
  Note that the median is included in both halves
  Outliers
  Very common in everyday statistics
  The interquartile range (IQR) is the range of the middle 50% of the data
  Q3 – Q1
  Depicted as the box in a box plot
  Also a measure of variance
  Value is either much bigger or smaller than rest of the data
  Often removed
  Formal definition:
  First define two fences (numerical value)

  For more extreme outliers use Q1 – 3x IQR and Q3 + 3x IQR
  What do we do with outliers?
  Leave it
  Reality of the data
  Train track maintenance of temperature impacts
  Remove
  In economics/ social sectors
  Focus solutions of IQR of data
  Then can worry about other 50% of data at a later stage
  Are values that fall beyond the outlier fences
  Box plot
  Visualisation
  Graphic view of IQR/ variance
  Based on Q1, median, Q3
  Flipped over in lecture slides

  Bell curve/ normal distribution (see diagram below)
  2 whiskers will be the same length
  Symmetrical data
  What data we would ideally like
  Lots of theory based on them
  Skewed distribution (see diagram below)
  If one whisker is longer than the other
  Toward left (negatively skewed)
  Toward right (positively skewed)
  Include suspected outliers, depicted as an ‘o’ or similar

  Histogram
  Always confirm box plot interpretation of data
  Comparing groups using descriptive statistics
  Example data
  Diamonds
  Checking quality, cut, colour, etc
  Split into levels
  Can do this using one R command

  Diamonds %>% group_by(cut) %>% summarise(Min = min(price, na.rm = TRUE)
  Comparing groups using visualisation
  Box plots
  Single R command
  `Diamonds%>%boxplot(pricecut, data = ., main- “Box Plot of Diamond Price by Cut”, ylab = “Cut”, xlab = “Price”, horizontal = TRUE, col = “skyblue”)`

  Lots of outliers for higher prices
  Using this plot confirm the following features
  Ideal has the smallest median price
  Premium has the highest IQR
  All price distributions are positively skewed
  All price distributions have many suspected outliers
  Fair has the highest Q1
  Premium has the highest Q3
  Scatter plots
  Single R command
  Diamonds%>%plot(price~cut, data = ., ylab = “Price”, xlab = “Carat”, col=”blue”, main= “Price by Carat”)

  Can see general relationship/ correlation

## Lecture 3: Probability: The Language of Uncertainty
  Contingency tables
  To explore the relationship between two categorical variables for your object
  Aka cross tabulations
  One = row
  Other = column
  Use to calculate conditional probabilities/ percentages
  tally(~cut + clarity, margins = TRUE, data = Diamonds)
  Can calculate conditional percentages
  round(tally(~cut|clarity, margins = TRUE, format = “proportion”, data = Diamonds), 3)
  Clustered Bar Charts
  Clustered bar charts are a great way to visualise two qualitative variables
  First, must create contingency table in an object called table
  This will make it easy for us to create clustered bar chart
  table <- tally(~cut | clarity, format = “proportion”, data = Diamonds)
  barplot(table, main = “Diamond Cut Quality by Clarity”, ylab = “Proportion within Clarity”, ylim = c(0,.8), legend = rownames(table), beside = TRUE, args.legend = c(x=”top”, horiz = TRUE, title = “Cut”), xlab = “Clarity”)
  grid()
  Notice the grid() was added after the plot was produced in R
  Grid lines can help the viewer quickly read off and compare values on the plot axes
  Easy way to compare things
  Probability
  Defined as the proportion of times a random event occurs in a very large number of trials
  Event: being female, or under 25, etc.
  Probability of an event = f/n
  f – frequency
  n – total sample size
  To improve – increase the sample size
  Rules

  Mutually exclusive
  Two events are mutually exclusive if, when one event occurs, the other cannot occur and vice versa
  Pr(A ∩ B) = 0
  Union
  Pr(A ∪ B)
  Intersection
  Pr(A ∩ B)
  Complement
  Pr( < 1 serve) (should be over the top)
  Conditional Probability
  Lots in medical area
  Probability that an event, B, will occur given that another event, A has already occurred
  Pr (B | A) = Pr (A ∩ B) / Pr (A)
  Use to check independence
  Two events are independent if
  Pr (A | B) = Pr (A) or Pr (A | B) = Pr (B)
  Permutations
  There are 6 candidates
  Vote for top 3
  Order matters
  Preferential voting a great example
  Huge number of permutations
  Pr (n, k) = n! / (n – k)!
  n! = n factorial
  6! = 6*5*4*3*2*1
  Combinations
  Order doesn’t matter
  More than permutation

## Lecture 4 – Probability Distributions: Random but Predictable
  Distribution functions for discrete quantitative variables
  Many variables follow predictable patterns
  Follow specific mathematical models
  Can fit to a model
  Will never get 100% accuracy
  Increase number of data points, can increase the accuracy
  We can predict many useful features
  Guessing on a multiple choice exam
  Coin choice
  Goals scored in footy match
  Infection rate of a disease
  Number of people in a queue for a café
  Binomial distribution
  Consider an experiment (trial) where there are only 2 options
  Success or failure
  Used to model the number of success/ failures in ‘n’ independent trials
  The probability of success at each trial is fixed as p
  Probability of failure is 1 – p
  Complement
  Same for all trials – independent of each other
  Defined by 2 parameters
  n – number of trials
  p – probability
  binom(n,p)
  Example:
  Cancer vaccine
  Effective 85% of the time
  p = 0.85
  If n = 12
  Success = 10.2
  Failure = 1.8


  Eff
  Has the following mathematical form
  The formula is known as a probability mass function (PMF)
  Don’t need to know formula
  Where
  k = success
  n = number of trials
  p = probability of success


  X represents the random variable itself
  x values that the random variable can take
  Mean and variance of a binomial distribution
  The mean, or expected value (E(x)), variance and standard deviation for a binomial distribution as follows
  Normal mean formula
  Assumed probability of each of those values is the same
  Changes if you have a different probability for success/ failure
  Need a mean formula that takes this into account
  Mean = E(x) = np
  Variance = np(1-p)
  Standard deviation = √np(1-p)
  Cumulative Distribution
  Probability that X will take a value less than or equal to itself
  Calculating probability using R
  What is the probability that the vaccine will work for 10 people?
  Pr(x=10) = 0.2923585
  dbinom(10, 12, 0.85)
  d – means distribution
  binom – type of distribution using (can vary)
  First number is the number of successes
  Second number is always n
  Third number is probability of success
  What is the probability that the vaccine will work for 8 or less people (cumulative probability)?
  Pr(x<= 8) = 0.09220633
  Add together the probability of x=1, x=2, …, x=8
  Pay attention to whether < or <=
  Particularly for discrete variables
  pbinom(8, 12, 0.85, lower.tail = TRUE)
  p – use for cumulative probability
  lower.tail = TRUE
  TRUE must be in capitals
  Add all values to the left of 8
  Notice how the argument lower.tail = TRUE has been made so a cumulative probability is calculated
  First number is the number of successes
  Second number is n
  Third number is the probability of success
  Probability increases and maximum probability is between 10-11
  What is the probability that the vaccine will work for between 9-10 people?
  Pr(9 <= x <= 11) = 0.7655519
  Always write the statement in terms of probability first
  Will aid your understanding
  Whether have the equals sign or not
  pbinom(11, 12, 0.85, lower.tail = TRUE) – pbinom(8, 12, 0.85, lower.tail = TRUE)
  Note that the lower level has been reduced to 8 to include the value of 9 in the calculation because our probability is in fact p(x=9) + p(x=10) + p(x=11)


  What is the expected value and standard deviation of the binomial distribution with n = 12, p = 0.85?
  E(x) = n*p = 12 * 0.85 = 10.2
  SD(x) = √n*p(1-p) = √1.53 = 1.24
  Zero is included as it has a value
  Probability needs to be calculated

  Skewed data
  Mean makes sense when you look at the graph

  Poisson distribution
  Used to model the occurrence of discrete events over a specific unit of time, t
  Especially useful for engineers
  Number of car accidents a month
  Number of under 80-year-old deaths a year
  Examples
  Telecommunication
  New antennae
  10k calls per minute
  Needs to be able to take this load
  Bank
  Mortgage applications per unit of time
  Unit of time may vary
  Month, year, etc.
  Average occurs per unit of time
  Defines the parameters
  Only one parameter
  Called lambda (λ)
  Mean and variance
  λ can be adjusted to take into account different time periods
  µ = λ * t
  Example
  The number of accidents per month in Melbourne is 10
  So the number of accidents in a year is: µ = 12 * 10 = 120
  Can vary unit of time as required
  Average for new unit of time
  If discrete variable x follows Poisson distribution with λ = 10 then
  Mean of x = E(x) = µ = λ = 10
  Variance of Poisson = λ
  Probability function for Poisson

  If you are using the same period of time
  t = 1
  µ = λ
  Probability calculation for Poisson
  Example
  Expected daily number of patients for a doctor during winter might be λ = 16 per day
  Mean for the week: µ = λ * t = 16 * 7 = 112
  Variance: σ2 = Var(x) = λ
  Standard deviation: σ = √λ
  Mean: µ = E(x) = λ
  Using R
  What is the probability the doctor will see exactly 16 patients in a given day?
  Pr(x = 16) = 0.09921753
  > dpois(x = 16, lambda = 16)
  Whenever you want the probability of X/x, equals a given value, you want your density function (dpois, dbinom)
  What is the probability that the doctor will see 12 or less patients in a given day?
  Pr(x <= 12) = 0.1931215
  > ppois(q =12, lambda = 16)
  What is the probability that the doctor will see less than or equal to 100 patients in a week?
  Pr(x <= 100) = 0.1378483
  Where µ = ⎣ * t = 16 * 7 = 112
  >ppois(q=100, lambda = 16 * 7)
  What is the probability that the doctor will see more than 25 patients in a day?
  1 – Pr(x <= 25) = 0.01311856
  >ppois(q = 25, lambda = 12, lower.tail = FALSE)
  What is the probability that the doctor will see between 8 and 24 patients in a given day?
  Pr(8 <= x <= 24) = 0.9676847
  >ppois(q = 24, lambda = 12) – ppois(q = 7, lambda = 12)

## Lecture 5 – Probability Distributions: Random but Predictable
  Normal distribution
  Example

  ```r
  IQ
  IQ ~ N(μ,θ) ~ N(100,5)
  ```
  Properties

  The centre of the symmetric bell shape is the mean (μ)
  99.7% of data falls within μ +- 3θ
  95% of data falls within μ +- 2θ
  68% of data falls within μ + θ
  For continuous <= vs < doesn’t matter as much
  Looking for area under the curve
  Calculating probability
  ```r
  Probability of IQ less than 80 = 0.09121122
  pnorm(q, mean, sd, lower.tail = TRUE)
  pnorm(80, 100, 15, lower.tail = TRUE)
   IQ  above 110 = 0.2524925
  pnorm(110, 100, 15, lower.tail = FALSE)
  Pr(85 < x < 115) = 0.6826895
  Within 1 θ of the mean on either side
  pnorm(115, 100, 15) - pnorm(85, 100, 15)
  ```
  Find x given percentile
  Which value of x, get 90% probability? = 119.2233
  ```r
  Pr (X <x) = 0.9
  qnorm(p, mean, sd, lower.tail)
  qnorm(0.9, 110, 15, lower.tail = TRUE)
  95% of population between a score of 71 and what upper value
  95% between mean and 2θ
  71% is not μ +- 2θ
  ```
  Almost but not exactly
  ```r
  Pr(71 < x < b) = 0.95
  Can find Pr(X > 71) = 0.973 (above 71)
  1 - pnorm(q=71, mean = 100, sd = 15) = 0.9734024
  pnorm(q = 71, mean = 100, sd =15, lower.tail = FALSE)
  qnorm(1 - 0.023, 100, 15) = 129.9309
  Can check using  pnorm(71 < x < 130) = 0.95
  ```
  What if you don’t have access to R (or another statistical program)?
  Standard Normal Z-distribution
  Mean is always 0
  Standard deviation is always 1
  Use the letter Z
  We can transfer a normal distribution into SN or ZD
  ```
  Z = (x - μ) / Ө
  Example
  Pr(x > 110) using SN
  Z = (x - μ) / Ө = (110 - 100)/ 15 = 10/15 = 0.667
  Pr(x > 110) = Pr(z > 0.667)
  ```
  Then can use a normal SD table and look up the value

  Get more precise values from R/ stats package

## Lecture 6/ Module 5 - Sampling: Randomly Representative
  Mean, standard deviation and distribution of the sample mean X̅
  X̅ = sampling distribution
  Examples
  Battery life of new mobile
  Sampling methods
  Simple random sampling (SRS)
  Every unit in a population has an equal chance of being selected
  Stratified sampling
  Very common in research
  Marketing
  Medical
  Divide population into strata
  Non-overlapping sub populations
  Age
  Ethnicity
  Take SRS from each strata proportional to the strata’s representation
  Cluster sampling
  First divides the population into naturally occurring and homogenous clusters
  Postcode
  Factory/ workplace
  Randomly selects a defined number of clusters
  Then use all selected clusters or take an SRS from each cluster
  Multi-stage clustering
  Convenience sampling
  Don’t know how representative your sample is
  Always biased
  Estimating kangaroos along roadside rather than over whole area
  Budget restraints
  Not always a bad thing
  Use substantial caution
  Probably the most common form of sampling
  Sampling distribution
  Mean of sample size changes as soon as you change the elements of the sample
  We can say that the sample mean X̅ is a random variable
  So one can define the probability distribution with specific mean and standard deviation for X̅
  This distribution is called sampling distribution
  A hypothetical distribution of a sample statistic constructed through the repeated sampling from a population
  2 major influences
  The underlying distribution of the random variable
  Size of your sample
  Should have 30 or more
  Not always possible
  Less than 30 is a small sample
  Different rules apply
  Regardless of original population distribution, X̅ will always be a normal distribution/ can use central limit theorem
  Mean, standard deviation

  Example
  Youtube video length
  ```r
  n = 10 (graph skewed to right)
  μ = 193
  θ² = 193^2
  θ = 193

  n = 30

  n = 100
  ```
  Central limit theorem
  If the underlying population distribution of a variable is normally distributed, the resulting distribution of the mean will be normally distributed

  Probability of randomly selecting a sample of size n = 100 that has a sample mean duration of less than 150 sec
  ```r
  Pr( X̅ < 150) = 0.0294095
  pnorm(150, 193, 19.3)
  n = 200
  pnorm(300, 193, 193/√200, lower.tail = FALSE) = 2.244519e-15
  ```




## Lecture 7
  using James Baglin’s slides
  Go back to first week’s lecture
  Airline data
  Sample size of 5
  Mean estimates
  Variable sample mean/ μ
  There is always an error
  Must be aware of this uncertainty when in the real world
  Point and interval estimate
  Don’t even use point estimate
  Can be easily disputed
  Should use interval in real life
  Use confidence interval
  In general over many repetitions
  State confidence level
  95% sure the mean is within that range
  Mean of sample will fall within that range 95 times out of 100
  Usually give value of confidence
  Range from 90 to 99%

  `1 - α` is significance level
  `100 (1− α)% CI`, is an interval estimate for a population parameter, based on a given sample statistic, where if samples of a certain size n were repeatedly drawn from the population and a CI for each sample's statistic was calculated, 100(1−α)% of these intervals would capture the population parameter, whereas the other 100(α)% would not.
  Confidence interval inverse relationship to sample size
  Same size getting closer to whole population size
  `100 * (1 - α)% CI = confidence interval`
  Value of α is the significance level
  Simple explanation
  Confidence intervals are one way to represent how "good" an estimate is; the larger a [95]% confidence interval for a particular estimate, the more caution is required when using the estimate. Confidence intervals are an important reminder of the limitations of the estimates.
  Visualising confidence interval
  App of CI
  `100, 10, 0.05`
  Mean of actual population - black
  Mean + CI for each sample - blue
  Mean outside CI - red
  Impact of sample size and confidence
  As sample size increases, width of CI decreases
  As confidence increases, width of CI increases

  Why use 95%?
  Accepted in majority of fields
  Bit more relaxed than 99%
  Security/ safety fields - use 99%
  Civil engineers
  90% in social services
  Mean
  Estimate population mean IQ, σ (standard deviation) = 15
  Z follows a normal standard deviation
  Must decide whether to use Z table or T table
  Choose Z when
  Population follows a normal distribution
  If don’t know original distribution of data, n > 30
  Only T available in R
  Copy equations from notes
  qnorm(0.975)
  In R, need to use full stats
  Find mean of sample
  favstats(~IQ, data = IQ)
  Upper and lower confidence intervals

  ```r
  mean(IQ$IQ) + qnorm(0.975) * (15/sqrt(1290) = 103.91
  mean(IQ$IQ) - qnorm(0.975) * (15/sqrt(1290) = 102.07
  ```
  If you don’t know σ
  σ is the standard deviation of the population
  Use population sample σ as a guide
  Copy equation from notes
  Note the use of sample standard deviation s instead of σ
  t is continuous
  T distribution has one variables
  n - 1
  Degrees of freedom
  Shape similar to normal distribution
  Same mean but a bit flatter

  If `n = 25+`, t and normal distribution have ‘same’ distribution
  Used heavily when sample size is less than 25
  Have to use assumption of normality and sigma is known
  ```r
  qt(0.975, df = 1289) = 1.96
  ```
  Copy formulas into notes
  As degrees of freedom increases t ➝ z
  Confidence interval (CI)
  Built in command in R
  ```r
  confint(t.test(~IQ, data - IQ))
  ```
  Gives mean
  Lower CI
  Upper CI
  Level - default is 0.95 (confidence.level = 0.95)
  Can combine confint() and t.test() functions
  ```r
  confint(t.test(~Diameter, data = subset(Pizza, subset = (Store == ‘Dominos’))))
  ```
  Exam
  Open book
  No sample exam paper published
  Multiple choice questions - 30-40 of them
  Long questions
  Using R output
  Similar to tute questions except give you R output
  Compare CI for 95 - 99% intervals
  Can bring in 2 A4 pages
  Typed or handwritten
  Add formulas, etc
  Proportions
  Using water data
  95% CI people choose Fiji as first choice
  Binomial distribution
  If `np(1 - p) >= 5`, then the 95% CI for a portion can be calculated using normal distributions
  Copy in equation from notes
  Here `np(1 - p) = 109 * 0.404 (1 - 0.404) = 26`
  Safe to use normal distribution (26 >= 5)

  ```r
  install packages(“epitools”)
  library(epitools)
  binom.approx(44, 109, conf.level=0.95)
  Returns
  x = 1
  n = 44
  Proportion = 109
  Lower = 0.312
  Upper = 0.496
  Conf level = 0.95
  If don’t use normal
  binom.exact(44, 109, conf.level=0.95)
  ```
  Similar answers
  Rates
  Follow poisson distribution
  Pay attention to time period
  If `ƛ > 100`, safe to use normal approximation
  `pois.approx(156, pt=1, conf.level=0.95)`
  Returns
  x
  pt (time period)
  May need to convert to other units
  Given per week, pt = 1
  Per year, pt = 52
  Lower
  Upper
  Conf.level

## Lecture 8
  Decision making/ hypothesis testing
  How to use data to make decisions
  Using analytics
  Start by taking a sample
  Use confidence intervals to make statements about whole population
  2 decisions
  Null hypothesis
  In R, most of code based on it
  Hypothesis testing provides a set of rules to help us decide what should be considered ‘unusual’
  All about the NULL hypothesis
  Decide if want to investigate the mean or proportion
  Null/ Ho
  Logic is simple
  Begin by stating an assumption about the world, Ho
  Ho is the status quo
  Alternative/ Ha
  Alternative hypothesis
  What we set out to establish
  Need to gather evidence to support
  The burden of proof always on Ha
  To support Ha, must rule out Ho beyond all reasonable doubt
  Reject null


  Example
  Ho : µ = 100
  Ha : µ <> 100
  One sided test: Ha > µ0
  Two sided test: Ha <> µ
  Need evidence to reject Ho
  In favour of alternative hypothesis
  Outcome of some action
  ɑ is the significance level used to reject (or not) your Ho
  5% chance – line in the sand
  Use knowledge of sampling distributions and confidence intervals
  General approach
  Assume null is true
  Look for evidence that null is false
  Use a critical value of the test and see if its falling into the rejection region or
  Calculate p (conditional probability) – value is less than the significance level ɑ or
  Does (1 - ɑ) confidence interval contain the Ho value
  T-test
  Test statistic for hypothesis testing
  Can calculate

  Be careful using this if n is less than 25
  Use z
  In real world not always easy to get sample size > 25
  Need to check normality condition
  Skewed distribution
  Qqplot (confidence interval)
  Example
  Oral human body temperature
  favstats(Body_temp, data = Body_temp)
  check n
  ```r
  Ho: µ = 37
  Ha: µ < 37
  P-value = p = Pr(Ẍ < 36.81 | µ = 37)
  ```
  How possible it is to get mean less than 36.81 if actual population mean is 37
  ```r
  If p < ɑ, reject Ho
  If p >= ɑ, fail to reject Ho
  Usually ɑ = 0.05 for stuff I have done previously
  ```
  Pay attention to the sign of probability in p-value
  Follows the sign in Ha
  Calculate one-sided p-value
  Convert the mean into t-test statistic and calculate p-value
  `p = Pr(t < -5.38 | t = 0)`
  Where t defined by

  `pt(t, df = n – 1)`
  Since p is very small, can reject the null
  Claim test is very significant and mean temperature is less than 37
  Calculate two-sided p-value
  `Ha: µ <> 37`
  Things get a little strange if we use a two-tailed test (Ha: µ <> 37)
  Because we need to take into account the mean also falling 5.83 SE above the mean
  ```r
  p = Pr(t < 5.83 | t = 0) + Pr(t > 5.83 | t = 0)
  ```
  As the t-distribution is symmetric, the two probabilities to be added are exactly the same
  Therefore, a shortcut to a two-tailed p-value can be calculated as
  ```r
  p = Pr(t < 5.83 | t = 0) * 2
  pt(t, df = n – 1) *2
  ```
  When to reject the null?
  Suggest the ‘treatment’ has a significant
  Fail to reject null
  Not enough evidence to reject


  Confidence interval approach
  If we use a confidence interval to test Ho for a one-sample t-test, we will automatically use a 2-tailed hypothesis test
  That’s because most confidence intervals divide significance level by 2 in their calculations
  One-sided confidence intervals can be calculated, but are not typically supported by most statistical software
  First we calculate the 95% CI for the sample mean Ẍ = 36.81
  Recall when the population standard deviation is unknown, the 95% CI is calculated as:
   (apologises for the bad resolution)
  confint(t.test(~Body_temp, data = Body_temp))

  ```r
  Is µ = 37 captured by the 95% CI (36.74, 36.87)? No – reject Ho
  ```
  R

  ```r
  t.test(~Body_temp, data = Body_temp, mu = 37, alternative = “less”)
  ```
  One-sided t test
  Only one-sided confidence level given
  If so, need to run R code twice to get two-sided confidence intervals
  Rejection region


  Always say what your alternative hypothesis is
  P value and CI should give you the same decisision

## Lecture 9 – Two sample and paired samples t-test
  Comparing the mean of two populations
  Select a sample from each population
  Size of 2 samples doesn’t have to be equal
  Depending on size of populations
  Two sample test
  Decide if two means are equal
  Normality assumptions
  Sample size more than 30
  So can apply central limit theorem
  Variance assumptions
  Often unknown
  Unknown but equal
  Different tests if know they are different
  Means can be different but have same variability
  Levene’s test
  Use to test the homogeneity of variance
  Hypothesis for comparing mean of two populations
  Null
  Mean 1 – mean 2 = 0
  Alternative
  Mean 1 ≠ mean 2
  Mean 1 – mean 2 > 0
  Mean 2 – mean 1 > 0
  levenetest(BodyTemp ~ Gender, data = BodyTemp)
  Decision based on p-value or confidence interval
  Also get F-score
  Not symmetrical
  Different test statistic
  We will be using p-values
  Example – battery performance
  Until now we have run favstats
  Graphically look at distribution
  Null
  different in mean battery performance
  0 = Mean(energizer) – mean(ultracell)
  Alternate
  Mean(energizer) – mean(ultracell) ≠ 0
  Conclusion
  Reject null if value for differences doesn’t fall into confidence intervals
  Confidence intervals for differences not individual means
  Normality
  Normality is only a problem in small samples (generally sample sizes less than 30) due to the central limit theorem
  However, when we need to test normality the most, there is no good method
  Graphs help

  Often, we don’t have sufficient information
  Sometimes we need to make an assumption or maybe look for alternative methods
  Solid middle line = normal probability line
  Ranking pairs of observed data for each percentile
  If close to this line, normal assumption valid
  Package plots 95% CI as dotted lines
  95% of actual data should fall within dotted lines
  Don’t get a p-value from R
  Homogeneity of variance
  ANOVA – more than 2 samples
  Levene’s test
  Ho: The data are drawn from two populations that have EQUAL variance
  Ha: The data are drawn from two populations that have UNEQUAL variance
  Look at the p-value produced by Levene’s test
  Assume equal variance if you Fail to reject null, p > 0.05
  Otherwise, do not assume equal variance, p < 0.05
  If you fail to reject the null, use the standard two-sample t-test in R var.equal = TRUE
  Or use 2-sample t-test in R with variance not equal (Welch two-sample) var.equal = FALSE
  R code
  ```r
  Battery_sub <- subset(Battery, subset = Voltage == 0.8)
  favstats(~Pulses | Brand, data = Battery_sub)
  leveneTest(Pulses ~ Brand, data = Battery_sub)
  t.test(~Pulses | Brand, data = Battery_sub)
  ```
  Interpretation
  Negative confidence intervals means mean 2 is greater than mean 1
  If confidence interval includes zero, have to ACCEPT the null
  Test statistics
  The test statistics ‘t’ for two sample test is defined by
  Where:

  Where t follows a T-distribution with the following degrees of freedom
  ```r
  df = n1 + n2 – 2
  ```
  Different when you have unequal variance
  Welch 2 sample t-test
  Hard to calculate
  If you don’t specify var.equal in the t.test() function in R, the two-sample t-test default is assuming unequal variance
  t.test(Body_temp ~ Gender, data = Body_temp, var.equal = FALSE, alternative = “two.sided”)
  The 95% CI of the difference between the means (-0.163) was calculated using the following formula in R

  Paired samples
  Used in medical studies
  Situations where the measurements are taken on the same source, subjects or objects under two different procedures, conditions, environments to decide whether the two conditions are the same
  Dependent samples
  Not independent
  Same people measured twice
  Paired data
  Steps to carry out hypothesis testing for paired samples
  For each subject, we have two measurements, we find the differences for all subjects in the same
  We test the mean differences
  We are dealing with population differences only so it is a one sample test
  If the two conditions are the same then the mean of differences is zero
  Test statistics
  Test statistics following T-distribution with `df = n – 1` is:
  
  The `(1 - ɑ)% CI` is:

  Graphical interpretation of paired samples
  Dependant sample assessment plots using granova and R

  Some features worth mentioning
  X and y axes are equal to allow easy comparison between the two sets of samples
  Post assessment scores are along the x axis so that the mean difference will be positive for increased performance
  The solid black line represents not difference in samples
  Any points above this line represent positive change (increased scores)
  Any points below this line represent negative change (decreased scores)
  Horizontal red line is the pre-assessment mean
  Vertical red line is the post-assessment mean
  Thick red diagonal line is the mean difference
  Green bar is the 95% confidence interval
  If the green bar overlaps the identity line, than any observed difference is not statistically significant

  Two-sample t-test - overview
  Hypothesis for the two-sample (independent samples) t-test:

  Assumptions:
  Comparing two independent population means with unknown variance
  Population data are normally distributed or large sample used (n > 30 for both groups)
  Population homogeneity of variance
  Decision rules:
  Reject Ho:
  ```
  If p-value <  (ɑ significance level)
  ```
  If 95% confidence interval of the difference between means does not capture Ho: Uenergizer – Uultracell - 0
  Otherwise, fail to reject Ho
  Conclusion:
  Test will be statistically significant if we reject Ho
  Otherwise, test is not statistically significant
  Two-sample t-test result summary
  Two sample t-test result summary:
  We assumed normality, but there might be some doubt
  We defaulted to not assuming equal variance, despite the Levene’s test indicating it was safe to assume
  Estimated difference between means: 118.22 – 156.67 = -38.45 pulses
  95% CI of difference between means [-46.18, -30.71]
  `p-value < 0.01`
  Decision:
  Reject the null

  Paired-samples t-test
  Hypothesis for the paired (dependent) samples t-test:

  Assumptions:
  Comparing the population average difference or change between two matched measurements
  Differences are normally distributed or large sample used
  Decision rules:
  Reject Ho:
  If p-value < 0.05 (ɑ significance level)
  If 95% CI of the mean difference does not capture Ho
  Otherwise, fail to reject Ho
  Conclusion:
  Test will be statistically significant if we reject Ho
  Otherwise, the test is not statistically significant

## Lecture 10 – Module 9
  Simple linear regression and correlation
  Overview
  Statistical investigations often aim to understand the relationship between variables in order to make accurate predictions
  This module will cover the use of linear regression models for modelling relationships between two quantitative variables
  Correlation and simple linear regression are used to examine the relationship between two quantitative (discrete or continuous) variables
  Linear regression
  Is there a relationship?
  How strong is it?
  Which variable is dependant (y)?
  Which variable is independent/ predictor (x)?
  Could be one (simple linear regression)
  Could be more than one (multi-regression)
  Correlation and simple linear regression are used to examine the relationship between 2 quantitative (discrete/ continuous) variables
  Linear vs non-linear?
  Not in this course
  In this class
  Linear
  1 independent variable
  ```r
  y = ɑ + ɓx + ɛ
  y – dependant variables
  ɑ - constant/ intercept
  ɓ - slope
  ```
  Change in y per unit x
  Can be negative or positive
  X – predictor
  ɛ (epsilon) – random error
  Never find a model that explains 100% of your data
  Must follow a normal distribution
  µ = 0 and σ

  Should we fit a linear regression?
  Check scatter plot
  Scatter plot must be linear
  Each pair of x, y represented by one dot

  Graphical decision

  Fitting a linear regression in R
  Ordinary least squares (OLS)
  Minimise the sum of squared differences
  Get rid of negatives

  Always points not on the line
  ɛ difference between the predicted and actual data
  ```r
  ɛ(point 5) = y(5) – y(pred)
  ```
  Statistical packages use optimisation to get the lowest error possible
  Mean of 0, variance of σ2
  For ɛ
  Positive and negative should cancel each other out
  Half the points above and half the point below the line
  Constant variance?
  Constant throughout the sampling process
  Significant role in predictive ability
  σ2 always given
  Large σ2 not so good
  Small σ2
  Good predictive ability
  Points closer to predicted line

  Example – oxygen uptake efficiency
  Measuring fitness
  Maximise ability to measure this
  Related to oxygen consumption
  Presented by OUES
  Easy to measure clinically
  Dependant variable is difficult to measure
  Why we do regressions
  Look at scatter plot
  Constant pattern
  Positive correlation

  Hypotheses
  Ho – data doesn’t fit to linear regression model
  Ha – data fits linear regression
  Use an F-test (not sure exactly what this is!)
  Not learning this subject – use p-value instead
  Assumptions
  Independence
  Using different groups of people
  Each person independent of each other
  Otherwise, repeated measurements
  Different type of regression
  Check experimental design
  Linear relationship
  Discussed above
  Normality of residual
  Don’t check using graph
  Normal probability qqplot
  ```r
  qqplot(ouesvo2maxmodel$residuals,  dist = “norm”)
  ```
  Homoscedasticity
  Related to the assumption of homogeneity of variance for two-sample t-test
  mplot(ouesvo2maxmodel)
  Constant variance
  Should be a football shape
  Heteroscedasticity
  Fan shaped residual
  Common shape



  Decision rules
  Reject Ho if p-value for F-stats < ɑ
  R code
  Using lm() function
  ```r
  ouesvo2maxmodel <- lm(VO2_Max ~ OUES_3, data = OUES)
  msummary(ouesvo2maxmodel)
  ```
  Give a name to your regression model
  Doesn’t give you output
  Always y variable first, followed by x
  Same order as scatterplot
  Summary of model
  Gives full output
  Same for other numbers of predictors
  First line
  Intercept, ɑ in regression
  Std use for confidence intervals
  `p value for ɑ`
  Second line
  `p value for ɓ = 0`
  Gives you both f and p values

  ```r
  p = 1.345e-13
  ```
  Very small p, is a relationship between x and y

  Regression equation
  ```r
  Y = 2017 + 0.6085x
  ```
  Increase as positive
  Intercept
  p value for
  2 p values in output
  Do not contradict each other
  Slopes make sense when compared to scatter plot
  R2 value
  Goodness of fit
  In R output
  Ranges from 0 – 1
  Reflects the proportion of variability in the dependant variable that can be explained by a linear relationship with the predictor variable
  How strong a predictor is it?
  A percentage
  Closer to 1 – stronger relationship
  Sometimes get told what R2 value to expect
  i.e. reject under 0.7
  Adjusted R2 as well
  Minus significant outliers
  If R2 and AR2 are too different, means you have heaps of outliers
  A value of 0.684 means
  68% of value y is due to x
  Other 34% explained by something else
  To improve R2, bring more predictors in
  F distribution
  Skewed
  Two degrees of freedom
  Test for a significant constant or not
  Follow a t-distribution
  Just use p-values
  Using confidence intervals
  confint(ouesvo2maxmodel)
  Only run this command after you run regression model
  Useful to identify outliers
  Get through R command
  Prediction interval
  Ok if nothing falls outside
  Points that are wacky
  Same assumptions as discussed previously
  Example write-up
  Prior to fitting the regression, a scatterplot assessing the bivariate relationship between VO2 max and OUES 3 minutes was inspected
  The scatterplot demonstrated evidence of a positive linear relationship
  The overall regression model was statistically significant, F(1, 48) = 103.92, p < 0.001
  The results show that OUES 3 minutes explains 68.4% of the variabililty in VO2 max, R2 = 0.684
  The estimated regression equation is VO2 – 2106.8 + 0.609 * OUES
  The positive slope for OUES 3 minutes as statistically significant, b = 0.609, t(48_ = 10.194, p < 0.001, 95% CI [0.488, 0.729]
  Final inspection of the residuals supported normality and homoscedasticity
  Correlation
  Pearsons correlation coefficient (r)
  A standardised measure of the strength of the linear relationship between two variables
  Can be negative or positive (same as slope)
  Varies from -1 – 0 – 1
  -1 or 1 means perfect relationship with x to y
  -0.5 to 0.5 means not much of a relationship
  Mali uses > 0.75 or < -.075
  Putting condition on r easier than R2
  In R
  cor(VO2_Max, OUES_3, data = OUES)
  rcor gives slightly different response

## Lecture 11 – Module 8 – Hypothesis testing
  A demonstration of the chi-square goodness of fit test and chi-square test of association
  Want to test the goodness of the fit
  Associated between variable and different levels of your category variables
  Whenever you make a decision, need a test statistic
  Chi – test
    1 parameter
    Follows a standard distribution
    Longer tail
  What we will cover in this lecture
    Investigate the distribution of categorical variables or explore the associations between categorical variables using Chi-square distribution
    Determine when a Chi-square goodness of fit test or Chi-square distribution
    Apply and interpret the Chi-square goodness of fit test
    Apply and interpret the Chi-square test of association
    Use R to compute a Chi-square goodness of fit test and Chi-square test of association
    Interpret a Chi-square goodness of fit test and Chi-square test of association
  Example: M&Ms
    6 colours
    Manufacturer claims different percentage of colours
    n = 48 packs of M&Ms, 2620 M&Ms
    In table
      Observed – based on sample
      Proportion of observed
      Expected – based on manufacturer claim
      Population proportion – manufacturer claim

  Find absolute error
    As some differences negative and some are positive
  Could use a 2 proportion test
    In a t-test
    Didn’t learn this
  Goodness of fit
    Can test no matter how many categories
    Differences close to zero, accept claim
    Otherwise reject
    Only one assumption
    Minimum expected value must be at least 5
    Hypotheses
    Ho: distribution as claimed
    Ha: not as claimed
    Only one alternative
    Not one per category
    Use a two-smaple t-test instead for this

    Smaller χ2 – close to expected
    Larger χ2 – further from expected
    50.8 is large!
    Degrees of freedom = number of categories minus 1
  R
    ```r
    qchisq(0.05, df = 5, lower.tail = FALSE)
    Calculate p-value of Pr(χ2 > 50.83)
    pchisq(50.83, df = 5, lower.tail = FALSE)
    ```
  Test of association
    Example: breast cancer vs. age they had their first child
    Contingency table

    Categorical values
    Degrees of freedom = (number of categories in columns – 1) * (number of categories in rows – 1)
    Calculate percentage within group and percentage within age
    If not associated with age, proportion the same everywhere
    R
      ```r
      Breast.Cancer$Group <- factor(Breast.Cancer$Group, levels = c(1,2), labels = c(“Case”, “Control”)
      Breast.Cancer$Age_Cat <- factor(Breast.Cancer$Age_Cat, levels = c(1,2,3,4,5), labels = c(“<20”, “20-24”, “25-29”, “30-34”, “>=35”), ordered = TRUE)
      tally(~Age_Cat | Group, margins = TRUE, data = Breast.Cancer)
      tally(~Age_Cat | Group, margins = TRUE, format = “proportion”, data = Breast.Cancer)
      table <- tally(~Age_Cat | Group, format = “proportion”, data = Breast.Cancer)
      barplot(table, ylab = “Proportion Within Group”,
      ylim = c(0,6), legend = rownames(table), beside = TRUE,
      args.legend=c(x = “top”, horiz=TRUE, title = “Age Category”),
      xlab = “Age Category”, col=rainbow(5, start = .4, end = .7))
      ```


  Example write up
    If there is no association between age at first birth and breast cancer, the height of the bars of the cases and controls within each age band would be the same
    Mothers with breast cancer are less likely to have their children under the age of 20 when compared to controls
    This is an example of a categorical association. The probability of being a mother with breast cancer depends on the age of the mother when they had their first child
  We need to determine with a Chi-square test of association whether this relationship is statistically significant or whether it reflects natural sampling variability assuming breast cancer and age are independent.
  Hypotheses
    Ho: there is no association in the population between the categorical variables
    Ha: there is an association in the population
  Equation

    Oij is the observed count in the ith row of the jth column

  More R
    ```r
    xchisq.test(tally(~Group | Age_Cat, data = Breast.Cancer))
    ```
    Results in this order
      Observed
      Expected
      Contribution to χ2
      Residual
  Example write-up
    A Chi-square test of association was used to test for a statistically significant association between breast cancer status and the age of a mother at first birth
    The results of the test found a statistically significant association, χ2 = 130.34, p < 0.001
    The results of this study suggest that women with breast cancer were more likely to give birth to their first child in older age categories when compared to controls
    Can continue to copy from notes but can’t be bothered…
  Examples
    Goodness of fit test – can drunk people walk straight?
    Test of association – eye colour vs hair colour?

## Lecture 12 – Revision

  Exam
  Sample exam
  Under assignments
  Open book
  2 double sided hand written/ typed A4 notes
  Use Mali’s notes as a basis
  Calculator
  Not allowed a graphics calculator
  But do need a simple calculator
  15 minutes reading time
  50 multiple choice questions
  10 short answers (worth 50 marks)
  Mali will send through notes of what she went through in the lecture today

  ### Module 1
  Definition of variables
  Nominal (categorical)
  Ordinal (rank)
  Interval (equal interval)
  Ratio (absolute zero)

  Design of analysis

  ### Module 2
  Summarising data
  Graphical
  Numerical
  Measures of central tendency
  Measures of central tendency
  Location of data
  Quantitative data
  Mean (ẍ - should be x bar but couldn’t find the simple)
  Sensitive to each individual data value
  Outliers
  Median
  Divides data into two groups of equal sizes
  Not impacted that much by outliers
  Two formulas – don’t need to know
  Mode
  Maximum frequency value
  Repeated value
  Can be bimodal etc.
  Frequency table/ histogram
  Measures of variability
  Spread of your data
  Range
  Most common measure of variability
  Max value – min value
  Very sensitive to outliers
  Variance

  Compared each sample to the mean
  Sensitive to each individual data point
  Remove outliers first?
  IQR
  Range of the middle 50% of data
  Q3 – Q1
  Outlier
  Any values less than Q1 – 1.5IQR or more than Q3 – 1.5IQR
  Boxplot
  No statistical package shows your fences (defined above)
  Use to decide if data is symmetric or not
  Whiskers are the same size
  Q2 (or median) middle of IQR
  Compare to histogram
  Use to compare (variability) of data
  Can look at median value
  Or length of positive skew
  Or largest Q3, etc
  Positive skew – mean greater than median
  Negative skew – mean less than median

  ### Module 3
  Probability using contingency table
  Events occurrence
  Mutually exclusive event
  Union
  Intersection
  Conditional probability


  ### Module 4
  Binomial distribution
  When outcome of each experiment is only two options
  Estimate number of success after n experiments
  Two parameters
  Number of trials
  Probability of success
  Discrete random variables only
  Expected value of success = mean
  Mean = n x p (not on exam)
  Variance = np(1 – n) (not on exam)


  Poisson distribution
  Rate of occurrence per unit time/ distances
  1 parameter λ
  Discrete random variables
  Or any factor of that time/ distance variable
  Mean = λ
  Variance = λ
  Normal distribution
  Symmetric
  Centre is always the mean
  Bell shape
  99.7% of values within µ ± 3σ
  95% of values within µ ± 2σ
  68% of values within µ ± σ
  Z – standardised normal
  Same bell shape
  Mean = 0
  Variance = 1

  Not fussed about >= or >
  Calculating area under the curve
  Continuous variables

  ### Module 5
  Mean of sample distribution and properties
  Observation in samples change
  Mean random variable on its own
  Population (should double check these equation)
  Mean µ
  Variance σ2
  E(ẍ) = n/x = µ
  Var(ẍ) = σ2/x = σ2/n
  SE = σ/√x =  σ/√n
  Standard error of mean
  Reduces as n increases
  Inversely proportional
  Central limit theorem
  Distribution of sample mean
  If n > 3σ and keep drawing samples to calculate mean
  They will be different
  Will follow a normal distribution
  qqplot
  For a normal population
  Doesn’t matter about sample size
  ẍ ~ N(µ, σ2/n)

  ### Module 6
  Point estimates
  ẍ point estimate of µ (population mean) - Ṕ
  Error = σ/√n
  Confidence intervals
  Define by ɑ significance level
  (1 - ɑ)/ CI
   
  Whether using z or n
  These are the true values
  If repeat sampling 100 times, get 100 CI
  Actual population mean (µ) would have CI 95 of these intervals
  Chance of not including value of µ in only 5%
  Using shiny app
  If increase sample size, CI will shrink
  Mean becomes closer to actual mean of population
  Increase level of CI (95 – 99.7), length of CI increases
  Larger interval
  For smaller samples
  Proportion – didn’t do much
  Use z statistic to calculate
  Formula?

  ### Module 7
  Hypothesis testing
  Null hypothesis
  Always value you have
  Equal to something
  Alternat hypothesis
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
  Χ2 – chi square test
  Degrees of freedom: number of categories – one
  Minimum value for each category must be more than 5

  E = expected value if assumption correct (30% black)

  ### Module 9
  Regression, y = ɑ + ɓx
  Test for a significant relationship between y and x
  Null: no relationship
  Alternate: is a relationship
  Look at p value for F statistic
  Small p, reject null
  Describe strength of relationship
  Look at R value
  R may be negative or positive
  R > 0.75 – yes there is a strong relationship
  ɓ = slope
  Can be positive or negative
  Change in y per unit x
  ɑ = significance in model
  ɑ = 0 vs ɑ ≠ 0
  Will be given p value in R
  Your residual must be normal
  Mean = 0
  Variance = σ2
