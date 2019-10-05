## Filtering Data

## ~old_todo~

R bootcamp
- https://astral-theory-157510.appspot.com/secured/RBootcamp_Course_02.html
- https://astral-theory-157510.appspot.com/secured/RBootcamp_Course_03.html

summarise module 2

## [slides](https://docs.google.com/presentation/d/1_qkWsi6sGyv8oUMYdtlWTNatYiegAdy1suBJCDgWFUw/edit#slide=id.p)
  - code is copied below
  - section How to run R (skipped)

## Learning Objectives

- Define, compute and interpret statistics used for summarising qualitative variables.
- Use technology to visualise summaries of qualitative data using common statistical plots, namely, bar charts and clustered bar charts.
- Interpret common visualisations of qualitative data.
- Define, compute and interpret statistics used for summarising quantitative variables.
- Use technology to visualise summaries of quantitative data using common statistical plots, namely, dot plots, histograms, and box plots.
- Use scatter plots to visualise the relationship between two quantitative variables.
- Understand and apply the basic principles of producing good plots.

### Variables and factors

```r
> Bicycle$day # Select the “day” variable

> Bicycle$day <- factor(Bicycle$day,
levels=c('Sun','Mon','Tue','Wed','Thu','Fri','Sat'),
                     	ordered=TRUE) # Reorder the factor levels

> Bicycle$Quarter <- factor(Bicycle$Quarter,levels=c(1,2,3,4),
    							labels=c("1st Quarter","2nd Quarter",
"3rd Quarter", "4th Quarter"),
ordered = TRUE) # Covert numeric variable to factor
```
### Filtering Data

```r
> Bicycle_Summer <- subset(Bicycle,
subset = (Season == "Summer"))
#Select only summer observations

> Bicycle_Warm <- subset(Bicycle,
subset = (Season == "Summer" | Season  ==
"Spring")) #Select only summer and spring observations
```

### Statistical Functions - Qualitative Variables

```r

> tally(~day, data = Bicycle) #Frequency distribution

> tally(~day, data = Bicycle, margins = TRUE) #Include total

> tally(~day, data = Bicycle, format = "percent") #Report percentages

> round(tally(~day | Season, data = Bicycle,
format = "percent"),2) #Rounded cross-tabulation

```

### Statistical Plots - Qualitative Variables
```r

> Bicycle$Season <- factor(Bicycle$Season,
levels=c("Summer","Autumn","Winter","Spring"),
ordered = TRUE) #Re-order season factor
> perc2<- tally(~day | Season, data = Bicycle,
format = "percent") #Assign percentage to object “freq2”
> barplot(perc2, main = "Sample Observations by Day of Week and Season",
        ylab="Percentage", xlab="Season", beside=TRUE,
        legend=rownames(perc2),
        args.legend=c(x = "top",horiz=TRUE),
        ylim = c(0,20))
> grid() #Overlay grid on plot

```
### Quantitative Variables

```r
> hist(Bicycle$CT_VOLUME_24HOUR, xlab = "Bicycle Traffic (24 hours)",
     col = "cornflowerblue" , main = "") #Basic histogram

> hist(Bicycle$CT_VOLUME_24HOUR, xlab = "Bicycle Traffic (24 hours)",
     col = "cornflowerblue" , main = "", breaks=30) #Change number of bins

> boxplot(CT_VOLUME_24HOUR ~ Season, data = Bicycle,
        col = c("red","lightblue","blue","yellow"),
        ylab="Bicycle Traffic Count (24 hours)",
        xlab="Season") #Side-by-side boxplot

```

- module 2 https://sites.google.com/a/rmit.edu.au/intro-to-stats/home/module-2

- worksheet https://docs.google.com/document/d/1WzaKKXAQiUY0mMSSeXoG_Vayt603L2dWFCOjeCWmugE/edit

- Learn this:




This week you need to focus on the following:

Complete R Bootcamp Course 2 (Links to an external site.)Links to an external site. and R  (Links to an external site.)Links to an external site.Bootcamp Course 3 (Links to an external site.)Links to an external site.

Work through the   Module 2 materials (Links to an external site.)Links to an external site. notes

Commence Assignment 1 (see Assessment Tasks → Assignment Deadlines)

Commence Module 2 Exercises

In class this week, I plan to provide demonstrations and work through activities in RStudio which will help you commence the Module 2 Exercises. To get the most out of this session, please bring along a laptop with R and RStudio installed. See you in class.

Remember, if you have any course related questions, please post them on the Canvas Discussion Board.



Lecture
  Click this link for Module 2 materials (Links to an external site.)Links to an external site.

Labs/Prac/Tutorial
  Click this link for Class Activities (Links to an external site.)Links to an external site.

Module Exercise
Module 2 Exercises - Descriptive Statistics Through Visualisation


# Links (private if you're not a RMIT student)

Worksheet:
- https://docs.google.com/document/d/1WzaKKXAQiUY0mMSSeXoG_Vayt603L2dWFCOjeCWmugE/edit

Data:
https://rmit.instructure.com/courses/13659/files/2662605?module_item_id=930240
