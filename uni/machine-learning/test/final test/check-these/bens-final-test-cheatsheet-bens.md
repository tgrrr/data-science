
# Shannon’s Model of Entropy: 
[Drawing]Information Gain, entropy wrt target feature: 

```math
H(t,𝒟)=−∑l ∈ levels(t)(P(t=l)×log2(P(t=l)))
```

P(t=i)
 is probability that random element t is type i, l is number of different types of t, and s is arbitrary but usually 2 for calculating bits. 
#### Information Gain, entropy after partitioning: 

```math
rem(d,𝒟)=∑l∈levels(d)∣∣𝒟d=l∣∣∣∣𝒟∣∣ ×H(t,𝒟d=l)
``` 

#### Information Gain: 
```math
IG(d,𝒟)=H(t,𝒟)−rem(d,𝒟)

#### Information Gain Ratio: 

```math
GR(d,𝒟)=IG(d,𝒟)−∑l∈levels(d)(P(d−l)×log2(P(d=l)))
```
Gini
```math
Gini(t,𝒟)=1−∑l∈levels(t)P(t=l)2
```

```math
var(t,𝒟)=∑ni=1(ti−t− )2n−1
```
Euclidean
```math
Euclidean=∑i=1m(𝐚[i]−𝐛[i])2‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾⎷
```
Man
```math
Manhattan=∑i=1mabs(𝐚[i]−𝐛[i])2
```
```math
Minkowski(a,b)=(∑i=1mabs(𝐚[i]−𝐛[i])2)1p
```
```math
simRR(𝐪,𝐝)=CP(𝐪,𝐝)∣∣𝐪∣∣
```
```math
simSM(𝐪,𝐝)=CP(𝐪,𝐝)+CA(𝐪,𝐝)∣∣𝐪∣∣
```
```math
simJ(𝐪,𝐝)=CP(𝐪,𝐝)CP(𝐪,𝐝)+PA(𝐪,𝐝)+AP(𝐪,𝐝)
```
```math
simcosine(a,b)=∑mi=1(a[i]×b[i])∑mi=1a[i]2‾‾‾‾‾‾‾‾‾√×∑mi=1b[i]2‾‾‾‾‾‾‾‾‾√
```

Binomial probability 
```math
P(x)=(nx)pxqn−x=n!(n−x)!∙x!pxqn−x
```
```math
(nx)=n!(n−x)!∙x!
```

n = num trials, x = num successes desired, p = prob success on one trial, q = 1-p 

Similarity metric criteria: 
Non-negativity, 
metric(𝐚,𝐛)≥0
```
```math 
Identity, 
metric(𝐚,𝐛)=0⇔𝐚=𝐛
```
```math
Symmetry, 
metric(𝐚,𝐛)=metric(𝐛,𝐚)
```
```math
Triangular inequality: 
metric(𝐚,𝐛)≤metric(𝐚,𝐜)+metric(𝐛,𝐜)
```
```math
K nearest neighbours: 
𝕄k(q)=argmaxl∈levels(t)∑i=1kδ(ti,l)
```
```math
Weighted k nearest neighbour model: 
𝕄k(q)=argmaxl∈levels(t)∑i=1k1dist(𝐪,𝐝𝐢)2δ(ti,l)
```
```math
𝕄k(q)=1k∑ki=1ti (continuous target)
```
```math
[Drawing]Range normalisation: 
a′i=ai−min(a)max(a)−min(a)×(high−low)+low
```
```math
P(t=l ∣∣ q[1],…,1[m])=P(q[1],…,q[m] ∣∣ t=l)∙P(t=l)P(q[1],…,q[m)
```
```math
P(t=l)
 Prior probability 
```
```math
P(q[1],...,q[m])
 joint prob of descriptive features 
```
```math
P(q[1],…,1[m] ∣∣ t=l)
 conditional prob 
```
<!-- ```math
𝕄(q)=argmaxl𝜖levels(t)P(t=l∣∣q[1],…,q[m])
``` -->
<!-- ```math
𝕄(q)=argmaxl𝜖levels(t)P([q]1,…,q[m] ∣∣ t=l)×P(t=l)P(q[1],…,q[m])
``` -->



| >      | >             | >    | >    | >                  | Prediction         |
| ------ | ------------- | ---- | ---- | ------------------ |:------------------:|
| Target | &nbsp;        | Pos+ | Neg- | >                  |     **Recall**     |
| ^      | Pos +         | TP   | FN   | $\frac{TP}{TP+FN}$ | $\frac{FN}{TP+FN}$ |
| ^      | Neg -         | FP   | TN   | $\frac{TN}{TN+FP}$ | $\frac{FP}{TN+FP}$ |
| ^      | **Precision** | >    | >    | $\frac{TP}{TP+FP}$ |                    |

precision=TP/(TP+FP)         
recall=TP/(TP+FN)

F<sub>1</sub> = $2×\frac{precision×recall}{precision+recall}$

average class accuracy=1/∣levels(t)∣∣∑lϵlevels(t)recalll
 
average class accuracy<sub>HM</sub> = 11∣∣levels(t)∣∣∑lϵlevels(t)1recalll

Stab′ty Index=∑lϵlevels(t)((∣∣𝒜t=l∣∣∣∣𝒜∣∣−∣∣ℬt=l∣∣∣∣ℬ∣∣)×ln(∣∣𝒜t=l∣∣∣∣𝒜∣∣∣∣ℬt=l∣∣∣∣ℬ∣∣/))
 
Bayes=P(X∣∣Y)=P(Y∣∣X)P(X)P(Y)=P(d∣∣t)=P(t∣∣d)P(d)P(t)

```math
Generalised Bayes Theorem: 
P(t=l∣∣q[1],…,q[m])=P(q[1],…,q[m]∣∣t=l)P(t=l)p(q[1],…,q[m])
```
```math
Chain Rule: 
P(q[1],…,q[m])=P(q[1])×P(q[2]∣∣q[1])×…×P(q[m]∣∣q[m−1],…,q[2],q[1])
```
```math
Naïve Bayes’ Classifier: 
𝕄(q)=argmaxlϵlevels(t)(∏mi=1P(q[i]∣∣t=l))×P(t=l)
```
```math
Laplacian Smoothing (conditional probabilities): 
P(f=v∣∣t)=count(f=v∣∣t)+kcount(f∣∣t)+(k×∣∣Domain(f)∣∣)
```
```math
ROC Index=∑∣∣T∣∣i=2(FPR(T[i])−FPR(T[i−1])) ×((TPR(T[i])+TPR(T[i−1]))2
```
```math
Sum of squared errors=12∑ni=1(ti−𝕄(di))2
```
```math
Mean squared error=∑ni=1(ti−𝕄(di))2n
```
```math
Root MSE = MSE‾‾‾‾‾√
```
```math
R2=1−sum of squared errorstotal sum of squares
```
```math
logx(y)=ln(y)ln(x)          log2(y)=ln(y)ln(2)
```
