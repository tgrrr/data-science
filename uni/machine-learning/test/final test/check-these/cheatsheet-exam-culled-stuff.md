

#### Final Cheatsheet: ready

- TODO: supervised vs unsupervised:
  unsupervised => no target (aka response variable)

## TODO: Examples of each formula

## Formulas:
**Entropy** 
```math
H(t)=-\sum_{i=1}^{1}\left(P(t=i) \times \log _{2}(P(t=i))\right)
```
eg. Probability of card = 0.019 (1/52)
= -Sum(Pr(0.019) * log2(Pr(0.019))) = 5.7 bits

- [ ] **Entropy of Partition**
```math
H(t,D)=-\sum _{ l\; \epsilon \; levels(t) }^{ l } \left( Pr(t=l)\times \log _{ 2 } (Pr(t=l)) \right) 
```
#### Eg. Family Partition Entropy
= - Pr(t(low) = yes) x log2(Pr(t(low) = yes)) +
Pr(t(low) = no) x log2(Pr(t(low) = no)) + 
Pr(t(high) = yes) x log2(Pr(t(high) = yes)) +
Pr(t(high) = no) x log2(Pr(t(high) = no))
= - 1/2 * log2(1/2) + 
1/2 * log2(1/2) +
2/3 * log2(2/3) +
1/3 * log2(1/3)
= 1.918

- [ ] **REM** Remainder
```math
rem(d,D)=\quad +\sum _{ l\; \epsilon \; levels(d) }^{ l } \underbrace { \frac { \left| { D }_{ d=l } \right|  }{ \left| D \right|  }  }_{ weighting } \times \quad \underbrace { H(t,\quad { D }_{ d=l }) }_{ entropy\, of\, \\ partition\, { D }_{ d=l } } 
```
**Eg.**
Get fraction of answers that will be true vs false from col
Fraction of those that True -> spam 
& fraction that true -> ham
Fraction that false -> spam + fraction goes to ham 
- Do log above to it

```math
Information Gain: IG(d,\mathcal{D})=H(t,\mathcal{D})-\operatorname{rem}(d,\mathcal{D})
```
```math
IG ratio: GR(t,\mathcal{D}) = { \frac { IG(d,\mathcal{D})  }{ H(t,\mathcal{D})  }  }
```
==TODO:==
```math
gini(t,D)=\quad 1\, - \sum _{ l\; \epsilon \; levels(t) }^{ l } \underbrace { { Pr(t=l) }^{ 2 } }_{ TODO } 
```
**Eg.**
- Gini index = how often misclassify an instance in a dataset
  - if you classified it based on the distribution of the classification in the dataset

```mermaid
graph LR;
    id1(entropy of a dataset forget variables)-->id2
    id2["entropy of partition"]-->id3
    id3["rem"]-->id4
    id4["information gain"]-->id5
    id5["split by highest IG"]
    id6["rinse and repeat"]
    id1 --> id6
```

- choose the majority when splitting decision tree roots
- TODO: don't forget equality!
- **Inductive Bias** = The set of assumptions that defines the model selection criteria of a ML algorithms

==TODO:== ID3 algorithms
1. choosing the best descriptive feature to test using IG
2. Add root node to tree labelled with selected test
3. Partition data using this feature
4. Rinse and repeat (exclude previous data)

## Model Ensembles

**Boosting** = New model biased to pay more attention to instances that previous models misclassified
  - uses a weighted dataset

**Bagging** = each model in ensemble is trained on random sample of dataset
  - sampling with replacement is used
  - each sample, therefore each model is different
  - aka boostrap aggregating

### Co-presence / Co-absence Formulas

| dataset           |          | >        | q       |
| ----------------- | -------- | -------- | ------- |
|                   |          | presence | absence |
| **d<sub>1</sub>** | presence | CP = 2   | PA = 0  |
| ^                 | absence  | AP = 1   | CA = 1  |

==NOTE: NOT alphabetical d->q==
AP: absense(q)presence(d) = 0

#### Formulas
- **Russel-Rao**: ${ Sim }_{ RR }(q,d)\quad =\quad \cfrac { CP(q,d) }{ \left| q \right|  } \quad $
- **Russel-rao(x, y)** = ratio of co-presence / total binary

- **Sokal-Michener**: ${ Sim }_{ SM }(q,d)\quad =\quad \cfrac { CP(q,d)\quad +\quad CA(q,d) }{ \left| q \right|  } \quad $
- **Sokal-Michiner(x, y)** = ratio of co-presence and co-absence / total binary

- **Jaccard**: ${ Sim }_{ J }(q,d)= \cfrac { CP(q,d) }{ CP(q,d)+PA(q,d)+AP(q,d) }$
- **Jaccard(x,y)** = ignores co-absence altogether

- [ ] $\text {Euclidean}(\mathbf{a}, \mathbf{b})=\sqrt{\sum_{i=1}^{m}(\mathbf{a}[i]-\mathbf{b}[i])^{2}}$
- [ ] $\operatorname{Minkowski}(\mathbf{a}, \mathbf{b})=\left(\sum_{i=1}^{m} a b s(\mathbf{a}[i]-\mathbf{b}[i])^{p}\right)^{\frac{1}{\rho}}$

- [ ] Manhattan distance ==TODO:==

| Neural Network                      | Decision Tree                           |
| ----------------------------------- | --------------------------------------- |
| lazy learner                        | Eager learners                          |
|                                     | underlying process is relatively stable |
| if adding new obs. to training data | do not want to continuously retrain     |
|                                     | If irrelevant descriptive features      |
| noisy data                          | noisy data                              |
| TODO: if concept drift              | want fast predictions                   |
| ^                                   | OR large number of observations         |
| if numeric data                     | if mix of numeric & categorical         |
| ^                                   | && want minimise preprocessing          |


**Log using calculator** = `log(x)/ log(2)`
**Eg.** Log<sub>2</sub>(0.19) = log(0.19)/log(2)
___________________________

```mermaid
graph TB;
    rootNode["Root"]
    interior1["Interior Node"]
    interior2[" "]
    leaf1["terminating node"]
    leaf2[" "]
    leaf3[" "]
    leaf4[" "]
    key["orange path = predicted classification for query"]

    note1['prefer shallower trees & less tests']
    note2["by splitting into pure sets (aka groups) of T/F"]
    note3['measured with _entropy_ in bits']
    note4["entropy = measure of impurity of a sets"]
    note5["higher probability = lower entropy"]

    rootNode-->interior1
    rootNode-->interior2
    interior1-->leaf1
    interior1-->leaf2
    interior2-->leaf3
    interior2-->leaf4
    note1---note2
    note2---note3
    note3---note4
    note4---note5
    
    style rootNode fill:#f4aa42,stroke:#333,stroke-width:4px
    style interior1 fill:#f4aa42,stroke:#333,stroke-width:4px
    style leaf1 fill:#f4aa42,stroke:#333,stroke-width:4px
    style key fill:#f4aa42,stroke:#333,stroke-width:4px
```