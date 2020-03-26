Fundamentals of Machine Learning
Chapter 5: Similarity-based Learning Sections 5.4, 5.5
  Chapter 5B
 1 / 69
 
 1
2 3 4 5 6 7
Handling Noisy Data
Data Normalization
Predicting Continuous Targets Other Measures of Similarity Feature Selection
Efficient Memory Search Summary
  Chapter 5B
 2 / 69
 
Handling Noisy Data
  Chapter 5B
 3 / 69
 
 Figure: Is the instance at the top right of the diagram really noise?
  Chapter 5B
 4 / 69
 
The k nearest neighbors model predicts the target level with the majority vote from the set of k nearest neightbors to the query q:
k
Mk(q) = argmax 􏰆δ(ti,l) (1) l∈levels(t) i=1
   Chapter 5B
 5 / 69
 
 Figure: The decision boundary using majority classification of the nearest 3 neighbors.
  Chapter 5B
 6 / 69
 
 Figure: The decision boundary using majority classification of the nearest 5 neighbors.
  Chapter 5B
 7 / 69
 
 Figure: The decision boundary when k is set to 15.
  Chapter 5B
 8 / 69
 
In a distance weighted k nearest neighbor algorithm the contribution of each neighbor to the classification decision is weighted by the reciprocal of the squared distance between the neighbor d and the query q:
1
dist (q, d)2
The weighted k nearest neighbor model is defined as:
(2)
   Mk(q)= argmax􏰆k 1 ×δ(ti,l) (3) l∈levels(t) i=1 dist(q,di)2
   Chapter 5B
 9 / 69
 
 Figure: The weighted k nearest neighbor model decision boundary.
  Chapter 5B
 10 / 69
 
Data Normalization
  Chapter 5B
 11 / 69
 
Table: A dataset listing the salary and age information for customers and whether or not the purchased a pension plan .
ID Salary Age Purchased
1 53700 41 No
2 65300 37 No
3 48900 45 Yes
4 64800 49 Yes
5 44200 30 No
6 55900 57 Yes
7 48600 26 No
8 72800 60 Yes
9 45300 34 No
10 73200 52 Yes
     Chapter 5B
 12 / 69
 
The marketing department wants to decide whether or not they should contact a customer with the following profile:
⟨SALARY = 56, 000, AGE = 35⟩
   Chapter 5B
 13 / 69
 
     3
1
6
8
10 4
2
      9 5
7
?
                  45000 55000
Figure: The salary and age feature space with the data in Table 1 [12] plotted. The instances are labelled their IDs, triangles represent the negative instances and crosses represent the positive instances. The location of the query ⟨SALARY = 56, 000, AGE = 35⟩ is indicated by the ?.
Salary
65000 75000
Age
25 30 35 40 45 50 55 60

    Salary and Age Dist. Neigh.
Salary Only Dist. Neigh.
2300.0078 2 9300.0002 6 7100.0070 3 8800.0111 5
11800.0011 8
102.3914 1
7400.0055 4 16800.0186 9 10700.0000 7 17200.0084 10
2300 2 9300 6 7100 3 8800 5
11800 8
100 1
7400 4 16800 9 10700 7 17200 10
ID Salary Age Purch.
Age Only Dist. Neigh. 6 4
2 2 10 6 14 7
5 5
22 9
9 3 25 10 1 1
17 8
 1 53700 41
2 65300 37
3 48900 45
4 64800 49
5 44200 30
6 55900 57
7 48600 26
8 72800 60
9 45300 34
10 73200 52
No No Yes Yes No Yes No Yes No Yes
   Chapter 5B
 15 / 69
 
This odd prediction is caused by features taking different ranges of values, this is equivalent to features having different variances.
We can adjust for this using normalization; the equation for range normalization is:
ai′ = ai −min(a) ×(high−low)+low (4) max(a) − min(a)
     Chapter 5B
 16 / 69
 
    Salary and Age Dist. Neigh.
Salary Only Dist. Neigh.
0.1935 1
0.3260 2 0.3827 5 0.5115 7 0.4327 6 0.6471 8 0.3677 3 0.9361 10 0.3701 4 0.7757 9
0.0793 2
0.3207 6 0.2448 3 0.3034 5 0.4069 8 0.0034 1 0.2552 4 0.5793 9 0.3690 7 0.5931 10
Normalized Dataset
Age Only Dist. Neigh.
0.17647 4
0.05882 2 0.29412 6 0.41176 7 0.14706 3 0.64706 9 0.26471 5 0.73529 10 0.02941 1 0.50000 8
ID Salary
1 0.3276
2 0.7276
3 0.1621
4 0.7103
5 0.0000
6 0.4034
7 0.1517
8 0.9862
9 0.0379
10 1.0000
Age Purch.
0.4412 No
0.3235 No 0.5588 Yes 0.6765 Yes 0.1176 No 0.9118 Yes 0.0000 No 1.0000 Yes 0.2353 No 0.7647 Yes
    Chapter 5B
 17 / 69
 
Normalizing the data is an important thing to do for almost all machine learning algorithms, not just nearest neighbor!
   Chapter 5B
 18 / 69
 
Predicting Continuous Targets
  Chapter 5B
 19 / 69
 
Return the average value in the neighborhood:
1 􏰆k
Mk (q) = k
 ti (5)
 i=1
  Chapter 5B
 20 / 69
 
Table: A dataset of whiskeys listing the age (in years) and the rating (between 1 and 5, with 5 being the best) and the bottle price of each whiskey.
 ID Age Rating Price
1 0 2 30.00
2 12 3.5 40.00
3 10 4 55.00
4 21 4.5 550.00
5 12 3 35.00
6 15 3.5 45.00
7 16 4 70.00
8 18 3 85.00
9 18 3.5 78.00
10 16 3 75.00
ID Age Rating
11 19 5 12 6 4.5 13 8 3.5 14 22 4 15 6 2 16 8 4.5 17 10 2 18 30 4.5 19 1 1 20 4 3
Price
500.00 200.00 65.00 120.00 12.00 250.00 18.00 450.00 10.00 30.00
      Chapter 5B
 21 / 69
 
Table: The whiskey dataset after the descriptive features have been normalized.
 ID Age Rating Price
1 0.0000 0.25 30.00
2 0.4000 0.63 40.00
3 0.3333 0.75 55.00
4 0.7000 0.88 550.00
5 0.4000 0.50 35.00
6 0.5000 0.63 45.00
7 0.5333 0.75 70.00
8 0.6000 0.50 85.00
9 0.6000 0.63 78.00
10 0.5333 0.50 75.00
ID Age Rating
11 0.6333 1.00 12 0.2000 0.88 13 0.2667 0.63 14 0.7333 0.75 15 0.2000 0.25 16 0.2667 0.88 17 0.3333 0.25 18 1.0000 0.88 19 0.0333 0.00 20 0.1333 0.50
Price
500.00 200.00 65.00 120.00 12.00 250.00 18.00 450.00 10.00 30.00
      Chapter 5B
 22 / 69
 
 ?
12●●16● ●
●3●● ●●●● ●●●●
●●●
●
   ●
                                 0.0 0.2 0.4
Figure: The AGE and RATING feature space for the whiskey dataset. The location of the query instance is indicated by the ? symbol. The circle plotted with a dashed line demarcates the border of the neighborhood around the query when k = 3. The three nearest neighbors to the query are labelled with their ID values.
Age
0.6 0.8 1.0
Rating
0.0 0.2 0.4 0.6 0.8 1.0

The model will return a price prediction that is the average price of the three neighbors:
200.00 + 250.00 + 55.00 = 168.33 3
    Chapter 5B
 24 / 69
 
In a weighted k nearest neighbor the model prediction equation is changed to:
􏰆k 1 ×ti i=1 dist(q,di)2
Mk (q) = k (6) 􏰆1
i=1 dist(q,di)2
      Chapter 5B
 25 / 69
 
 Table: The calculations for the weighted k nearest neighbor prediction
 ID Price Distance
1 30.00 0.7530 2 40.00 0.5017 3 55.00 0.3655 4 550.00 0.6456 5 35.00 0.6009 6 45.00 0.5731 7 70.00 0.5294 8 85.00 0.7311 9 78.00 0.6520 10 75.00 0.6839 11 500.00 0.5667 12 200.00 0.1828 13 65.00 0.4250 14 120.00 0.7120 15 12.00 0.7618 16 250.00 0.2358 17 18.00 0.7960 18 450.00 0.9417 19 10.00 1.0006 20 30.00 0.5044
Weight
1.7638 3.9724 7.4844 2.3996 2.7692 3.0450 3.5679 1.8711 2.3526 2.1378 3.1142
29.9376 5.5363 1.9726 1.7233
17.9775 1.5783 1.1277 0.9989 3.9301
Price×Weight 52.92 158.90 411.64 1319.78 96.92 137.03 249.75 159.04 183.50 160.33 1557.09 5987.53 359.86 236.71 20.68 4494.38 28.41 507.48 9.99 117.90 16 249.85
  Totals: 99.2604

Other Measures of Similarity
  Chapter 5B
 27 / 69
 
Table: A binary dataset listing the behavior of two individuals on a website during a trial period and whether or not they subsequently signed-up for the website.
ID Profile FAQ HelpForum Newsletter Liked Signup
1 1 1 1 0 1 Yes 2 1 0 0 0 0 No
     Chapter 5B
 28 / 69
 
  Who is q more similar to d1 or d2?
q = ⟨PROFILE:1, FAQ:0, HELP FORUM:1, NEWSLETTER:0, LIKED:0, ⟩
ID Profile FAQ HelpForum Newsletter Liked Signup
1 1 1 1 0 1 Yes 2 1 0 0 0 0 No
                Chapter 5B
 29 / 69
 
  Pres. Abs. d Pres. CP=2 PA=0 1 Abs. AP=2 CA=1
Pres. Abs. d Pres. CP=1 PA=1 2 Abs. AP=0 CA=3
qq
  Table: The similarity between the current trial user, q, and the two users in the dataset, d1 and d2, in terms of co-presence (CP), co-absence (CA), presence-absence (PA), and absence-presence (AP).
  Chapter 5B
 30 / 69
 
  Russel-Rao
The ratio between the number of co-presenses and the total number of binary features considered.
simRR (q, d) = CP (q, d) (7) |q|
               Chapter 5B
 31 / 69
 
  Russel-Rao
simRR (q, d) = CP (q, d) (8) |q|
⟨PROFILE:1, FAQ:0, HELP FORUM:1, NEWSLETTER:0, LIKED:0, ⟩ qq
              Pres. Abs. d Pres. CP=2 PA=0 1 Abs. AP=2 CA=1
Pres. Abs. d Pres. CP=1 PA=1 2 Abs. AP=0 CA=3
    Chapter 5B
 32 / 69
 
  Russel-Rao
simRR (q, d) = CP (q, d) (9) |q|
Example
simRR(q,d1) = 2 = 0.4 5
simRR(q,d2) = 1 = 0.2 5
                        The current trial user is judged to be more similar to instance d1 then d2.
      Chapter 5B
 33 / 69
 
  Sokal-Michener
Sokal-Michener is defined as the ratio between the total number of co-presences and co-absences, and the total number of binary features considered.
simSM (q, d) = CP (q, d) + CA(q, d) (10) |q|
               Chapter 5B
 34 / 69
 
  Sokal-Michener
simSM (q, d) = CP (q, d) + CA(q, d) (11) |q|
⟨PROFILE:1, FAQ:0, HELP FORUM:1, NEWSLETTER:0, LIKED:0, ⟩ qq
              Pres. Abs. d Pres. CP=2 PA=0 1 Abs. AP=2 CA=1
Pres. Abs. d Pres. CP=1 PA=1 2 Abs. AP=0 CA=3
    Chapter 5B
 35 / 69
 
  Sokal-Michener
simSM (q, d) = CP (q, d) + CA(q, d) (12) |q|
Example
simSM(q,d1) = 3 = 0.6 5
simSM(q,d2) = 4 = 0.8 5
                        The current trial user is judged to be more similar to instance d2 then d1.
      Chapter 5B
 36 / 69
 
  Jaccard
The Jacquard index ignore co-absences
simJ (q, d) = CP (q, d) (13) CP(q, d) + PA(q, d) + AP(q, d)
               Chapter 5B
 37 / 69
 
  Jaccard
simJ (q, d) = CP (q, d) (14) CP(q, d) + PA(q, d) + AP(q, d)
⟨PROFILE:1, FAQ:0, HELP FORUM:1, NEWSLETTER:0, LIKED:0, ⟩ qq
              Pres. Abs. d Pres. CP=2 PA=0 1 Abs. AP=2 CA=1
Pres. Abs. d Pres. CP=1 PA=1 2 Abs. AP=0 CA=3
    Chapter 5B
 38 / 69
 
  Jaccard
simJ (q, d) = CP (q, d) (15) CP(q, d) + PA(q, d) + AP(q, d)
Example
simJ(q,d1) = 2 = 0.5 4
simJ(q,d2) = 1 = 0.5 2
                        The current trial user is judged to be equally similar to instance d1 and d2!
      Chapter 5B
 39 / 69
 
Cosine similarity between two instances is the cosine of the inner angle between the two vectors that extend from the origin to each instance.
Cosine
           (a[1]×b[1])+···+(a[m]×b[m]) simCOSINE (a, b) = 􏰔􏰎mi =1 a[i ]2 × 􏰔􏰎mi =1 b[i ]2
        Chapter 5B
 40 / 69
 
Calculate the cosine similarity between the following two instances:
d1 = ⟨SMS = 97, VOICE = 21⟩ d2 = ⟨SMS = 18, VOICE = 184⟩
􏰎mi=1 (a[i] × b[i]) simCOSINE (a, b) = 􏰔􏰎mi =1 a[i ]2 × 􏰔􏰎mi =1 b[i ]2
      Chapter 5B
 41 / 69
 
Calculate the cosine similarity between the following two instances:
d1 = ⟨SMS = 97, VOICE = 21⟩ d2 = ⟨SMS = 18, VOICE = 184⟩
(97×181)+(21×184) simCOSINE (d1, d1) = √972 + 212 × √1812 + 1842
= 0.8362
      Chapter 5B
 42 / 69
 
           2
       1
           ●
θ
1
●
θ
                0 50 100 SMS
(a)
150
200
0.0
0.2
0.4 0.6 0.8 1.0 SMS
(b)
2
Figure: (a) The θ represents the inner angle between the vector emanating from the origin to instance d1 ⟨SMS = 97, VOICE = 21⟩ and the vector emanating from the origin to instance d2 ⟨SMS = 181, VOICE = 184⟩; (b) shows d1 and d2 normalized to the unit circle.
  Chapter 5B
 43 / 69
 Voice
0 50 100 150 200
Voice
0.0 0.2 0.4 0.6 0.8 1.0

Calculate the cosine similarity between the following two instances:
d1 = ⟨SMS = 97, VOICE = 21⟩ d3 = ⟨SMS = 194, VOICE = 42⟩
􏰎mi=1 (a[i] × b[i]) simCOSINE (a, b) = 􏰔􏰎mi =1 a[i ]2 × 􏰔􏰎mi =1 b[i ]2
      Chapter 5B
 44 / 69
 
Calculate the cosine similarity between the following two instances:
d1 = ⟨SMS = 97, VOICE = 21⟩ d3 = ⟨SMS = 194, VOICE = 42⟩
(97×194)+(21×42) simCOSINE (d1, d1) = √972 + 212 × √1942 + 422
=1
      Chapter 5B
 45 / 69
 
  ●B
●C
                                            ●A
                                                                                        ●B
●C
                                         ●A
                                                                                           ●B ●C ●A
                        YYY
                           0 20 40 60 80 100 0 20 40 60 80 100 0 20 40 60 80 10 XXX
(a) (b) (c)
Figure: Scatter plots of three bivariate datasets with the same center point A and two queries B and C both equidistant from A. (a) A dataset uniformly spread around the center point. (b) A dataset with negative covariance. (c) A dataset with positive covariance.
0 20 40 60 80 100
0 20 40 60 80 100
0 20 40 60 80 100
  Chapter 5B
 46 / 69

The mahalanobis distance uses covariance to scale distances so that distances along a direction where the dataset is spreadout a lot are scaled down and distances along directions where the dataset is tightly packed are scaled up.
 Mahalanobis(a, b) =
−1  a[1]−b[1]  [a[1]−b[1],...,a[m]−b[m]]×􏰆× ... 
a[m] − b[m]
(16)
  Chapter 5B
 47 / 69
 
Similar to Euclidean distance, the mahalanobis distance squares the differences of the features.
But it also rescales the differences (using the inverse covariance matrix) so that all the features have unit variance and the effects of covariance is removed.
    Chapter 5B
 48 / 69
 
                           80 5 80 80 31●
60 60 60 Y●1Y3Y
5 3
1
                                                                                                                   40 40
5
40
                  ●
   20 20 20
                           20 40 60 80 20 40 60 80 20 40 60 80 XXX
(a) (b) (c)
Figure: The coordinate systems defined by the mahalanobis metric using the co-variance matrix for the dataset in Figure 9(c) [46] using three different origins: (a) (50, 50), (b) (63, 71), (c) (42, 35). The ellipses in each figure plot the 1, 3, and 5 unit distances contours from each origin.
 Chapter 5B     49 / 69

          80
60
40
20
9.35
●B 2.15 ●C ●A
                  20 40 60 80
X
Figure: The effect of using a mahalanobis versus euclidean distance. Point A is the center of mass of the dataset in Figure 9(c) [46]. The ellipses plot the mahalanobis distance contours from A that B and C lie on. In euclidean terms B and C are equidistant from A, however using the mahalanobis metric C is much closer to A than B.
  Chapter 5B
 50 / 69
 Y

Feature Selection
  Chapter 5B
 51 / 69
 
  3.0 2.5 2.0
Y 1.5 1.0 0.5
0.00.0 0.5 1.0 1.5 2.0 2.5 3.0 XX
(a) (b)
Y
3. 2.5
2.0 1.5
0.51.0 Z 0.0 0.5 1.0 1.5 2.0 2.5 3.00.0
X
                                                          ●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
                               0.0 0.5 1.0 1.5 2.0 2.5 3.0
       Figure: A set of scatter plots illustrating the curse of dimensionality. Across figures (a), (b) and (c) the density of the marked unit hypercubes decreases as the number of dimensions increases.
(c)
  Chapter 5B
 52 / 69
 0.0 0.5 1.0 1.5 2.0 2.5 3.0
0

 (a)
(b)
(c)
3.0 2.5 2.0
Y 1.5 1.0 0.5
0.00.0 0.5 1.0 1.5 2.0 2.5 3.0 XX
Y
3.0 2.5
2.0 1.5
0.51.0 Z 0.0 0.5 1.0 1.5 2.0 2.5 3.00.0
X
0.0 0.5 1.0 1.5 2.0 2.5 3.0 0.0 0.5 1.0 1.5 2.0 2.5 3.0
●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
0.0 0.5 1.0 1.5 2.0 2.5 3.0
3.0 2.5 2.0
Y 1.5 1.0 0.5
0.0 0.0
Y
3.0 2.5
2.0 1.5
3.0 0.00.51.0 Z
0.5
1.0 1.5 XX
Figure: Figures (d) and (e) illustrate the cost we must incur if we wish to maintain the density of the instances in the feature space as the dimensionality of the feature space increases.
2.0
2.5
3.0
0.0
0.5
1.0
1.5
2.0 2.5
(d) (e)

During our discussion of feature selection approaches it will be useful to distinguish between different classes of descriptive features:
1 Predictive
2 Interacting
3 Redundant
4 Irrelevant
    Chapter 5B
 54 / 69
 
When framed as a local search problem feature selection is defined in terms of an iterative process consisting of the following stages:
1 Subset Generation
2 Subset Selection
3 Termination Condition
The search can move through the search space in a number of ways:
􏰋 Forward sequential selection
􏰋 Backward sequential selection
     Chapter 5B
 55 / 69
 
  X
  X
 Y
        Y
 X
  Z
X
 Y
 Z
 Forward Selection Backward Selection
        Z
  Y
 Z
Figure: Feature Subset Space for a dataset with 3 features X , Y , Z .
  Chapter 5B
 56 / 69
 
 Figure: The process of model induction with feature selection.

Efficient Memory Search
  Chapter 5B
 58 / 69
 
Assuming that the training set will remain relatively stable it is possible to speed up the prediction speed of a nearest neighbor model by investing in some one-off computation to create an index of the instances that enables efficient retrieval of the nearest neighbors.
The k-d tree, which is short for k-dimensional tree, is one of the best known of these indexes.
    Chapter 5B
 59 / 69
 
  Example
Let’s build a k-d tree for the college athlete dataset
Table: The speed and agility ratings for 22 college athletes labelled with the decisions for whether they were drafted or not.
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
11 2.00
6.00 No 8.00 No 5.50 No 8.25 No 7.50 No 5.00 No 5.25 No 3.25 No 4.00 No 3.75 No 2.00 No
12 5.00 13 8.25 14 5.75 15 4.75 16 5.50 17 5.25 18 7.00 19 7.50 20 7.25 21 6.75
2.50 No 8.50 No 8.75 Yes 6.25 Yes 6.75 Yes 9.50 Yes 4.25 Yes 8.00 Yes 5.75 Yes 3.00 Yes
       Chapter 5B
 60 / 69
 
   Example
        First split on the SPEED feature
  ID=6 Speed:4.5
             Speed<4.5 Speed≥4.5
          IDs= 1,2,3,4,5,7, 8,9,10,11
IDs= 12,13,14,15,16, 17,18,19,20,21
            (a) (b)
Figure: The k-d tree generated, for the dataset in Table 7 [60] after the initial split using the SPEED feature. (b) the partitioning of the feature space by the k-d tree in (a).
2468
Speed
   2468
Agility

   Example
        Next split on the AGILITY feature
      ID=6 Speed:4.5
         Speed<4.5 Speed≥4.5
Agility<5.5 Agility≥5.5
IDs=7,8,9,10,11 IDs=1,2,4,5
         ID=3 Agility:5.5
IDs= 12,13,14,15,16, 17,18,19,20,21
                (a) (b)
Figure: (a) the k-d tree after the dataset at the left child of the root has been split using the AGILITY feature with a threshold of 5.5. (b) the partitioning of the feature space by the k-d tree in (a)
2468
Speed
   2468
Agility

   Example
        After completing the tree building process
               ID=6 Speed:4.5
      Speed<4.5 Speed>=4.5
         ID=3 Agility:5.5
ID=16 Agility:6.75
         Agility<5.5 Agility>=5.5
Speed<3.25 Speed>=3.25
Agility<7.5
(a)
Figure: (a) The complete k-d tree generated, for the dataset in Table 7 [60]. (b) the partitioning of the feature space by the k-d tree in (a)
           ID=7 Speed:3.5
ID=4 Speed:3.25
ID=21 Speed:6.75
ID=19 Speed:7.5
             Speed<3.5 Speed>=3.5
Agility<3.25 Agility<4.0
Agility<6.75
Speed<6.75
Agility<6.25
Agility>=6.75
Speed>=6.75
Agility<5.75
Speed<7.5
Agility<9.5
Speed>=7.5
                ID=8 Agility:3.25
ID=9 Agility:4.0
ID=5 Agility:7.5
ID=2
ID=15 Agility:6.25
ID=20 Agility:5.75
ID=17 Agility:9.5
ID=13
       2
4
6 8
Speed
(b)
      ID=11
ID=10
ID=1
ID=12
ID=18
ID=14
   2468
Agility

  Example
Finding neighbors for query SPEED= 6, AGILITY= 3.5.
                              15
                    18 ? 21
12
         ID=12
      (a)
2468 Speed
(b)
Figure: (a) the path taken from the root node to a leaf node when we search the tree. (b) the location of the query in the feature space is represented by the ? and the target hypersphere defining the region that must contain the true nearest neighbor.
   Chapter 5B
  64 / 69
    Agility 2468
 
  Example
Finding neighbors for query SPEED= 6, AGILITY= 3.5.
                                                 15
18 ? 21
12
                    Speed<4.5
Agility<5.5 Agility>=5.5
Speed<3.25 Speed>=3.25
Speed>=4.5
Prune subtree and ascend?
                       Speed<3.5Speed>=3.5
Agility<3.25 Agility<4.0
Instance=11 Instance=10
Agility<6.75
Speed<6.75
Agility<6.25
Instance=12
Agility>=6.75
Search Speed>=6.7s5ubtree?
Agility<5.75
Instance=18
        Instance=2
(a)
Speed<7.5
Agility<9.5
Instance=14
Speed>=7.5
Instance=13
       Agility<7.5
Instance=1
2468 Speed
(b)
      Figure: (a) the state of the retrieval process stored as current-best. (b) the dashed circle hypersphere after current-best-distance has
after instance d21 has been illustrates the extent of the target been updated.
Instance=6 Split on: Speed Median: 4.5
  Instance=3 Split on: Agility Median: 5.5
Instance=16 Split on: Agility Median: 6.75
    Instance=7 Split on: Speed Median: 3.5
Instance=4 Split on: Speed Median: 3.25
Instance=21 Split on: Speed Median: 6.75
Instance=19 Split on: Speed Median: 7.5
      Instance=8 Split on: Agility Median: 3.25
Instance=9 Split on: Agility Median: 4.0
Instance=5 Split on: Agility Median: 7.5
Instance=15 Split on: Agility Median: 6.25
Instance=20 Split on: Agility Median: 5.75
Instance=17 Split on: Agility Median: 9.5
     Chapter 5B
 65 / 69
 Agility 2468

  Example
                       ID=21
                            Chapter 5B
 66 / 69
    
Summary
  Chapter 5B
 67 / 69
 
Nearest neighbor models are very sensitive to noise in the target feature the easiest way to solve this problem is to employ a k nearest neighbor.
Normalization techniques should almost always be applied when nearest neighbor models are used.
It is easy to adapt a nearest neighbor model to continuous targets.
There are many different measures of similarity.
Feature selection is a particularly important process for nearest
neighbor algorithms it alleviates the curse of dimensionality.
As the number of instances becomes large, a nearest neighbor model will become slower—techniques such as the k-d tree can help with this issue.
        Chapter 5B
 68 / 69
 
 1
2 3 4 5 6 7
Handling Noisy Data
Data Normalization
Predicting Continuous Targets Other Measures of Similarity Feature Selection
Efficient Memory Search Summary
  Chapter 5B
 69 / 69
 