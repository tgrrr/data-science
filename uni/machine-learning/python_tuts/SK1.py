#%% Change working directory from the workspace root to the ipynb file location. Turn this addition off with the DataScience.changeDirOnImportExport setting
import os
try:
	os.chdir(os.path.join(os.getcwd(), 'python_tuts'))
	print(os.getcwd())
except:
	pass
#%% [markdown]
# # scikit-learn Part 1: Data Preparation and Model Fitting
# ***
#%% [markdown]
# This is the first in a series of tutorials on supervised machine learning with Python and `scikit-learn`. This tutorial's topics are data preperation and model fitting using a train-test-split approach.
# 
# ## Learning Objectives
# 
# - Get a first taste in `scikit-learn` by going through three examples of supervised learning: 
#     - Binary classification
#     - Regression
#     - Multiclass classification (as an exercise with solutions provided)
# - Load datasets from `scikit-learn` as well as from the Cloud
# - Discretize numeric features
# - Make categorical features numeric
# - Encode target features for classification problems
# - Split the data into a training set and a test set
# - Fit and evaluate a nearest neighbor model
# - Fit and evaluate a decision-tree model
# - Fit and evaluate a Gaussian Naive Bayes model
# - Deploy a model in the real world for predicting new observations
#%% [markdown]
# As an overview of the big picture, we shall cover various aspects of `scikit-learn` in the following tutorials:
# 
# - **scikit-learn Part 1:** Data preparation and model fitting (this notebook)
# - **scikit-learn Part 2:** Feature selection and ranking
# - **scikit-learn Part 3:** Cross-validation and hyperparameter tuning
# - **scikit-learn Part 4:**  Machine learning pipeline and statistical model comparison
# - **scikit-learn Part 5:** Model evaluation
# - A complete case study
#%% [markdown]
# ## Table of Contents
# 
# * [Supervised Learning Tasks](#1)
#   - [Three Common Types of Supervised Learning Tasks](#1.1)
#   - [Other Types of Supervised Learning Tasks](#1.2)
#   - [Overview of Examples](#1.3)
# * [Binary Classification Example: Breast Cancer Wisconsin Data](#2)
#   - [Reading Breast Cancer Dataset from the Cloud](#2.2)
#   - [Discretizing Numeric Features](#2.2.1)
#   - [Making Categorical Features Numeric](#2.2.2)
#   - [Encoding Target](#2.3)
#   - [Scaling Descriptive Features](#2.4)
#   - [Spliting Data into Training and Test Sets](#2.5)
#   - [Fitting a Nearest Neighbor Classifier](#2.6)
#   - [Fitting a Decision Tree Classifier](#2.7)
#   - [Fitting a Gaussian Naive Bayes Classifier](#2.8)
#   - [Deploying a Model](#2.9)
# * [Regression Example: Boston Housing Data](#3)
#   - [Reading and Spliting Data](#3.1)
#   - [Fitting and Evaluating a Regressor](#3.2)
# * [Exercises](#4)
#   - [Problems](#4.1)  
#   - [Possible Solutions](#4.2)
#%% [markdown]
# ## Supervised Learning Tasks <a class="anchor" id="1"></a>
# 
# In line with our textbook's notation, supervised learning is a machine learning task which uses a set of descriptive features $D$ to predict a target feature $t$. Note that `scikit-learn` documentation and many machine learning books use $X$ and $y$ to denote input dataset and target feature respectively.
#%% [markdown]
# ### Three Common Types of Supervised Learning Tasks <a class="anchor" id="1.1"></a>
# 
# The three common types of target feature $t$ are as follows:
# 
# 1. **Continuous targets**. For example, house prices; loan amounts.
# 2. **Binary targets**. For instance, whether a patient has Type 2 diabetes or not; whether a loan will default or not.
# 3. **Multiclass targets**. For example, five-level Likert items such as "very poor", "poor", "average", "good" and "very good".
# 
# Let's get familiar with some terminology. When the target feature is continuous, we coin it as a `regression problem`. The predictive model is then called a `regressor`. If the target feature is binary or multiclass, we say it is a `classification problem`. In fact, binary is a special case of multiclass targets (it has only two classes). The model built is called a `classifier`.
#%% [markdown]
# ### Other Types of Supervised Learning Tasks <a class="anchor" id="1.2"></a>
# 
# Before we proceed further, it is worth to mention other types of target features that we shall not cover:
# 
# * **Count targets**, such as number of road accidents in Victoria.
# * **Multilabel targets**. Suppose we conduct a survey asking RMIT students "why do you love Melbourne". The possible answers include "coffee", "nice weather", "nice food", or "friendly people". The answers to the survey are an example of `multilabel` target variables. The labels are not mutually exclusive as the survey participants could select more than one answer, for example ("coffee", "nice weather"), ("coffee"), ("nice food", "friendly people"), or "all above".
# * **Proportional targets**, which are continuous, but strictly between 0 and 1, or equivalently 0 and 100%. For example, loan default probability, which is apparently between 0 and 1.
#%% [markdown]
# ### Overview of Examples <a class="anchor" id="1.3"></a>
# 
# To reiterate, we shall focus on continuous, binary, and multiclass targets in this and upcoming tutorials using the sample datasets below:
# 
# 1. [Breast Cancer Wisconsin Data](https://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+%28Diagnostic%29). The target feature is binary, i.e., if a cancer diagnosis is "malignant" or "benign".
# 2. [Boston Housing Data](https://archive.ics.uci.edu/ml/machine-learning-databases/housing/). The target feature is continuous, which is the house prices in Boston in 1970's.
# 3. [Wine Data](https://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data). The target feature is multiclass. It consists of three classes of wines in a particular region in Italy.
# 
# These datasets can be loaded from `scikit-learn`. Let's go through Breast Cancer Data and Boston Housing Data. We shall leave Wine Data as an exercise (with possible solutions).
#%% [markdown]
# ## Binary Classification Example: Breast Cancer Wisconsin Data <a class="anchor" id="2"></a>
# 
# This dataset contains 569 observations and has 30 input features. The target feature has two classes: 212 "malignant" (M) and 357 "benign" (B). 
#%% [markdown]
# ### Reading Breast Cancer Dataset from the Cloud <a class="anchor" id="2.2"></a>
# 
# We can load the data from `scikit-learn`, or we can read the data directly from the following github account.

#%%
import warnings
warnings.filterwarnings("ignore")

import pandas as pd
import io
import requests
import os


# if you run into any SSL certification issues, 
# you may need to run the following command for a Mac OS installation.
# $/Applications/Python\ 3.6/Install\ Certificates.command


#%%



#%%
# print os.getcwd() 


#%%
# how to read a csv file from a github account
cancer_url = 'https://raw.githubusercontent.com/vaksakalli/datasets/master/breast_cancer_wisconsin.csv'
url_content = requests.get(cancer_url).content
cancer_df = pd.read_csv(io.StringIO(url_content.decode('utf-8')))

#%% [markdown]
# Let's check the shape of this dataset to make sure it has been downloaded correctly.

#%%
cancer_df.shape

#%% [markdown]
# Let's have a look at 10 randomly selected rows in this raw dataset.

#%%
cancer_df.sample(n=10)

#%% [markdown]
# Let's check to see which columns have null values.

#%%
col_nulls = {col: cancer_df[col].isnull().sum() for col in               
cancer_df.columns if cancer_df[col].isnull().sum() > 0}
print(col_nulls)

#%% [markdown]
# We observe that there are no columns with a missing value, which is good.
#%% [markdown]
# ### Discretizing Numeric Features <a class="anchor" id="2.2.1"></a>
#%% [markdown]
# Sometimes it's a good idea to discretize a numeric feature and make it a categorical feature. For instance, instead of treating 
# an age variable as numeric, it might be a better option to discretize is as young, middle-aged, and old.
# 
# Let's briefly digress here and see how we can discretize the `mean_area` numeric feature in the cancer dataset as "small", 
# "average", and "large" using equal-frequency binning. We can use the `qcut` method in the `pandas` module, which performs 
# quantile-based discretization. We can also supply names for the resulting discretization.
# 
# First, we will make a copy of the original dataset and give it a different name.

#%%
cancer_df_cat = cancer_df.copy()
cancer_df_cat['mean_area'] = pd.qcut(cancer_df_cat['mean_area'], q=3, 
                                     labels=['small', 'average', 'large'])

#%% [markdown]
# Let's make sure we performed the dicretization correctly using the `value_counts` method in `pandas`.

#%%
cancer_df_cat['mean_area'].value_counts()

#%% [markdown]
# Let's have a look at the first 5 rows in the categorized dataset. You will notice that `mean area` is now categorical.

#%%
cancer_df_cat.head(5)

#%% [markdown]
# ### Making Categorical Features Numeric  <a class="anchor" id="2.2.2"></a>
#%% [markdown]
# Next thing we would like to see is how we can make the new `mean_area` feature a numeric one. 
# 
# 
# **<font color=blue>Keep in mind that `scikit-learn` always requires all data to be numeric, so you must always encode your categorical features as numeric. </font>**
# 
# For this purpose, we resort to `one-hot-encoding`, which creates a binary variable for each unique value of the categorical feature you are encoding. 
# 
# We can use the `get_dummies` method in the `pandas` module for one-hot-encoding. This is a very simple and effective function as you can do one-hot-encoding for multiple features at once and you can even supply a custom prefix for each categorical feature.

#%%
cancer_df_cat = pd.get_dummies(cancer_df_cat, columns=['mean_area'], 
                               prefix=['avg_area'])
cancer_df_cat.head(5)

#%% [markdown]
# We notice that the `mean_area` feature is now replaced with three binary features at the end of the dataset.
#%% [markdown]
# ### Encoding Target <a class="anchor" id="2.3"></a>
#%% [markdown]
# Next, we split `cancer_df` into the set of descriptive features and the target. Note that we are using the original dataset here and not the categorized one, which was only for demonstration purposes. We shall call this data as "unscaled" as we shall scale it further below before fitting any models.

#%%
Data_unscaled = cancer_df.drop(columns = 'diagnosis').values
target = cancer_df['diagnosis']

#%% [markdown]
# Remember, `scikit-learn` always requires all data to be numeric, so the `target` needs to be encoded as 0 and 1. Note that if we had more than two levels, their label encoding would be 0,1,2,3, etc.
# 
# So, how does `scikit-learn` know if 0,1,2,3 etc. is actually a numeric feature, or it's label-encoding of a categorical feature? We tell this to `scikit-learn` with the type of machine learning algorithm we use. For predicting numerical target features, we fit a `regressor` whereas for predicting categorical target features, we fit a `classifier`.
# 
# First, let's count how many instances each label has in the target feature in the cancer dataset. 

#%%
target.value_counts()

#%% [markdown]
# As expected, "B" (Benign) and "M" (Malignant) have 357 and 212 observations respectively. Next, let's encode these as 0 and 1 using `LabelEncoder` from the `scikit-learn` preprocessing module.

#%%
from sklearn import preprocessing

le = preprocessing.LabelEncoder()
le_fit = le.fit(target)
target = le_fit.transform(target)

#%% [markdown]
# Note that the `LabelEncoder` labels in an alphabetical order. That is, "B" is labeled as 0 whereas "M" as labeled as 1. 
# 
# Let's check how the encoding was done. Here, you need to be careful with respect to `NumPy` vs. `pandas` objects. The return value of label encoding is a `NumPy` array, so you now need to use the `np.unique` method; because `value_counts` method belongs to the `pandas` module and it will not work with a `NumPy` object.

#%%
import numpy as np

print(type(target))
np.unique(target, return_counts = True)
# this will not work:
# ### target.value_counts()

#%% [markdown]
# **Note:** Please keep in mind that you can always go back and forth between a `NumPy` array and a `pandas` Series (or DataFrame) as below where `s` denotes a Series, `df` denotes a DataFrame, and `a` denotes an array:
# * `NumPy` to `pandas`: pd.Series(`a`) (or pd.DataFrame(`a`))
# * `pandas to Numpy`: `s`.values (or `df`.values)
#%% [markdown]
# So, once encoded, how do we recover the original labels? We can do that using the `inverse_transform` method of the `LabelEncoder`.

#%%
target_original_values = le_fit.inverse_transform(target)
# here is an example of NumPy array to pandas Series conversion:
pd.Series(target_original_values).value_counts()

#%% [markdown]
# ### Scaling Descriptive Features <a class="anchor" id="2.4"></a>
#%% [markdown]
# It is always a good idea to scale your descriptive features before fitting any models, as scaling is a must for some important class of models such as nearest neighbors, SVMs, and deep learning.
# 
# Three popular types of scaling are as follows:
# 1. **Min-Max Scaling:** Each descriptive feature is scaled to be between 0 and 1.
# 2. **Standard Scaling:** Scaling of each descriptive feature is done via standardization. That is, each value of the descriptive feature is scaled by removing the mean and dividing by the standard deviation of that feature. This ensures that, after scaling, each descriptive feature has a 0 mean and 1 standard deviation.
# 3. **Robust Scaling:** Robust scaling is similar to standard scaling. However, this scaling type is robust to potential outliers in the feature as the median is used instead of mean, and MAD (median absolute deviation) is used instead of the standard deviation. If you suspect that there are outliers in your dataset, you may prefer to use robust scaling. 
# 
# All of the above scaling types can be easily performed using the `preprocessing` module in `sklearn`. Let's have a look at a simple example.

#%%
from sklearn import preprocessing

x = np.arange(10).reshape(-1, 1)
x = np.vstack((x, 100.0))

min_max = preprocessing.MinMaxScaler().fit_transform(x).ravel()
standard = preprocessing.StandardScaler().fit_transform(x).ravel()
robust = preprocessing.RobustScaler().fit_transform(x).ravel()

x_scaled_df = pd.DataFrame({'x': x.ravel(), 'min_max': min_max, 'standard': standard, 'robust': robust}, index=np.arange(len(x)))
x_scaled_df.round(2)

#%% [markdown]
# Let's scale the descriptive features in our breast cancer dataset before fitting any classifiers. Here, we use the `MinMaxScaler` scaler as an illustration. We first fit the data to create a scaler that "knows" how to transform the input data. Next, we perform the actual transformation. The reason we specifically want a fitted scaler is that, once we figure out which model to use and we would like to make predictions for new observations, we will need to transform the new observations **exactly** as we transformed the descriptive features while training the model. This shall be demonstrated in the model deployment section below.

#%%
data_scaler = preprocessing.MinMaxScaler().fit(Data_unscaled)
Data = data_scaler.transform(Data_unscaled)

#%% [markdown]
# ### Spliting Data into Training and Test Sets <a class="anchor" id="2.5"></a>
# 
# We split the descriptive features and the target feature into a training set and a test set by a ratio of 70:30. That is, we use 70 % of the data to build a decision-tree classifier and evaluate its performance using the test set. 
# 
# To split data, we use `train_test_split` function from `scikit-learn`.
# 
# In a classification problem, we might have an uneven proportion of classes. In the breast cancer example, the target has 212 "M" and 357 "B" classes. Therefore, when splitting the data into training and test sets, it is possible that the class proportions in these split sets might be different from the original one. So, in order to ensure the proportion is not deviating from the ratio of 212/357 when splitting the data, we set the `stratify` option in `train_test_split` function to the `target` array.
# 
# Furthermore, in order to be able to replicate our analysis later on, we set the `random_state` option to 999.
# 
# Finally, in order to ensure the data is split randomly, we set the `shuffle` option to `True` (which, by the way, is `True` by default).

#%%
from sklearn.model_selection import train_test_split

# The "\" character below allows us to split the line across multiple lines
D_train, D_test, t_train, t_test =     train_test_split(Data, target, test_size = 0.3, 
                     stratify=target, shuffle=True, random_state=999)

#%% [markdown]
# ### Fitting a Nearest Neighbor Classifier <a class="anchor" id="2.6"></a>
#%% [markdown]
# Let's try a nearest neighbor classifier with 5 neighbors using the Euclidean distance.

#%%
from sklearn.neighbors import KNeighborsClassifier

knn_classifier = KNeighborsClassifier(n_neighbors=5, p=2)

#%% [markdown]
# We can now go ahead and fit the classifier on the train data and evaluate its performance on the test data. Let's first fit the nearest neighbor classifier on the training set. 

#%%
# we put a ";" at the end to supress the line's output
knn_classifier.fit(D_train, t_train);

#%% [markdown]
# Done! We have created a nearest neighbor classifier. We shall use accuracy to evaluate this classifer using the test set. The accuracy metric is defined as:
# 
# $$\text{Accuracy} = \frac{\text{Number of correct predicted labels}}{\text{Number of total observations}}$$
#%% [markdown]
# In order to evaluate the performance of our classifier on the test data, we use the `score` method and set `X = D_test` and `y = t_test`.

#%%
knn_classifier.score(X=D_test, y=t_test)

#%% [markdown]
# The nearest neighbor classifier scores an accuracy rate of 95.9\% in this particular case. That is impressive.
#%% [markdown]
# ### Fitting a Decision Tree Classifier <a class="anchor" id="2.7"></a>
# 
# Let's say we want to fit a decision tree with a maximum depth of 4 (`max_depth = 4`) using information gain for split criterion (`criterion = 'entropy'`). For reproducibility, we set `random_state = 999`.

#%%
from sklearn.tree import DecisionTreeClassifier

dt_classifier = DecisionTreeClassifier(max_depth=4,
                                       criterion='entropy',
                                       random_state = 999)

#%% [markdown]
# Now let's fit the decision tree on the training set. 

#%%
dt_classifier.fit(D_train, t_train);


#%%
dt_classifier.score(D_test, t_test)

#%% [markdown]
# The decision tree predicts the correct labels on the test set with an accuracy rate of 94%. However, there are other metrics, such as precision, recall, and F1 score, to assess model performance from different angles. We shall revisit model evaluation in `scikit-learn` Part 5.
#%% [markdown]
# ### Fitting a Gaussian Naive Bayes Classifier <a class="anchor" id="2.8"></a>
#%% [markdown]
# One last model we would like to fit to the breast cancer dataset is the Gaussian Naive Bayes classifier with a variance smoothing value of $10^{-3}$.

#%%
from sklearn.naive_bayes import GaussianNB

nb_classifier = GaussianNB(var_smoothing=10**(-3))
nb_classifier.fit(D_train, t_train)
nb_classifier.score(D_test, t_test)

#%% [markdown]
# We observe that the accuracy of the Gaussian Naive Bayes and decision tree classifiers are slightly lower compared to that of the nearest neighbor classifier. We would have to perform a **paired t-test** in order to determine if this difference is statistically significant or not. We shall cover this topic in upcoming tutorials.
#%% [markdown]
# ### Deploying a Model <a class="anchor" id="2.9"></a>
#%% [markdown]
# From the above discussion, we see that the nearest neighbor model with k=5 and p=2 gives slightly better results on the test data. Suppose we would like to go ahead and deploy this model in the real world for making a prediction on a new set of observations. 
# 
# The business of train-test-split (or cross-validation) is for comparing models and making sure we are not overfitting. Once we figure out which model to use for deployment, we use the **entire data** for training, not just the train data (which is 70%). Think about this: why would you throw away 30% of your data (that you used for testing) while training a model for deployment? That would be a waste of data, yet data is always valuable.
# 
# Once we train our deployment model with the entire data, we are ready to make predictions for new observations. The trick here is that, before making a new prediction, we must scale the new observations **exactly** as we scale the original input data. 
# 
# As an example, suppose the model is a main-effects logistic regression model. Consider an age feature with a minimum value of 20 and a maximum value of 60 that was normalized between 0 and 1 during training. Suppose the coefficient of the age feature in the logistic regression (after model fitting) is 1.6. For an observation with an age value of 40, its normalized value would be 0.5 and its contribution to the linear part in the logistic regression would be 1.6x0.5 = 0.8. In a set of new observations, suppose the minimum age is 30 and maximum age is 80. If normalized from scratch, an observation with an age value of 40 in the new set of observations would be (40-30)/(80-30) = 0.2, and its contribution to the linear part in the logistic regression would be 1.6x0.2 = 0.32, which will clearly result in different prediction probabilities. This example illustrates that new observations must be scaled **exactly** the same way as the original data.
# 
# For this purpose, we use the "data_scaler" object that we created earlier that "knows" how to transform input data. As an illustration, suppose we would like to find out the model's prediction for the first three rows in the input data. Of course, we already know the labels of these  rows (which are all malignant), so this is just to illustrate how you would make a prediction for a new set of observations.

#%%
# train deployment model on the entire (scaled) data
knn_classifier_deployment = KNeighborsClassifier(n_neighbors=5, p=2)
knn_classifier_deployment.fit(Data, target)

# get the first three observations from the original (unscaled) input data
obs_for_prediction_unscaled = Data_unscaled[0:3, ]

# scale these observations using the min-max scaler that was fitted to the input data
obs_for_prediction = data_scaler.transform(obs_for_prediction_unscaled)

# use the model's predict function for making a prediction for these three observations
knn_classifier_deployment.predict(obs_for_prediction)

#%% [markdown]
# ## Regression Example: Boston Housing Data <a class="anchor" id="3"></a>
# 
# ### Reading and Spliting Data <a class="anchor" id="3.1"></a>
# 
# The Boston Housing Data is available within `scikit-learn` datasets. Let's load the dataset and use 70 % of the data for training and the remaining 30 % for testing. The goal is to build a decision tree regressor to predict median value of owner-occupied homes in thousand dollars (labeled as `MEDV`) in Boston in 1970's. The input data has been cleaned; in particular, `CHAS` (Charles River dummy variable = 1 if tract bounds river; 0 otherwise) is already encoded. To display more information, you can print `housing_df.DESCR`.

#%%
from sklearn.datasets import load_boston

housing_data = load_boston()
print(housing_data.DESCR)

#%% [markdown]
# The `housing_data` object has two fields: `data` and `target`, both as Numpy arrays. To see the first few rows in the data and the target, we can use array slicing.

#%%
housing_data.data[:3,]


#%%
housing_data.target[:3,]

#%% [markdown]
# Let's split both the data and the target into train and test respectively.

#%%
from sklearn.model_selection import train_test_split
D_train, D_test, t_train, t_test =     train_test_split(housing_data.data, housing_data.target, test_size = 0.3,
        shuffle=True, random_state=999)

#%% [markdown]
# ### Fitting and Evaluating a Regressor  <a class="anchor" id="3.2"></a>
# 
# We create a decision tree regressor object (`DecisionTreeRegressor`) with a maximum depth of 4. Since it is a regression problem, we cannot build the model using information gain or purity. Instead, we build the regressor based on mean squared error (MSE). The MSE is given as:
# 
# $$\text{MSE} = \frac{1}{n} \sum_{i=1}^{n}(\hat{t}_{i} - t_{i})^2$$
# 
# where
# 
# * $n$ is the total number of observations in the dataset (it can be training or test).
# * $t_{i}$ is the actual target value for $i^{th}$ instance.
# * $\hat{t}_{i}$ is the predicted target value for $i^{th}$ instance.
# 
# A lower MSE value indicates a smaller difference between predicted and actual values on the average, and thus better prediction performance. 

#%%
from sklearn.tree import DecisionTreeRegressor

dt_regressor = DecisionTreeRegressor(max_depth = 4, random_state = 999)
dt_regressor.fit(D_train, t_train)

#%% [markdown]
# To compute MSE, we first need to predict on the test set.

#%%
t_pred = dt_regressor.predict(D_test)

#%% [markdown]
# Next, we import `mean_squared_error` from `sklearn.metrics` module and compute MSE using the predicted and test target feature values.

#%%
from sklearn.metrics import mean_squared_error

mse = mean_squared_error(t_test, t_pred)
mse

#%% [markdown]
# It is more intuitive to examine the root of MSE, which is denoted by RMSE, rather than MSE itself as RMSE is in the same units as the target feature.

#%%
np.sqrt(mse)

#%% [markdown]
# We observe that our decision tree regressor achieves a RMSE value of 4.4 (thousand dollars) for the Boston housing dataset.
#%% [markdown]
# ## Exercises <a class="anchor" id="4"></a>
# 
# ### Problems <a class="anchor" id="4.1"></a>
# 
# 1. On the breast cancer dataset, check if the accuracy score improves when we increase max depth from 4 to 5. **Note**: In upcoming tutorials, we shall demonstrate how to search for the optimal set of parameters such as max depth to improve model accuracy.
# 
# 2. Refresher questions for `pandas` and matplotlib: 
#     - Read Wine Data from `scikit` datasets by calling `sklearn.datasets import load_wine`.
#     - Plot a bar chart for target wine classes.
#     - Calculate means of all numeric variables for each wine class. Are mean values very different among wine classes for some numeric variables?
# 
# 3. Build a decision tree classifier for Wine Data and calculate the accuracy score.
#%% [markdown]
# ###  Possible Solutions <a class="anchor" id="4.2"></a>
# 
# **Problem 1**
# ```
# # Load and split the data using stratification
# 
# import numpy as np
# from sklearn.datasets import load_breast_cancer
# from sklearn.model_selection import train_test_split
# from sklearn.tree import DecisionTreeClassifier
# cancer_df = load_breast_cancer()
# Data, target = cancer_df.data, cancer_df.target
# 
# D_train, D_test, t_train, t_test = \
#     train_test_split(Data, target, 
#         test_size = 0.3, stratify = target)
# 
# # Calculate the counts for each label in test and training sets
# test_counts  = np.unique(t_test, return_counts = True)
# train_counts = np.unique(t_train, return_counts = True)
# 
# print('The class proportions in test set are ' + 
#     str(test_counts[1]/sum(test_counts[1])))
# print('The class proportions in test set are ' + 
#     str(train_counts[1]/sum(train_counts[1])))
# 
# decision_tree1 = DecisionTreeClassifier(max_depth = 4,
#                                         criterion = 'entropy',
#                                         random_state = 999)
# decision_tree2 = DecisionTreeClassifier(max_depth = 5,
#                                         criterion = 'entropy',
#                                         random_state = 999)
# decision_tree1.fit(D_train, t_train)
# decision_tree2.fit(D_train, t_train)
# 
# print(decision_tree1.score(X = D_test, y = t_test))
# print(decision_tree2.score(X = D_test, y = t_test))
# ```
#%% [markdown]
# **Problems 2 and 3**
# ```
# import numpy as np
# from sklearn.datasets import load_wine
# from sklearn.model_selection import train_test_split
# from sklearn.tree import DecisionTreeClassifier
# 
# wine = load_wine()
# 
# Data, target = wine.data, wine.target
# print(np.unique(wine.target, return_counts = True))
# 
# # prepare for plotting
# import matplotlib.pyplot as plt
# %matplotlib inline 
# %config InlineBackend.figure_format = 'retina'
# plt.style.use("ggplot")
# 
# # Draw the bar chart
# target_counts = np.unique(target, return_counts = True)
# plt.bar(target_counts[0], target_counts[1])
# plt.xlabel('Wine type')
# plt.ylabel('Counts')
# plt.show();
# 
# # Get means of all numeric variables for each target
# import pandas as pd
# all_data = pd.DataFrame(wine.data)
# all_data['target'] = target
# pd.pivot_table(all_data, index="target", aggfunc = np.mean)
# 
# # Build and visualise the model.
# D_train, D_test, t_train, t_test = \
#     train_test_split(Data, target, test_size = 0.3, stratify = target)
# 
# decision_tree = DecisionTreeClassifier(max_depth = 4,
#                                        criterion = 'entropy',
#                                        random_state = 999)
# decision_tree.fit(D_train, t_train)
# print(decision_tree.score(X = D_test, y = t_test))
# ```
#%% [markdown]
# ## References
# 
# * Scikit-learn: Machine Learning in Python, Pedregosa et al., JMLR 12, pp. 2825-2830, 2011.
#%% [markdown]
# ***
# 
# MATH2319 - Machine Learning @ RMIT University

