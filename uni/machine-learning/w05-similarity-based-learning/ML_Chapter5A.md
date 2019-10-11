Fundamentals of Machine Learning
Chapter 5: Similarity-based Learning Sections 5.1, 5.2, 5.3
  Chapter 5A
 1 / 38
 
 1
2
Big Idea
Fundamentals
Feature Space Distance Metrics
  3
4
5
Standard Approach: The Nearest Neighbor Algorithm
A Worked Example
 Epilogue Summary
  Chapter 5A
 2 / 38
 
Big Idea
  Chapter 5A
 3 / 38
 
The year is 1798 and you are Lieutenant-Colonel David Collins of HMS Calcutta who is exploring the region around Hawkesbury River, in New South Wales.
After an expedition up the river one of the men tells you that he saw a strange animal near the river.
You ask him to describe the animal to you and he explains that he didn’t see it very well but that he did notice that it had webbed feet and a duck-bill snout, and that it growled at him.
In order to plan the expedition for the next day you decide that you need to classify the animal so that you can figure out whether it is dangerous to approach it or not.
      Chapter 5A
 4 / 38
 
     Grrrh! Score
##1
##1
#2
Figure: Matching animals you remember to the features of the unknown animal described by the sailor. Note: The images used in this figure were created by Jan Gillbank for the English for the Australian Curriculum website (http://www.e4ac.edu.au) and are used under the Create Commons Attribution 3.0 Unported licence
    (http://creativecommons.org/licenses/by/3.0). The images were

The process of classifying an unknown animal by matching the features of the animal against the features of animals you can remember neatly encapsulates the big idea underpinning similarity-based learning:
if you are trying to classify something then you should search your memory to find things that are similar and label it with the same class as the most similar thing in your memory
One of the simplest and best known machine learning algorithms for this type of reasoning is called the nearest neighbor algorithm.
    Chapter 5A
 6 / 38
 
Fundamentals
  Chapter 5A
 7 / 38
 
The fundamentals of similarity-based learning are:
􏰋 Feature space
􏰋 Similarity metrics
   Chapter 5A
 8 / 38
 
Table: The speed and agility ratings for 20 college athletes labelled with the decisions for whether they were drafted or not.
 ID Speed Agility Draft
ID Speed Agility Draft
  1 2.50
2 3.75
3 2.25
4 3.25
5 2.75
6 4.50
7 3.50
8 3.00
9 4.00
10 4.25
6.00 No 8.00 No 5.50 No 8.25 No 7.50 No 5.00 No 5.25 No 3.25 No 4.00 No 3.75 No
11 2.00 12 5.00 13 8.25 14 5.75 15 4.75 16 5.50 17 5.25 18 7.00 19 7.50 20 7.25
2.00 No 2.50 No 8.50 No 8.75 Yes 6.25 Yes 6.75 Yes 9.50 Yes 4.25 Yes 8.00 Yes 5.75 Yes
    Chapter 5A
 9 / 38
 
                          Agility
2468
        2345678
Speed
Figure: A feature space plot of the data in Table 2 [25]. The triangles represent ’Non-draft’ instances and the crosses represent the ’Draft’ instances.

A feature space is an abstract n-dimensional space that is created by taking each of the descriptive features in an ABT to be the axes of a reference space and each instance in the dataset is mapped to a point in the feature space based on the values of its descriptive features.
   Chapter 5A
 11 / 38
 
A similarity metric measures the similarity between two instances according to a feature space
Mathematically, a metric must conform to the following four criteria:
1 Non-negativity: metric(a, b) ≥ 0
2 Identity: metric(a, b) = 0 ⇐⇒ a = b
3 Symmetry: metric(a, b) = metric(b, a)
4 Triangular Inequality: metric(a, b) ≤ metric(a, c) + metric(b, c)
where metric(a, b) is a function that returns the distance between two instances a and b.
     Chapter 5A
 12 / 38
 
One of the best known metrics is Euclidean distance which computes the length of the straight line between two points. Euclidean distance between two instances a and b in a m-dimensional feature space is defined as:
 􏰉􏰈 m 􏰇
 Euclidean(a, b) = 􏰈􏰆 (a[i ] − b[i ])2 (1) i=1
  Chapter 5A
 13 / 38
 
  Example
The Euclidean distance between instances d12 (SPEED= 5.00, AGILITY= 2.5) and d5 (SPEED= 2.75,AGILITY= 7.5) in Table 2 [25] is:
             Chapter 5A
 14 / 38
 
  Example
The Euclidean distance between instances d12 (SPEED= 5.00, AGILITY= 2.5) and d5 (SPEED= 2.75,AGILITY= 7.5) in Table 2 [25] is:
         Euclidean(⟨5.00, 2.50⟩ , ⟨2.75, 7.50⟩) = =
􏰔22 (5.00 − 2.75) + (2.50 − 7.50)
√
30.0625 = 5.4829
      Chapter 5A
 14 / 38
 
Another, less well known, distance measure is the Manhattan distance or taxi-cab distance.
The Manhattan distance between two instances a and b in a feature space with m dimensions is:1
m
Manhattan(a, b) = 􏰆 abs(a[i] − b[i]) (2)
i=1
   1The abs() function surrounding the subtraction term indicates that we use the absolute value, i.e. non-negative value, when we are summing the differences; this makes sense because distances can’t be negative.
  Chapter 5A
 15 / 38
 
    ●
      ●
Manhattan
         Figure: The Manhattan and Euclidean distances between two points.
  Chapter 5A
 16 / 38
 Euclidean

  Example
The Manhattan distance between instances d12 (SPEED= 5.00, AGILITY= 2.5) and d5 (SPEED= 2.75,AGILITY= 7.5) in Table 2 [25] is:
             Chapter 5A
 17 / 38
 
  Example
The Manhattan distance between instances d12 (SPEED= 5.00, AGILITY= 2.5) and d5 (SPEED= 2.75,AGILITY= 7.5) in Table 2 [25] is:
Manhattan(⟨5.00, 2.50⟩ , ⟨2.75, 7.50⟩) = abs(5.00 − 2.75) + abs(2.5 − 7.5) = 2.25+5 = 7.25
             Chapter 5A
 17 / 38
 
The Euclidean and Manhattan distances are special cases of
Minkowski distance
The Minkowski distance between two instances a and b in a feature space with m descriptive features is:
􏰌 􏰕1 mp
Minkowski(a, b) = 􏰆 abs(a[i] − b[i])p (3) i=1
where different values of the parameter p result in different distance metrics
The Minkowski distance with p = 1 is the Manhattan distance and with p = 2 is the Euclidean distance.
      Chapter 5A
 18 / 38
 
The larger the value of p the more emphasis is placed on the features with large differences in values because these differences are raised to the power of p.
   Chapter 5A
 19 / 38
 
   Example
         Instance ID
12 12
Instance ID
Manhattan (Minkowski p=1)
Euclidean (Minkowski p=2) 5.4829
8.25
 5 7.25 17 7.25
   17 5
    12
  Manhattan Euclidean
             2345678 Speed
The Manhattan and Euclidean distances between instances d12 (SPEED= 5.00, AGILITY= 2.5) and d5 (SPEED= 2.75, AGILITY= 7.5) and between instances d12 and d17 (SPEED= 5.25, AGILITY= 9.5).
   Agility 2468

Standard Approach: The Nearest Neighbor Algorithm
  Chapter 5A
 21 / 38
 
The Nearest Neighbour Algorithm
Require: set of training instances Require: a query to be classified
1: Iterateacrosstheinstancesinmemoryandfindtheinstancethatis shortest distance from the query position in the feature space.
2: Make a prediction for the query equal to the value of the target
feature of the nearest neighbor.
  Chapter 5A
 22 / 38
 
Table: The speed and agility ratings for 20 college athletes labelled with the decisions for whether they were drafted or not.
 ID Speed Agility Draft
ID Speed Agility Draft
  1 2.50
2 3.75
3 2.25
4 3.25
5 2.75
6 4.50
7 3.50
8 3.00
9 4.00
10 4.25
6.00 No 8.00 No 5.50 No 8.25 No 7.50 No 5.00 No 5.25 No 3.25 No 4.00 No 3.75 No
11 2.00 12 5.00 13 8.25 14 5.75 15 4.75 16 5.50 17 5.25 18 7.00 19 7.50 20 7.25
2.00 No 2.50 No 8.50 No 8.75 Yes 6.25 Yes 6.75 Yes 9.50 Yes 4.25 Yes 8.00 Yes 5.75 Yes
    Chapter 5A
 23 / 38
 
  Example
Should we draft an athlete with the following profile: SPEED= 6.75, AGILITY= 3
              Chapter 5A
 24 / 38
 
                      ?
           2345678
Speed
Figure: A feature space plot of the data in Table 2 [25] with the position in the feature space of the query represented by the ? marker. The triangles represent ’Non-draft’ instances and the crosses represent the ’Draft’ instances.
  Chapter 5A
 25 / 38
 Agility
2468

Table: The distances (Dist.) between the query instance with SPEED = 6.75 and AGILITY = 3.00 and each instance in Table 2 [25].
 ID SPEED 18 7.00 12 5.00 10 4.25 20 7.25 9 4.00 6 4.50 8 3.00 15 4.75 7 3.50 16 5.50
AGILITY DRAFT Dist. 4.25 yes 1.27 2.50 no 1.82 3.75 no 2.61 5.75 yes 2.80 4.00 no 2.93 5.00 no 3.01 3.25 no 3.76 6.25 yes 3.82 5.25 no 3.95 6.75 yes 3.95
ID SPEED AGILITY 11 2.00 2.00 19 7.50 8.00
3 2.25 5.50 1 2.50 6.00 13 8.25 8.50 2 3.75 8.00 14 5.75 8.75 5 2.75 7.50 4 3.25 8.25 17 5.25 9.50
DRAFT Dist. no 4.85 yes 5.06 no 5.15 no 5.20 no 5.70 no 5.83 yes 5.84 no 6.02 no 6.31 yes 6.67
      Chapter 5A
 26 / 38
 
  (a) Voronoi tessellation (b) Decision boundary (k = 1)
Figure: (a) The Voronoi tessellation of the feature space for the dataset in Table 2 [25] with the position of the query represented by the ? marker; (b) the decision boundary created by aggregating the neighboring Voronoi regions that belong to the same target level.
  Chapter 5A
 27 / 38
 
One of the great things about nearest neighbour algorithms is that we can add in new data to update the model very easily.
   Chapter 5A
 28 / 38
 
Table: The extended version of the college athletes dataset.
 ID SPEED
1 2.50
2 3.75
3 2.25
4 3.25
5 2.75
6 4.50
7 3.50
8 3.00
9 4.00
10 4.25
11 2.00
AGILITY DRAFT 6.00 no 8.00 no 5.50 no 8.25 no 7.50 no 5.00 no 5.25 no 3.25 no 4.00 no 3.75 no 2.00 no
ID SPEED 12 5.00 13 8.25 14 5.75 15 4.75 16 5.50 17 5.25 18 7.00 19 7.50 20 7.25 21 6.75
AGILITY DRAFT 2.50 no 8.50 no 8.75 yes 6.25 yes 6.75 yes 9.50 yes 4.25 yes 8.00 yes 5.75 yes 3.00 yes
      Chapter 5A
 29 / 38
 
  (a) Voronoi tessellation (b) Decision boundary (k = 1)
Figure: (a) The Voronoi tessellation of the feature space when the dataset has been updated to include the query instance; (b) the updated decision boundary reflecting the addition of the query instance in the training set.
  Chapter 5A
 30 / 38
 
Epilogue
  Chapter 5A
 31 / 38
 
Returning to 1798 and HMS Calcutta, the next day you accompany your men on the expedition up the river and you encounter the strange animal the sailor had described to you.
This time when you see the animal yourself you realize that it definitely isn’t a duck!
It turns out that you and your men are the first Europeans to encounter a platypus2.
    2The story recounted here of the discovery of the platypus is loosely based on real events.
  Chapter 5A
 32 / 38
 
 Figure: A duck-billed platypus.The platypus image used in here was created by Jan Gillbank for the English for the Australian Curriculum website (http://www.e4ac.edu.au) and are used under the Create Commons Attribution 3.0 Unported licence (http://creativecommons.org/licenses/by/3.0). The image was sourced via Wikimedia Commons.
  Chapter 5A
 33 / 38
 
This epilogue illustrates two important, and related, aspects of supervised machine learning:
1 supervised machine learning is based on the stationarity assumption which states that the data doesn’t change - remains stationary - over time.
2 in the context of classification, supervised machine learning creates models that distinguish between the classes that are present in the dataset they are induced from. So, if a classification model is trained to distinguish between lions, frogs and ducks, the model will classify a query as being either a lion, a frog or a duck; even if the query is actually a platypus.
    Chapter 5A
 34 / 38
 
Summary
  Chapter 5A
 35 / 38
 
Similarity-based prediction models attempt to mimic a very human way of reasoning by basing predictions for a target feature value on the most similar instances in memory—this makes them easy to interpret and understand.
This advantage should not be underestimated as being able to understand how the model works gives people more confidence in the model and, hence, in the insight that it provides.
    Chapter 5A
 36 / 38
 
The inductive bias underpinning similarity-based classification is that things that are similar (i.e., instances that have similar descriptive features) belong to the same class.
The nearest neighbor algorithm creates an implicit global predictive model by aggregating local models, or neighborhoods.
The definition of these neighborhoods is based on proximity within the feature space to the labelled training instances.
Queries are classified using the label of the training instance defining the neighborhood in the feature space that contains the query.
      Chapter 5A
 37 / 38
 
 1
2
Big Idea
Fundamentals
Feature Space Distance Metrics
  3
4
5
Standard Approach: The Nearest Neighbor Algorithm
A Worked Example
 Epilogue Summary
  Chapter 5A
 38 / 38
 