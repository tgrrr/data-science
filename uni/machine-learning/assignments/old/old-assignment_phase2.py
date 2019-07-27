
# TODO: NEW for Ass2
# - [ ] get rid of integers
# > you should never use integer-encoding for nominal categorical descriptive features
# - [ ] No major issue despite formatting issues. It would be more professionally if you include some explanations in markdown, instead of comments within codes.
# - [ ] Data wrangling was careful except using Isolation forest to detect outliers. You might want to use a different random seed to check if you will get similar outlier detection results.
# - [ ] Is your target feature a numeric or multiclass variable? Is it a classification or regression problem?

# ============================================================================ #

#%% Change working directory from the workspace root to the ipynb file location. Turn this addition off with the DataScience.changeDirOnImportExport setting
import os
try:
	os.chdir(os.path.join(os.getcwd(), 'assignments'))
	print(os.getcwd())
except:
	pass
#%% [markdown]
#   # MATH2319 Machine Learning
#   #### Phase 2-Assignment 2-Semester 1, 2019
#   #### Phil Steinke s3725547, Ash Olney s3686808
#%% [markdown]
#  TODO:
#  
# - [ ] Pick 3 different classifiers @together
# - [ ] FIXME: outliers, test it with random.seed
#  > FEEDBACK: Data wrangling was careful except using Isolation forest to detect outliers. You might want to use a different random seed to check if you will get similar outlier detection results.
# - [ ] > FEEDBACK: Is your target feature a numeric or multiclass variable?
# - [ ] > FEEDBACK: Is it a classification or regression problem?
# - [ ] Performance shall be measured as RMSE (root mean squared error) on the test dataset.
# - [ ] deal with NA's in test dataset
#  > From assignment Please keep in mind that the training dataset has all the y values whereas the test dataset does not contain any y values. We actually know these y values, but we are apparently hiding them from you so that we can figure out the best team on the Kaggle competition!
# - [ ] Find most relevant features from phase #1-said in lecture that this can yield a better fit
# 
#  > No major issue despite formatting issues.<br />
#  > FEEDBACK: It would be more professionally if you include some explanations in markdown, instead of comments within codes.
#%% [markdown]
#   ----------------------------------------------------------------
#%% [markdown]
#   # Phase 2

#%%
# Change directory to VSCode workspace root so that relative path loads work correctly. Turn this addition off with the DataScience.changeDirOnImportExport setting
import os
try:
	os.chdir(os.path.join(os.getcwd(), '..'))
	print(os.getcwd())
except:
	pass


#%%
import pandas as pd
import numpy as np
import altair as alt
import math
from scipy import stats
from sklearn import preprocessing
# !pip install iso3166 # to install if in Colab
# from iso3166 import countries
import os
import io


#%%
# from google.colab import files
# uploaded = files.upload()


#%%
# from google.colab import drive
# drive.mount('/content/drive')
# !ls "/content/drive/My Drive/" # this line will let you know if it's mounted correctly


#%%
os.getcwd()
os.chdir('/Users/phil/code/data-science/uni/machine-learning/assignments')


#%%
__file_name__ = 'advertising_train.csv'
data = pd.read_csv(__file_name__)



#%% [markdown]
# ## Overview of Methodology-Rubric 4/30
# NOTE: three different ML algorithms
# 
#%% [markdown]
# ## Algorithm Fine-tuning and Performance Analysis-Rubric 10/30
# 
#%% [markdown]
# ## Performance comparison-Rubric 4/30
# NOTE:  present performance comparisons to indicate which method seems to work best
# 
#%% [markdown]
#   ## A Critique of Your Approach-Rubric 4/30
# 
#%% [markdown]
#   ## Summary and Conclusions-Rubric 4/30
# 
#%% [markdown]
#   ------------------------------------------------------------------
#%% [markdown]
#   # Data Source
#%% [markdown]
#   ------------------------------------------------------------------
# 
#   FOLLOWING IS SECTIONS FROM THE DEMO ASSIGNMENT IN R TO MODEL OFF
# 
#   ------------------------------------------------------------------
#%% [markdown]
#  # Introduction
#  - The objective of this project was to build classifiers to predict whether TODO:
#  - Data sourced from TODO:
#  - In Phase I, we CHECKME: cleaned the data and re-categorised some descriptive features to be less granular.
#  - In Phase II, we built three binar classifiers on the cleaned data. The rest of this report is organised as followS.
#  - Section 2 describes an overview of our methodology.
#  - Section 3 discusses the classifiers’ fine-tuning process and detailed performance analysis of each classifier.
#  - Section 4 compares the performance of the classifiers using the same resampling method.
#  - Section 5 critiques our methodology. The last section concludes with a summary.
#%% [markdown]
#  # Methodology
#  - We considered three CHECKME: classifiers-Naive Bayes(NB), Random Forest(RF), and $K$- Nearest Neighbour(KNN).
#  - The NB was the baseline classifier.
#  - Each classifier was trainned to make probability predictions so that we were able to adjust prediction threshold to refine the performance.
#  - CHECKME: We split the full data set into 70% training set and 30% test set. Each set resembled the full data by having the same proportion of target classes i.e. approximately 76% of individuals earning less than USD 50, 000 and 24% earning higher.
#  - For fine-tuning process, we ran a five-folded cross-validation stratified sampling on each classifier. Stratified sampling was used to cater the slight imbalance class of the target feature.
#  - Next, for each classsifer, we determined the optimal probability threshold. Using the tuned hyperparameters and the optimal thresholds, we made predictions on the test data.
#  - During model training (hyperparameter tuning and threshold adjustment), we relied on mean misclassification error rate (mmce). In addition to mmce, we also used the confusion matrix on the test data to evaluate classifiers' performance. The modelling was implemented in `R` with the `mlr` package[@mlr].
#%% [markdown]
# # Hyperparameter Tune-Fining
# 
# ## Naive Bayes
# 
# - Since the training set might have unwittingly excluded rare instances, the NB classifier might produce some fitted zero probabilities as predictions.
# - To mitigate this, we ran a grid search to determine the optimal value of the Laplacian smoothing parameter. Using the stratified sampling discussed in the previous section, we experimented values ranging from 0 to 30.
# - The optimal Laplacian parameter was 3.33 with a mean test error of 0.167.
# 
# ## Random Forest
# 
# - We tune-fined the number of variables randomly sampled as candidates at each split(i.e. `mtry`). For a classification problem, @Breiman suggests `mtry` = $\sqrt{p}$ where $p$ is the number of descriptive features. In our case, $\sqrt{p} = \sqrt{11} = 3.31$. Therefore, we experimented `mtry` = 2, 3, and 4. We left other hyperparameters, such as the number of trees to grow at the default value. The result was 3 with a mean test error of 0.139.
# 
# ## $K$-Nearest Neighbour
# 
# - By using the optimal kernel, we ran a grid search on $k = 2, 3, ...20$. The outcome was 20 with a mean test error of 0.165.
#%% [markdown]
# ## Threshold Adjustment
# 
# - Remove the granular features
# - Set a common random seed for reproducibility

#%%
set.seed(1234)

#%% [markdown]
# - Spliting the data into 70% training & 30% test data
# - Get the training data and test data
#  They are quite balanced and representative of the full dataset
#  We shall use training data for modeling
#  and test data for model evaluation
#%% [markdown]
# 2. Modeling
#  
# 2.1. Basic configuration
#  
# - Configure classification task
# - Configure learners with probability type
# 
# 2.2 Model fine-tuning
# 
# - For naiveBayes, we can fine-tune Laplacian For randomForest, we can fine-tune mtry i.e mumber of variables randomly sampled as candidates at each split. Following Breiman, L. (2001), Random Forests, Machine Learning 45(1), 5-32,
# - we can try mtry = 2, 3, 4 as mtry = sqrt(p) where p = 11
# - For kknn, we can fine-tune k = 2 to 20
# - Configure tune control search and a 5-CV stratified sampling
# - Configure tune wrapper with tune-tuning settings
# - Train the tune wrappers
# - Predict on training data
# 
# 2.3 Obtain threshold values for each learner
# 
# > The following plots depict the value of mmce vs. the range of probability thresholds. The thresholds were approximately 0.60, 0.63, and 0.51 for NB, RF, and 20-KNN classifiers respectively. These thresholds were used to determine the probability of an individual earning more than USD 50,000.
#%% [markdown]
#  Evaluation
#  Get threshold for each learner

