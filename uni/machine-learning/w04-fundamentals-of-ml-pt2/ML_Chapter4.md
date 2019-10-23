Fundamentals of Machine Learning
Chapter 4: Information-based Learning Sections 4.1, 4.2, 4.3
  Chapter 4A
 1 / 65
 
 1
2
Big Idea
Fundamentals
Decision Trees Shannon’s Entropy Model Information Gain
   3
4
Standard Approach: The ID3 Algorithm
A Worked Example: Predicting Vegetation Distributions
 Summary
  Chapter 4A
 2 / 65
 
In this chapter we are going to introduce a machine learning algorithm that tries to build predictive models using only the most informative features.
In this context an informative feature is a descriptive feature whose values split the instances in the dataset into homogeneous sets with respect to the target feature value.
    Chapter 4A
 3 / 65
 
Big Idea
  Chapter 4A
 4 / 65
 
    (a) Brian (b) John (c) Aphra (d) Aoife Figure: Cards showing character faces and names for the Guess-Who game .
 Man
Yes Yes No No
Long Hair
No No Yes No
Glasses
Yes No No No
Name
Brian John Aphra Aoife
    Chapter 4A
 5 / 65
 
    (a) Brian (b) John (c) Aphra (d) Aoife Figure: Cards showing character faces and names for the Guess-Who game .
Which question would you ask first:
Is it a man?
2 Does the person wear glasses?
      1
      Chapter 4A
6 / 65
      
            Does the person wear glasses?
Does the person wear glasses?
  Yes No
  Yes No
Yes
No
Yes No
              Brian
Is it a man?
Brian
Do they have long hair?
                John
Do they have long hair?
Aphra
Is it a man?
            (a)
(b)
Aphra
Yes
No
Yes No
Aoife
Figure: The different question sequences that can follow in a game of Guess-Who beginning with the question Does the person wear glasses?
John
Aoife
  Chapter 4A
 7 / 65
 
In both of the diagrams:
􏰋 one path is 1 question long,
􏰋 one path is 2 questions long,
􏰋 and two paths are 3 questions long.
Consequently, if you ask Question (2) first the average number of questions you have to ask per game is:
1+2+3+3 =2.25 4
     Chapter 4A
 8 / 65
 
      Is it a man?
          Does the person wear glasses?
Do they have long hair?
    Yes No
Yes No
Yes No
        Brian
John
Figure: The different question sequences that can follow in a game of Guess-Who beginning with the question Is it a man?
Aphra
Aoife
  Chapter 4A
 9 / 65
 
All the paths in this diagram are two questions long.
So, on average if you ask Question (1) first the average number of questions you have to ask per game is:
2+2+2+2=2 4
     Chapter 4A
 10 / 65
 
On average getting an answer to Question (1) seems to give you more information than an answer to Question (2): less follow up questions.
This is not because of the literal message of the answers: YES or NO.
It is to do with how the answer to each questions splits the domain into different sized sets based on the value of the descriptive feature the question is asked about and the likelihood of each possible answer to the question.
     Chapter 4A
 11 / 65
 
  Big Idea
So the big idea here is to figure out which features are the most informative ones to ask questions about by considering the effects of the different answers to the questions, in terms of:
1 how the domain is split up after the answer is received,
2 and the likelihood of each of the answers.
               Chapter 4A
 12 / 65
 
Fundamentals
  Chapter 4A
 13 / 65
 
A decision tree consists of:
1 a root node (or starting node),
2 interior nodes
3 and leaf nodes (or terminating nodes).
Each of the non-leaf nodes (root and interior) in the tree specifies a test to be carried out on one of the query’s descriptive features.
Each of the leaf nodes specifies a predicted classification for the query.
      Chapter 4A
 14 / 65
 
ID 376 489 541 693 782 976
SUSPICIOUS WORDS true true true false false false
UNKNOWN SENDER false true true true false false
CONTAINS
IMAGES CLASS
true spam false spam false spam true ham false ham false ham
Table: An email spam prediction dataset.
     Chapter 4A
 15 / 65
 
  Contains Images
true
Suspicious Words
true false
(a)
Contains Images
    false
Unknown Sender
true
true
false
Unknown Sender
true false
     Suspicious Words
Suspicious Words
true false
          false
true
(b)
false
 ham
 spam
        spam
ham
spam
ham
spam
Figure: (a) and (b) show two decision trees that are consistent with the instances in the spam dataset. (c) shows the path taken through the tree shown in (a) to make a prediction for the query instance: SUSPICIOUS WORDS = ’true’, UNKNOWN SENDER = ’true’, CONTAINS IMAGES = ’true’.
ham
(c)
spam
ham
  Chapter 4A
 16 / 65
 
Both of these trees will return identical predictions for all the examples in the dataset.
So, which tree should we use?
    Chapter 4A
 17 / 65
 
Apply the same approach as we used in the Guess-Who game: prefer decision trees that use less tests (shallower trees).
This is an example of Occam’s Razor.
    Chapter 4A
 18 / 65
 
  How do we create shallow trees?
The tree that tests SUSPICIOUS WORDS at the root is very shallow because the SUSPICIOUS WORDS feature perfectly splits the data into pure groups of ’spam’ and ’ham’.
Descriptive features that split the dataset into pure sets with respect to the target feature provide information about the target feature.
So we can make shallow trees by testing the informative features early on in the tree.
All we need to do that is a computational metric of the purity of a set: entropy
                 Chapter 4A
 19 / 65
 
Claude Shannon’s entropy model defines a computational measure of the impurity of the elements of a set.
An easy way to understand the entropy of a set is to think in terms of the uncertainty associated with guessing the result if you were to make a random selection from the set.
    Chapter 4A
 20 / 65
 
Entropy is related to the probability of a outcome.
􏰋 High probability → Low entropy
􏰋 Low probability → High entropy
If we take the log of a probability and multiply it by -1 we get this mapping!
    Chapter 4A
 21 / 65
 
  What is a log?
Remember the log of a to the base b is the number to which we must raise b to get a.
log2(0.5) = −1 because 2−1 = 0.5 log2(1) = 0 because 20 = 1
log2(8) = 3 because 23 = 8
log5(25) = 2 because 52 = 25 log5(32) = 2.153 because 52.153 = 32
                  Chapter 4A
 22 / 65
 
         log2P(x)
−10 −8 −6 −4 −2 0
− log2P(x)
0 2 4 6 8 10
0.0 0.2 0.4
(a)
P(x)
0.6
0.8
1.0
0.0
0.2
0.4 0.6 0.8 1.0 P(x)
(b)
Figure: (a) A graph illustrating how the value of a binary log (the log to the base 2) of a probability changes across the range of probability values. (b) the impact of multiplying these values by −1.
   Chapter 4A
23 / 65

Shannon’s model of entropy is a weighted sum of the logs of the probabilities of each of the possible outcomes when we make a random selection from a set.
l
H(t)=−􏰆(P(t =i)×logs(P(t =i))) (1)
i=1
   Chapter 4A
 24 / 65
 
What is the entropy of a set of 52 different playing cards?
 H(card) =
= =
52
−􏰆P(card =i)×log2(P(card =i))
i=1
52 52
− 􏰆 0.019 × log2(0.019) = − 􏰆 −0.1096 i=1 i=1
5.700 bits
  Chapter 4A
 25 / 65
 
What is the entropy of a set of 52 playing cards if we only distinguish between the cards based on their suit {ê, T, , ♠}?
   Chapter 4A
 26 / 65
 
H(suit) = − 􏰆 P(suit = l) × log2(P(suit = l)) l ∈{ê,T, ,♠}
= −􏰀(P(ê)×log2(P(ê)))+(P(T)×log2(P(T)))
+ (P( ) × log2(P( ))) + (P(♠) × log2(P(♠))) 􏰁
= −􏰀 􏰂13/52 × log2(13/52)􏰃 + 􏰂13/52 × log2(13/52)􏰃
+ 􏰂13/52 × log2(13/52)􏰃 + 􏰂13/52 × log2(13/52)􏰃 􏰁
= −􏰀(0.25×−2)+(0.25×−2) +(0.25×−2)+(0.25×−2)􏰁
= 2 bits
  Chapter 4A
 27 / 65
 
 (a) H(card) = 0.00 (b) H(card) = 0.81 (c) H(card) = 1.00
(d) H(card) = 1.50 (e) H(card) = 1.58 (f) H(card) = 3.58 Figure: The entropy of different sets of playing cards measured in bits.
Chapter 4A 28 / 65

Table: The relationship between the entropy of a message and the set it was selected from.
 Entropy of a Message
High Medium Medium Low
Properties of the Message Set
A large set of equally likely messages.
A large set of messages, some more likely than others. A small set of equally likely messages.
A small set of messages with one very likely message.
    Chapter 4A
 29 / 65
 
   Suspicious Words
true
Contains Unknown Images
Sender
true false
true false
            ID Class
376 489 541
spam
(a)
(b)
(c)
false
ID Class
693 ham 782 ham 976 ham
ID Class
489
541
693 ham
spam
Figure: How the instances in the spam dataset split when we partition using each of the different descriptive features from the spam dataset in Table 1 [15]
spam
ID Class
376
693 ham
spam
ID Class
489
541
782 ham 976 ham
spam
 spam
  spam
spam
ID Class
376
782 ham 976 ham
 spam
  Chapter 4A
 30 / 65
 
Our intuition is that the ideal discriminatory feature will partition the data into pure subsets where all the instances in each subset have the same classification.
􏰋 SUSPICIOUS WORDS perfect split.
􏰋 UNKNOWN SENDER mixture but some information (when ’true’ most
instances are ’spam’).
􏰋 CONTAINS IMAGES no information.
One way to implement this idea is to use a metric called information gain.
    Chapter 4A
 31 / 65
 
  Information Gain
The information gain of a descriptive feature can be understood as a measure of the reduction in the overall entropy of a prediction task by testing on that feature.
              Chapter 4A
 32 / 65
 
Computing information gain involves the following 3 equations: H(t,D)=− 􏰆 (P(t =l)×log2(P(t =l))) (2)
l∈levels(t)
rem(d,D)= 􏰆 |Dd=l| ×H(t,Dd=l) (3) |D| 􏰒 􏰑􏰐 􏰓
   l∈levels(d) 􏰒 􏰑􏰐 􏰓
weighting partition Dd=l
IG (d, D) = H (t, D) − rem (d, D) (4)
entropy of
    Chapter 4A
 33 / 65
 
As an example we will calculate the information gain for each of the descriptive features in the spam email dataset.
   Chapter 4A
 34 / 65
 
Calculate the entropy for the target feature in the dataset.
H(t,D)=− 􏰆 (P(t =l)×log2(P(t =l))) l∈levels(t)
  ID 376 489 541 693 782 976
SUSPICIOUS WORDS true true true false false false
UNKNOWN SENDER false true true true false false
CONTAINS
IMAGES CLASS
true spam false spam false spam true ham false ham false ham
    Chapter 4A
 35 / 65
 
H(t,D)= − 􏰆 (P(t =l)×log2(P(t =l))) l ∈{’spam’,’ham’}
= − ((P(t = ’spam’) × log2(P(t = ’spam’)) + (P(t = ’ham’) × log2(P(t = ’ham’)))
= −􏰂􏰂3/6 × log2(3/6)􏰃 + 􏰂3/6 × log2(3/6)􏰃􏰃 = 1 bit
  Chapter 4A
 36 / 65
 
Calculate the remainder for the SUSPICIOUS WORDS feature in the dataset.
rem(d,D)= 􏰆 |Dd=l| ×H(t,Dd=l) |D| 􏰒 􏰑􏰐 􏰓
    l∈levels(d) 􏰒 􏰑􏰐 􏰓
weighting partition Dd=l
entropy of
   ID 376 489 541 693 782 976
SUSPICIOUS WORDS true true true false false false
UNKNOWN SENDER false true true true false false
CONTAINS
IMAGES CLASS
true spam false spam false spam true ham false ham false ham
    Chapter 4A
 37 / 65
 
rem (WORDS, D)
􏰄 |DWORDS=T | 􏰅 􏰄 |DWORDS=F | 􏰅 |D| × H (t, DWORDS=T ) + |D| × H (t, DWORDS=F )
= =
+
= 􏰂3/6 × 􏰂− 􏰂􏰂3/3 × log2(3/3)􏰃 + 􏰂0/3 × log2(0/3)􏰃􏰃􏰃􏰃
+ 􏰂3/6 × 􏰂− 􏰂􏰂0/3 × log2(0/3)􏰃 + 􏰂3/3 × log2(3/3)􏰃􏰃􏰃􏰃 = 0 bits
     
3/6 × − 􏰆 P(t = l) × log2(P(t = l)) l ∈{’spam’ ,’ham’ }
   
3/6 × − 􏰆 P(t =l)×log2(P(t =l)) l ∈{’spam’ ,’ham’ }
  Chapter 4A
 38 / 65
 
Calculate the remainder for the UNKNOWN SENDER feature in the dataset.
rem(d,D)= 􏰆 |Dd=l| ×H(t,Dd=l) |D| 􏰒 􏰑􏰐 􏰓
    l∈levels(d) 􏰒 􏰑􏰐 􏰓
weighting partition Dd=l
entropy of
   ID 376 489 541 693 782 976
SUSPICIOUS WORDS true true true false false false
UNKNOWN SENDER false true true true false false
CONTAINS
IMAGES CLASS
true spam false spam false spam true ham false ham false ham
    Chapter 4A
 39 / 65
 
rem (SENDER, D)
􏰄 |DSENDER=T | 􏰅 􏰄 |DSENDER=F | 􏰅 |D| × H (t, DSENDER=T ) + |D| × H (t, DSENDER=F )
= =
+
= 􏰂3/6 × 􏰂− 􏰂􏰂2/3 × log2(2/3)􏰃 + 􏰂1/3 × log2(1/3)􏰃􏰃􏰃􏰃
+ 􏰂3/6 × 􏰂− 􏰂􏰂1/3 × log2(1/3)􏰃 + 􏰂2/3 × log2(2/3)􏰃􏰃􏰃􏰃 = 0.9183 bits
     
3/6 × − 􏰆 P(t = l) × log2(P(t = l)) l ∈{’spam’ ,’ham’ }
   
3/6 × − 􏰆 P(t =l)×log2(P(t =l)) l ∈{’spam’ ,’ham’ }
  Chapter 4A
 40 / 65
 
Calculate the remainder for the CONTAINS IMAGES feature in the dataset.
rem(d,D)= 􏰆 |Dd=l| ×H(t,Dd=l) |D| 􏰒 􏰑􏰐 􏰓
    l∈levels(d) 􏰒 􏰑􏰐 􏰓
weighting partition Dd=l
entropy of
   ID 376 489 541 693 782 976
SUSPICIOUS WORDS true true true false false false
UNKNOWN SENDER false true true true false false
CONTAINS
IMAGES CLASS
true spam false spam false spam true ham false ham false ham
    Chapter 4A
 41 / 65
 
rem (IMAGES, D)
􏰄 |DIMAGES=T | 􏰅 􏰄 |DIMAGES=F | 􏰅 |D| × H (t, DIMAGES=T ) + |D| × H (t, DIMAGES=F )
= =
+
= 􏰂2/6 × 􏰂− 􏰂􏰂1/2 × log2(1/2)􏰃 + 􏰂1/2 × log2(1/2)􏰃􏰃􏰃􏰃
+ 􏰂4/6 × 􏰂− 􏰂􏰂2/4 × log2(2/4)􏰃 + 􏰂2/4 × log2(2/4)􏰃􏰃􏰃􏰃 = 1 bit
     
2/6 × − 􏰆 P(t = l) × log2(P(t = l)) l ∈{’spam’ ,’ham’ }
   
4/6 × − 􏰆 P(t =l)×log2(P(t =l)) l ∈{’spam’ ,’ham’ }
  Chapter 4A
 42 / 65
 
Calculate the information gain for the three descriptive feature in the dataset.
IG (d, D) = H (t, D) − rem (d, D)
   Chapter 4A
 43 / 65
 
IG (SUSPICIOUS WORDS, D) = H (CLASS, D) − rem (SUSPICIOUS WORDS, D) = 1 − 0 = 1 bit
IG (UNKNOWN SENDER, D) = H (CLASS, D) − rem (UNKNOWN SENDER, D) = 1 − 0.9183 = 0.0817 bits
IG (CONTAINS IMAGES, D) = H (CLASS, D) − rem (CONTAINS IMAGES, D) = 1 − 1 = 0 bits
The results of these calculations match our intuitions.
   Chapter 4A
 44 / 65
 
Standard Approach: The ID3 Algorithm
  Chapter 4A
 45 / 65
 
ID3 Algorithm (Iterative Dichotomizer 3)
Attempts to create the shallowest tree that is consistent with the data that it is given.
The ID3 algorithm builds the tree in a recursive, depth-first manner, beginning at the root node and working down to the leaf nodes.
     Chapter 4A
 46 / 65
 
 1 The algorithm begins by choosing the best descriptive feature to test (i.e., the best question to ask first) using information gain.
2 A root node is then added to the tree and labelled with the selected test feature.
3 The training dataset is then partitioned using the test.
4 For each partition a branch is grown from the node.
5 The process is then repeated for each of these branches using the relevant partition of the training set in place of the full training set and with the selected test feature excluded from further testing.
  Chapter 4A
 47 / 65
 
The algorithm defines three situations where the recursion stops and a leaf node is constructed:
1 All of the instances in the dataset have the same classification (target feature value) then return a leaf node tree with that classification as its label.
2 The set of features left to test is empty then return a leaf node tree with the majority class of the dataset as its classification.
3 The dataset is empty return a leaf node tree with the majority class of the dataset at the parent node that made the recursive call.
   Chapter 4A
 48 / 65
 
Table: The vegetation classification dataset.
 ID STREAM 1 false 2 true
3 true
4 false 5 false 6 true 7 true
SLOPE ELEVATION steep high moderate low
VEGETATION chaparral riparian
 steep medium riparian steep medium chaparral flat high conifer
steep highest conifer steep high chaparral
   Chapter 4A
 49 / 65
 
H (VEGETATION, D)
= − 􏰆 P(VEGETATION = l) × log2 (P(VEGETATION = l))
􏰍’chaparral’,􏰘 l ∈ ’riparian’,
’conifer’
= − 􏰂􏰂3/7 × log2(3/7)􏰃 + 􏰂2/7 × log2(2/7)􏰃 + 􏰂2/7 × log2(2/7)􏰃􏰃 = 1.5567 bits
  Chapter 4A
 50 / 65
 
Table: Partition sets (Part.), entropy, remainder (Rem.) and information gain (Info. Gain) by feature for the dataset in Table 3 [49].
 Split By Feature
STREAM SLOPE
ELEVATION
Level Part. ’true’ D1 ’false’ D2 ’flat’ D3 ’moderate’ D4 ’steep’ D5 ’low’ D6 ’medium’ D7 ’high’ D8 ’highest’ D9
Instances d2, d3, d6, d7
Partition Entropy 1.5
Rem. 1.2507
0.9793
Info. Gain
0.3060 0.5774
 d1, d4,d5 0.9183 d5 0 d2 0
d1,d3, d4 , d6 , d7 1.3710 d2 0
  d3,d4 1.0 0.6793 0.8774 d1 , d5 , d7 0.9183
d6 0
   Chapter 4A
 51 / 65
 
 Elevation
low highest medium high
      D6
 ID
 Stream
 Slope
Vegetation
  2
  true
  moderate
 riparian
  D9
 ID
Stream
  Slope
Vegetation
  6
 true
   steep
 conifer
  D8
 ID
Stream
  Slope
Vegetation
  1
 false
   steep
 chaparral
 5
 false
   flat
 conifer
  7
true
  steep
chaparral
  D7
 ID
Stream
  Slope
Vegetation
 3
 true
   steep
 riparian
  4
false
  steep
chaparral
Figure: The decision tree after the data has been split using ELEVATION.
  Chapter 4A
 52 / 65
 
H (VEGETATION, D7)
= − 􏰆 P(VEGETATION = l) × log2 (P(VEGETATION = l))
􏰍’chaparral’,􏰘 l ∈ ’riparian’,
’conifer’
= − 􏰂􏰂1/2 × log2(1/2)􏰃 + 􏰂1/2 × log2(1/2)􏰃 + 􏰂0/2 × log2(0/2)􏰃􏰃 = 1.0 bits
  Chapter 4A
 53 / 65
 
Table: Partition sets (Part.), entropy, remainder (Rem.) and information gain (Info. Gain) by feature for the dataset D7 in Figure 9 [52].
 Split By Feature
STREAM SLOPE
Level
’true’ ’false’ ’flat’ ’moderate’ ’steep’
Partition Info. Part. Instances Entropy Rem. Gain
D10 d3 001.0 D11 d4 0
D12 0
D13 0 1.0 0 D14 d3,d4 1.0
     Chapter 4A
 54 / 65
 
 Elevation
low highest medium high
      D6
 ID
 Stream
 Slope
Vegetation
  2
  true
  moderate
 riparian
  D9
 ID
Stream
  Slope
Vegetation
  6
 true
   steep
 conifer
  D8
 ID
Stream
  Slope
Vegetation
  1
 false
   steep
 chaparral
 5
 false
   flat
 conifer
  7
true
  steep
chaparral
 true
false
Stream
    D10
 ID
 Slope
Vegetation
  3
  steep
 riparian
  D11
 ID
 Slope
Vegetation
  4
  steep
 chaparral
Figure: The state of the decision tree after the D7 partition has been split using STREAM.
  Chapter 4A
 55 / 65
 
H (VEGETATION, D8)
= − 􏰆 P(VEGETATION = l) × log2 (P(VEGETATION = l))
􏰍’chaparral’,􏰘 l ∈ ’riparian’,
’conifer’
= − 􏰂􏰂2/3 × log2(2/3)􏰃 + 􏰂0/3 × log2(0/3)􏰃 + 􏰂1/3 × log2(1/3)􏰃􏰃 = 0.9183 bits
  Chapter 4A
 56 / 65
 
Table: Partition sets (Part.), entropy, remainder (Rem.) and information gain (Info. Gain) by by feature for the dataset D8 in Figure 10 [55].
 Split By Feature
STREAM SLOPE
Level
’true’ ’false’ ’flat’ ’moderate’ ’steep’
Part. Instances D15 d7
Partition
Entropy Rem.
Info. Gain
0.2517 0.9183
 0 0.6666 D16 d1,d5 1.0
 D17 d5 0
D18 0 0 D19 d1,d7 0
   Chapter 4A
 57 / 65
 
 Elevation
    low medium
Stream
false
highest
 D6
 ID
 Stream
 Slope
Vegetation
  2
  true
  moderate
 riparian
 D9
 ID
Stream
  Slope
Vegetation
  6
 true
   steep
 conifer
   high
  true
 D10
 ID
 Slope
Vegetation
  3
  steep
 riparian
 D11
 ID
 Slope
Vegetation
  4
  steep
 chaparral
   Slope
   flat
moderate
steep
  D19
 ID
 Stream
Vegetation
 1
 false
 chaparral
  7
 true
chaparral
 D17
 ID
 Stream
Vegetation
  5
  false
 conifer
 D18
 ID
 Stream
Vegetation
 -
 -
 -
   Figure: The state of the decision tree after the D8 partition has been split using SLOPE.
  Chapter 4A
 58 / 65
 
 Elevation
low medium high highest
Stream Slope
true false flat moderate steep
        riparian
conifer
         riparian
chaparral
conifer
Figure: The final vegetation classification decision tree.
chaparral
chaparral
  Chapter 4A
 59 / 65
 
 Elevation
low medium high highest
Stream Slope
true false flat moderate steep
        riparian
conifer
         riparian
chaparral
conifer
What prediction will this decision tree model return for the following query?
STREAM = ’true’, SLOPE=’Moderate’, ELEVATION=’High’
chaparral
chaparral
   Chapter 4A
 60 / 65
 
 Elevation
    low medium high highest
Stream Slope
true false flat moderate steep
    riparian
         riparian
chaparral
conifer
What prediction will this decision tree model return for the following query?
STREAM = ’true’, SLOPE=’Moderate’, ELEVATION=’High’ VEGETATION = ’Chaparral’
conifer
chaparral
chaparral
   Chapter 4A
 61 / 65
 
 ID STREAM 1 false 2 true
3 true
4 false 5 false 6 true 7 true
SLOPE ELEVATION steep high moderate low
VEGETATION chaparral riparian
 steep medium riparian steep medium chaparral flat high conifer
steep highest conifer steep high chaparral
 STREAM = ’true’, SLOPE=’Moderate’, ELEVATION=’High’ VEGETATION = ’Chaparral’
This is an example where the model is attempting to generalize beyond the dataset.
Whether or not the generalization is correct depends on whether the assumptions used in generating the model (i.e. the inductive bias) were appropriate.
    Chapter 4A
 62 / 65
 
Summary
  Chapter 4A
 63 / 65
 
The ID3 algorithm works the same way for larger more complicated datasets.
There have been many extensions and variations proposed for the ID3 algorithm:
􏰋 using different impurity measures (Gini, Gain Ratio)
􏰋 handling continuous descriptive features
􏰋 to handle continuous targets
􏰋 pruning to guard against over-fitting
􏰋 using decision trees as part of an ensemble (Random Forests) We cover these extensions in Section 4.4.
     Chapter 4A
 64 / 65
 
 1
2
Big Idea
Fundamentals
Decision Trees Shannon’s Entropy Model Information Gain
   3
4
Standard Approach: The ID3 Algorithm
A Worked Example: Predicting Vegetation Distributions
 Summary
  Chapter 4A
 65 / 65
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Fundamentals of Machine Learning
Chapter 4: Information-based Learning Sections 4.4, 4.5
  Chapter 4B
 1 / 52
 
1
2
3
4
5
Alternative Feature Selection Metrics Handling Continuous Descriptive Features Predicting Continuous Targets
Noisy Data, Overfitting and Tree Pruning
Model Ensembles
Boosting Bagging
Summary
  6
  Chapter 4B
 2 / 52
 
Alternative Feature Selection Metrics
  Chapter 4B
 3 / 52
 
Entropy based information gain, preferences features with many values.
One way of addressing this issue is to use information gain ratio which is computed by dividing the information gain of a feature by the amount of information used to determine the value of the feature:
  GR (d, D) =
X IG (d, D) (1)
  (P(d = l) ⇥ log2(P(d = l))) l2levels(d)
   Chapter 4B
 4 / 52
 
IG (STREAM, D) = IG (SLOPE, D) = IG (ELEVATION, D) =
0.3060 0.5774 0.8774
  Chapter 4B
 5 / 52
 
H (STREAM, D)
=   X P(STREAM = l) ⇥ log2 (P(STREAM = l))
l 2n’true’,o ’false’
=   ⇣⇣4/7 ⇥ log2(4/7)⌘ + ⇣3/7 ⇥ log2(3/7)⌘⌘ = 0.9852 bits
H ( S L O P E , DX)
=   (’flat’, ) P(SLOPE = l) ⇥ log2 (P(SLOPE = l))
l 2 ’moderate’, ’steep’
=   ⇣⇣1/7 ⇥ log2(1/7)⌘ + ⇣1/7 ⇥ log2(1/7)⌘ + ⇣5/7 ⇥ log2(5/7)⌘⌘ = 1.1488 bits
H ( E L E V A T I OXN , D )
=   8 9 P(ELEVATION = l) ⇥ log2 (P(ELEVATION = l))
><’low’, >= l 2 ’medium’,
>:’high’, >; ’highest’
=   ⇣⇣1/7 ⇥ log2(1/7)⌘ + ⇣2/7 ⇥ log2(2/7)⌘ + ⇣3/7 ⇥ log2(3/7)⌘ + ⇣1/7 ⇥ log2(1/7)⌘⌘ = 1.8424 bits
  Chapter 4B
 6 / 52
 
GR (STREAM, D) = 0.3060 = 0.3106 0.9852
GR (SLOPE, D) = 0.5774 = 0.5026 1.1488
GR (ELEVATION, D) = 0.8774 = 0.4762 1.8424
     Chapter 4B
 7 / 52
 
 Slope
   flat moderate steep
Elevation
low medium high
Stream
true false
highest
   conifer
riparian
        chaparral
  Figure: The vegetation classification decision tree generated using information gain ratio.
chaparral
conifer
  riparian
chaparral
  Chapter 4B
 8 / 52
 
Another commonly used measure of impurity is the Gini index: Gini(t,D)=1  X P(t=l)2 (2)
l2levels(t)
The Gini index can be thought of as calculating how often you would misclassify an instance in the dataset if you classified it based on the distribution of classifications in the dataset.
Information gain can be calculated using the Gini index by replacing the entropy measure with the Gini index.
     Chapter 4B
 9 / 52
 
Gini (VEGETXATION, D)
= 1   (’chapparal’,) P(VEGETATION = l)2
l 2 ’riparian’,
✓ ’conifer’ ⇣ ⌘2 ⇣ ⌘2◆
=1  (3/7)2+ 2/7 + 2/7 = 0.6531
  Chapter 4B
 10 / 52
 
Table: Partition sets (Part.), entropy, Gini index, remainder (Rem.), and information gain (Info. Gain) by feature
Split by Feature
STREAM SLOPE
ELEVATION
Level
’true’ ’false’ ’flat’ ’moderate’ ’steep’ ’low’ ’medium’ ’high’ ’highest’
Partition
Gini Index Rem.
Info. Gain
0.1054 0.2531
 Part. Instances
D1 d2 , d3 , d6 , d7
D2 d1 , d4 , d5
D3 d5 0
D4 d2 0 0.4 D5 d1, d3, d4, d6, d7 0.56
0.625 0.5476 0.4444
  D6 d2 0
D7 d3,d4 0.5 0.3333 0.3198
 D8 d1 , d5 , d7 0.4444 D9 d6 0
   Chapter 4B
 11 / 52
 
Handling Continuous Descriptive Features
  Chapter 4B
 12 / 52
 
The easiest way to handle continuous valued descriptive features is to turn them into boolean features by defining a threshold and using this threshold to partition the instances based their value of the continuous descriptive feature.
How do we set the threshold?
    Chapter 4B
 13 / 52
 
1 The instances in the dataset are sorted according to the continuous feature values.
2 The adjacent instances in the ordering that have different classifications are then selected as possible threshold points.
3 The optimal threshold is found by computing the information gain for each of these classification transition boundaries and selecting the boundary with the highest information gain as the threshold.
  Chapter 4B
 14 / 52
 
Once a threshold has been set the dynamically created new boolean feature can compete with the other categorical features for selection as the splitting feature at that node.
This process can be repeated at each node as the tree grows.
    Chapter 4B
 15 / 52
 
Table: Dataset for predicting the vegetation in an area with a continuous ELEVATION feature (measured in feet).
ID STREAM 1 false 2 true
3 true
4 false 5 false 6 true 7 true
SLOPE steep moderate steep steep flat steep steep
ELEVATION 3 900 300 1 500 1 200 4450 5 000 3 000
VEGETATION chapparal riparian riparian chapparal conifer conifer chapparal
     Chapter 4B
 16 / 52
 
Table: Dataset for predicting the vegetation in an area sorted by the continuous ELEVATION feature.
ID STREAM 2 true
4 false 3 true
7 true 1 false 5 false 6 true
SLOPE moderate steep steep steep steep flat steep
ELEVATION 300 1 200 1 500 3 000 3 900 4450 5 000
VEGETATION riparian chapparal riparian chapparal chapparal conifer conifer
     Chapter 4B
 17 / 52
 
Table: Partition sets (Part.), entropy, remainder (Rem.), and information gain (Info. Gain) for the candidate ELEVATION thresholds:  750,  1 350,  2 250 and  4 175.
Split by Threshold
 750  1 350  2 250  4 175
Part. Instances D1 d2
D2 d4, d3, d7, d1, d5, d6 D3 d2,d4
D4 d3, d7, d1, d5, d6 D5 d2 , d4 , d3
Partition Entropy 0.0 1.4591
Rem. 1.2507
Info. Gain
0.3060
  1.0 1.3728 0.1839 1.5219
0.9183 0.9650 0.5917 1.0
0.6935 0.8631
  D6 d7, d1, d5, d6
D7 d2, d4, d3, d7, d1
D8 d5,d6 0.0
0.9710
    Chapter 4B
 18 / 52
 
 Elevation
<4,175 ≥4,175
    D7
 ID
 Stream
 Slope
 Elevation
Vegetation
  2
  true
  moderate
  300
 riparian
  4
  false
  steep
  1,200
 chaparral
  3
  true
  steep
  1,500
 riparian
 7
 true
 steep
 3,000
 chaparral
  1
 false
 steep
 3,900
chaparral
 D8
 ID
Stream
  Slope
 Elevation
Vegetation
 5
 false
   flat
 4,450
 conifer
  6
true
  steep
 5,000
conifer
 Figure: The vegetation classification decision tree after the dataset has been split using ELEVATION   4 175.
  Chapter 4B
 19 / 52
 
 Elevation
  <4,175 ≥4,175
  Stream
true false
Elevation
<2,250 ≥2,250
    chaparral
    riparian
chaparral
Figure: The decision tree that would be generated for the vegetation classification dataset listed in Table 3 [17] using information gain.
conifer
  Chapter 4B
 20 / 52
 
Predicting Continuous Targets
  Chapter 4B
 21 / 52
 
Regression trees are constructed so as to reduce the variance in the set of training examples at each of the leaf nodes in the tree
We can do this by adapting the ID3 algorithm to use a measure of variance rather than a measure of classification impurity (entropy) when selecting the best attribute
    Chapter 4B
 22 / 52
 
The impurity (variance) at a node can be calculated using the following equation:
Pn    2
var(t,D)= i=1ti  ̄t (3)
  n 1
We select the feature to split on at a node by selecting the feature that minimizes the weighted variance across the resulting partitions:
d[best]=argmin X |Dd=l|⇥var(t,Dd=l) (4) d 2d l 2levels(d ) |D|
    Chapter 4B
 23 / 52
 
 uuu uuu uuu uh uh uh
(a)
(b)
(c)
(d)
uuuu - Target
uuuu - Underfitt
uuuu - Goldiloc
uh uh uh uh - Overfitti
Figure: (a) A set of instances on a continuous number line; (b), (c), and (d) depict some of the potential groupings that could be applied to these instances.
Chapter 4B 24 / 52

Table: A dataset listing the number of bike rentals per day.
ID SEASON WORK DAY RENTALS 1 winter false 800
ID SEASON 7 summer
WORK DAY RENTALS false 3000
   2 winter 3 winter 4 spring 5 spring 6 spring
false 826 true 900 false 2 100 true 4 740 true 4 900
8 9 10 11 12
summer
summer true autumn false autumn false autumn true
5 800 6 200 2 910 2 880 2 820
true
    Chapter 4B
 25 / 52
 
Table: The partitioning of the dataset in Table 5 [25] based on SEASON and WORK DAY features and the computation of the weighted variance for each partitioning.
Split by
Feature
SEASON WORK DAY
Level
’winter’
’spring’ ’summer’ ’autumn’ ’true’ ’false’
Part. Instances
D1 d1, d2, d3
D2 d4, d5, d6
D3 d7, d8, d9
D4 d10,d11,d12
D5 d3, d5, d6, d8, d9, d12 D6 d1, d2, d4, d7, d10, d11
| Dd =l | Weighted | D   | var (t,D) Variance |
| ----- | -------- | --- | ------------------ |
0.25 26921
0.25 24725333 13793311 0.25 3 040 000 3 0.25 21001
0.50 40263463 25518131 0.50 1 077 280 3
           Chapter 4B
 26 / 52
 
 Season
winter spring summer autumn
     D1
 ID
Work Day
 Rentals
  1
 false
  800
 2
 false
   826
  3
true
 900
 D4
 ID
Work Day
 Rentals
  10
 false
  2,910
 11
 false
   2,880
  12
true
 2,820
 D2
 ID
Work Day
 Rentals
  4
 false
  2,100
 5
 true
   4,740
  6
true
 4,900
 D3
 ID
Work Day
 Rentals
  7
 false
  3,000
 8
 true
   5,800
  9
true
 6,200
    Figure: The decision tree resulting from splitting the data in Table 5 [25] using the feature SEASON.
  Chapter 4B
 27 / 52
 
 Season
    winter
autumn
Work Day
true false
  Work Day
true false
spring
summer
     ID
Rentals
 Pred.
  1
 800
813
 2
 826
 ID
Rentals
 Pred.
  10
 2,910
2,895
 11
 2,880
   ID
Rentals
 Pred.
  3
 900
  900
 ID
Rentals
 Pred.
  12
 2,820
  2,820
        true
Work Day
false
Work Day
true
false
  ID
Rentals
 Pred.
  5
 4,740
4,820
 6
 4,900
  ID
Rentals
 Pred.
  8
 5,800
6,000
 9
 6,200
   ID
Rentals
 Pred.
  4
 2,100
  2,100
 ID
Rentals
 Pred.
  7
 3,000
  3,000
Figure: The final decision tree induced from the dataset in Table 5 [25]. To illustrate how the tree generates predictions, this tree lists the instances that ended up at each leaf node and the prediction (PRED.) made by each leaf node.
  Chapter 4B
 28 / 52
 
Noisy Data, Overfitting and Tree Pruning
  Chapter 4B
 29 / 52
 
In the case of a decision tree, over-fitting involves splitting the data on an irrelevant feature.
The likelihood of over-fitting occurring increases as a tree gets deeper because the resulting classifications are based on smaller and smaller subsets as the dataset is partitioned after each feature test in the path.
               Chapter 4B
 30 / 52
 
Pre-pruning: stop the recursive partitioning early. Pre-pruning is also known as forward pruning.
Common Pre-pruning Approaches
1 early stopping
2  2 pruning
Post-pruning: allow the algorithm to grow the tree as much as it likes and then prune the tree of the branches that cause over-fitting.
                 Chapter 4B
 31 / 52
 
 Common Post-pruning Approach
Using the validation set evaluate the prediction accuracy achieved by both the fully grown tree and the pruned copy of the tree. If the pruned copy of the tree performs no worse than the fully grown tree the node is a candidate for pruning.
               Performance on Training Set Performance on Validation Set
            0 50 100 150 200 Training Iteration
     Chapter 4B
 32 / 52
 Misclassification Rate
0.1 0.2 0.3 0.4 0.5

Table: An example validation set for the post-operative patient routing task.
CORE- STABLE- ID TEMP TEMP
1 high true 2 low true 3 high false 4 high false 5 low false 6 low true
 GENDER
male gen
female icu female icu male icu female icu male icu
DECISION
    Chapter 4B
 33 / 52
 
 Core-Temp
[icu]
  low
Gender
[icu]
male female
high
Stable-Temp
[gen]
true false
          icu
gen
Figure: The decision tree for the post-operative patient routing task.
gen
icu
  Chapter 4B
 34 / 52
 
 Core-Temp
[icu]
Core-Temp
[icu]
low high
     low
high
Stable-Temp
[gen]
true false
     Gender
[icu] (0)
male female
Stable-Temp
[gen] (2)
true false
  icu
icu (0)
              icu (0)
gen (2)
(a)
(b) (c)
gen
icu
Figure: The iterations of reduced error pruning for the decision tree in Figure 7 [34] using the validation set in Table 7 [33]. The subtree that is being considered for pruning in each iteration is highlighted in black. The prediction returned by each non-leaf node is listed in square brackets. The error rate for each node is given in round brackets.
gen (0)
icu (0)
gen (0)
icu (0)
   Chapter 4B
35 / 52
  Core-Temp
[icu] (1)
low high
Stable-Temp
[gen]
true false
    
Advantages of pruning:
Smaller trees are easier to interpret
Increased generalization accuracy when there is noise in the training data (noise dampening).
    Chapter 4B
 36 / 52
 
Model Ensembles
  Chapter 4B
 37 / 52
 
Rather than creating a single model they generate a set of models and then make predictions by aggregating the outputs of these models.
A prediction model that is composed of a set of models is called a
model ensemble.
In order for this approach to work the models that are in the ensemble must be different from each other.
     Chapter 4B
 38 / 52
 
 
There are two standard approaches to creating ensembles:
1 boosting
2 bagging.
   Chapter 4B
 39 / 52
 
Boosting works by iteratively creating models and adding them to the ensemble.
The iteration stops when a predefined number of models have been added.
When we use boosting each new model added to the ensemble is biased to pay more attention to instances that previous models miss-classified.
This is done by incrementally adapting the dataset used to train the models. To do this we use a weighted dataset
      Chapter 4B
 40 / 52
 
 Weighted Dataset
Each instance has an associated weight wi   0,
Initially set to 1 where n is the number of instances in the dataset.
After each model is added to the ensemble it is tested on the
training data and the weights of the instances the model gets correct are decreased and the weights of the instances the model gets incorrect are increased.
These weights are used as a distribution over which the dataset is sampled to created a replicated training set, where the replication of an instance is proportional to its weight.
           n
        Chapter 4B
 41 / 52
 
During each training iteration the algorithm:
1 Induces a model and calculates the total error, ✏, by summing the weights of the training instances for which the predictions made by the model are incorrect.
2 Increases the weights for the instances misclassified using:
w[i] w[i]⇥✓ 1 ◆ (5)
 2⇥✏
3 Decreases the weights for the instances correctly classified:
w[i] w[i]⇥✓ 1 ◆ (6) 2⇥(1 ✏)
 4 Calculate a confidence factor, ↵, for the model such that ↵ increases as ✏ decreases:
↵ = 1 ⇥ loge ✓1   ✏◆ (7) 2✏
    Chapter 4B
 42 / 52
 
Once the set of models have been created the ensemble makes
predictions using a weighted aggregate of the predictions made by the individual models.
The weights used in this aggregation are simply the confidence factors associated with each model.
    Chapter 4B
 43 / 52
 
When we use bagging (or bootstrap aggregating) each model in the ensemble is trained on a random sample of the dataset known as bootstrap samples.
Each random sample is the same size as the dataset and
sampling with replacement is used.
Consequently, every bootstrap sample will be missing some of the instances from the dataset so each bootstrap sample will be different and this means that models trained on different bootstrap samples will also be different
     Chapter 4B
 44 / 52
 
When bagging is used with decision trees each bootstrap sample only uses a randomly selected subset of the descriptive features in the dataset. This is known as subspace sampling.
The combination of bagging, subspace sampling, and decision trees is known as a random forest model.
    Chapter 4B
 45 / 52
 
  ID F1 F2 F3 Target
 1---- 2---- 3---- 4----
   Bagging and Subspace Sampling
      ID F2 F3 Target
 2--- 2--- 4--- 4---
    ID F1 F3 Target
1--- 1--- 2--- 3---
ID F1 F3 Target
1--- 3--- 3--- 4---
          Machine Learning Machine Learning Machine Learning Algorithm Algorithm Algorithm
          F3 F2 F1
    F1
F3
MODEL ENSEMBLE
Figure: The process of creating a model ensemble using bagging and subspace sampling.
  Chapter 4B
 46 / 52
 
Which approach should we use? Bagging is simpler to implement and parallelize than boosting and, so, may be better with respect to ease of use and training time.
Empirical results indicate:
I boosted decision tree ensembles were the best performing model of those tested for datasets containing up to 4,000 descriptive features.
I random forest ensembles (based on bagging) performed better for datasets containing more that 4,000 features.
    Chapter 4B
 47 / 52
 
Summary
  Chapter 4B
 48 / 52
 
The decision tree model makes predictions based on sequences of tests on the descriptive feature values of a query
The ID3 algorithm as a standard algorithm for inducing decision trees from a dataset.
    Chapter 4B
 49 / 52
 
 Decision Trees: Advantages
interpretable.
handle both categorical and continuous descriptive features.
has the ability to model the interactions between descriptive features (diminished if pre-pruning is employed)
relatively, robust to the curse of dimensionality. relatively, robust to noise in the dataset if pruning is used.
                   Chapter 4B
 50 / 52
 
 Decision Tress: Potential Disadvantages
trees become large when dealing with continuous features.
decision trees are very expressive and sensitive to the dataset, as a result they can overfit the data if there are a lot of features (curse of dimensionality)
eager learner (concept drift).
                 Chapter 4B
 51 / 52
 
1
2
3
4
5
Alternative Feature Selection Metrics Handling Continuous Descriptive Features Predicting Continuous Targets
Noisy Data, Overfitting and Tree Pruning
Model Ensembles
Boosting Bagging
Summary
  6
  Chapter 4B
 52 / 52
 