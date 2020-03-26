Seat No
________________________________
Student Name
Phil Steinke
________________________________
Student ID
s3725547
________________________________
Signature
________________________________
EXAM COVER SHEET
Note: DO NOT REMOVE this exam paper from the exam venue
EXAM DETAILS
MATH2319D
Course Code:
Course Description:
Date of exam:
Total number of pages (incl. this cover sheet) 7
Machine Learning
Start time of exam: Duration of exam: 2hr 15min

7. Non text storing calculators are allowed.
8. You must show all your work for full credit.
9. Organise your work in a neat and coherent way. Work scattered all over the page without a clear ordering will receive very little credit.
10. Mysterious or unsupported answers will not receive full credit.
1
Created on: 13 May 2019 ­­ 1­22­55:263 ­­ 813

MATH2319 - Machine Learning Final Exam (Deferred), Semester 1, 2019

## Problem 1 (20 points): 

A retail supermarket chain has built a prediction model that recognizes the household that a customer comes from as being one of single, business, or family. After deployment, the analytics team at the supermarket chain uses the **stability index** to monitor the performance of this model. The table below shows the frequencies of predictions of the three different levels made by the model for the original validation dataset at the time the model was built, for the month after deployment, and for a month-long period that is six months after deployment.

| Target   | Original Count | %        | 1st New Count | %      | 2nd New Count | %      |
| -------- | -------------- | -------- | ------------- | ------ | ------------- | ------ |
| single   | 100            | > 0.2525 | 250           | 0.2711 | 551           | 0.4004 |
| business | 140            | > 0.3535 | 300           | 0.3253 | 200           | 0.1453 |
| family   | 156            | > 0.3939 | 372           | 0.4034 | 625           | 0.4542 |
| SUM      | 396            |          | 922           |        | 1376          |        |


Stability Index:
```math
\sum _{ { lelevels }(t) } \left( \left( \frac { \left| { A }_{ t=l } \right|  }{ |{ A }| } -\frac { \left| { B }_{ t=l } \right|  }{ |{ B }| }  \right) \times \ln { \left( \frac { \left| { A }_{ t=l } \right|  }{ |{ A }| } /\frac { \left| { B }_{ t=l } \right|  }{ |B| }  \right)  }  \right) 
=\sum _{ { lelevels }(t) } \left( \left( \frac { 123 }{ 443 } -\frac { 252 }{ 948 }  \right) \times \ln { \left( \frac { 123 }{ 443 } /\frac { 252 }{ 948 }  \right)  }  \right)
```
\|A\| is size of test
\|At=l\| is number of instances in original test set

please note: turned into percentages above

Single:
(0.2525 - 0.2711) * log((0.2525 / 0.2711),2)
> 0.0019072760907881774

business

(0.3535 - 0.3253) * log((0.3535 - 0.3253),2)
> -0.14517814096564852


family

(0.3939 - 0.4034) * log((0.3939 - 0.4034), 2)
> 0.06381963932657582 - 0.043057421347358384i





100/396
> 0.2525

140/396
> 0.3535

156/396
> 0.3939


250/922
> 0.2711

300/922
> 0.3253

372/922
> 0.4034


551/1376
> 0.4004

200/1376
> 0.1453

625/1376
> 0.4542


==~old_todo~== Calculate the stability index for the two new periods and determine whether the model should be retrained at either of these points. 

ANSWER:

Sample 1: (1st new sample after 1 month) = 

single:
(100/250)-


Stability Index:
```math
\sum _{ { lelevels }(t) } \left( \left( \frac { \left| { A }_{ t=l } \right|  }{ |{ A }| } -\frac { \left| { B }_{ t=l } \right|  }{ |{ B }| }  \right) \times \ln { \left( \frac { \left| { A }_{ t=l } \right|  }{ |{ A }| } /\frac { \left| { B }_{ t=l } \right|  }{ |B| }  \right)  }  \right) 
=\sum _{ { lelevels }(t) } \left( \left( \frac { 123 }{ 443 } -\frac { 252 }{ 948 }  \right) \times \ln { \left( \frac { 123 }{ 443 } /\frac { 252 }{ 948 }  \right)  }  \right)
```
\|A\| is size of test
\|At=l\| is number of instances in original test set




<!-- For full credit, you must show all your works including how you calculated the stability index for both samples.
2 -->

MATH2319 - Machine Learning Final Exam (Deferred), Semester 1, 2019
## Problem 2 (10 points): 
Consider the diagrams below.
(i) Partitioning of a predictor space (ii) A decision tree
a) (5 points) Sketch the decision tree corresponding to the partitioning of the predictor space illustrated in the left- hand panel. The numbers inside the boxes indicate the mean of Y within each region. For full credit, you must sketch the tree completely.

```mermaid
  graph TB;
      rootNode[Decision tree header not specified]

      rootNode-->| 1< x1|node1
      rootNode-->| x1=>1 |node2

      node1['mean Y is between -4 and 10']
      node2['mean Y == 5']

      node1-->|'x2 => 1'| node3
      node1-->|'x2 < 1'| node4

      node3['Y mean == 10']
      node4['Y mean between -4 and 5']

      node4-->|'x1 => 0'| node5
      node4-->|'x1 < 0'| node6

      node5['Y mean between -4 and 5']
      node6['Y mean == 0']
      
      node5-->|'x2 => 0'| node7
      node5-->|'x2 < 0'| node8

      node7['Y mean == -4']
      node8['Y mean == 5']



      style rootNode fill:#f4aa42,stroke:#333,stroke-width:4px
      style node1 fill:#f4aa42,stroke:#333,stroke-width:4px
  ```

b) ~old_fixme~ (5 points) Create a diagram similar to the left-hand panel, using the tree illustrated in the right-hand panel of the figure. You should divide up the predictor space into the correct regions, and indicate the predicted class for each region. For full credit, you must create the diagram completely.

please note: ! See paper for answer


MATH2319 - Machine Learning Final Exam (Deferred), Semester 1, 2019

## Problem 3 (10 points): 

The table below contains training data with 6 observations, 3 numeric predictors and 1 qualitative response variable:

| Observation | X1  | X2  | X3  | Y   |
| ----------- | --- | --- | --- | --- |
| #1          | 1   | 2   | `2` | No  |
| #2          | `1` | 2   | 1   | Yes |
| #3          | 0   | 2   | -1  | Yes |
| #4          | 1   | 1   | 0   | No  |
| #5          | 2   | 3   | 3   | Yes |
| #6          | 2   | 1   | 2   | No  |

Suppose we wish to make a **prediction for Y** when `X1 = 1, X2 = 0 and X3 = 2` using **K-nearest neighbors.**

### a) (6 points) Compute the **Euclidean distance** between each observation and the test point X1 = 1, X2 = 0 and X3 = 2. For full credit, you must show all your work.

$\text {Euclidean}(\mathbf{a}, \mathbf{b})=\sqrt{\sum_{i=1}^{m}(\mathbf{a}[i]-\mathbf{b}[i])^{2}}$

`X1 = 1, X2 = 0 and X3 = 2`

Observation #1          1   2   `2` No 
sqrt((x1 - x1(test))^2 + (x1 - x1(test))^2 + (x1 - x1(test))^2 )
sqrt( (1 - 1)^2 + (2 - 0)^2 + (2 - 2)^2 )
> 2

Observation #2          `1` 2   1   Yes
sqrt((x1 - x1(test))^2 + (x1 - x1(test))^2 + (x1 - x1(test))^2 )
sqrt( (1 - 1)^2 + (2 - 0)^2 + (1 - 2)^2 )
> 2.23606797749979

Observation #3          0   2   -1  Yes
sqrt((x1 - x1(test))^2 + (x1 - x1(test))^2 + (x1 - x1(test))^2 )
sqrt( (0 - 1)^2 + (2 - 0)^2 + (-1 - 2)^2 )
> 3.7416573867739413

Observation #4          1   1   0   No 
sqrt((x1 - x1(test))^2 + (x1 - x1(test))^2 + (x1 - x1(test))^2 )
sqrt( (1 - 1)^2 + (1 - 0)^2 + (0 - 2)^2 )
> 2.23606797749979

Observation #5          2   3   3   Yes
sqrt((x1 - x1(test))^2 + (x1 - x1(test))^2 + (x1 - x1(test))^2 )
sqrt( (2 - 1)^2 + (3 - 0)^2 + (3 - 2)^2 )
> 3.3166247903554

Observation #6          2   1   2   No 
sqrt((x1 - x1(test))^2 + (x1 - x1(test))^2 + (x1 - x1(test))^2 )
sqrt( (1 - 1)^2 + (2 - 0)^2 + (2 - 2)^2 )
> 2

### b)  (2 points) If `K = 1` what prediction would you make? For full credit, you must explain why. (2 points) 

No. 

Because the two closest ovservations are Observation #1 = 2 and Observation #6 = 2
Both have the answer of `No`

c) If `K = 3` what prediction would you make? For full credit, you must explain why.

No.

For k = 3, we observe the 3 nearest neigbours:

Observation #1: No 
> 2

Observation #6: No 
> 2

Observation #2: Yes
> 2.23606797749979

Observation #4: No 
> 2.23606797749979

We examine 4, because of the equal values of 1 and 6, and 2 and 4. We have 3 `No`'s, which are the values of 1 and 6 (the closest two neighbours). Therefore, we choose `No`.


MATH2319 - Machine Learning Final Exam (Deferred), Semester 1, 2019
## ==~old_todo~== Problem 4 
(10 points):
==~old_todo~== (a) (5 Points) Which of the following classifiers can perfectly classify the following data? Please reason out your
answers.

o DecisionTree 
o KNN
o NaïveBayes

(b) (5 Points) Consider the Venn diagram below where A, B, and C are positive integers. The circle on the left denotes a Positive Diagnosis event and the circle on the right denotes a Cancer event.

Venn diagram of cancer event.
ABC

A is Positive diagnosis
C is Cancer event
B is Positive diagnosis of cancer event

### (i) (3 points) Based on the Venn diagram above, write down the expressions for precision and recall.

Precision:

$\text{FP = Pr(A|}\neg \text{B) = false positive diagnosis}$ 

$\text{FN = Pr(C|}\neg \text{A) = false negative diagnosis}$ 

B = TP True Positives

$precision = \frac{TP}{TP+FP}$

$\text{= B / (B + Pr(A|}\neg \text{B)}$)

#### Recall

Recall<sub>true</sub> = TP/(TP+FN)
Recall<sub>true</sub> = 

$\text{B / (B + Pr(C|}\neg \text{A)}$ )


(ii) (2 points) Re-draw the above diagram if the doctor was able to identify all cancer patients accurately.

See paper for answers (hint: it's a circle including ABC)

MATH2319 - Machine Learning Final Exam (Deferred), Semester 1, 2019
Problem 5 
(30 points): Imagine that you have been given a dataset of 1,000 documents that have been classified as being about entertainment or education. There are **700 entertainment documents in the dataset and 300 education** documents in the dataset. The tables below give the number of documents from each topic that a selection of words occurred in:

Word-document counts for the **entertainment** dataset
| fun | is  | machine | Christmas | family | learning |
| --- | --- | ------- | --------- | ------ | -------- |
| 415 | 695 | 35      | 0         | 400    | 70       |

Word-document counts for the **education** dataset
| fun | is  | machine | Christmas | family | learning |
| --- | --- | ------- | --------- | ------ | -------- |
| 200 | 295 | 120     | 0         | 10     | 105      |

a) (15 points) What target level will a naive Bayes model predict for the query document: “machine learning is fun”.

Entertainment (700 total)
| Word     | Count | P(word\|entertainment)         |
| -------- | ----- | ------------------------------ |
| fun      | 415   | 415 / 700 = 0.5928571428571429 |
| is       | 695   | 695 / 700 = 0.9928571428571429 |
| machine  | 35    | 35  / 700 = 0.05               |
| learning | 70    | 70  / 700 = 0.1                |
| TOTAL    | 1215  |                                |


Education (300 total)
| Word     | Count | P(word\|entertainment)         |
| -------- | ----- | ------------------------------ |
| fun      | 200   | 200 / 300 = 0.6666666666666666 |
| is       | 295   | 295 / 300 = 0.9833333333333333 |
| machine  | 120   | 120 / 300 = 0.4                |
| learning | 105   | 105 / 300 = 0.35               |
| TOTAL    | 720   |                                |

P(entertainment)
= 700 / 1000
= 0.7

P(education)
= 300 / 1000
= 0.3

Naïve Bayes’ Classifier: 

```math
\mathbb{M}(q)=\underset{l \text { elevelst) }}{\operatorname{argmax}}\left(\prod_{i=1}^{m} P(q[i] | t=l)\right) \times P(t=l)
```


P(entertainment|q) = 
  P(fun | entertainment ) *      
  P(is | entertainment ) *       
  P(machine | entertainment ) *  
  P(learning | entertainment ) * 
  P(entertainment)

=   
  0.5928571428571429 *
  0.9928571428571429 *
  0.05               *
  0.1                *
  0.3

= 0.0008829336734693878
  
P(education|q) =
  P(fun | education ) *      
  P(is | education ) *       
  P(machine | education ) *  
  P(learning | education ) * 
  P(education)

=
  0.6666666666666666 *
  0.9833333333333333 *
  0.4                *
  0.35               *
  0.3

= 0.02753333333333333  

P(entertainment|q) = 
0.00089
P(education|q) =
0.02753
 
Therefore Naive Bayes would select Education
Because P(entertainment|q) < P(education|q)


==~old_todo~== b) (15 points) What target level will a naive Bayes model predict for the query document “christmas family fun”, if Laplace smoothing with `k = 10` and a vocabulary `size of 6` is used?

```math
P(f=v | t)=\frac{\operatorname{count}(f=v | t)+k}{\operatorname{count}(f | t)+(k \times|\operatorname{Domain}(f)|)}
```

Please note: ignore the pdata, it's a strange output from latex

```
eg. for k = 10
Pr(GC = none|¬fr) = 12+3/ ( 14+(3*3) )
Pr(GC = guarantor|¬fr) = 0+3/ ( 14+(3*3) )
Pr(GC = coapplicant|¬fr) = 2+3/ ( 14+(3*3) )
```

smoothing parameter
Entertainment (700 total)
| Word      | Count | Raw probabilities | Smoothed Equation            | Smoothed Prob |
| --------- | ----- | ----------------- | ---------------------------- | ------------- |
| fun       | 415   | 415/700 = 0.5928  | (415 + 10)/(700 + (10 * 6) ) | 0.5592        |
| Christmas | 0     | 0  /700 = 0       | (0 + 10)/(700 + (10 * 6) )   | 0.0131        |
| family    | 400   | 400/700 = 0.5714  | (400 + 10)/(700 + (10 * 6) ) | 0.5394        |

(415 + 10)/(700 + (10 * 6) )
> 0.5592105263157895

(0 + 10)/(700 + (10 * 6) )  
> 0.013157894736842105

(400 + 10)/(700 + (10 * 6) )
> 0.5394736842105263


P(entertainment|q) = 
  P(fun | entertainment ) *      
  P(Christmas | entertainment ) *       
  P(family | entertainment ) *  
  P(entertainment)

= 0.5592 * 0.0131 * 0.5394 * 0.7
= 0.0027659698416

Education (300 total)
| Word      | Count | Raw Probabilities | Smoothed Equation           | Smoothed Prob |
| --------- | ----- | ----------------- | --------------------------- | ------------- |
| fun       | 200   | 200/300 = 0.6666  | (200 + 10)/(300 + (10 * 6)) | 0.5833        |
| Christmas | 0     | 0  /300 = 0       | (0 + 10)/(300 + (10 * 6)  ) | 0.0277        |
| family    | 10    | 10 /300 = 0.0333  | (10 + 10)/(300 + (10 * 6) ) | 0.0555        |

P(education|q) = 
  P(fun | education ) *      
  P(Christmas | education ) *       
  P(family | education ) *  
  P(education)

= 0.5833 *  0.0277 * 0.0555 * 0.3
= 0.0002690208765
  
P(entertainment|q)
= 0.0027659698416
P(education|q)
= 0.0002690208765

Pr(entertainment) > Pr(education)

We would select Entertainment


MATH2319 - Machine Learning Final Exam (Deferred), Semester 1, 2019
## ==~old_todo~== Problem 6 
(20 points total, 2 points each): For True/False questions, circle whether the statement is True or False. If you circle both choices for a scenario, you will not receive any points. For fill-in-the-blanks questions, do not use more than a few words.

a) A classifier that attains 99% accuracy on the training set and 70% accuracy on test set is better than a classifier that attains 65% accuracy on the training set and 75% accuracy on test set.
FALSE

b) While keeping the number of observations constant, increasing the number of features results in better prediction performance in supervised machine learning in general.
FALSE

! c) Suppose a dataset has 900 text-free images and 100 text-filled images. Despite the imbalance in the target feature, if we train a binary classifier (for detecting existence of text in an image) that achieves 85% accuracy on this dataset, it can be considered as a good classifier (where accuracy is the performance metric).

TRUE

d) ROC is a graphical representation of the trade-off between the true positive rates and false negative rates at various thresholds.

FALSE

e) In cross-validation, each observation is used the same number of times for training and exactly once for testing.

FALSE

! f) Entropy-based information gain criterion gives higher preference to features with many levels.

FALSE

g) Naïve Bayes is considered Naïve because of the assumption of conditional independence among the observations in the training data.

FALSE - it's conditional independence of features

! h) Non-parametric models are more flexible but they can struggle with large datasets.

TRUE

i) The trade-off between the number of descriptive features and the density of the instances in the feature space is known as the `Curse of dimensionality`

j) A model is `generative` if it can be used to obtain data that will have the same characteristics as the dataset from which the model was produced.

