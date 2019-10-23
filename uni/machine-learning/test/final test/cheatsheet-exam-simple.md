---
id: "my-id"
class: "my-class1 my-class2"
---

@import "cheatsheetstylesimple.less"

```math
Entropy\enskip H(t)=-\sum_{i=1}^{1}\left(P(t=i) \times \log _{2}(P(t=i))\right)
```

▶`P(t=i)` is probability that random element t is type i
▶`l` level is number of different types of t, and 
▶`s` is arbitrary. Normally = 2 for calculating bits

```math
Entropy of partition\enskip H(t,D)=-\sum _{ l\; \epsilon \; levels(t) }^{ l } \left( Pr(t=l)\times \log _{ 2 } (Pr(t=l)) \right) 
```
```math
rem(d,D)=\enskip +\sum _{ l\; \epsilon \; levels(d) }^{ l } \underbrace { \frac { \left| { D }_{ d=l } \right|  }{ \left| D \right|  }  }_{ weighting } \times \enskip \underbrace { H(t,\enskip { D }_{ d=l }) }_{ entropy\, of\, \\ partition\, { D }_{ d=l } } 
```
```math
Information Gain: IG(d,\mathcal{D})=H(t,\mathcal{D})-\operatorname{rem}(d,\mathcal{D})
```
```math
IG ratio: GR(t,\mathcal{D}) = { \frac { IG(d,\mathcal{D})  }{ H(t,\mathcal{D})  }  }
```
```math
gini(t,D)=1\, -\sum _{ l\; \epsilon \; levels(t) }^{ l } \underbrace { { Pr(t=l) }^{ 2 } }_{ ~old_todo~ }=1\, -\sum _{ l\; \epsilon \; \left\{ \begin{matrix} 'chapparian' \\ 'riparian' \\ 'conifer' \end{matrix} \right\}  }^{ l } \underbrace { { Pr(t=l) }^{ 2 } }_{ ~old_todo~ } \\ =1-\left( { \frac { 3 }{ 7 }  }^{ 2 }+{ \frac { 2 }{ 7 }  }^{ 2 }+{ \frac { 2 }{ 7 }  }^{ 2 } \right) \ =0.653
```
▶==NOTE: NOT alphabetical d->q== AP: absense(q) presence(d)=0
| dataset           |          | >        | q       |
| ----------------- | -------- | -------- | ------- |
|                   |          | presence | absence |
| **d<sub>1</sub>** | presence | CP = 2   | PA = 0  |
| ^                 | absence  | AP = 1   | CA = 1  |

▶**Russel-Rao(x,y)**: ${ Sim }_{ RR }(q,d)=\cfrac { CP(q,d) }{ \left| q \right|  } =\frac { ratio\enskip of\enskip co-presence }{ totalbinary }$

▶**Sokal-Michener(x,y)**: ${ Sim }_{ SM }(q,d)\enskip =\enskip \cfrac { CP(q,d)\enskip +\enskip CA(q,d) }{ \left| q \right|  } =\frac {  co-presence\enskip  and\enskip co-absence\enskip }{ totalbinary ratio} $

▶**Jaccard**: ${ Sim }_{ J }(q,d)= \cfrac { CP(q,d) }{ CP(q,d)+PA(q,d)+AP(q,d) } \enskip ignores\enskip coabsence\enskip altogether$

▶ $\text {Euclidean}(\mathbf{a}, \mathbf{b})=\sqrt{\sum_{i=1}^{m}(\mathbf{a}[i]-\mathbf{b}[i])^{2}}$

▶ $\operatorname{Minkowski}(\mathbf{a}, \mathbf{b})=\left(\sum_{i=1}^{m} a b s(\mathbf{a}[i]-\mathbf{b}[i])^{p}\right)^{\frac{1}{\rho}}$

▶ $\text {Manhattan}(\mathbf{a}, \mathbf{b})=\sum_{i=1}^{m} \operatorname{abs}(\mathbf{a}[i]-\mathbf{b}[i])$

Eg. `k = 3` <- count 3 look at 3 nearest-neigbours

| Neural Network                      | Decision Tree                           |
| ----------------------------------- | --------------------------------------- |
| lazy learner                        | Eager learners                          |
|                                     | underlying process is relatively stable |
| if adding new obs. to training data | do not want to continuously retrain     |
|                                     | If irrelevant descriptive features      |
| noisy data                          | noisy data                              |
| ~old_todo~ if concept drift              | want fast predictions                   |
| ^                                   | OR large number of observations         |
| if numeric data                     | if mix of numeric & categorical         |
| ^                                   | && want minimise preprocessing          |

▶ Decision trees

- choose the majority when splitting decision tree roots
- ==~old_todo~== don't forget equality! huh?
- prefer shallower trees & less tests
- by splitting into pure sets (aka groups) of T/F
- measured with _entropy_ in bits
- entropy = measure of impurity of a sets
- higher probability = lower entropy

$Nearest neighbour \mathbb{M}_{k}(\mathbf{q})=\underset{l \in \text {lelevels}(t)}{\operatorname{argmax}} \sum_{i=1}^{k} \delta\left(t_{i}, l\right)$

$Weighted Neighest Neighbour \mathbb{M}_{k}(\mathbf{q})=\underset{l \in \operatorname{levels}(t)}{\operatorname{argmax}} \sum_{i=1}^{k} \frac{1}{\operatorname{dist}\left(\mathbf{q}, \mathbf{d}_{\mathbf{i}}\right)^{2}} \times \delta\left(t_{i}, I\right)$

==~old_todo~==
$Normalisation a_{i}^{\prime}=\frac{a_{i}-\min (a)}{\max (a)-\min (a)} \times(h i g h-l o w)+l o w$

```math
\text { average class accuracy }_{\mathrm{HM}}=\frac{1}{\frac{1}{\text | {levels}(t) |} \sum_{\text {lelevels}(t)} \frac{1}{\text {recall}_{l}}}
```

▶ Misclassification

- determine suitable model, estimate performance, convince users
- misclassification rate = incorrect predictions (count/number of) / total predictions

**misclassification** accuracy = (FP + FN)/(TP+TN+FP+FN) = (2 + 3)/(6+9+2+3) = 0.25
**classification** accuracy = (TP+TN)/(TP+TN+FP+FN) = (6 + 9)/(6+9+2+3) = 0.7

▶ Evaluation

- **Hold-out sampling** = divide data into training + validation + test sets
- because: avoid overfitting
- ! The data used to evaluate must be different than training
- **K-fold:** - not enough data, reduce a lucky split (difficult in training, easy in test set)
- **LOOCV (Leave-one-out cross validation)** - not enough data for kfold

| >      | >             | >    | >               | >                          | Prediction                  |
| ------ | ------------- | ---- | --------------- | -------------------------- |:---------------------------:|
| Target | &nbsp;        | Pos+ | Neg-            | >                          | **Recall** TP/(TP+FN) = 4/5 |
| ^      | Pos +         | TP   | FN              | **TPR** $\frac{TP}{TP+FN}$ |   FNR $\frac{FN}{TP+FN}$    |
| ^      | Neg -         | FP   | TN              | **TNR** $\frac{TN}{TN+FP}$ |   FPR  $\frac{FP}{TN+FP}$   |
| ^      | **Precision** | >    | =TP/(TP+FP)=3/4 |                            |                             |

```math
{ \text { average class accuracy } }=\frac { 1 }{ |{ levels }(t)| } \sum _{ l\in levels(t) }{ recall } _{ l }
```

```math
\text { harmonic mean average class accuracy }_{\mathrm{HM}}=\frac{1}{\frac{1}{\text | {levels}(t) |} \sum_{\text {lelevels}(t)} \frac{1}{\text {recall}_{l}}}
```
Levels: `0.1 - 0.25` warrants investigation, `> 0.25` unaceptable

**F1** measure: harmonic mean of precision and recall $F₁ = 2×\frac{precision×recall}{precision+recall}$

==~old_todo~== average class accuracy=1/∣levels(t)∣∣∑lϵlevels(t)recall

▶ ROC - Higher ROC -> Better model

```math
\text { ROC Index }\mathrm=\sum_{i=2}^{|T|} \frac{(F P R(T[i])-F P R(T[i-1])) \times((T P R(T[i])+T P R(T[i-1]))}{2}
\\ \text { T is set of thresholds |T| = \#thresholds tested}
\\ \text { FRP(T[i]) = rate at threshold i}
```

- Receiver Operating Characteristic
- ROC index - measures area under ROC curve (AUC)
  - higher AUC is better: 97% -> make right decision 97% of time (if we present one true, and one false) < 0.6 is weak > 0.7 strong
  - Fixes class imbalance problem
- `Gini coefficient = (2xROC index) - 1`
- Threshold: as the threshold increases TPR decreases and TNR increases (and vice versa)

▶ ~old_todo~ Staby Index
```math
\text {staby index }\sum _{ { lelevels }(t) } \left( \left( \frac { \left| { A }_{ t=l } \right|  }{ |{ A }| } -\frac { \left| { B }_{ t=l } \right|  }{ |{ B }| }  \right) \times \ln { \left( \frac { \left| { A }_{ t=l } \right|  }{ |{ A }| } /\frac { \left| { B }_{ t=l } \right|  }{ |B| }  \right)  }  \right) =\sum _{ { lelevels }(t) } \left( \left( \frac { 123 }{ 443 } -\frac { 252 }{ 948 }  \right) \times \ln { \left( \frac { 123 }{ 443 } /\frac { 252 }{ 948 }  \right)  }  \right)
```

▶ ==~old_todo~== Bayes theorum
```math
\text {Bayes}=P(X | Y)=\frac{P(Y | X) P(X)}{P(Y)}=P(d | t)=\frac{P(t | d) P(d)}{P(t)}
```
```math
\begin{array}{l}{\text { Generalised Bayes Theorem: }} \\ {P(t=l | q[1], \ldots, q[m])=\frac{P(q[1], \ldots, q[m] | t=l) P(t=l)}{p(q[1], \ldots, q[m])}}\end{array}```
```

${\text {Chain rule: }}P(q[1], \ldots, q[m]) \times P(q[2] | q[1]) \times \ldots \times P(q[m] | q[m-1], \ldots, q[2], q[1])$

▶ Naïve Bayes’ Classifier: 
  
```math
\mathbb{M}(q)=\underset{l \text { elevelst) }}{\operatorname{argmax}}\left(\prod_{i=1}^{m} P(q[i] | t=l)\right) \times P(t=l)
```

▶ Laplacian Smoothing (conditional probabilities)

> Smoothing takes some of the probability from the events with lots of the probability share and gives it to the other probabilities in the set.

```
eg. for k = 3
Pr(GC = none|¬fr) = 12+3/ ( 14+(3*3) )
Pr(GC = guarantor|¬fr) = 0+3/ ( 14+(3*3) )
Pr(GC = coapplicant|¬fr) = 2+3/ ( 14+(3*3) )
```

```math
P(f=v | t)=\frac{\operatorname{count}(f=v | t)+k}{\operatorname{count}(f | t)+(k \times|\operatorname{Domain}(f)|)}
```
```math
\text { Sum of squared errors }=\frac{1}{2} \sum_{i=1}^{n}\left(t_{i}-\mathbb{M}\left(d_{i}\right)\right)^{2}
```
```math
\text { Mean squared error }=\frac{\sum_{i=1}^{n}\left(t_{i}-\mathbb{M}\left(d_{i}\right)\right)^{2}}{n}
```
```math
\text {Root } M S E=\sqrt{M S E}
```
```math
{ meanabsoluteerror }=\frac { \sum _{ i=1 }^{ n }{ abs } \left( t_{ i }-{ M }\left( { d }_{ i } \right)  \right)  }{ n } 
```
```math
\begin{matrix} Sum\enskip of\enskip squared\enskip errors\enskip =\enskip \frac { 1 }{ 2 } \sum _{ i=1 }^{ n } \left( t_{ i }-{ M }\left( d_{ i } \right)  \right) ^{ 2 } \\ =\frac { 1 }{ 2 } \sum _{ i=1 }^{ n } \left( true\enskip target\enskip feature\enskip value_{ i }-\enskip model's\enskip prediction \right) ^{ 2 } \end{matrix}
```
```math
R^{2}=1-\frac{\text { sum of squared errors }}{\text { total sum of squares }}
```

▶ Definitions
**Inductive Bias** = The set of assumptions that defines the model selection criteria of a ML algorithms
##### Model Ensembles
**Boosting** 

- = New _model biased_ to pay more attention to instances that _previous models misclassified_
- uses a weighted dataset
**Bagging** (_aka boostrap aggregating_) 
- each model in ensemble is _trained on random sample of dataset_
- _sampling with replacement_ is used
- each sample, therefore each model is different

**Machine learning** is an _ill-posed problem_
**supervised vs unsupervised**: unsupervised => no target (aka response variable)