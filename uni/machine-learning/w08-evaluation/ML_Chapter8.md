Fundamentals of Machine Learning
Chapter 8: Evaluation Sections 8.1, 8.2, 8.3
  
The most important part of the design of an evaluation experiment for a predictive model is ensuring that the data used to evaluate the model is not the same as the data used to train the model. 
 
The purpose of evaluation is threefold:
1 to determine which model is the most suitable for a task
2 to estimate how the model will perform
3 to convince users that the model will meet their needs 
 
Standard Approach: Measuring
Misclassification Rate on a Hold-out Test Set
 
 Figure: The process of building and evaluating a model using a hold-out test set.
 
Table: A sample test set with model predictions.
 ID Target Pred. Outcome
ID Target Pred.
11 ham ham TN 12 spam ham FN 13 ham ham TN 14 ham ham TN 15 ham ham TN 16 ham ham TN 17 ham spam FP 18 spam spam TP 19 ham ham TN 20 ham spam FP
Outcome
  1 2 3 4 5 6 7 8 9 10
spam ham FN spam ham FN ham ham TN spam spam TP ham ham TN spam spam TP ham ham TN spam spam TP spam spam TP spam spam TP 
 
misclassification rate = number incorrect predictions (1) total predictions 
 
misclassification rate = number incorrect predictions (1) total predictions
misclassification rate = (2 + 3) = 0.25 (6+9+2+3) 
 
For binary prediction problems there are 4 possible outcomes:
1 True Positive (TP)
2 True Negative (TN)
3 False Positive (FP)
4 False Negative (FN) 
 
Table: The structure of a confusion matrix.
  Target
Prediction positive negative
positive TP FN negative FP TN
 
Table: A confusion matrix for the set of predictions shown in Table 1 [7].
  Target
Prediction
’spam’ ’ham’ ’spam’ 6 3 ’ham’ 2 9
 
misclassification accuracy = (FP + FN) (2) (TP +TN +FP +FN) 
 
misclassification accuracy = (FP + FN) (2) (TP +TN +FP +FN)
misclassification accuracy = (2 + 3) = 0.25 (6+9+2+3) 
 
classification accuracy = (TP + TN) (3) (TP +TN +FP +FN) 
 
classification accuracy = (TP + TN) (3) (TP +TN +FP +FN)
classification accuracy = (6 + 9) = 0.75 (6+9+2+3) 
 
Summary
 
 1
2
3
Big Idea
Fundamentals
Standard Approach: Measuring Misclassification Rate on a Hold-out Test Set
Summary
4
 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 Fundamentals of Machine Learning
Chapter 8: Evaluation Sections 8.4, 8.5
 
 1
Designing Evaluation Experiments
Hold-out Sampling
k-Fold Cross Validation Leave-one-out Cross Validation Bootstrapping
Out-of-time Sampling
     2
Performance Measures: Categorical Targets
Confusion Matrix-based Performance Measures Precision, Recall and F1 Measure
Average Class Accuracy
Measuring Profit and Loss
    3
4 5
6
Performance Measures: Prediction Scores
Receiver Operating Characteristic Curves Kolmogorov-Smirnov Statistic
Measuring Gain and Lift
         7
Summary
Performance Measures: Multinomial Targets
Performance Measures: Continuous Targets
Basic Measures of Error
Domain Independent Measures of Error
Evaluating Models after Deployment
Monitoring Changes in Performance Measures Monitoring Model Output Distributions
Monitoring Descriptive Feature Distribution Changes Comparative Experiments Using a Control Group

Designing Evaluation Experiments
 
   Training** Predic'Voanli*da'on* Set* Model* Set*
 Test* Set*
(a) A 50:20:30 split
  Training** Set*
 VPraelidiac'on* MSoedte* l*
 Test* Set*
(b) A 40:20:40 split
Figure: Hold-out sampling can divide the full data into training, validation, and test sets.
 
     Performance on Training Set Performance on Validation Set
            0 50 100 150 200 Training Iteration
Figure: Using a validation set to avoid overfitting in iterative machine learning algorithms.
 Misclassification Rate
0.1 0.2 0.3 0.4 0.5

   Fold*1" Fold*2" Fold*3" Fold*4" Fold*5" Fold*6" Fold*7" Fold*8" Fold*9" Fold*10"
                  Figure: The division of data during the k-fold cross validation process. Black rectangles indicate test data, and white spaces indicate training data.
 
  Fold 1
2
3
4
5
Overall
Confusion Matrix
Class Accuracy
   Target
Target
Target
Target
Target
Target
’lateral’ ’frontal’
’lateral’ ’frontal’
’lateral’ ’frontal’
’lateral’ ’frontal’
’lateral’ ’frontal’
’lateral’ ’frontal’
Prediction
’lateral’ ’frontal’ 81%
43 9 10 38
Prediction
’lateral’ ’frontal’ 88%
46 9 3 42
Prediction
’lateral’ ’frontal’ 82%
51 10 8 31
Prediction
’lateral’ ’frontal’ 85%
51 8 7 34
Prediction
’lateral’ ’frontal’ 84%
46 9 7 38
Prediction
’lateral’ ’frontal’ 84%
237 45 35 183
           
 Fold*1" Fold*2" Fold*3" Fold*4" Fold*5"
Fold*k-2" Fold*k-1" Fold*k"
                   Figure: The division of data during the leave-one-out cross validation process. Black rectangles indicate instances in the test set, and white spaces indicate training data.
 
Performance Measures: Categorical Targets
 
Table: The structure of a confusion matrix.
Prediction positive negative
  Target
positive TP FN negative FP TN
 
Table: A confusion matrix for the set of predictions shown in Table 1 [7].
Prediction
’spam’ ’ham’
  Target
’spam’ 6 3 ’ham’ 2 9
 
TPR = TP (1) (TP + FN)
TNR = TN (2) (TN + FP)
FPR = FP (3) (TN + FP)
FNR = FN (4) (TP + FN)
 
TPR = 6 (6+3)
TNR = 9 (9+2)
FPR = 2 (9+2)
FNR = 3 (6+3)
=0.667 =0.818 =0.182 =0.333
 
precision = TP (5) (TP + FP)
recall = TP (6) (TP + FN)
 
precision = 6 = 0.75 (6+2)
recall = 6 = 0.667 (6+3)
 
F1-measure = 2 ⇥ (precision ⇥ recall) (7) (precision + recall)
 
F1-measure = 2 ⇥ (precision ⇥ recall) (7) (precision + recall)
⇣6⇥6⌘
F1-measure = 2 ⇥ ⇣(6+2) (6+3)⌘ 6+6
(6+2) (6+3) = 0.706
 
Table: A confusion matrix for a k-NN model trained on a churn prediction problem.
  Target
’non-churn’ ’churn’
Prediction
’non-churn’ ’churn’
90 0 9 1
Table: A confusion matrix for a naive Bayes model trained on a churn prediction problem.
  Target
’non-churn’ ’churn’
Prediction
’non-churn’ ’churn’
70 20 2 8
 
average class accuracy = 1 X recalll (8) |levels(t)| l2levels(t)
 
average class accuracy = 1 (9) HM 1 X 1
| levels(t) | l2levels(t) recalll |
| --------- | ------------------- |
 
✓1 ◆=1=18.2% 11+1 5.5
     2 1.0 0.1
✓ 1 ◆ = 1 = 78.873%
11+1 1.268 2 0.778 0.800
 
  (a) (b)
Figure: Surfaces generated by calculating (a) the arithmetic mean and (b) the harmonic mean of all combinations of features A and B that range from 0 to 100.
 
It is not always correct to treat all outcomes equally
In these cases, it is useful to take into account the cost of the different outcomes when evaluating models
 
Table: The structure of a profit matrix.
Prediction positive negative
  Target
positive TPProfit FNProfit negative FPProfit TNProfit
 
Table: The profit matrix for the pay-day loan credit scoring problem.
Prediction
’good’ ’bad’
  Target
’good’ 140  140 ’bad’  700 0
 
Table: (a) The confusion matrix for a k-NN model trained on the pay-day loan credit scoring problem (average class accuracyHM = 83.824%); (b) the confusion matrix for a decision tree model trained on the pay-day loan credit scoring problem (average class accuracyHM = 80.761%).
(a) k-NN model
Prediction
’good’ ’bad’
Target ’good’ 57 3 ’bad’ 10 30
(b) decision tree
    Target
’good’ ’bad’
Prediction
’good’ ’bad’
43 17 3 37
 
Table: (a) Overall profit for the k-NN model using the profit matrix in Table 4 [25] and the confusion matrix in Table 5(a) [26]; (b) overall profit for the decision tree model using the profit matrix in Table 4 [25] and the confusion matrix in Table 5(b) [26].
(a) k-NN model
Prediction
’good’ ’bad’
7980  420  7 000 0 Profit     560
(b) decision tree
Prediction
’good’ ’bad’
6020  2380  2 100 0 Profit     1 540
    Target
’good’ ’bad’
Target
’good’ ’bad’
 
Performance Measures: Prediction Scores
 
All our classification prediction models return a score which is then thresholded.
Example
           threshold (score, 0.5) = (positive if score   0.5 (10) negative otherwise
 
Table: A sample test set with model predictions and scores (threshold= 0.5.
Pred- Out-
Pred- Out- ID Target iction Score come
5 ham ham 0.302 TN 14 ham ham 0.348 TN 17 ham spam 0.657 FP 8 spam spam 0.676 TP 6 spam spam 0.719 TP 10 spam spam 0.781 TP 18 spam spam 0.833 TP 20 ham spam 0.877 FP 9 spam spam 0.960 TP 4 spam spam 0.963 TP
 ID Target iction 7 ham ham 11 ham ham 15 ham ham 13 ham ham 19 ham ham 12 spam ham 2 spam ham 3 ham ham 16 ham ham 1 spam ham
Score come 0.001 TN 0.003 TN 0.059 TN 0.064 TN 0.094 TN 0.160 FN 0.184 FN 0.226 TN 0.246 TN 0.293 FN
 
We have ordered the examples by score so the threshold is apparent in the predictions.
Note that, in general, instances that actually should get a prediction of ’ham’ generally have a low score, and those that should get a prediction of ’spam’ generally get a high score.
 
There are a number of performance measures that use this ability of a model to rank instances that should get predictions of one target level higher than the other, to assess how well the model is performing.
The basis of most of these approaches is measuring how well the distributions of scores produced by the model for different target levels are separated
 
     Prediction Score Prediction Score
(a) (b)
Figure: Prediction score distributions for two different prediction models. The distributions in

              0.0 0.2 0.4 0.6 0.8 1.0
Prediction Score
(a) spam
0.0 0.2
0.4 0.6 0.8 1.0
Prediction Score
(b) ham
Figure: Prediction score distributions for the (a) ’spam’ and (b) ’ham’ target levels based on the data in Table 7 [30].
 Density
0.0 0.5 1.0 1.5 2.0 2.5
Density
0.0 0.5 1.0 1.5 2.0 2.5

The receiver operating characteristic index (ROC index), which is based on the receiver operating characteristic curve (ROC curve), is a widely used performance measure that is calculated using prediction scores.
TPR and TNR are intrinsically tied to the threshold used to convert prediction scores into target levels.
This threshold can be changed, however, which leads to different predictions and a different confusion matrix.
 
Table: Confusion matrices for the set of predictions shown in Table 7 [30] using (a) a prediction score threshold of 0.75 and (b) a prediction score threshold of 0.25.
    Target
Target
’spam’ ’ham’
Prediction
’spam’ ’ham’
7 2 4 7
(a) Threshold: 0.75
Prediction
’spam’ ’ham’
’spam’ 4 4 ’ham’ 2 10
(b) Threshold: 0.25
 
  Score 0.001 0.003 0.059 0.064 0.094 0.160 0.184 0.226 0.246 0.293 0.302 0.348 0.657 0.676 0.719 0.781 0.833 0.877
Misclassification Rate True Positive Rate (TPR) True Negative rate (TNR)
False Positive Rate (FPR) False Negative Rate (FNR)
Pred. Pred. (0.10) (0.25) ham ham ham ham ham ham ham ham ham ham
spam ham spam ham spam ham spam ham spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam spam 0.300 0.300 1.000 0.778 0.455 0.636 0.545 0.364 0.000 0.222
Pred. Pred. Pred. (0.50) (0.75) (0.90) ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham ham
spam ham ham spam ham ham spam ham ham spam spam ham spam spam ham spam spam ham spam spam spam spam spam spam 0.250 0.300 0.350 0.667 0.444 0.222 0.818 0.909 1.000 0.182 0.091 0.000 0.333 0.556 0.778
ID Target 7 ham 11 ham 15 ham 13 ham 19 ham 12 spam 2 spam 3 ham 16 ham 1 spam 5 ham 14 ham 17 ham 8 spam 6 spam 10 spam 18 spam
 20 9 4
ham
spam 0.960 spam 0.963
  
Note: as the threshold increases TPR decreases and TNR increases (and vice versa).
Capturing this tradeoff is the basis of the ROC curve.
 
    Thresh = 0.25
Prediction spam ham
spam Target ham
72 47
   Thresh = 0.5
Prediction spam ham
spam Target ham
63 29
  Thresh = 0.75
Prediction spam ham
spam Target ham
42 2 10
  True Positive Rate True Negative Rate
  0.0 0.2 0.4 0.6 Threshold
(a)
0.8
1.0
0.0
0.2
0.4 0.6 0.8 1.0 False Positive Rate
(b)
Figure: (a) The changing values of TPR and TNR for the test data shown in Table 36 [37] as the threshold is altered; (b) points in ROC space for thresholds of 0.25, 0.5, and 0.75.
 0.0 0.2 0.4
0.6 0.8 1.0
Value
True Positive Rate
0.0 0.2 0.4 0.6 0.8 1.0

            0.0 0.2
0.4 0.6 False Positive Rate
(a)
0.8
1.0
0.0
0.2
0.4 0.6 False Positive Rate
(b)
Model 1 (0.996) Model 2 (0.887) Model 3 (0.764) Model 4 (0.595)
0.8 1.0
Figure: (a) A complete ROC curve for the email classification example; (b) a selection of ROC curves for different models trained on the same prediction task.
 True Positive Rate
0.0 0.2 0.4 0.6 0.8 1.0
True Positive Rate
0.0 0.2 0.4 0.6 0.8 1.0

We can also calculate a single performance measure from an ROC curve
The ROC Index measures the area underneath an ROC curve.
ROC index =
X|T| (FPR(T[i])   FPR(T[i   1])) ⇥ (TPR(T[i]) + TPR(T[i   1])) (11)
i=2 2
 
Performance Measures: Multinomial Targets
 
Table: The structure of a confusion matrix for a multinomial prediction problem with l target levels.
  level1
level1
level2 Target level3
.
levell
Prediction
Recall
- - -
. -
level2
level3
· · ·
levell
---- ---- ----
... ----
 Precision - - - ··· -
 
precision(l) = TP(l) (20) TP(l) + FP(l)
recall(l) = TP(l) (21) TP(l) + FN(l)
 
Table: A sample test set with model predictions for a bacterial species identification problem.
ID 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
Target durionis ficulneus fructosus ficulneus durionis pseudo. durionis ficulneus pseudo. pseudo. fructosus ficulneus durionis fructosus fructosus
Prediction fructosus fructosus fructosus ficulneus durionis pseudo. fructosus ficulneus pseudo. fructosus fructosus ficulneus durionis fructosus ficulneus
ID Target 16 ficulneus 17 ficulneus 18 fructosus 19 durionis 20 fructosus 21 fructosus 22 durionis 23 fructosus 24 pseudo. 25 durionis 26 pseudo. 27 fructosus 28 ficulneus 29 fructosus 30 fructosus
Prediction ficulneus ficulneus fructosus durionis fructosus fructosus durionis fructosus fructosus durionis pseudo. fructosus ficulneus fructosus fructosus
 
Table: A confusion matrix for a model trained on the bacterial species identification problem.
Prediction
Recall
0.714 0.857 0.909 0.600
  ’durionis’ ’ficulneus’ ’fructosus’ ’pseudo.’ Precision
’durionis’ ’ficulneus’ ’fructosus’ ’pseudo.’
5020 0610 0 1 10 0 0023
 Target
1.000
0.857
0.667
1.000
 
The average class accuracyHM for this problem is:
✓ 1 ◆= 1 =75.000%
 1 1+1+1+1 1.333 4 0.714 0.857 0.909 0.600
 
Performance Measures: Continuous Targets
 
1Xn 2
sum of squared errors = 2 (ti   M(di )) (22)
 i=1
Xn 2
(ti  M(di))
mean squared error = i=1 (23)
 n
vu ut Xn
 root mean squared error = Xn
i=1
(24)
u
(ti  M(di))2 n
abs(ti  M(di)) n
 mean absolute error = i=1
(25)
 
  ID 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
Linear Regression
k -NN Prediction
12.240 21.000 16.973
7.543
8.383 10.228 12.921
7.588
9.277 21.000 15.496
5.724 16.449 6.640 5.840 18.965 8.941 12.484 13.021 10.920 9.920 18.526 7.719 8.934 11.241 10.010 8.157 13.409 9.684 5.553
Target 10.502 18.990 20.000
6.883
5.351 11.120 11.420
4.836
8.177 19.009 13.282
8.689 18.050 5.388 10.646 19.612 10.576 12.934 10.492 13.439 9.849 18.045 6.413 9.522 12.083 10.104 8.924 10.636 5.457 3.538 MSE RMSE MAE R2
Prediction 10.730 17.578 21.760 7.001 5.244 10.842 10.913 7.401 8.227 16.667 14.424 9.874 19.503 7.020 10.358 16.219 10.680 14.337 10.366 14.035 9.821 16.639 7.225 9.565 13.048 10.085 9.048 10.876 4.080 7.090
Error 0.228 -1.412 1.760 0.118 -0.107 -0.278 -0.507 2.565 0.050 -2.341 1.142 1.185 1.453 1.632 -0.288 -3.393 0.104 1.403 -0.126 0.596 -0.029 -1.406 0.813 0.043 0.965 -0.020 0.124 0.239 -1.376 3.551 1.905 1.380 0.975 0.889
Error 1.738 2.010 -3.027 0.660 3.032 -0.892 1.500 2.752 1.100 1.991 2.214 -2.965 -1.601 1.252 -4.805 -0.646 -1.634 -0.451 2.529 -2.519 0.071 0.482 1.307 -0.588 -0.842 -0.095 -0.767 2.773 4.228 2.014 4.394 2.096 1.750 0.776
   
R2 = 1   sum of squared errors (26) total sum of squares
total sum of squares = 1 Xn  ti   t 2 (27) 2 i=1
 
Evaluating Models after Deployment
 
To monitor the on-going performance of a model, we need a signal that indicates that something has changed. There are three sources from which we can extract such a signal:
1 The performance of the model measured using appropriate performance measures
2 The distributions of the outputs of a model
3 The distributions of the descriptive features in query instances presented to the model
 
The simplest way to get a signal that concept drift has occurred is to repeatedly evaluate models with the same performance measures used to evaluate them before deployment.
We can calculate performance measures for a deployed model and compare these to the performance achieved in evaluations before the model was deployed.
If the performance changes significantly, this is a strong indication that concept drift has occurred and that the model has gone stale.
 
Although monitoring changes in the performance of a model is the easiest way to tell whether it has gone stale, this method makes the rather large assumption that the correct target feature value for a query instance will be made available shortly after the query has been presented to a deployed model.
 
An alternative to using changing model performance is to use changes in the distribution of model outputs as a signal for concept drift.
stability index = X ✓✓|At=l|   |Bt=l|◆ ⇥ loge ✓|At=l|/|Bt=l|◆◆ (28) l 2levels(t ) |A| |B| |A| |B|
 
In general,
stability index < 0.1, then the distribution of the newly collected test set is broadly similar to the distribution in the original test set.
stability index is between 0.1 and 0.25, then some change has occurred and further investigation may be useful.
stability index > 0.25 suggests that a significant change has occurred and corrective action is required.
 
 Table: Calculating the stability index for the bacterial species identification problem given new test data for two periods after model deployment. The frequency and percentage of each target level are shown for the original test set and for two samples collected after deployment. The column marked SIt shows the different parts of the stability index sum based on Equation (28)[72].
Original New Sample 1 New Sample 2
 Target Count ’durionis’ 7 ’ficulneus’ 7
’fructosus’ 11 ’pseudo.’ 5
Sum 30
% Count 0.233 12 0.233 8 0.367 16 0.167 9
45
% 0.267 0.178 0.356 0.200
SIt Count 0.004 12 0.015 9 0.000 14 0.006 25 0.026 60
% 0.200 0.150 0.233 0.417
SIt 0.005 0.037 0.060 0.229 0.331
   
stabilityindex = ✓7  12◆⇥loge✓7/12◆ 30 45 3045
    +✓7   8◆⇥loge✓7/8◆ ✓30 45◆ ✓30 45◆
    + 11 16 ⇥loge 11/16 ✓30 45◆ ✓30 45◆
    + 5 9 ⇥loge 5/9 30 45 3045
= 0.026
 
           durionis ficulneus fructosus Target
(a) Original
pseudo.
durionis ficulneus fructosus pseudo. Target
(b) New Sample 1
  New Sample 2
      New Sample 1
   durionis
ficulneus fructosus Target
pseudo.
Month
 Density Density
0.0 0.1 0.2 0.3 0.4 0.0 0.1 0.2 0.3 0.4
Stability Index
Density
0.0 0.1 0.2 0.3 0.4

We use control groups not to evaluate the predictive power of the models themselves, but rather to evaluate how good they are at helping with the business problem when they are deployed.
 
 Table: The number of customers who left the mobile phone network operator each week during the comparative experiment from both the control group (random selection) and the treatment group (model selection).
Control Group Treatment Group Week (Random Selection) (Model Selection)
1 21 23 2 18 15 3 28 18 4 19 20 5 18 15 6 17 17 7 23 18 8 24 20 9 19 18
10 20 19 11 18 13 12 21 16
Mean 20.500 17.667 Std. Dev. 3.177 2.708
    
These figures show that, on average, fewer customers churn when the churn prediction model is used to select which customers to call.
 