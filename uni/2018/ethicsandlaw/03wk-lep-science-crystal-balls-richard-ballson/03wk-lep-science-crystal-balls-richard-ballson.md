
tldr (from conclusion)

All modelling techniques have their place 
- Prediction
- Insight
- Action

The important things to consider is:
- what end user needs, 
- ethics - understand the potential ethical implications of your models
- Always ensure that the data is in context 
  - even if only using prediction based techniques
- At the end, **nothing is achieved if we do not provide value to the end user**

# Crystal Ball: Techniques
- Neural Networks/Deep Learning Clustering (k means)
- Nearest Neighbours
- Ensemble Modelling
- Random Forests 
- SVM

## Why prediction is not enough

- **what, not why** - Predictions only tell us what is likely to happen, not why
- It can be **hard to sell predictions** to end users without explanations, and there are ethical implications
- **Without knowing a relationship** between predictor and predicted it can be **hard to action predictions**
- **Understanding predictions** allows the development of strategic decision making

## Insights Driven: Approach to Modelling
- Focus on prediction, with the development of insights
- **Contextualising data** and developing hypotheses to test are key
- ~old_todo~~old_later~ Generally **parametric models**   
- Models are less accurate than purely predictive models in general
- These models can 
  - generalise well over long periods and 
  - capture long term dynamics



## Insights Driven: Techniques
- Regression
- Decision Trees
- Density Estimation
- Time Series 
  - Fixed Effects/
  - Variable Effects
- Naïve Bayes

Insights Driven: Example Insights
- Education is critical for improving salaries
- People who invest are generally better off (even if they are losing in the market)
- The number of hours worked greatly increases your likelihood of earning more.

### When are Insights Not Enough
- Insights can tell us what is affecting the prediction, 
  - but it **does not quantify how actioning an insight will affect the entire model**
- For example: a model insight is that people prefer phone calls over texts. The action is to make more calls, but as we increase the number of calls people become annoyed.
- The challenge with machine learning is we often **do not have causal relationship only an abstraction**
- Further, machine learning techniques can fail to generalise in dynamic structure situations

## Causal/Action Driven Modelling: Approach

- Focus on understanding 
  - **causal relationships between** 
  - **the predictors and target**
- Fundamentally understanding the drivers of the target are critical
- Models are structural
- Models allow for action driven analysis to be tested
- Model generalise well, 
  - but take long durations to build, 
  - and often the required data is not available


### Techniques: Causal/Action Driven Modelling

- Structural Models
- Network Models
- Regression Models

### Applications: Causal/Action Driven Modelling

- Engineering
- Economics 
- Genetics


~old_todo~~old_later~
## Incorporating Actions into Structural Models
- tldr: behaviour not feasable
- Just as relationships between elements in the system are defined,
 - a functional description of how the action will affect the model needs to be created 
 - to understand the effect of an action
- Defining relationships between observations and outcomes in nature 
  - has been explored for centuries, 
  - and structural models exist that describe these relationships
- This is generally not true for human behaviour, 
  - and describing a persons behaviour in an equation is currently not feasible 
  - (also suffers from the observer effect)

## Model ethics

- biased 
  - against demographics
  - from historical context
  - eg. unusual names

Without understanding model insights it is possible for models to be biased against specific demographics
Also historical context may bias our models based on effects that are increasingly changing over time.
This can happen in unexpected ways, such as unusual names or historical bias in data being used to develop models.