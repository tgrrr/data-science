# Practice exam:
#### Q2.
hypercube (1/10)^(1/10) = 0.794

#### Q4. Target -> Prediction
- Do confusion matrix

MATH2319 – MACHINE LEARNING FINAL EXAM

### Problem 1: (20 points) 

Consider the prediction problem below where the customer’s Preferred Channel is a binary target feature with Gender, Age, and Policy Type being categorical descriptive features.

A) (10 points) What target level will a Naïve Bayes model predict for the following customer? 
`Gender = male, Age = middle-aged, Policy Type = planA`
The factor probabilities corresponding to this dataset are calculated as below.

```
Pr(Channel = phone | q) = 0.56 * 0.4 * 0.4 * 0.2 = 0.018 
Pr(Channel = email | q) = 0.44 * 0.75 * 0.25 * 0.5 = 0.042 
Prediction: Channel = email.
```
B) (10 points) In Part (A), suppose the Policy Type of the customer was incorrectly recorded as planA and the true Policy Type is actually planC. In light of this new information, what target level will a Naïve Bayes model predict for this customer?
Gender = male, Age = middle-aged, Policy Type = planC 
```
Pr(Channel = phone | q) = 0.56 * 0.4 * 0.4 * 0.6 = 0.054 
Pr(Channel = email | q) = 0.44 * 0.75 * 0.25 * 0.25 = 0.021 
Prediction: Channel = phone.
```
---

### Problem 2: (15 points) 

Suppose that we have a set of observations, each with measurements on p = 1 feature, X. We assume that X is uniformly (evenly) distributed on [0,1]. Associated with each observation is a response value. Suppose that we wish to predict a test observation’s response using only observation's that are within 10% of the range of X closest to that test observation. For instance, in order to predict the response for a test observation with X = 0.5, we will use observations in the range [0.45, 0.55]. In each part below, please also explain your reasoning.
A) (5 points) On average, what fraction of the available observations will we use to make the prediction?
Answer: `10%`
B) (10 points) Now suppose that we wish to make a prediction for a test observation by creating a p-dimensional hypercube centred around the test observation that contains, on average, 10% of the training observations. For p = 10, what is the length of each side of the hypercube? Note that a hypercube is a generalization of a cube to an arbitrary number of dimensions. When p = 1, a hypercube is simply a line segment, when p = 2, it is a square, etc.
Answer: `(0.1)^(1/10) = 0.794`

#### Problem 3: (15 points) 
Email spam filtering models often use a bag-of-words representation for emails. In a bag-of-words representation, the descriptive features that describe a document (in this case, an email) each represent how many times a particular word occurs in the document. One descriptive feature is included for each word in a predefined dictionary. The dictionary is typically defined as the complete set of words that occur in the training dataset. The table below lists the bag-of-words representation for the following five emails and a target feature, SPAM, whether they are spam emails or genuine emails:

• “money, money, money”
• “free money for free gambling fun” • “gambling for fun”
• “machine learning for fun, fun, fun” • “free machine learning”
What target level would a nearest neighbour model with k=3 using Manhattan distance return for the following email: “machine learning for free”?
The bag-of-words representation for this query is as follows:

```
Pr(ph) = 5/9 <- out of total possibilities
Pr(gender=M | ph) = 2/5  <- total phone
Pr(age=middle | ph) = 2/5 
Pr(plan=a | ph) = 1/5 
**Pr(channel = phone | q) =**
5/9 * 2/5 * 2/5 * 1/5 = 0.017777777777777778

Pr(email) = Pr(¬ ph) = 4/9
Pr(gender=M | e) = 3/4 
Pr(age=middle | e) = 1/4 
Pr(plan=a | e) = 2/4 
**Pr(channel = email | q) =**
4/9 * 3/4 * 1/4 * 2/4 = 0.041666666666666664
**Prediction:** channel = phone
```

### Problem 4: (15 points) 
The table below shows the predictions made for a categorical target feature by a model for a test dataset. Based on this test set, calculate the evaluation measures listed below where true corresponds to the positive level.

#### A) (5 points) The confusion matrix with row and column labels
ID Target
1 true
2 false
3 true
4 false
5 true
6 false
7 false
8 true
9 false
10 true

#### B) (5 points) The average class accuracy (harmonic mean)
```
Recalltrue = 3/5 = 0.6
Recallfalse = 4/5 = 0.8
ACAHM = 1/ ((1/2) * (1/0.6 + 1/0.8)) = 0.685
```
#### C) (5 points) The precision, recall, and F1 measure
```
Precision =3/4 = 0.75
Recall =3/5 = 0.6
F1 =2*(0.75*0.6)/(0.75+0.6)=0.67
```
### Problem 5: (20 points) 
A retail supermarket chain has built a prediction model that recognizes the household that a customer comes from as being one of single, business, or family. After deployment, the analytics team at the supermarket chain uses the stability index to monitor the performance of this model. The table below shows the frequencies of predictions of the three different levels made by the model for the original validation dataset at the time the model was built, for the month after deployment, and for a month-long period that is six months after deployment.

Bar plots of these three sets of prediction frequencies are shown in the following images.
Calculate the stability index for the two new periods and determine whether the model should be retrained at either of these points.

### Problem 6: (15 points) 
Consider a supervised machine learning problem where there are four binary descriptive features and a binary target feature. You are given a training dataset that has 10 observations with unique combinations of the descriptive features. You are told to assume that there is no noise in the training data.

#### A) (5 points) What is the total number of prediction models that can be used?
```
Total number of combinations of descriptive features = 2^4 = 16 
Total number of prediction models = 2^16 = 65,536
```
#### B) (5 points) What is the total number of prediction models that are consistent with the training dataset?
Out of the 16 possible combinations, 10 of them are known, leaving 6 unknown combinations. Total number of consistent prediction models `= 2^6 = 64`

#### C) (2 points) Select the correct choice: If the training data is assumed to be noisy, the total number of prediction models would be (i) less than (ii) more than (iii) equal to what you calculated in part (A) in general.

Answer: (iii) equal to

#### D) (2 points) Select the correct choice: If the training data is assumed to be noisy, the total number of prediction models that are consistent with the training data would be (i) less than (ii) more than (iii) equal to what you calculated in part (B) in general.
Answer: (iii) equal to

#### E) (1 point) How should the blank space be filled? Because a single consistent model cannot be determined based on the training data in general, machine learning is said to be __an ill-posed problem_.