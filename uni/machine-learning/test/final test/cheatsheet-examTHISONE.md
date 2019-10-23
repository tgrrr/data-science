---
id: "my-id"
class: "my-class1 my-class2"
---

==~old_todo~==

- ! Draw binary classifier box
- ROC curve ch8 q3
- Bayes Theorum
  - k-NN model vs Native Bayes Model see ch8b
- ~old_todo~'s in untitled

profit matrix

Later tonight:
- css print fix <!-- @import "cheatsheetstyle.less" -->
- turn into snippets

  - [ ] ~old_todo~ Chapter 4 (Information-based learning): Problems 2, 3, 4
  - [ ] ~old_todo~ Chapter 5 (Similarity-based learning): Problems 1, 2, 5
    - [ ] ~old_todo~ including Feature Selection (5.4.6)
  - [ ] ~old_todo~ Chapter 6 (Probability-based learning): Problems 2, 5, 6
  - [ ] ~old_todo~ Chapter 8 (Evaluation): Exercises 1, 2, 3, 4

  ### Chapters covered by the final exam:
    - [ ] Chapter 1
    - [ ] Chapter 4
    - [ ] Chapter 5
    - [ ] Chapter 6
    - [ ] Chapter 8
    - [ ] Chapter 11 (subject to the exclusions above)

  ### Deathlist

    - [ ] ~old_todo~ Add final test solutions
    - [ ] ~old_todo~ Check each chapter pdf and summarise
    - [ ] ~old_todo~ The check-these folder

<details id='lefty'>
  <summary>
    Entropy
  </summary>
  <br><p id='righty'>

  eg. Probability of card = 0.019 (1/52)
  ==~old_fixme~== example for every _level_ 
  = -Sum(Pr(suit) * log₂(Pr(suit)))
  = ==-== Pr(♡) * log₂(Pr(♡) +
      Pr(♧) * log₂(Pr(♧) +
      Pr(♢) * log₂(Pr(♢) +
      Pr(♤) * log₂(Pr(♤)
  = (1/4 * log₂(1/4)) * 4  <- log(1/4, 2) # <- syntax for log₂(1/4)
  > -1.3862943611198906

  = 5.7 bits

  `P(t=i)` is probability that random element t is type i
  `l` level is number of different types of t, and 
  `s` is arbitrary. Normally = 2 for calculating bits
</p></details>

```math
Entropy\enskip H(t)=-\sum_{i=1}^{1}\left(P(t=i) \times \log _{2}(P(t=i))\right)
```

<details>
  <summary>
    Entropy of Partition
  </summary>
  <br>

  **Eg. Family Partition Entropy**

  ```
  = - Pr(t(low) = true) x log₂(Pr(t(low) = true)) +
      Pr(t(low) = false) x log₂(Pr(t(low) = false)) + 
      Pr(t(high) = true) x log₂(Pr(t(high) = true)) +
      Pr(t(high) = false) x log₂(Pr(t(high) = false))
  = - 1/2 * log₂(1/2) + 
      1/2 * log₂(1/2) +
      2/3 * log₂(2/3) +
      1/3 * log₂(1/3)
  =   1.918
  ```
  **order of operation:**
  ```mermaid
  graph LR;
      id1("entropy of a dataset LEVELS (forget variables)")-->id2
      id2["entropy of EACH partition"]-->id3
      id3["rem"]-->id4
      id4["information gain"]-->id5
      id5["split by highest IG"]
      id6["rinse and repeat"]
      id1 --> id6
  ```
</details>

```math
Entropy of partition\enskip H(t,D)=-\sum _{ l\; \epsilon \; levels(t) }^{ l } \left( Pr(t=l)\times \log _{ 2 } (Pr(t=l)) \right) 
```

<details>
  <summary>
    REM Remainder
  </summary>
  <br />

  ==~old_todo~ Eg.==
  How:

  - Get fraction of answers that will be true vs false from col
  - Fraction of those that True -> spam 
  - & fraction that true -> ham
  - Fraction that false -> spam + fraction goes to ham 
  - Do log above to it
</details>

```math
rem(d,D)=\enskip +\sum _{ l\; \epsilon \; levels(d) }^{ l } \underbrace { \frac { \left| { D }_{ d=l } \right|  }{ \left| D \right|  }  }_{ weighting } \times \enskip \underbrace { H(t,\enskip { D }_{ d=l }) }_{ entropy\, of\, \\ partition\, { D }_{ d=l } } 
```

```math
Information Gain: IG(d,\mathcal{D})=H(t,\mathcal{D})-\operatorname{rem}(d,\mathcal{D})
```
```math
IG ratio: GR(t,\mathcal{D}) = { \frac { IG(d,\mathcal{D})  }{ H(t,\mathcal{D})  }  }
```

<details>
  <summary>
    Gini Index
    </summary>
  <br>
    = how often misclassify an instance in a dataset
    - if you classified it based on the distribution of the classification in the dataset
</details>

```math
gini(t,D)=1\, -\sum _{ l\; \epsilon \; levels(t) }^{ l } \underbrace { { Pr(t=l) }^{ 2 } }_{ ~old_todo~ }=1\, -\sum _{ l\; \epsilon \; \left\{ \begin{matrix} 'chapparian' \\ 'riparian' \\ 'conifer' \end{matrix} \right\}  }^{ l } \underbrace { { Pr(t=l) }^{ 2 } }_{ ~old_todo~ } \\ =1-\left( { \frac { 3 }{ 7 }  }^{ 2 }+{ \frac { 2 }{ 7 }  }^{ 2 }+{ \frac { 2 }{ 7 }  }^{ 2 } \right) \ =0.653
```

### Co-presence / Co-absence
==NOTE: NOT alphabetical d->q== AP: absense(q) presence(d)=0
| dataset           |          | >        | q       |
| ----------------- | -------- | -------- | ------- |
|                   |          | presence | absence |
| **d<sub>1</sub>** | presence | CP = 2   | PA = 0  |
| ^                 | absence  | AP = 1   | CA = 1  |

**Russel-Rao(x,y)**: ${ Sim }_{ RR }(q,d)=\cfrac { CP(q,d) }{ \left| q \right|  } =\frac { ratio\enskip of\enskip co-presence }{ totalbinary }$

**Sokal-Michener(x,y)**: ${ Sim }_{ SM }(q,d)\enskip =\enskip \cfrac { CP(q,d)\enskip +\enskip CA(q,d) }{ \left| q \right|  } =\frac {  co-presence\enskip  and\enskip co-absence\enskip }{ totalbinary ratio} $

**Jaccard**: ${ Sim }_{ J }(q,d)= \cfrac { CP(q,d) }{ CP(q,d)+PA(q,d)+AP(q,d) } \enskip ignores\enskip coabsence\enskip altogether$

$\text {Euclidean}(\mathbf{a}, \mathbf{b})=\sqrt{\sum_{i=1}^{m}(\mathbf{a}[i]-\mathbf{b}[i])^{2}}$

$\operatorname{Minkowski}(\mathbf{a}, \mathbf{b})=\left(\sum_{i=1}^{m} a b s(\mathbf{a}[i]-\mathbf{b}[i])^{p}\right)^{\frac{1}{\rho}}$

$\text {Manhattan}(\mathbf{a}, \mathbf{b})=\sum_{i=1}^{m} \operatorname{abs}(\mathbf{a}[i]-\mathbf{b}[i])$

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


<details>
  <summary>
    Decision trees
    </summary>
  <br>
  - choose the majority when splitting decision tree roots
  - ==~old_todo~== don't forget equality! huh?
  - prefer shallower trees & less tests
  - by splitting into pure sets (aka groups) of T/F
  - measured with _entropy_ in bits
  - entropy = measure of impurity of a sets
  - higher probability = lower entropy
</details>

$Nearest neighbour \mathbb{M}_{k}(\mathbf{q})=\underset{l \in \text {lelevels}(t)}{\operatorname{argmax}} \sum_{i=1}^{k} \delta\left(t_{i}, l\right)$

$Weighted Neighest Neighbour \mathbb{M}_{k}(\mathbf{q})=\underset{l \in \operatorname{levels}(t)}{\operatorname{argmax}} \sum_{i=1}^{k} \frac{1}{\operatorname{dist}\left(\mathbf{q}, \mathbf{d}_{\mathbf{i}}\right)^{2}} \times \delta\left(t_{i}, I\right)$

==~old_todo~==
$Normalisation a_{i}^{\prime}=\frac{a_{i}-\min (a)}{\max (a)-\min (a)} \times(h i g h-l o w)+l o w$

<div class='clearfix'>
<details>
  <summary>
    Practice Evaluation: (ch8pt1)
    </summary>
  <br>

  ### eg ch8 q1:

  #### 1a. Confusion matrix:

  | `confusionMatrix` | >       | >      | Prediction |
  | ----------------- | ------- | ------ | ---------- |
  | >                 | &nbsp;  | `true` | `false`    |
  | Target            | `true`  | TP=8   | FN=1       |
  | ^                 | `false` | FP=0   | TN=11      |

  #### 1a. Misclassification rate

    misclassification rate = incorrect predictions (count) / total predictions

    **misclassification** accuracy
    = (FP + FN)/(TP+TN+FP+FN)
    = (0 + 1)/(20) = 1/20 = 0.05

  #### 1b. Average Class Accuracy (harmonic mean)

    - Recall<sub>true</sub> = TP/(TP+FN)
    - Recall<sub>true</sub> = 
    8/(8 + 1) 
    > 0.8888888888888888 = 0.89

    - Recall<sub>false</sub> = TN/(TN+FP)
    - Recall<sub>false</sub> = 
    11/(11+0) 
    > 1

    ```math
    \text { average class accuracy }_{\mathrm{HM}}=\frac{1}{\frac{1}{\text | {levels}(t) |} \sum_{\text {lelevels}(t)} \frac{1}{\text {recall}_{l}}}
    ```

    - ACA<sub>hm</sub> = 
    1/( (1/2) * (1/0.89 + 1/1) )
    > 0.9417989417989417

  ### 1c.

  #### Precision

  $precision = \frac{TP}{TP+FP}$ = 
  8 / (8 + 0)
  > 1

  #### Recall

  - Recall<sub>true</sub> = TP/(TP+FN)
  - Recall<sub>true</sub> = 
  8/(8 + 1) 
  recall = 0.89
  > 0.89

  #### F1 measures

  f1 = 2 * (precision * recall) / (precision + recall)
  > 0.9417989417989417

  #### Ch8 q2a. i. sum of square errors

  ```math
  \text { Sum of squared errors }=\frac{1}{2} \sum_{i=1}^{n}\left(t_{i}-\mathbb{M}\left(d_{i}\right)\right)^{2}
  ```

  #### Ch8 q2a. ii. R^2 measure

  ```math
  R^{2}=1-\frac{\text { sum of squared errors }}{\text { total sum of squares }}
  ```
  ti is the true target feature value
  for the i-th instance,
  M(di) is the model’s prediction. 
  #### Ch8 q2b. Calc 

  sum of squared errors: 
  (0.228^2 + 1.760^2 + ... )/2
  > 28.570682999999992

  Mean squared error
  57.141365999999984/30
  > 1.9047121999999994

  root mean squared error
  sqrt(57.141365999999984/30)
  > 1.3801131113064609

  -1.8933759999999997/30
  > -0.06311253333333332

  MAE:
  (0.228 + 1.760 + ...)/30
  > 0.9751333333333334

  Total sum of squares:

  get average of **Target**
  (10.502 + ... + 3.538)/30
  > 11.13

  ? total sum of squares:
  ((11.13 - 10.502)^2 + ... + (11.13 - 3.538)^2)/2
  > 323.41613676833333

  R^2 = sum squared errors / total sum of squares = 
  1 - (28.570682999999992 / 323.41613676833333)
  > 0.9116596862312238
  !!! wrong somehow

</details>
</div>
<details>
  <summary>
    Misclassification
  </summary>
  <br />

  - determine suitable model, estimate performance, convince users

  misclassification rate = incorrect predictions (count/number of) / total predictions

  **misclassification** accuracy
  = (FP + FN)/(TP+TN+FP+FN)
  = (2 + 3)/(6+9+2+3) = 0.25

  **classification** accuracy
  = (TP + TN)/(TP+TN+FP+FN)
  = (6 + 9)/(6+9+2+3) = 0.7

  ## Evaluation ch8 Pt2
  **Hold-out sampling** = divide data into training + validation + test sets
  - because: avoid overfitting
  - ! The data used to evaluate must be different than training

  **K-fold:** - not enough data, reduce a lucky split (difficult in training, easy in test set)
  **LOOCV (Leave-one-out cross validation)** - not enough data for kfold

</details>

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
<div class='clearfix'>
<details class='clearfix'>
  <summary>
    Levels: `0.1 - 0.25` warrants investigation, `> 0.25` unaceptable
  </summary>
  <br>
  **Eg.** 
  
  - Recall<sub>true</sub> = 3/5 = 0.6
  - Recall<sub>false</sub> = 4/5 = 0/8
  - ACA<sub>hm</sub> = 1/( (1/2) * (1/0.6 + 1/0.8) ) = 0.685
</details>
</div>
<details class='clearfix'>
  <summary>
    f1 harmonic
  </summary>
  <br>
  **F1** measure: harmonic mean of precision and recall
</details>

$F₁ = 2×\frac{precision×recall}{precision+recall}$

==~old_todo~==
average class accuracy=1/∣levels(t)∣∣∑lϵlevels(t)recall

<details>
  <summary>
  ROC - Higher ROC -> Better model
    </summary>
  <br>

  ROC 
    
  - Receiver Operating Characteristic
  - ROC index - measures area under ROC curve (AUC)
    - higher AUC is better: 97% -> make right decision 97% of time (if we present one true, and one false) < 0.6 is weak > 0.7 strong
    - Fixes class imbalance problem
  - `Gini coefficient = (2xROC index) - 1`
  ![ML_Chapter8B_pdf__page_39_of_63_](/assets/ML_Chapter8B_pdf__page_39_of_63_.jpg)
  - Threshold: as the threshold increases TPR decreases and TNR increases (and vice versa)

  Ch8 q3.

  Textbook:
  at pred0.5:
  FPR = 0.182
  TPR = 0.667

  at pred0.25:
  ?FPRi-1 = 0.364
  ?TPRi-1 = 0.778

  (FPR(i) - FPR(i-1)) x (TPR[i] + TPR(i-1)) / 2

  (0.182 - 0.364) * (0.667 + 0.778) / 2
  > -0.131495

  1-0.131495 why did I need to do this?
  > 0.868505 seems wrong...
  
  8.3
  Model1

  | confusionMatrix | >      | >     | Prediction |
  | --------------- | ------ | ----- | ---------- |
  | >               | &nbsp; | `bad` | `good`     |
  | Target          | `bad`  | TP=16 | FN=1       |
  | ^               | `good` | FP=2  | TN=11      |

  TPR = TP / (TP + FN)
  TPR = 16 / (16 + 1)
  > 0.9411764705882353

  FPR = FP / (TN + FP)
  FPR = 2 / (11 + 2)
  > 0.15384615384615385

  Plot these 2 points
    
</details>

```math
\text { ROC Index }\mathrm=\sum_{i=2}^{|T|} \frac{(F P R(T[i])-F P R(T[i-1])) \times((T P R(T[i])+T P R(T[i-1]))}{2}
\\ \text { T is set of thresholds |T| = \#thresholds tested}
\\ \text { FRP(T[i]) = rate at threshold i}
```

#### Staby Index
```math
\sum _{ { lelevels }(t) } \left( \left( \frac { \left| { A }_{ t=l } \right|  }{ |{ A }| } -\frac { \left| { B }_{ t=l } \right|  }{ |{ B }| }  \right) \times \ln { \left( \frac { \left| { A }_{ t=l } \right|  }{ |{ A }| } /\frac { \left| { B }_{ t=l } \right|  }{ |B| }  \right)  }  \right) =\sum _{ { lelevels }(t) } \left( \left( \frac { 123 }{ 443 } -\frac { 252 }{ 948 }  \right) \times \ln { \left( \frac { 123 }{ 443 } /\frac { 252 }{ 948 }  \right)  }  \right)
```


### Bayes theorum

==~old_todo~==
```math
\text {Bayes}=P(X | Y)=\frac{P(Y | X) P(X)}{P(Y)}=P(d | t)=\frac{P(t | d) P(d)}{P(t)}
```

==~old_todo~==
```math
\begin{array}{l}{\text { Generalised Bayes Theorem: }} \\ {P(t=l | q[1], \ldots, q[m])=\frac{P(q[1], \ldots, q[m] | t=l) P(t=l)}{p(q[1], \ldots, q[m])}}\end{array}```
```

==~old_todo~==
${\text {Chain rule: }}P(q[1], \ldots, q[m]) \times P(q[2] | q[1]) \times \ldots \times P(q[m] | q[m-1], \ldots, q[2], q[1])$

<details>
  <summary>
  Naïve Bayes’ Classifier: 
  </summary>
  <br>
  
  Pr(ph) = 5/9 <- `9` is out of total possibilities
  Pr(gender=M | ph) = 2/5  <- `5` is total phone
  Pr(age=middle | ph) = 2/5 
  Pr(plan=a | ph) = 1/5 
  **Pr(channel = phone | q) =** 5/9 * 2/5 * 2/5 * 1/5   = 0.0178
  
  Pr(email) = Pr(¬ ph) = 4/9
  Pr(gender=M | e) = 3/4 
  Pr(age=middle | e) = 1/4 
  Pr(plan=a | e) = 2/4 
  **Pr(channel = email | q) =** 4/9 * 3/4 * 1/4 * 2/4   = 0.0417
  **Prediction:** channel = phone
</details>

```math
\mathbb{M}(q)=\underset{l \text { elevelst) }}{\operatorname{argmax}}\left(\prod_{i=1}^{m} P(q[i] | t=l)\right) \times P(t=l)
```

<details>
  <summary>
    Laplacian Smoothing (conditional probabilities)
  </summary>
  <br>

  > Smoothing takes some of the probability from the events with lots of the probability share and gives it to the other probabilities in the set.

  ```
  eg. for k = 3
  Pr(GC = none|¬fr) = 12+3/ ( 14+(3*3) )
  Pr(GC = guarantor|¬fr) = 0+3/ ( 14+(3*3) )
  Pr(GC = coapplicant|¬fr) = 2+3/ ( 14+(3*3) )
  ```
</details>

```math
P(f=v | t)=\frac{\operatorname{count}(f=v | t)+k}{\operatorname{count}(f | t)+(k \times|\operatorname{Domain}(f)|)}
```

==~old_todo~== eg.
```math
\text { Sum of squared errors }=\frac{1}{2} \sum_{i=1}^{n}\left(t_{i}-\mathbb{M}\left(d_{i}\right)\right)^{2}
```
==~old_todo~== eg.
```math
\text { Mean squared error }=\frac{\sum_{i=1}^{n}\left(t_{i}-\mathbb{M}\left(d_{i}\right)\right)^{2}}{n}
```
==~old_todo~== eg.
```math
\text {Root } M S E=\sqrt{M S E}
```
==~old_todo~== eg.
```math
{ meanabsoluteerror }=\frac { \sum _{ i=1 }^{ n }{ abs } \left( t_{ i }-{ M }\left( { d }_{ i } \right)  \right)  }{ n } 
```
==~old_todo~== eg.
```math
\begin{matrix} Sum\enskip of\enskip squared\enskip errors\enskip =\enskip \frac { 1 }{ 2 } \sum _{ i=1 }^{ n } \left( t_{ i }-{ M }\left( d_{ i } \right)  \right) ^{ 2 } \\ =\frac { 1 }{ 2 } \sum _{ i=1 }^{ n } \left( true\enskip target\enskip feature\enskip value_{ i }-\enskip model's\enskip prediction \right) ^{ 2 } \end{matrix}
```
==~old_todo~== eg.

```math
R^{2}=1-\frac{\text { sum of squared errors }}{\text { total sum of squares }}
```
==~old_todo~== eg.

<details>
  <summary>
    Definitions
  </summary>
  <br>

  **Inductive Bias** = The set of assumptions that defines the model selection criteria of a ML algorithms

  ##### Model Ensemble s

  **Boosting** 
  - = New _model biased_ to pay more attention to instances that _previous models misclassified_
  - uses a weighted dataset

  **Bagging** (_aka boostrap aggregating_) 
  - each model in ensemble is _trained on random sample of dataset_
  - _sampling with replacement_ is used
  - each sample, therefore each model is different

  **Machine learning** is an _ill-posed problem_
  **supervised vs unsupervised**:
    unsupervised => no target (aka response variable)

</details>

[comment]: <> (log rule: log₂[y]=ln[y]ln[2])
