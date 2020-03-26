practice exam @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
___________________________


# ~old_todo~
[ ] Chapter 1
[ ] Chapter 4
[ ] Chapter 5

## Practice Test:

## Problem 1: (30 points) 

- [ ] a. total entropy
  = measure length of paths. Eg. 1 path is 3 Questions long, 

You are given the dataset below with three descriptive features (Smoker, Obese, Family) with Risk being the target feature.

### A) (5 points) 
What is the **total entropy** of this dataset?

**Entropy** 
```math
H(t)=-\sum_{i=1}^{1}\left(P(t=i) \times \log _{2}(P(t=i))\right)
```

= - (Pr(t = low) log2(Pr(t = low))) 
  \+ (Pr(t = high) + log2(Pr(t = high)))
= - 2/5 * log2(2/5) + 3/5 * log2(3/5)
= - 0.52877+ -0.44217 = 0.95047


### B) (20 points) 
Which one of the two descriptive features would you split at the root node if you are to use the **Information gain split** criterion: Family or Smoker? Show all your work.

```math
IG(d,\mathcal{D})=H(t,\mathcal{D})\operatorname{rem}(d,\mathcal{D})
```

```math
H(t,D)=-\sum _{ l\; \epsilon \; levels(t) }^{ l } \left( Pr(t=l)\times \log _{ 2 } (Pr(t=l)) \right) 
```
#### Family Partition Entropy
= - Pr(t(low) = yes) x log2(Pr(t(low) = yes)) +
Pr(t(low) = no) x log2(Pr(t(low) = no)) + 
Pr(t(high) = yes) x log2(Pr(t(high) = yes)) +
Pr(t(high) = no) x log2(Pr(t(high) = no))
= - 1/2 * log2(1/2) + 
1/2 * log2(1/2) +
2/3 * log2(2/3) +
1/3 * log2(1/3)
= 1.918

![midsemester--ML_2018_pdf__page_1_of_4_](/assets/midsemester--ML_2018_pdf__page_1_of_4_.jpg)
Family Partition Entropy

#### Obese Partition Entropy
= - Pr(t(low) = yes) x log2(Pr(t(low) = yes)) +
Pr(t(low) = no) x log2(Pr(t(low) = no)) + 
Pr(t(high) = yes) x log2(Pr(t(high) = yes)) +
Pr(t(high) = no) x log2(Pr(t(high) = no))
= - 1/2 * log2(1/2) + 
1/2 * log2(1/2) +
2/3 * log2(2/3) +
1/3 * log2(1/3)




### C) (5 points) 
Suppose you decided to split on the Obese variable and you decided to make only **one split at the root node**. Draw the corresponding **decision tree** and **label the predictions** made at each one of the leaf nodes.


1. 
  [ ] b. Which feature would you split at the node if you used the info gain?
  [ ] c. draw a decision tree
    [ ] label predictions
  
2. Which model to choose? Rusell, Sokal, Jaccard?
  [ ] a. Summarise detailed below
  [ ] b. Summarise detailed below

3.   

------------------  

# Detailed answers:

Source: [detailed notes on this question](../w06-probability-based-learning/w06-probability-based-learning__notes-and-tasks.md)


## Problem 1: (30 points) 
see above

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

~old_todo~ formulas
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
**Customer #2**
because Item #1, #3, #4 have been bought by both `d3` and `Q`

(Q)uery | Item 1 | Item 2 | Item 3 | Item 4
--------|--------|--------|--------|-------
4       | True   | False  | True   | True


(D)ataset | Item 1 | Item 2 | Item 3 | Item 4
----------|--------|--------|--------|-------
1         | True   | False  | True   | False
**2**         | True   | False  | False  | False
3         | True   | True   | True   | True

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


