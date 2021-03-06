Fundamentals of Machine Learning
Chapter 6: Probability-based Learning Sections 6.1, 6.2, 6.3
  Chapter 6A
 1 / 68
 
1 2
Big Idea
Fundamentals
Bayes’ Theorem
Bayesian Prediction
Conditional Independence and Factorization
Standard Approach: The Naive Bayes’ Classifier
A Worked Example
Summary
   3
 4
  Chapter 6A
 2 / 68
 
Big Idea
  Chapter 6A
 3 / 68
 
             (a)
      (b)
Figure: A game of find the lady

       (a)
    Left Center Right
(b)
Figure: A game of find the lady: (a) the cards dealt face down on a table; and (b) the initial likelihoods of the queen ending up in each position.
Likelihood

       (a)
    Left Center Right
(b)
Figure: A game of find the lady: (a) the cards dealt face down on a table; and (b) a revised set of likelihoods for the position of the queen based on evidence collected.
Likelihood

      (a)
    Left Center Right
(b)
Figure: A game of find the lady: (a) The set of cards after the wind blows over the one on the right; (b) the revised likelihoods for the position of the queen based on this new evidence.
Likelihood

    Figure: A game of find the lady: The final positions of the cards in the game.

 Big Idea
We can use estimates of likelihoods to determine the most likely prediction that should be made.
More importantly, we revise these predictions based on data we collect and whenever extra evidence becomes available.
                Chapter 6A
 9 / 68
 
Fundamentals
  Chapter 6A
 10 / 68
 
Table: A simple dataset for MENINGITIS diagnosis with descriptive features that describe the presence or absence of three common symptoms of the disease: HEADACHE, FEVER, and VOMITING.
ID HEADACHE 1 true
2 false
3 true
4 true 5 false 6 true 7 true 8 true 9 false
10 true
FEVER VOMITING true false true false
false true false true true false false true false true false true
true false false true
MENINGITIS false false false false true false false true false true
     Chapter 6A
 11 / 68
 
A probability function, P(), returns the probability of a feature taking a specific value.
A joint probability refers to the probability of an assignment of specific values to multiple different features.
A conditional probability refers to the probability of one feature taking a specific value given that we already know the value of a different feature
A probability distribution is a data structure that describes the probability of each possible value a feature can take. The sum of a probability distribution must equal 1.0.
      Chapter 6A
 12 / 68
 
A joint probability distribution is a probability distribution over more than one feature assignment and is written as a multi-dimensional matrix in which each cell lists the probability of a particular combination of feature values being assigned.
The sum of all the cells in a joint probability distribution must be 1.0.
    Chapter 6A
 13 / 68
 
P(H,F,V,M) = 6
P(h,¬f,¬v,m), P(h,¬f,¬v,¬m),
2 P(h,f,v,m), 6 P(h,f,v,¬m), 6 P(h,f,¬v,m),
P(¬h,f,v,m) 3 P(¬h,f,v,¬m) 7 P(¬h,f,¬v,m) 7 P(¬h,f,¬v,¬m) 7 P(¬h,¬f,v,m) 7 P(¬h,¬f,v,¬m) 75 P(¬h,¬f,¬v,m) P(¬h,¬f,¬v,¬m)
P(h,f,¬v,¬m), 6 P(h,¬f,v,m), 64 P(h,¬f,v,¬m),
  Chapter 6A
 14 / 68
 
Given a joint probability distribution, we can compute the probability of any event in the domain that it covers by summing over the cells in the distribution where that event is true.
Calculating probabilities in this way is known as summing out.
    Chapter 6A
 15 / 68
 
 Bayes’ Theorem
         P(X|Y) = P(Y|X)P(X) P(Y)
      Chapter 6A
 16 / 68
 
 Example
After a yearly checkup, a doctor informs their patient that he has both bad news and good news. The bad news is that the patient has tested positive for a serious disease and that the test that the doctor has used is 99% accurate (i.e., the probability of testing positive when a patient has the disease is 0.99, as is the probability of testing negative when a patient does not have the disease). The good news, however, is that the disease is extremely rare, striking only 1 in 10,000 people.
What is the actual probability that the patient has the disease?
Why is the rarity of the disease good news given that the patient has tested positive for it?
                Chapter 6A
 17 / 68
 
P(d|t) = P(t|d)P(d) P(t)
P(t) = P(t|d)P(d) + P(t|¬d)P(¬d)
= (0.99 ⇥ 0.0001) + (0.01 ⇥ 0.9999) = 0.0101
 P(d|t) =
= 0.0098
0.99 ⇥ 0.0001
 0.0101
  Chapter 6A
 18 / 68
 
 
 Generalized Bayes’ Theorem
P(t = l|q[1],...,q[m]) = P(q[1],...,q[m]|t = l)P(t = l) P(q[1], . . . , q[m])
               Chapter 6A
 22 / 68
 
 Chain Rule
· · · ⇥ P(q[m]|q[m   1], . . . , q[2], q[1])
To apply the chain rule to a conditional probability we just add the
conditioning term to each term in the expression:
P(q[1],...,q[m]|t = l) =
P(q[1]|t =l)⇥P(q[2]|q[1],t =l)⇥...
···⇥P(q[m]|q[m 1],...,q[3],q[2],q[1],t =l)
         P(q[1],...,q[m]) =
P(q[1]) ⇥ P(q[2]|q[1])⇥
      Chapter 6A
 23 / 68
 
ID 1 2 3 4 5 6 7 8 9
10 true
HEADACHE true
FEVER true true false false true false false false true false
FEVER false
VOMITING false false true true false true true true false true
MENINGITIS false false false false true false false true false true
HEADACHE true false true true false true true true false
   VOMITING true
MENINGITIS ?
     Chapter 6A
 24 / 68
 
P(M|h,¬f,v) =?
In the terms of Bayes’ Theorem this problem can be stated as:
P(M|h,¬f,v)= P(h,¬f,v|M)⇥P(M) P(h,¬f,v)
There are two values in the domain of the MENINGITIS feature, ’true’ and ’false’, so we have to do this calculation twice.
     Chapter 6A
 25 / 68
 
We will do the calculation for m first
To carry out this calculation we need to know the following probabilities: P(m), P(h,¬f,v) and P(h,¬f,v | m).
  ID 1 2 3 4 5 6 7 8 9 10
HEADACHE FEVER VOMITING true true false
MENINGITIS false false false false true false false true false true
  false true true false true true true false true
true false false true false true
true false false true false true false true
true false false true
   Chapter 6A
 26 / 68
 
We can calculate the required probabilities directly from the data. For example, we can calculate P(m) and P(h,¬f,v) as follows:
 P(m)= |{d5,d8,d10}|
| {d1, d2, d3, d4, d5, d6, d7, d8, d9, d10} |
| ----------------------------------------- |
P(h,¬f,v) = |{d3,d4,d6,d7,d8,d10}|
| {d1, d2, d3, d4, d5, d6, d7, d8, d9, d10} |
| ----------------------------------------- |
= 3 =0.3 10
= 6 = 0.6 10
      Chapter 6A
 27 / 68
 
However, as an exercise we will use the chain rule calculate:
 ID 1 2 3 4 5 6 7 8 9
P(h,¬f,v | m) =? HEADACHE FEVER VOMITING
true true false false true false true false true true false true false true false true false true true false true true false true
true false false true
MENINGITIS false false false false true false false true false true
  false 10 true
   Chapter 6A
 28 / 68
 
Using the chain rule calculate:
P(h,¬f,v |m)=P(h|m)⇥P(¬f |h,m)⇥P(v |¬f,h,m) = |{d8, d10}| ⇥ |{d8, d10}| ⇥ |{d8, d10}| |{d5, d8, d10}| |{d8, d10}| |{d8, d10}|
= 2 ⇥ 2 ⇥ 2 = 0.6666 322
         Chapter 6A
 29 / 68
 
So the calculation of P(m|h,¬f,v) is:
!
 P(m|h,¬f,v) =
P(h|m)⇥P(¬f|h,m) ⇥P(v|¬f,h,m)⇥P(m)
 P(h,¬f,v)
= 0.6666 ⇥ 0.3 = 0.3333
 0.6
  Chapter 6A
 30 / 68
 
The corresponding calculation for P(¬m|h,¬f,v) is: P(¬m|h,¬f,v)= P(h,¬f,v |¬m)⇥P(¬m)
P(h,¬f,v) P(h|¬m)⇥P(¬f |h,¬m)
⇥P(v|¬f,h,¬m)⇥P(¬m)
=
  !
P(h,¬f,v)
= 0.7143⇥0.8⇥1.0⇥0.7 = 0.6667
0.6
    Chapter 6A
 31 / 68
 
P(m|h,¬f,v) = 0.3333 P(¬m|h,¬f,v) = 0.6667
These calculations tell us that it is twice as probable that the patient does not have meningitis than it is that they do even though the patient is suffering from a headache and is vomiting!
   Chapter 6A
 32 / 68
 
 The Paradox of the False Positive
The mistake of forgetting to factor in the prior gives rise to the
paradox of the false positive which states that in order to make predictions about a rare event the model has to be as accurate as the prior of the event is rare or there is a significant chance of false positives predictions (i.e., predicting the event when it is not the case).
               Chapter 6A
 33 / 68
 
 Bayesian MAP Prediction Model
MMAP(q) = argmax P(t = l | q[1],...,q[m]) l2levels(t)
= argmax P(q[1], . . . , q[m] | t = l) ⇥ P(t = l) l2levels(t) P(q[1], . . . , q[m])
Bayesian MAP Prediction Model (without normalization)
MMAP(q)= argmax P(q[1],...,q[m]|t =l)⇥P(t =l) l2levels(t)
                            Chapter 6A
 34 / 68
 
 ID 1 2 3 4 5 6 7 8 9
HEADACHE FEVER true true false true
true false true false false true true false true false true false
true false
FEVER true
VOMITING false false true true false true true true false true
VOMITING false
MENINGITIS false false false false true false false true false true
MENINGITIS ?
  false 10 true
 HEADACHE true
   
 ID 1 2 3 4 5 6 7 8 9
10 true
FEVER VOMITING true false true false
false true false true true false false true false true false true
true false false true
P(m | h,f,¬v) =? P(¬m | h,f,¬v) =?
MENINGITIS false false false false true false false true false true
HEADACHE true false true true false true true true false
   
P(m | h,f,¬v) =
P(h|m)⇥P(f |h,m) ⇥P(¬v |f,h,m)⇥P(m)
!
 P(h,f,¬v)
= 0.6666⇥0⇥0⇥0.3 =0
 0.1
  Chapter 6A
 37 / 68
 
P(h|¬m)⇥P(f |h,¬m) ⇥P(¬v |f,h,¬m)⇥P(¬m)
P(¬m | h,f,¬v) =
!
 P(h,f,¬v)
= 0.7143⇥0.2⇥1.0⇥0.7 =1.0
0.1
   Chapter 6A
 38 / 68
 
P(m | h,f,¬v) = 0 P(¬m | h,f,¬v) = 1.0
There is something odd about these results!
   Chapter 6A
 39 / 68
 
 Curse of Dimensionality
As the number of descriptive features grows the number of potential conditioning events grows. Consequently, an exponential increase is required in the size of the dataset as each new descriptive feature is added to ensure that for any conditional probability there are enough instances in the training dataset matching the conditions so that the resulting probability is reasonable.
              Chapter 6A
 40 / 68
 
The probability of a patient who has a headache and a fever having meningitis should be greater than zero!
Our dataset is not large enough ! our model is over-fitting to the training data.
The concepts of conditional independence and factorization can help us overcome this flaw of our current approach.
     Chapter 6A
 41 / 68
 
If knowledge of one event has no effect on the probability of another event, and vice versa, then the two events are independent of each other.
If two events X and Y are independent then: P(X|Y) = P(X)
P (X , Y ) = P (X ) ⇥ P (Y )
Recall, that when two event are dependent these rules are:
P(X|Y) = P(X,Y) P(Y)
P (X , Y ) = P (X |Y ) ⇥ P (Y ) = P (Y |X ) ⇥ P (X )
              Chapter 6A
 42 / 68
 
Full independence between events is quite rare.
A more common phenomenon is that two, or more, events may be independent if we know that a third event has happened.
This is known as conditional independence.
     Chapter 6A
 43 / 68
 
For two events, X and Y , that are conditionally independent given knowledge of a third events, here Z , the definition of the probability of a joint event and conditional probability are:
P(X|Y,Z) = P(X|Z)
P (X , Y |Z ) = P (X |Z ) ⇥ P (Y |Z )
          P(X|Y) = P(X,Y) P(Y)
P (X , Y ) = P (X |Y ) ⇥ P (Y ) = P(Y|X) ⇥ P(X)
X and Y are dependent
P(X|Y) = P(X)
P (X , Y ) = P (X ) ⇥ P (Y )
X and Y are independent
      Chapter 6A
 44 / 68
 
If the event t = l causes the events q[1], . . . , q[m] to happen then the events q[1], . . . , q[m] are conditionally independent of each other given knowledge of t = l and the chain rule definition can be simplified as follows:
P(q[1],...,q[m] | t = l)
=PY(q[1]|t =l)⇥P(q[2]|t =l)⇥···⇥P(q[m]|t =l) m
= P(q[i] | t = l) i=1
   Chapter 6A
 45 / 68
 
Using this we can simplify the calculations in Bayes’ Theorem, under the assumption of conditional independence between the descriptive features given the level l of the target feature:
Ym !
P(q[i]|t =l) ⇥P(t =l) i=1
P(q[1], . . . , q[m])
 P(t = l | q[1],...,q[m]) =
   Chapter 6A
 46 / 68
 
 Withouth conditional independence
P (X , Y , Z |W ) = P (X |W ) ⇥ P (Y |X , W ) ⇥ P (Z |Y , X , W ) ⇥ P (W ) With conditional independence
P(X,Y,Z|W) = P(X|W)⇥P(Y|W)⇥P(Z|W)⇥P(W) | {z } | {z } | {z } |{z}
Factor 1 Factor 2 Factor 3 Factor 4
                                   Chapter 6A
 47 / 68
 
The joint probability distribution for the meningitis dataset.
 P(H,F,V,M) = 6
P(h,¬f,¬v,m), P(h,¬f,¬v,¬m),
2 P(h,f,v,m), 6 P(h,f,v,¬m), 6 P(h,f,¬v,m),
P(¬h,f,v,m) 3 P(¬h,f,v,¬m) 7 P(¬h,f,¬v,m) 7 P(¬h,f,¬v,¬m) 7 P(¬h,¬f,v,m) 7 P(¬h,¬f,v,¬m) 75 P(¬h,¬f,¬v,m) P(¬h,¬f,¬v,¬m)
P(h,f,¬v,¬m), 6 P(h,¬f,v,m), 64 P(h,¬f,v,¬m),
  Chapter 6A
 48 / 68
 
Assuming the descriptive features are conditionally independent of each other given MENINGITIS we only need to store four factors:
Factor1 : < P(M) >
Factor2 : < P(h|m), P(h|¬m) > Factor3 : < P(f |m), P(f |¬m) > Factor4 : < P(v|m), P(v|¬m) >
P (H , F , V , M ) = P (M ) ⇥ P (H |M ) ⇥ P (F |M ) ⇥ P (V |M )
   Chapter 6A
 49 / 68
 
 ID HEADACHE 1 true
2 false
3 true
4 true 5 false 6 true 7 true 8 true 9 false
10 true
FEVER VOMITING true false true false
false true false true true false false true false true false true
true false false true
MENINGITIS false false false false true false false true false true
   Calculate the factors from the data. Factor1 : < P(M) >
 Factor2 : < P(h|m), P(h|¬m) > Factor3 : < P(f |m), P(f |¬m) > Factor4 : < P(v|m), P(v|¬m) >

Factor1 : < P(m) = 0.3 >
Factor2 : < P(h|m) = 0.6666, P(h|¬m) = 0.7413 > Factor3 : < P(f |m) = 0.3333, P(f |¬m) = 0.4286 > Factor4 : < P(v|m) = 0.6666,P(v|¬m) = 0.5714 >
Using the factors above calculate the probability of MENINGITIS=’true’ for the following query.
HEADACHE FEVER VOMITING MENINGITIS true true false ?
      Chapter 6A
 52 / 68
 
P(m|h,f,¬v)= PP(h|m)⇥P(f|m)⇥P(¬v|m)⇥P(m) = i P(h|Mi)⇥P(f|Mi)⇥P(¬v|Mi)⇥P(Mi)
0.6666 ⇥ 0.3333 ⇥ 0.3333 ⇥ 0.3
(0.6666 ⇥ 0.3333 ⇥ 0.3333 ⇥ 0.3) + (0.7143 ⇥ 0.4286 ⇥ 0.4286 ⇥ 0.7)
= 0.1948
    Chapter 6A
 53 / 68
 
Factor1 : < P(m) = 0.3 >
Factor2 : < P(h|m) = 0.6666, P(h|¬m) = 0.7413 > Factor3 : < P(f |m) = 0.3333, P(f |¬m) = 0.4286 > Factor4 : < P(v|m) = 0.6666,P(v|¬m) = 0.5714 >
Using the factors above calculate the probability of MENINGITIS=’false’ for the same query.
HEADACHE FEVER VOMITING MENINGITIS true true false ?
      Chapter 6A
 54 / 68
 
P(h|¬m) ⇥ P(f|¬m) ⇥ P(¬v|¬m) ⇥ P(¬m) P(¬m|h,f,¬v)= Pi P(h|Mi)⇥P(f|Mi)⇥P(¬v|Mi)⇥P(Mi) =
0.7143 ⇥ 0.4286 ⇥ 0.4286 ⇥ 0.7 = 0.8052 (0.6666 ⇥ 0.3333 ⇥ 0.3333 ⇥ 0.3) + (0.7143 ⇥ 0.4286 ⇥ 0.4286 ⇥ 0.7)
    Chapter 6A
 55 / 68
 
P(m|h,f,¬v) = 0.1948 P(¬m|h,f,¬v) = 0.8052
As before, the MAP prediction would be MENINGITIS = ’false’ The posterior probabilities are not as extreme!
    Chapter 6A
 56 / 68
 
Standard Approach: The Naive Bayes’ Classifier
  Chapter 6A
 57 / 68
 
 Naive Bayes’ Classifier
Ym !
M(q)= argmax P(q[i]|t =l) ⇥P(t =l)
l2levels(t)
         i=1
     Chapter 6A
 58 / 68
 
 Naive Bayes’ is simple to train!
1 calculate the priors for each of the target levels
2 calculate the conditional probabilities for each feature given each target level.
              Chapter 6A
 59 / 68
 
 
 P(fr) P(CH = ’none’ | fr) P(CH = ’paid’ | fr) P(CH = ’current’ | fr) P(CH = ’arrears’ | fr) P(GC = ’none’ | fr) P(GC = ’guarantor’ | fr) P(GC = ’coapplicant’ | fr) P(ACC = ’own’ | fr) P(ACC = ’rent’ | fr) P(ACC = ’free’ | fr)
= 0.3
= 0.1666 = 0.1666 = 0.5
= 0.1666 = 0.8334 = 0.1666 = 0
= 0.6666 = 0.3333 = 0
P(¬fr) P(CH = ’none’ | ¬fr) P(CH = ’paid’ | ¬fr) P(CH = ’current’ | ¬fr) P(CH = ’arrears’ | ¬fr) P(GC = ’none’ | ¬fr) P(GC = ’guarantor’ | ¬fr) P(GC = ’coapplicant’ | ¬fr) P(ACC = ’own’ | ¬fr) P(ACC = ’rent’ | ¬fr) P(ACC = ’free’ | ¬fr)
= 0.7
= 0
= 0.2857 = 0.2857 = 0.4286 = 0.8571 = 0
= 0.1429 = 0.7857 = 0.1429 = 0.0714
 Table: The probabilities needed by a Naive Bayes prediction model calculated from the dataset. Notation key: FR=FRAUDULENT, CH=CREDIT HISTORY, GC = GUARANTOR/COAPPLICANT, ACC = ACCOMODATION, T=’true’, F=’false’.
 
 P(fr) P(CH = ’none’ | fr) P(CH = ’paid’ | fr) P(CH = ’current’ | fr) P(CH = ’arrears’ | fr) P(GC = ’none’ | fr) P(GC = ’guarantor’ | fr) P(GC = ’coapplicant’ | fr) P(ACC = ’own’ | fr) P(ACC = ’rent’ | fr) P(ACC = ’free’ | fr)
= 0.3
= 0.1666 = 0.1666 = 0.5
= 0.1666 = 0.8334 = 0.1666 = 0
= 0.6666 = 0.3333 = 0
P(¬fr) P(CH = ’none’ | ¬fr) P(CH = ’paid’ | ¬fr) P(CH = ’current’ | ¬fr) P(CH = ’arrears’ | ¬fr) P(GC = ’none’ | ¬fr) P(GC = ’guarantor’ | ¬fr) P(GC = ’coapplicant’ | ¬fr) P(ACC = ’own’ | ¬fr) P(ACC = ’rent’ | ¬fr) P(ACC = ’free’ | ¬fr)
= 0.7
= 0
= 0.2857 = 0.2857 = 0.4286 = 0.8571 = 0
= 0.1429 = 0.7857 = 0.1429 = 0.0714
 CREDIT HISTORY GUARANTOR/COAPPLICANT ACCOMODATION FRAUDULENT paid none rent ?
    
 P(CH = ’paid’ | fr)
P(GC = ’none’ | fr)
= 0.1666 = 0.8334 = 0.3333
P(CH = ’paid’ | ¬fr) = P(GC = ’none’ | ¬fr) = P(ACC = ’rent’ | ¬fr) =
0.2857 0.8571 0.1429
CREDIT HISTORY paid
GUARANTOR/COAPPLICANT ACCOMODATION none rent
FRAUDULENT ?
P(fr) = 0.3
P(¬fr) = 0.7
P(ACC = ’rent’ | fr)
✓Ym ◆
 ✓ Ym k=1
◆
P(q[k]|fr) ⇥P(fr)=0.0139 k=1
P (q [k] | ¬fr) ⇥ P(¬fr) = 0.0245
      Chapter 6A
 63 / 68
 
 P(CH = ’paid’ | fr)
P(GC = ’none’ | fr)
= 0.1666 = 0.8334 = 0.3333
P(CH = ’paid’ | ¬fr) = P(GC = ’none’ | ¬fr) = P(ACC = ’rent’ | ¬fr) =
0.2857 0.8571 0.1429
CREDIT HISTORY paid
GUARANTOR/COAPPLICANT ACCOMODATION none rent
FRAUDULENT
’false’
P(fr) = 0.3
P(¬fr) = 0.7
P(ACC = ’rent’ | fr)
✓Ym ◆
 ✓ Ym k=1
◆
P(q[k]|fr) ⇥P(fr)=0.0139 k=1
P (q [k] | ¬fr) ⇥ P(¬fr) = 0.0245
      Chapter 6A
 64 / 68
 
 The model is generalizing beyond the dataset!
 ID 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
CREDIT HISTORY paid
CREDIT GUARANTOR/ HISTORY COAPPLICANT
current none paid none paid none paid guarantor
arrears none arrears none current none arrears none current none
none none current coapplicant current none current none
paid none arrears none current none arrears coapplicant arrears none arrears none
paid none
ACCOMMODATION own
own
own
rent
own
own
own
own
rent
own
own
own
rent
own
own
own
rent
free
own
own
FRAUD true false false true false true false false false true false true true false false false false false false false
  GUARANTOR/COAPPLICANT none
ACCOMMODATION FRAUDULENT rent ’false’
   
Summary
  Chapter 6A
 66 / 68
 
P(t|d) = P(d|t) ⇥ P(t) (2) P (d)
A Naive Bayes’ classifier naively assumes that each of the descriptive features in a domain is conditionally independent of all of the other descriptive features, given the state of the target feature.
This assumption, although often wrong, enables the Naive Bayes’ model to maximally factorise the representation that it uses of the domain.
Surprisingly, given the naivety and strength of the assumption it depends upon, a Naive Bayes’ model often performs reasonably well.
      Chapter 6A
 67 / 68
 
1 2
Big Idea
Fundamentals
Bayes’ Theorem
Bayesian Prediction
Conditional Independence and Factorization
Standard Approach: The Naive Bayes’ Classifier
A Worked Example
Summary
   3
 4
  Chapter 6A
 68 / 68

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Fundamentals of Machine Learning
Chapter 6: Probability-based Learning Sections 6.4, 6.5
  Chapter 6B
 1 / 74
 
1 2 3 4 5
Smoothing
Continuous Features: Probability Density Functions Continuous Features: Binning
Bayesian Networks
Summary
  Chapter 6B
 2 / 74
 
Smoothing
  Chapter 6B
 3 / 74
 
 
 P(fr) P(CH = ’none’ | fr) P(CH = ’paid’ | fr) P(CH = ’current’ | fr) P(CH = ’arrears’ | fr) P(GC = ’none’ | fr) P(GC = ’guarantor’ | fr) P(GC = ’coapplicant’ | fr) P(ACC = ’own’ | fr) P(ACC = ’rent’ | fr) P(ACC = ’free’ | fr)
= 0.3
= 0.1666 = 0.1666 = 0.5
= 0.1666 = 0.8334 = 0.1666 = 0
= 0.6666 = 0.3333 = 0
P(¬fr) P(CH = ’none’ | ¬fr) P(CH = ’paid’ | ¬fr) P(CH = ’current’ | ¬fr) P(CH = ’arrears’ | ¬fr) P(GC = ’none’ | ¬fr) P(GC = ’guarantor’ | ¬fr) P(GC = ’coapplicant’ | ¬fr) P(ACC = ’own’ | ¬fr) P(ACC = ’rent’ | ¬fr) P(ACC = ’free’ | ¬fr)
= 0.7
= 0
= 0.2857 = 0.2857 = 0.4286 = 0.8571 = 0
= 0.1429 = 0.7857 = 0.1429 = 0.0714
 CREDIT HISTORY GUARANTOR/COAPPLICANT ACCOMMODATION FRAUDULENT paid guarantor free ?
    
 P(fr) = 0.3 P(CH = paid | fr) = 0.1666 P(GC = guarantor | fr) = 0.1666
P(¬fr) = 0.7 P(CH = paid | ¬fr) = 0.2857
P(GC = guarantor | ¬fr) = 0 P(ACC=free|¬fr) = 0.0714
P(ACC=free|fr) = 0
 Qmk=1 P(q[k] | fr)  ⇥ P(fr) = 0.0
  Qmk=1 P(q[k] | ¬fr)  ⇥ P(¬fr) = 0.0
CREDIT HISTORY GUARANTOR/COAPPLICANT ACCOMMODATION FRAUDULENT paid guarantor free ?
      Chapter 6B
 5 / 74
 
The standard way to avoid this issue is to use smoothing.
Smoothing takes some of the probability from the events with lots of the probability share and gives it to the other probabilities in the set.
    Chapter 6B
 6 / 74
 
There are several different ways to smooth probabilities, we will use Laplacian smoothing.
Laplacian Smoothing (conditional probabilities)
count(f = v|t) + k
count (f |t ) + (k ⇥ |Domain(f )|)
           P(f=v|t) =
      Chapter 6B
 7 / 74
 
  Raw Probabilities
Smoothing Parameters
P(GC = none|¬fr)
P (GC = guarantor |¬fr )
P (GC = coapplicant |¬fr )
k
count (GC |¬fr )
count (GC = none|¬fr )
count (GC = guarantor |¬fr )
count (GC = coapplicant |¬fr )
| Domain(GC) |
| ---------- |
= 0.8571 = 0
= 0.1429 = 3
= 14
= 12
= 0
= 2
= 3
= 0.6522 = 0.1304 = 0.2174
  Smoothed
Probabilities
P(GC = none|¬fr) = P(GC = guarantor|¬fr) = P(GC = coapplicant|¬fr) =
12+3 14+(3⇥3)
0+3 14+(3⇥3)
2+3 14+(3⇥3)
    Table: Smoothing the posterior probabilities for the GUARANTOR/COAPPLICANT feature conditioned on FRAUDULENT being False.

  P(fr) P(CH = none|fr) P(CH = paid|fr) P (CH = current |fr ) P(CH = arrears|fr) P(GC = none|fr) P (GC = guarantor |fr ) P (GC = coapplicant |fr ) P(ACC = own|fr) P(ACC = rent|fr) P(ACC = Free|fr)
= 0.3
= 0.2222 = 0.2222 = 0.3333 = 0.2222 = 0.5333 = 0.2667 = 0.2
= 0.4667 = 0.3333 = 0.2
P(¬fr) = P(CH = none|¬fr) = P (CH = paid |¬fr ) = P (CH = current |¬fr ) = P(CH = arrears|¬fr) = P(GC = none|¬fr) = P (GC = guarantor |¬fr ) = P (GC = coapplicant |¬fr ) = P(ACC = own|¬fr) = P (ACC = rent |¬fr ) = P(ACC = Free|¬fr) =
0.7 0.1154 0.2692 0.2692 0.3462 0.6522 0.1304 0.2174 0.6087 0.2174 0.1739
 Table: The Laplacian smoothed, with k = 3, probabilities needed by a Naive Bayes prediction model calculated from the fraud detection dataset. Notation key: FR=FRAUDULENT, CH=CREDIT HISTORY, GC = GUARANTOR/COAPPLICANT, ACC = ACCOMODATION, T=’True’, F=’False’.

CREDIT HISTORY GUARANTOR/COAPPLICANT ACCOMMODATION FRAUDULENT paid guarantor free ?
     Chapter 6B
 10 / 74
 
 P(CH = paid|fr) P (GC = guarantor |fr ) P(ACC = Free|fr)
= 0.2222 = 0.2667 = 0.2
P (CH = paid |¬fr ) = P (GC = guarantor |¬fr ) = P(ACC = Free|¬fr) =
0.2692 0.1304 0.1739
P(fr) = 0.3
P(¬fr) = 0.7
 Qmk=1 P(q[m]|fr)  ⇥ P(fr) = 0.0036  Qmk=1 P(q[m]|¬fr)  ⇥ P(¬fr) = 0.0043
  Table: The relevant smoothed probabilities, from Table 2 [9], needed by the Naive Bayes prediction model in order to classify the query from the previous slide and the calculation of the scores for each candidate classification.
  Chapter 6B
 11 / 74
 
Continuous Features: Probability Density Functions
  Chapter 6B
 12 / 74
 
 Table: The dataset from the loan application fraud detection domain with a new continuous descriptive features added: ACCOUNT BALANCE
 ID 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
CREDIT GUARANTOR/
HISTORY COAPPLICANT ACCOMMODATION
current none own current none own current none own
paid guarantor rent arrears none own arrears none own current none own arrears none own current none rent
none none own current coapplicant own current none free current none rent
paid none own arrears none own current none own arrears coapplicant rent arrears none free arrears none own
ACCOUNT BALANCE 56.75 1,800.11 1,341.03 749.50 1,150.00 928.30 250.90 806.15 1,209.02 405.72 550.00 223.89 103.23 758.22 430.79 675.11 1,657.20 1,405.18 760.51
FRAUD true false false true false true false false false true false true true false false false false false false
 20 current none own 985.41 false

We need to define two PDFs for the new ACCOUNT BALANCE (AB) feature with each PDF conditioned on a different value in the domain or the target:
I P(AB = X|fr) = PDF1(AB = X|fr)
I P(AB = X|¬fr) = PDF2(AB = X|¬fr)
Note that these two PDFs do not have to be defined using the same statistical distribution.
    Chapter 6B
 24 / 74
 
       Density
0.0000 0.0005 0.0010 0.0015 0.0020
Density
0.0000 0.0005 0.0010 0.0015 0.0020
0 500 1000
Feature Values
(a)
1500
2000
0
500
1000 1500 2000
Feature Values
(b)
Figure: Histograms, using a bin size of 250 units, and density curves for the ACCOUNT BALANCE feature: (a) the fraudulent instances overlaid with a fitted exponential distribution; (b) the non-fraudulent instances overlaid with a fitted normal distribution.
 Chapter 6B     25 / 74

From the shape of these histograms it appears that
I the distribution of values taken by the ACCOUNT BALANCE feature in the set of instances where the target feature FRAUDULENT=’True’ follows an exponential distribution
I the distributions of values taken by the ACCOUNT BALANCE feature in the set of instances where the target feature FRAUDULENT=’False’ is similar to a normal distribution.
Once we have selected the distributions the next step is to fit the distributions to the data.
    Chapter 6B
 26 / 74
 
To fit the exponential distribution we simply compute the sample mean, x ̄, of the ACCOUNT BALANCE feature in the set of instances where FRAUDULENT=’True’ and set the   parameter equal to one divided by x ̄.
To fit the normal distribution to the set of instances where FRAUDULENT=’False’ we simply compute the sample mean and sample standard deviation, s, for the ACCOUNT BALANCE feature for this set of instances and set the parameters of the normal distribution to these values.
    Chapter 6B
 27 / 74
 
 Table: Partitioning the dataset based on the value of the target feature and fitting the parameters of a statistical distribution to model the ACCOUNT BALANCE feature in each partition.
   ID . . . 1
4
6
10 ... 12
13
AB
  =1!/AB
ACCOUNT
BALANCE FRAUD
56.75 true 749.50 true 928.30 true 405.72 true 223.89 true 103.23 true 411.22
0.0024
ID . . . 2
 3
 5
 7
 8
 9
11
14
15
16
17
18
19
20
AB sd(AB)
ACCOUNT BALANCE 1 800.11 1 341.03 1 150.00 250.90 806.15 1209.02 550.00 758.22 430.79 675.11 657.20 405.18 760.51 985.41 984.26 460.94
FRAUD false false false false false false false false false false false false false false
 1 1
       
Table: The Laplace smoothed (with k = 3) probabilities needed by a naive Bayes prediction model calculated from the dataset in Table 5 [23], extended to include the conditional probabilities for the new ACCOUNT BALANCE feature, which are defined in terms of PDFs.
 P(fr) P(CH = none|fr) P(CH = paid|fr) P (CH = current |fr ) P(CH = arrears|fr) P(GC = none|fr) P (GC = guarantor |fr ) P (GC = coapplicant |fr ) P(ACC = own|fr) P(ACC = rent|fr) P(ACC = free|fr) P(AB = x|fr)
⇡
= 0.3
= 0.2222 = 0.2222 = 0.3333 = 0.2222 = 0.5333 = 0.2667 = 0.2
= 0.4667 = 0.3333 = 0.2
0 x, 1 E @  = 0.0024A
P(¬fr) P(CH = none|¬fr) P (CH = paid |¬fr ) P (CH = current |¬fr ) P(CH = arrears|¬fr) P(GC = none|¬fr) P (GC = guarantor |¬fr )
= 0.7
= 0.1154 = 0.2692 = 0.2692 = 0.3462 = 0.6522 = 0.1304 = 0.2174 = 0.6087 = 0.2174 = 0.1739
P (GC
= coapplicant |¬fr ) P(ACC = own|¬fr) P (ACC = rent |¬fr ) P(ACC = free|¬fr)
P(AB = x|¬fr) ⇡
01 B x, C
N B@μ = 984.26,CA   = 460.94
   Chapter 6B
 29 / 74
 
Table: A query loan application from the fraud detection domain.
Credit Guarantor/ Account
History CoApplicant Accomodation Balance Fraudulent paid guarantor free 759.07 ?
     Chapter 6B
 30 / 74
 
Table: The probabilities, from Table 7 [29], needed by the naive Bayes prediction model to make a prediction for the query
hCH = ’paid’, GC = ’guarantor’, ACC = ’free’, AB = 759.07i and the calculation of the scores for each candidate prediction.
 P(fr) P(CH = paid|fr) P (GC = guarantor |fr ) P(ACC = free|fr) P (AB = 759.07|fr )
0 759.07, 1 ⇡ E @  = 0.0024A
= 0.3
= 0.2222 = 0.2667 = 0.2
= 0.00039
P(¬fr) = P (CH = paid |¬fr ) = P (GC = guarantor |¬fr ) = P(ACC = free|¬fr) =
P (AB = 759.07|¬fr ) 0B759.07,1C
⇡ N B@μ = 984.26,CA =   = 460.94
0.7 0.2692 0.1304 0.1739
0.00077
 Qmk=1 P(q[k]|fr)  ⇥ P(fr) = 0.0000014  Qmk=1 P(q[k]|¬fr)  ⇥ P(¬fr) = 0.0000033
    Chapter 6B
 31 / 74
 
       εε
PDF(x− ) PDF(x− ) 22
   PDF(x) PDF(x) PDF(x)
εε
PDF(x+ ) PDF(x+ ) 22
A
B
     εεεεεε
x− x x+   x− x x+   x− x x+ 222222
(a) (b) (c)
    Figure: (a) The area under a density curve between the limits x   ✏ and 2
 x + ✏ ; (b) the approximation of this area computed by PDF (x ) ⇥ ✏; and (c) the 2
 error in the approximation is equal to the difference between area A, the area under the curve omitted from the approximation, and area B, the area above the curve erroneously included in the approximation. Both of these areas will get smaller as the width of the interval gets smaller, resulting in a smaller error in the approximation.
   Chapter 6B 21 / 74

Continuous Features: Binning
  Chapter 6B
 32 / 74
 
In Section 3.6.2 we explained two of the best known binning techniques equal-width and equal-frequency.
We can use these techniques to bin continuous features into categorical features
In general we recommend equal-frequency binning.
     Chapter 6B
 33 / 74
 
 Table: The dataset from a loan application fraud detection domain with a second continuous descriptive feature added: LOAN AMOUNT
 ID 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
CREDIT GUARANTOR/
HISTORY COAPPLICANT ACCOMMODATION
current none own current none own current none own
paid guarantor rent arrears none own arrears none own current none own arrears none own current none rent
none none own current coapplicant own current none free current none rent
paid none own arrears none own current none own arrears coapplicant rent arrears none free arrears none own current none own
ACCOUNT LOAN
BALANCE
AMOUNT FRAUD 900 true 150 000 false 48 000 false 10 000 true 32 000 false 250 000 true 25 000 false 18 500 false 20 000 false 9500 true 16 750 false 9850 true 95 500 true 65000 false 500 false 16 000 false 15 450 false 50 000 false 500 false 35 000 false
 1 1
1 1
56.75 800.11 341.03 749.50 150.00 928.30 250.90 806.15 209.02 405.72 550.00 223.89 103.23 758.22 430.79 675.11 657.20 405.18 760.51 985.41
1 1
 
 Table: The LOAN AMOUNT continuous feature discretized into 4 equal-frequency bins.
 ID 15 19 1 10 12 4 17 16 11 8
BINNED LOAN LOAN AMOUNT AMOUNT 500 bin1 500 bin1 900 bin1 9,500 bin1 9,850 bin1 10,000 bin2 15,450 bin2 16,000 bin2 16,750 bin2 18,500 bin2
FRAUD false false true true true true false false false false
BINNED LOAN LOAN
ID AMOUNT 9 20,000 7 25,000 5 32,000 20 35,000 3 48,000 18 50,000 14 65,000 13 95,500 2 150,000 6 250,000
AMOUNT FRAUD bin3 false bin3 false bin3 false bin3 false bin3 false bin4 false bin4 false
bin4 true bin4 false bin4 true
    
Once we have discretized the data we need to record the raw continuous feature threshold between the bins so that we can use these for query feature values.
Table: The thresholds used to discretize the LOAN AMOUNT feature in queries.
Bin Thresholds
  9, 925 <
19, 225 <
49, 000 < Bin4
Bin1  9, 925
Bin2  19, 250
Bin3  49, 000
    Chapter 6B
 36 / 74
 
 Table: The Laplace smoothed (with k = 3) probabilities needed by a naive Bayes prediction model calculated from the fraud detection dataset. Notation key: FR = FRAUD, CH = CREDIT HISTORY, AB = ACCOUNT BALANCE, GC = GUARANTOR/COAPPLICANT, ACC = ACCOMMODATION, BLA = BINNED LOAN AMOUNT.
 P(fr) P(CH = none|fr) P(CH = paid|fr) P (CH = current |fr ) P(CH = arrears|fr) P(GC = none|fr) P (GC = guarantor |fr ) P (GC = coapplicant |fr ) P(ACC = own|fr) P(ACC = rent|fr) P(ACC = free|fr) P(AB = x|fr)
= 0.3
= 0.2222 = 0.2222 = 0.3333 = 0.2222 = 0.5333 = 0.2667 = 0.2
= 0.4667 = 0.3333 = 0.2
P(¬fr) = P(CH = none|¬fr) = P (CH = paid |¬fr ) = P (CH = current |¬fr ) = P(CH = arrears|¬fr) = P(GC = none|¬fr) = P (GC = guarantor |¬fr ) =
0.7 0.1154 0.2692 0.2692 0.3462 0.6522 0.1304 0.2174 0.6087 0.2174 0.1739
x, ! ⇡E  =0.0024
P(BLA = bin1|fr) P(BLA = bin2|fr) P(BLA = bin3|fr) P(BLA = bin4|fr)
= 0.3333 = 0.2222 = 0.1667 = 0.2778
0.1923 0.2692 0.3077 0.2308
P (GC
= coapplicant |¬fr ) = P(ACC = own|¬fr) = P (ACC = rent |¬fr ) = P(ACC = free|¬fr) =
P(AB = x|¬fr)
0B x, 1C
⇡ N B@μ = 984.26,CA   = 460.94
P(BLA = bin1|¬fr) = P(BLA = bin2|¬fr) = P(BLA = bin3|¬fr) = P(BLA = bin4|¬fr) =
 
Table: A query loan application from the fraud detection domain.
Credit Guarantor/ Account Loan
History CoApplicant Accomodation Balance Amount Fraudulent paid guarantor free 759.07 8,000 ?
     Chapter 6B
 38 / 74
 
 Table: The relevant smoothed probabilities, from Table 13 [37], needed by the naive Bayes model to make a prediction for the query
hCH = ’paid’, GC = ’guarantor’, ACC = ’free’, AB = 759.07, LA = 8 000i and the calculation of the scores for each candidate prediction.
 P(fr) P(CH = paid|fr) P (GC = guarantor |fr ) P(ACC = free|fr) P (AB = 759.07|fr )
0 759.07, 1 ⇡E@ =0.0024A
P(BLA = bin1|fr)
 Qmk=1 P(q[k] | fr)  ⇥ P(fr) = 0.000000462
= 0.3
= 0.2222 = 0.2667 = 0.2
P(¬fr) = P (CH = paid |¬fr ) = P (GC = guarantor |¬fr ) = P(ACC = free|¬fr) =
P (AB = 759.07|¬fr ) 0B759.07,1C
⇡ N B@μ = 984.26,CA =   = 460.94
0.7 0.2692 0.1304 0.1739
0.00077 0.1923
= 0.00039 = 0.3333
P(BLA = bin1|¬fr) =  Qnk=1 P(q[k] | ¬fr)  ⇥ P(¬fr) = 0.000000633
  
Summary
  Chapter 6B
 72 / 74
 
Naive Bayes models can suffer from zero probabilities of relatively rare events. Smoothing is an easy way to combat this.
Two ways to handle continuous features in probability-based models are: Probability density functions and Binning
Using probability density functions requires that we match the observed data to an existing distribution.
Although binning results in information loss it is a simple and effective way to handle continuous features in probability-based models.
Bayesian network representation is generally more compact than a full joint distribution, yet is not forced to assert global conditional independence between all descriptive features.
       Chapter 6B
 73 / 74
 

