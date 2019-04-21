5.8 Exercises
1. The table below lists a dataset that was used to create a nearest neighbour model
that predicts whether it will be a good day to go surfing.
| ID | WAVE SIZE (FT) | WAVE PERIOD (SECS) | WIND SPEED (MPH) | GOOD SURF |
| --- | --- | --- | --- | --- |
| 1 | 6 | 15 | 5 | yes |
| 2 | 1 | 6 | 9 | no |
| 3 | 7 | 10 | 4 | yes |
| 4 | 7 | 12 | 3 | yes |
| 5 | 2 | 2 | 10 | no |
| 6 | 10 | 2 | 20 | no |

Assuming that the model uses Euclidean distance to find the nearest neighbour, what
prediction will the model return for each of the following query instances.
| ID WAVE SIZE (FT) | WAVE PERIOD (SECS) | WIND SPEED (MPH) | GOOD SURF |  |
| --- | --- | --- | --- | --- |
| Q1 | 8 | 15 | 2 | ? |
| Q2 | 8 | 2 | 18 | ? |
| Q3 | 6 | 11 | 4 | ? |

2. Email spam filtering models often use a bag-of-words representation for emails.
In a bag-of-words representation, the descriptive features that describe a document (in
our case, an email) each represent how many times a particular word occurs in the
document. One descriptive feature is included for each word in a predefined
dictionary. The dictionary is typically defined as the complete set of words that occur
in the training dataset. The table below lists the bag-of-words representation for the
following five emails and a target feature, SPAM, whether they are spam emails or
genuine emails:
“money, money, money”
“free money for free gambling fun”
“gambling for fun”
“machine learning for fun, fun, fun”
“free machine learning”



a. What target level would a nearest neighbour model using Euclidean distance return for the following email: “machine learning for free”?

b. What target level would a k-NN model with k = 3 and using Euclidean distance
return for the same query?

c. What target level would a weighted k-NN model with k = 5 and using a weighting
scheme of the reciprocal of the squared Euclidean distance between the neighbor and
the query, return for the query?

d. What target level would a k-NN model with k = 3 and using Manhattan distance
return for the same query?

e. There are a lot of zero entries in the spam bag-of-words dataset. This is indicative of sparse data and is typical for text analytics. Cosine similarity is often a good choice when dealing with sparse non-binary data. What target level would a 3-NN model using cosine similarity return for the query?

3. The predictive task in this question is to predict the level of corruption in a country based on a range of macro-economic and social features. The table below lists some countries described by the following descriptive features:

LIFE EXP., the mean life expectancy at birth
TOP-10 INCOME, the percentage of the annual income of the country that goes to
the top 10% of earners
INFANT MORT., the number of infant deaths per 1,000 births
MIL. SPEND, the percentage of GDP spent on the military
SCHOOL YEARS, the mean number years spent in school by adult females
The target feature is the Corruption Perception Index (CPI). The CPI measures the
perceived levels of corruption in the public sector of countries and ranges from 
`0 (highly corrupt) to 100 (very clean)`.

We will use Russia as our query country for this question. The table below lists the descriptive features for Russia.

a. What value would a 3-nearest neighbor prediction model using Euclidean distance
return for the CPI of Russia?
b. What value would a weighted k-NN prediction model return for the CPI of Russia?
Use k = 16 (i.e., the full dataset) and a weighting scheme of the reciprocal of the
squared Euclidean distance between the neighbor and the query.
c. The descriptive features in this dataset are of different types. For example, some are
percentages, others are measured in years, and others are measured in counts per
1,000. We should always consider normalizing our data, but it is particularly
important to do this when the descriptive features are measured in different units.
What value would a 3-nearest neighbor prediction model using Euclidean distance
return for the CPI of Russia when the descriptive features have been normalized
using range normalization?
d. What value would a weighted k-NN prediction model—with k = 16 (i.e., the full
dataset) and using a weighting scheme of the reciprocal of the squared Euclidean
distance between the neighbor and the query—return for the CPI of Russia when it is
applied to the range-normalized data?
e. The actual 2011 CPI for Russia was 2.4488. Which of the predictions made was the
most accurate? Why do you think this was?

✻ 4. You have been given the job of building a recommender system for a large
online shop that has a stock of over 100,000 items. In this domain the behavior of
customers is captured in terms of what items they have bought or not bought. For
example, the following table lists the behavior of two customers in this domain for a
subset of the items that at least one of the customers has bought.
ID ITEM 107 ITEM 498 ITEM 7256 ITEM 28063 ITEM 75328
1 true true true false false
2 true false false true true
a. The company has decided to use a similarity-based model to implement the
recommender system. Which of the following three similarity indexes do you think
the system should be based on?
b. What items will the system recommend to the following customer? Assume that the
recommender system uses the similarity index you chose in the first part of this
question and is trained on the sample dataset listed above. Also assume that the
system generates recommendations for query customers by finding the customer
most similar to them in the dataset and then recommending the items that this similar
customer has bought but that the query customer has not bought.
ID
ITEM
107
ITEM
498
ITEM
7256
ITEM
28063
ITEM
75328
Query true false true false false
✻ 5. You are working as an assistant biologist to Charles Darwin on the Beagle
voyage. You are at the Galápagos Islands, and you have just discovered a new animal
that has not yet been classified. Mr. Darwin has asked you to classify the animal using
a nearest neighbor approach, and he has supplied you the following dataset of already
classified animals.
The descriptive features of the mysterious newly discovered animal are as follows:
a. A good measure of distance between two instances with categorical features is the
overlap metric (also known as the hamming distance), which simply counts the
number of descriptive features that have different values. Using this measure of
distance, compute the distances between the mystery animal and each of the animals
in the animal dataset.
b. If you used a 1-NN model, what class would be assigned to the mystery animal?
c. If you used a 4-NN model, what class would be assigned to the mystery animal?
Would this be a good value for k for this dataset?
✻ 6. You have been asked by a San Francisco property investment company to
create a predictive model that will generate house price estimates for properties they
are considering purchasing as rental properties. The table below lists a sample of
properties that have recently been sold for rental in the city. The descriptive features in
this dataset are SIZE (the property size in square feet) and RENT (the estimated monthly
rental value of the property in dollars). The target feature, PRICE, lists the prices that
these properties were sold for in dollars.
ID SIZE RENT PRICE
1 2,700 9,235 2,000,000
2 1,315 1,800 820,000
3 1,050 1,250 800,000
4 2,200 7,000 1,750,000
5 1,800 3,800 1,450,500
6 1,900 4,000 1,500,500
7 960 800 720,000
a. Create a k-d tree for this dataset. Assume the following order over the features:
RENT then SIZE.
b. Using the k-d tree that you created in the first part of this question, find the nearest
neighbor to the following query: SIZE = 1,000, RENT = 2,200.