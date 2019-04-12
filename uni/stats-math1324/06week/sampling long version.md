the long version:

- https://sites.google.com/a/rmit.edu.au/intro-to-stats/home/module-6?pli=1



Links:
worksheet: https://docs.google.com/document/d/1JmhTRn6pF1KzlWF121geI2g0t6OyTMqFwxnjyipz22M/edit



# Module 5: Sampling: Randomly Representative

Contents

1.  [**1** Module 5: Sampling: Randomly Representative](https://sites.google.com/a/rmit.edu.au/intro-to-stats/home/module-5#TOC-Module-5:-Sampling:-Randomly-Representative)
    1.  [**1.1** Overview and Learning Objectives](#TOC-Overview-and-Learning-Objectives)
    2.  [**1.2** Video](#TOC-Video)
    3.  [**1.3** Populations and Samples](#TOC-Populations-and-Samples)
    4.  [**1.4** Sampling Methods](#TOC-Sampling-Methods)
        1.  [**1.4.1** Simple Random Sampling (SRS)](#TOC-Simple-Random-Sampling-SRS-)
        2.  [**1.4.2** Stratified Sampling](#TOC-Stratified-Sampling)
        3.  [**1.4.3** Cluster Sampling](#TOC-Cluster-Sampling)
        4.  [**1.4.4** Convenience Sampling](#TOC-Convenience-Sampling)
    5.  [**1.5** Sampling Distributions](#TOC-Sampling-Distributions)
        1.  [**1.5.1** YouTube Data](#TOC-YouTube-Data)
        2.  [**1.5.2** Simulations in R](#TOC-Simulations-in-R)
    6.  [**1.6** Central Limit Theorem](#TOC-Central-Limit-Theorem)
    7.  [**1.7** What are sampling distributions used for?](#TOC-What-are-sampling-distributions-used-for-)

## Overview and Learning Objectives

Often a population is immeasurable. Therefore, statistical investigations must often rely on the use of a sample from the population. This module will introduce sampling from populations.

The learning objectives associated with this module are: 

*   Describe the purpose of sampling for estimation and inference. 
*   Define and distinguish between different sampling methods. 
*   Define a sampling distribution for a statistic.
*   Define the expected value and variance of a sampling distribution.
*   Use technology to simulate and explore the characteristics of sampling distributions.
*   Define and apply the Central Limit Theorem (CLT).

## Video

This a nice video that explains the challenge of sampling in ecology research. The video discusses populations, samples and random samples.

## Populations and Samples

In this module we will dive deeper into the world of inferential statistics first introduced back in Module 1. Recall, statistical inference refers to methods for estimating population parameters using sample data. A **population** is the larger group that a researcher wants to generalise their results to. For example, a researcher may need to know the average battery life for a new model of mobile phone, or estimate the average transfer speeds for a new computer hard disk drive. It would be too expensive or infeasible to test every unit manufactured. Therefore, the researcher must use another method.

A researcher's confidence in their ability to infer what's happening in the population comes down to the quality of the sample and quality of the data collected. In this section we will deal with samples. A **sample** is a smaller subset of a population. If the sample is chosen appropriately, it can provide a fairly accurate account of the population. Why do we use samples? Cost, time and practical constraints often make measuring the population impossible. Think back to the mobile phone and hard disk drive example in the previous paragraph. When an entire population is measured, it is called a **census**. The Australian Bureau of Statistics (ABS) conducts the Australian Census every five years at an estimated cost of $440 million (Based on 2011 Census). As you can understand, this amount of time and money is well beyond the means of most statistical investigations.

There are good and bad ways of gathering samples. Probability-based methods maximise the chances of gathering a randomly representative sample. Common probability-based methods include simple random sampling, cluster sampling and stratified sampling. Non-probability based methods make no effort to ensure the sample is randomly representative. The best example of these types of methods are convenience sampling, purposive sampling, quota sampling and snowballing. Let's take a closer look at the probability-based methods.

## Sampling Methods

### Simple Random Sampling (SRS)

In SRS, every unit in a population has an equal chance of being selected. For example, every new model mobile phone manufactured has an equal chance of being selected to undertake a battery test. This is the most simple and effective probability-based sampling method. However, it can be tricky to implement. For example, if we were looking at the population, how do we get a list of every single Australian so you can ensure everyone has an equal chance of being selected? A phone book is a good start, but what about people without landlines? This course will focus mainly on simple random sampling. Watch the following video by Steve Mays for a nice overview of SRS. 

### Stratified Sampling

Stratified sampling divides the population into subpopulations, called strata (e.g. gender, age bands, ethnicity), and then takes a SRS from each strata proportional to the strata's representation in the population. For example, the Australian population is approximately 49% male and 51% female. A stratified sample for gender would divide the population into males and females and then proceed to take SRSs of males and females so the resulting sample is approximately 49:51 male:female. Stratified sampling can be more complex as there is no limit to the number of strata and levels within the strata. For example, a researcher may wish to stratify the population by gender, age bands and ethnicity. This would result in a sample that is more likely to be representative, but would require substantially more time and effort. 

### Cluster Sampling

Cluster sampling first divides the population into naturally occurring and homogeneous clusters, e.g. postcodes, towns, manufacturing batches, factories, etc. The investigator then randomly selects a defined number of clusters. For example, referring back to the hard disk drive example, the company may have manufactured 100 batches of hard disk drives on different days. They may decide to randomly select 10 batches which they define as the clusters. Using these randomly sampled clusters, the investigator would then proceed with the use of SRS within each cluster to select their sample. For example, the investigator might decide to randomly select 10 hard disk drives from each of the 10 batches making a total sample size of 100. Cluster sampling can be more economical and less time-consuming than SRS. This is because the researcher is required to perform SRS only within a limited number of clusters and not the entire population.

### Convenience Sampling

Convenience sampling methods, or non-probabilistic sampling, make no effort to randomly sample from the population. Therefore, the degree to which a convenience sample is randomly representative to the population is always unknown. Convenience samples have a high probability of being biased. A **biased sample** is a sample that cannot be considered representative of the target population. It is possible for a convenience sample to be representative, but the probability is always unknown. Substantial caution must be placed on inferences drawn from the use of convenience samples. Regardless, convenience samples are probably the most common samples used in research due to their low cost and relative ease. Very few researchers have the time and money to use probabilistic methods. That's not to say you shouldn't try, but if you're forced to use a convenience sample, you should always note its limitations.

#### summary

It's important to note that probability-based sampling methods do not guarantee a representative sample either. That's why we say the sample is **randomly representative**.  There is still uncertainty. This is particularly true for small samples. We can take another look at the info-graphic provided by Wild, Pfannkuch and Horton (2011) that looks at populations, samples and sample size. Note that Wild et al. are referring to probability-based sampling methods.

[![](https://sites.google.com/a/rmit.edu.au/intro-to-stats/_/rsrc/1435900787452/home/module-1/Wild_2011_Statistical_Inference.png)](https://sites.google.com/a/rmit.edu.au/intro-to-stats/home/module-1/Wild_2011_Statistical_Inference.png?attredirects=0)

*

*Figures 2 - 4 have been taken from Wild, Pfannkuch and Horton (2011).*

*

So, from this we can conclude the following:

**The larger a random sample, the more likely it is to represent the population.**

This is an important lesson. Sample size does matter and should always be considered an important consideration when planning an investigation. In the next section will be explore this concept further when we consider sampling distributions.

## Sampling Distributions

Take a random sample from the population, of say size n = 100, measure a quantitative variable on each unit and calculate the sample mean. Write down the sample mean in a data recording sheet. Now place the sample back into the population and take another random sample of the same size. Measure your variable, calculate the sample mean, and record its value in the same recording sheet. The sample mean won't be the same, because it's a slightly different sample. Remember, this is called sampling variability or error. Now, repeat this process many, many times, say one thousand. Now, take all the one thousand sample means you recorded and plot them using a histogram. This histogram of the sample means is an example of a **sampling distribution**. 

A **sampling distribution** is a hypothetical distribution of a sample statistic, such as a mean, median or proportion, constructed through the repeated sampling from a population. A sampling distribution describes what would happen if we were to repeat a study many times over and for each replicated study we recorded a summary statistic. Sampling distributions are influenced by two major factors. The first factor is the underlying distribution of the random variable. For example, if your random variable is distributed normally, binomially, or exponentially, this will have an effect on the characteristics of the sampling distribution. The second major factor is the sample size n. The sample size of the hypothetical repeated studies has some interesting effects on the sampling distribution, as we will discover shortly.

The following Shiny app will allow you to commence exploring sampling distributions. If the app does not appear, your web browser may be blocking it. Ensure your web browser permits the app to load - it's completely safe... trust me. Alternatively, you can visit the app directly [here](http://www.google.com/url?q=http%3A%2F%2Fshiny.stat.calpoly.edu%2FSampling_Distribution%2F&sa=D&sntz=1&usg=AFQjCNElH6x6P7lELiRdsdURWMpyqGG5nA). Complete the following activities.

**Activity 1**

1.   Set the following inputs:

*   **Population Distribution**: Normal
*   **Population mean**: 0
*   **Population standard deviation**: 1
*   **Sample size**: 10
*   **Statistic**: Mean
*   **Number of samples**: 1

3.  Click **Draw samples**. This draws one random sample (n = 10) from the population. The sample values are displayed in the first histogram. The sample mean is calculated and plotted on the sampling distribution of the mean plot. 
4.  **Number of samples**: 1000
5.  Click **Draw samples**. The app will quickly draw 1000 random samples and plot their means. Note the difference between a sample distribution versus a sampling distribution of the mean.

**Activity 2**

Now let's change the underlying population distribution and increase the sample size. 

1.   Set the following inputs:

*   **Population Distribution**: Left-skewed
*   **Population mean**: 0
*   **Population standard deviation**: 1
*   **Sample size**: 100
*   **Statistic**: Mean
*   **Number of samples**: 1000

3.  Click **Draw samples**. Note that while the population distribution is heavily left-skewed, the sampling distribution of the means is not. You will learn more about this when we look at the central limit theorem.

#### Sampling Distribution Shiny App

JOT\_postEvent('registerForRpc', this, \['3300334439471250189', 693392232, '//tal2tot4uenli8d3lphbjvrrl237cfes-a-sites-opensocial.googleusercontent.com/gadgets/ifr?url\\x3dhttp://hosting.gmodules.com/ig/gadgets/file/106581606564100174314/iframe.xml\\x26container\\x3denterprise\\x26view\\x3ddefault\\x26lang\\x3den\\x26country\\x3dGB\\x26sanitize\\x3d0\\x26v\\x3dc94d5eca331f592f\\x26libs\\x3dcore:dynamic-height\\x26mid\\x3d60\\x26parent\\x3dhttps://sites.google.com/a/rmit.edu.au/intro-to-stats/home/module-5#up\_scroll\\x3dauto\\x26up\_iframeURL\\x3dhttp://shiny.stat.calpoly.edu/Sampling\_Distribution/\\x26st\\x3de%3DAIHE3cCicUtP3hhDEfUhsR2JIJParRMfEg71EnOfVMKeZ6hI9tqA4YiNirHl7DuIZ9FIdVFLZtLXLtrIRDG7jCZYXmUTCMo1154GyusZ7jmZgYJPxvO95EbCr1lf7ZisA0MfLwJ7zQyS%26c%3Denterprise\\x26rpctoken\\x3d3300334439471250189'\])

### YouTube Data

We will use the `Youtube.csv` data to explore the concepts of a sampling distribution. The data was originally sourced from [here](https://www.google.com/url?q=https%3A%2F%2Farchive.ics.uci.edu%2Fml%2Fdatasets%2FOnline%2BVideo%2BCharacteristics%2Band%2BTranscoding%2BTime%2BDataset&sa=D&sntz=1&usg=AFQjCNEpfXXxqk7S38PjTTrft98g2-ortg), but a `.csv` version is available from the [Data Repository](https://drive.google.com/a/rmit.edu.au/folderview?id=0Bwtqn_QygJ8_fmZQZVVUM2R2WjZuWEYzTTBtOFdqdnpfV3BHN3RHMG1VMlhScmhkMExJejA&usp=sharing). The Youtube.csv data will be treated as the unknown population. As the dataset contains over 24,000 video characteristics, this isn't too difficult to imagine, even though the total population size of YouTube is much, much, much higher (I am yet to find a credible estimate! If you find one email me). For the sake of the example, we will imagine this to be the unknown reality that we are trying to estimate. We will look at estimating the average YouTube video duration, measured in seconds (sec). The data has been cleaned to enable a better a visualisation of the population distribution. Extreme outliers (Durations > Q3 + \[IQR*3\]) have been removed to help lessen the extent of the extreme values in the right tail of the distribution. I usedthe following R code and saved the filtered data object as `Youtube_clean`.

`> Youtube_clean<-subset(Youtube,duration < (281 + ((281-52)*3)))`

This step only removed around 3% of the original data. The YouTube video duration distribution is visualised in the following density plot. A density plot is similar to a histogram, but uses a smoothing algorithm to remove the need for bins. The mean is depicted using a red line. The distribution is skewed to the right.

[![](https://sites.google.com/a/rmit.edu.au/intro-to-stats/_/rsrc/1438742013617/home/module-5/Module_5_Pop_Dist.png)](https://sites.google.com/a/rmit.edu.au/intro-to-stats/home/module-5/Module_5_Pop_Dist.png?attredirects=0)

Here are the population'sparameters:

`> favstats(~ duration, data = Youtube_clean)`

` min Q1 median  Q3 max     mean       sd     n missing`

`   1 50    131 261 966 192.9844 193.4058 24325       0`

The population mean, which we denote as μ, rounds to 193 secs (or 3 minutes 21 secs). However, variability is high with a population standard deviation, which we denote as σ,  of 193 secs. 

### Simulations in R

We can use R to simulate repeated random sampling from the population of YouTube video durations. Let's run a simulation that simulates 10,000 random samples of size n = 10.  The simulator will save the sample means in order to create a sampling distribution. Here's a simple simulator:

`> set.seed(1234) #Set random seed number to allow replication`

`> n <- 10 #set sample size`

`> sims <- 10000 #Set number of random samples to be drawn`

`> sdist_01 <- do(sims) * mean(duration, `

`+                               data = sample(Youtube_clean, n)) #Run the simulation`

`> favstats(sdist_01$mean) #Report the sampling distribution descriptive statistics`

`  min    Q1 median    Q3   max     mean       sd     n missing`

` 38.7 147.4  185.9 229.9 533.2 191.7926 60.57194 10000       0`

The `set.seed()` function forces R's built-in random number generator to start at a particular seeding value. This ensures that others, like yourself, can re-run this code, and get the same results. If we used a different seed, the results would be a little different. Try for yourself if you wish. 

Next, we set the sample size `n <- 10`, and the number of random samples to draw from the population distribution, `sims <- 10000`. Generally, we should do this at least 10,000 times, but keep in mind that requires computational time. 

Next, we assign the results of the simulation to an object, which we called `sdist_01`. The `do()` function tells R to repeat a function many times. We use the `sims` object to tell R to repeat the simulation 10,000 times. If we change the sims object, we can quickly change the number of simulations, e.g. sims <- 1000 or sims <-100000. 

We then tell R to repeat the calculation of the `mean(duration,...)`from the `YouTube_clean` (outliers removed) data object. But, notice how `Youtube_clean` is wrapped by the `sample()` function. The `sample()` function allows you to draw random samples, of size `n`, from a dataset. The steps of the simulations can be depicted as follows:

#### Sampling Distribution Simulation Overview

Sampling Distribution Simulation Overview

Let's take a closer look at the sampling distribution visualised using a histogram. Also included for comparison is the population distribution. Pay attention to the differences. Notice how the variability of the sampling distribution is much smaller and the mean of the sampling distribution is approximately the same as the population mean?

[![](https://sites.google.com/a/rmit.edu.au/intro-to-stats/_/rsrc/1438742013617/home/module-5/Module_5_Pop_Dist.png)](https://sites.google.com/a/rmit.edu.au/intro-to-stats/home/module-5/Module_5_Pop_Dist.png?attredirects=0)

[![](https://sites.google.com/a/rmit.edu.au/intro-to-stats/_/rsrc/1438742217092/home/module-5/Module_5_Samp_Dist_01.png)](https://sites.google.com/a/rmit.edu.au/intro-to-stats/home/module-5/Module_5_Samp_Dist_01.png?attredirects=0)

These observations introduce two important concepts related to the sampling distributions. For sampling distributions of the mean, the expected value, variance and standard deviation are as follows:

![](https://latex.codecogs.com/gif.latex?E%28%5Cbar%7BX%7D%29%3D%5Cmu%7B%7D_%7B%5Cbar%7BX%7D%7D%20%3D%20%5Cmu%7B%7D)

![](https://latex.codecogs.com/gif.latex?Var%28%5Cbar%7BX%7D%29%3D%20%5Csigma%5E2_%7B%5Cbar%7BX%7D%7D%3D%5Cfrac%7B%5Csigma%5E2%7D%7Bn%7D)

![](https://latex.codecogs.com/gif.latex?%5Csigma_%7B%5Cbar%7BX%7D%7D%3D%5Cfrac%7B%5Csigma%7B%7D%7D%7B%5Csqrt%7Bn%7D%7D)

where x̄ refers to a sample mean, and n = sample size. Let's demonstrate that this is true. The population parameters are as follows:

![](https://latex.codecogs.com/gif.latex?%5Cmu%20%3D%20193)

![](https://latex.codecogs.com/gif.latex?%5Csigma%5E2%20%3D%20193%5E2)

![](https://latex.codecogs.com/gif.latex?%5Csigma%20%3D%20193)

According to the formula above, the mean, variance and standard deviation of a sampling distribution of the mean using a sample size n = 10, are...

![](https://latex.codecogs.com/gif.latex?%5Cmu_%7B%5Cbar%7BX%7D%7D%20%3D%20193)

![](https://latex.codecogs.com/gif.latex?%5Csigma%5E%7B2%7D_%7B%5Cbar%7BX%7D%7D%20%3D%20%5Cfrac%7B193%5E2%7D%7B10%7D%20%3D%203724.9)

![](https://latex.codecogs.com/gif.latex?%5Csigma_%7B%5Cbar%7BX%7D%7D%20%3D%20%5Cfrac%7B193%7D%7B%5Csqrt%7B10%7D%7D%20%3D%2061.03)

Now, keeping in mind that we used a simulation, and we expect there to be some random error (especially for the variance), recall the descriptive statistics of the sampling distribution simulated in R...

\> favstats(sdist_01$mean) #Report the sampling distribution descriptive statistics

  min    Q1 median    Q3   max     mean       sd     n missing

 38.7 147.4  185.9 229.9 533.2 191.7926 60.57194 10000       0

\> var(sdist_01$mean)

\[1\] 3668.959

These estimates are pretty close. We get closer if we increase the simulation size, but this becomes impractical due to the extra computational time. 

The standard deviation for a sampling distribution is known as the standard error (SE). So, we could write the standard error for the mean as:

![](https://latex.codecogs.com/gif.latex?SE%20%3D%20%5Csigma_%7B%5Cbar%7BX%7D%7D%20%3D%20%5Cfrac%7B%5Csigma%7D%7B%5Csqrt%7Bn%7D%7D)

The size of the sample and the standard error share an inverse relationship. As sample size increases, the SE for the mean decreases. Consider the following sheet and plot.

#### Sample Size and Standard Error

Sample Size and Standard Error

Why? Larger random samples provide more reliable estimates of population parameters, therefore, less error. Let's demonstrate this further by running the simulation outlined above for three different sample sizes,  n = 10, 30, and 100. The results for the simulations are summarised in the following three histograms:

**

[![](https://sites.google.com/a/rmit.edu.au/intro-to-stats/_/rsrc/1438751855520/home/module-5/Module_5_Samp_Dist_02.png)](https://sites.google.com/a/rmit.edu.au/intro-to-stats/home/module-5/Module_5_Samp_Dist_02.png?attredirects=0)

**

As you can see, as the sample size increases, the standard error decreases. You might also detect that the shape changes from being slightly skewed to symmetric. This brings us to the next important concept.

## Central Limit Theorem

There are a few useful rules we need to know about sampling distributions of the mean. **If the underlying population distribution of a variable is normally distributed, the resulting sampling distribution of the mean will be normally distributed.** This rule is referred to the Central Limit Theorem and can be written as:

![](https://latex.codecogs.com/gif.latex?%5Ctext%7BIf%20%7D%20x%20%5Csim%20N%28%5Cmu%2C%20%5Csigma%29%20%5Ctext%7B%20then%20%7D%20%5Cbar%7BX%7D%5Csim%20N%28%5Cmu%2C%5Cfrac%7B%5Csigma%7D%7B%5Csqrt%7Bn%7D%7D%29)

This makes sense. However, what if the population distribution isn't normally distributed as was the case with YouTube video durations? We got a hint in the previous figure. Let's take a closer look.

We use our simulator to create a sampling distribution of the mean duration using 10,000 samples of size 100. We plot the distribution and overlay a hypothetical normal distribution (blue line):

![](https://latex.codecogs.com/gif.latex?%5Cbar%7BX%7D%20%5Csim%20N%28%5Cmu%2C%5Cfrac%7B%5Csigma%7D%7B%5Csqrt%7Bn%7D%7D%29%20%3DN%28193%2C19.3%29)

[![](https://sites.google.com/a/rmit.edu.au/intro-to-stats/_/rsrc/1438752620502/home/module-5/Module_5_Samp_Dist_03.png)](https://sites.google.com/a/rmit.edu.au/intro-to-stats/home/module-5/Module_5_Samp_Dist_03.png?attredirects=0)

The blue line is a near perfect fit to the sample distribution. This is another important property of the Central Limit Theorem. **When the sample size we use is large, typically defined as** ***n* \> 30, the sampling distribution of the mean isapproximately normal, regardless of the variable's underlying population distribution. **

## What are sampling distributions used for?

We will start using sampling distributions in greater depth to help us answer interesting questions about the results of statistical investigation later in Module 7. For now, we go through a few examples to start getting a sense of how sampling distributions are used in statistics. We will use the CLT to quickly calculate probabilities of observing different sample means for various sample sizes, assuming the population mean and standard deviation of YouTube video duration is 193 secs.

**1\. What is the probability of randomly selecting a sample of size n = 100 that has a sample mean duration of less than 150 secs?**

Because we have a large sample size, we can invoke the CLT, which means the sampling distribution of the mean can be approximated as:

![](https://latex.codecogs.com/gif.latex?%5Cbar%7BX%7D%20%5Csim%20N%28%5Cmu%2C%5Cfrac%7B%5Csigma%7D%7B%5Csqrt%7Bn%7D%7D%29%20%3DN%28193%2C19.3%29)

Now we can use R's normal distribution functions to determine Pr(x̄ < 150). 

In R we use the formula:

\> pnorm(150, 193, 19.3)

\[1\] 0.01294095

The probability, Pr(x̄ < 150), was found to equal .013. Therefore, there is a 1.3% chance that an investigator will randomly select a sample with a mean below 150 secs. 

**2\. What is the probability of randomly selecting a sample of size n = 100 that has a mean duration greater than four minutes?**

We need to find Pr(x̄ > 240). In R, we use the formula:

\> pnorm(240, 193, 19.3, lower.tail = FALSE)

\[1\] 0.007441098

The answer is found to be Pr(x̄ > 240) = 0.007. 

**3\. What is the probability of randomly selecting a sample of size n = 200 that has a mean duration greater than five minutes?** 

We need to change the standard error as the example calls for a larger sample. We can do this directly in R using:

`> pnorm(300, 193, 193/sqrt(200), lower.tail = FALSE)`

`[1] 2.244519e-15`

Note how we calculated SE directly in the formula using the `sqrt()` function. We find Pr(x̄ > 300) = 2.244519e-15. What does that mean? When you see e-15, that means to move the decimal place to the right 15 places from 2.244519, so, Pr(x̄ > 300) = 0.000000000000002244519. In other words, the probability is really, really small. 

Why has the probability substantially dropped? As a larger sample size was used, the sampling distribution has a smaller standard error. Therefore, observing a sample mean duration of 300 secs would be very unlikely when the sample size was n = 200 vs. n = 100. Larger random samples provide more reliable estimates of population parameters.

[Return to top](https://sites.google.com/a/rmit.edu.au/intro-to-stats/home/module-5)

 |

 |

[Recent Site Activity](https://sites.google.com/a/rmit.edu.au/intro-to-stats/system/app/pages/recentChanges)|[Report Abuse](https://sites.google.com/a/rmit.edu.au/intro-to-stats/system/app/pages/reportAbuse)|Print Page|[Remove Access](https://sites.google.com/a/rmit.edu.au/intro-to-stats/system/app/pages/removeAccess)|Powered By **[Google Sites](http://sites.google.com)**
