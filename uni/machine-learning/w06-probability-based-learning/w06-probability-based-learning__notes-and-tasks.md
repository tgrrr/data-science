## Notes on Entropy:

![Summation_-_Wikipedia](/assets/Summation_-_Wikipedia.jpg)
https://en.wikipedia.org/wiki/Summation

doing Sigma sum above

log(2)   = 0.30103

log2(12) = log(12)÷log(2)
         = 1.07918÷0.30103 
         = 3.584958


So from the lectures on cards:

log<sub>2</sub>(0.019)
= log(0.019) / log<sub>2</sub> 
=log(0.019)/0.30103
= -5.717856689


___________________________

## Problem 1: (30 points) 

You are given the dataset below with three descriptive features (Smoker, Obese, Family) with Risk being the target feature.

![midsemester--ML_2018_pdf__page_1_of_4_](/assets/midsemester--ML_2018_pdf__page_1_of_4_.jpg)

### A) (5 points) 
What is the **total entropy** of this dataset?



### B) (20 points) 
Which one of the two descriptive features would you split at the root node if you are to use the **Information gain split** criterion: Family or Smoker? Show all your work.

### C) (5 points) 
Suppose you decided to split on the Obese variable and you decided to make only **one split at the root node**. Draw the corresponding **decision tree** and **label the predictions** made at each one of the leaf nodes.

______________________________________________________________


## Problem 2: (20 points) 

- binary: bought/not bought

You would like to build a **recommender system** for a large online shop that has a stock of over thousands of items. In this domain, the behavior of customers is captured in terms of what items they have bought or not bought. For example, the following table lists the behavior of three customers in this domain for a subset of four items.

#### A) (5 points) 
The company has decided to use a **similarity-based model** to implement the recommender system. Which of the following **three similarity indexes** do you think the system should be based on and why? Explain your choice in no more than one sentence.

Answer: ==Russel Rao==, because they want to include what is not bought, and the other models do not account for **co-absence**
> the behavior of customers is captured in terms of what items they have bought or not bought

TODO: formulas
- **Russel-rao(x, y)** = ratio of co-presence / total binary
- **Sokal-Michiner(x, y)** = ratio of co-presence and co-absence / total binary
- **Jaccard(x,y)** = ignores co-absence altogether

![midsemester--ML_2018_pdf__page_2_of_4_](/assets/midsemester--ML_2018_pdf__page_2_of_4_.jpg)



#### B) (15 points) What items will the system recommend to the following customer?

- Assume that the recommender system uses the Russel-Rao similarity index and the system is trained on the sample dataset with three observations listed above. 
- Also assume that the system generates recommendations by
  - **recommending the items that the most similar customer has bought** 
  - but that the **query customer has not bought**.
- Finally, assume that ties are broken by selecting the customer with the highest number of purchases. Show all your work for full credit.

**What would happen with this customer? #4**

Shorter version:

Russel-Rao(X,Y) = CP / P = Copresence / total

P = 4

#### d1
CP = 2
Russel-Rao(X,Y) = 2/4 = 0.5

#### d2
CP = 1

Russel-Rao(X,Y) = 1/4 = 0.25

#### d3
CP = 3
Russel-Rao(X,Y) = 2/4 = 0.75

Therefore: **d3 is most similar**

Which items would the system recommend?
**Item #2**
because Item #1, #3, #4 have been bought by both `d3` and `Q`

(Q)uery | Item 1 | Item 2 | Item 3 | Item 4
--------|--------|--------|--------|-------
4       | True   | False  | True   | True


(D)ataset | Item 1 | Item 2 | Item 3 | Item 4
----------|--------|--------|--------|-------
1         | True   | False  | True   | False
2         | True   | False  | False  | False
3         | True   | True   | True   | True

#### d1

CP: Co-presence: x2 (item #1, #3)
CA: Co-absence: x1 (item #2)
PA: presence(q)absense(d) = 1 (item #4)
==NOTE: NOT alphabetical d->q==
AP: absense(q)presence(d) = 0

| dataset           |          | >                  | q               |
| ----------------- | -------- | ------------------ | --------------- |
|                   |          | presence           | absence         |
| **d<sub>1</sub>** | presence | CP = 2 (item 1, 3) | PA = 0          |
| ^                 | absence  | AP = 1 (item 4)    | CA = 1 (item 2) |


#### d2

CP: Co-presence: x1 (item #1)
CA: Co-absence: x1 (item #2)
PA: presence(q)absense(d) = 2 (item #3, #4)
AP: absense(q)presence(d) = 0 ()

| dataset           |          | >                | q                    |
| ----------------- | -------- | ---------------- | -------------------- |
|                   |          | presence         | absence              |
| **d<sub>1</sub>** | presence | CP = 1 (item #1) | PA = 2 (item #3, #4) |
| ^                 | absence  | AP = 0           | CA = 1 (item #2)     |

#### d3

CP: Co-presence: x2 (item #1 #3)
CA: Co-absence: x1 (item #2)
PA: presence(q)absense(d) = 1 (item #2)
AP: absense(q)presence(d) = 0

| dataset           |          | >             | q                |
| ----------------- | -------- | ------------- | ---------------- |
|                   |          | presence      | absence          |
| **d<sub>1</sub>** | presence | CP = 2 (item) | PA = 1 (item #2) |
| ^                 | absence  | AP = 0        | CA = 1 (item #2) |




  

| dataset           |          | >        | q       |
| ----------------- | -------- | -------- | ------- |
|                   |          | presence | absence |
| **d<sub>1</sub>** | presence | CP =     | PA =    |
| ^                 | absence  | AP =     | CA =    |



**(empty copy)**

| dataset           |          | >        | q       |
| ----------------- | -------- | -------- | ------- |
|                   |          | presence | absence |
| **d<sub>1</sub>** | presence | CP =     | PA =    |
| ^                 | absence  | AP =     | CA =    |
