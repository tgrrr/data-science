# %% markdown
# # SK Part 0: Introduction to Machine Learning with Python and scikit-learn
# %% markdown
# This is the first in a series of tutorials on supervised machine learning with Python and `scikit-learn`. It is a short introductory tutorial that provides a bird's eye view using a binary classification problem as an example and it is actually is a simplified version of the tutorial **SK Part 1**. The reference textbook in these tutorials is below and it can be accessed [here](https://machinelearningbook.com/).
# * Kelleher, John D., Brian Mac Namee, and Aoife D’Arcy. 2015. Fundamentals of Machine Learning for Predictive Data Analytics: Algorithms, Worked Examples, and Case Studies. MIT Press.
# 
# 
# The classifiers illustrated are as follows:
# * **Nearest neighbors** (Chapter 5: Similarity-based learning)
# * **Decision trees** (Chapter 4: Information-based learning)
# * **Random forests ensemble method** (Chapter 4: Information-based learning)
# * **Naive Bayes** (Chapter 6: Probability-based learning)
# * **Support vector machines** (Chapter 7: Error-based learning)
# 
# As an overview, we shall cover various aspects of `scikit-learn` in the following tutorials:
# 
# - **SK Part 0 ("SK-Intro"):** Introduction to machine learning with Python and scikit-learn (this tutorial)
# - **SK Part 1 ("SK-Basics"):** Basic model fitting
# - **SK Part 2 ("SK-FS"):** Feature selection and ranking
# - **SK Part 3 ("SK-CV"):** Cross-validation and hyperparameter tuning
# - **SK Part 4 ("SK-Eval"):** Model evaluation (using performance metrics other than simple accuracy)
# - **SK Part 5 ("SK-Pipes"):** Machine learning pipeline, statistical model comparison, and model deployment
# 
# Throughout these tutorials, we use the [**Altair**](https://altair-viz.github.io/index.html) module for plotting. Altair works on Pandas data frames and behaves somewhat similar to the ggplot2 library in R. In addition, however, Altair allows charts to be interactive. A good introductory tutorial on Altair can be found [here](https://vallandingham.me/altair_intro.html). Altair appears to be a one-stop shop for all plotting routines in Python as it supports data frames, interactive plots, and faceting.
# %% markdown
# ## Binary Classification Example: Breast Cancer Wisconsin Data
# 
# This dataset is concerned with predicting whether a cell tissue is cancerous or not using the cell's measurement values. It contains 569 observations and 30 input features. The target feature, "diagnosis", has two classes: 212 "malignant" and 357 "benign", denoted by "M" and "B" respectively.
# 
# The dataset has no missing values and all features are numeric other than the target feature (which is binary).
# %% markdown
# ### Reading Breast Cancer Dataset from the Cloud
# 
# We load the data directly from the following github account.
# %%
import warnings
warnings.filterwarnings("ignore")

import numpy as np
import pandas as pd
import io
import requests

# for Mac OS users only!
# if you run into any SSL certification issues, 
# you may need to run the following command for a Mac OS installation.
# $/Applications/Python 3.x/Install Certificates.command
# if this does not fix the issue, please run the code chunk below
import os, ssl
if (not os.environ.get('PYTHONHTTPSVERIFY', '') and
    getattr(ssl, '_create_unverified_context', None)): 
    ssl._create_default_https_context = ssl._create_unverified_context

cancer_url = 'https://raw.githubusercontent.com/vaksakalli/datasets/master/breast_cancer_wisconsin.csv'
url_content = requests.get(cancer_url).content
cancer_df = pd.read_csv(io.StringIO(url_content.decode('utf-8')))
# %% markdown
# Let's check the shape of this dataset to make sure it has been downloaded correctly.
# %%
cancer_df.shape
# %% markdown
# Let's have a look at the first 5 rows in this raw dataset.
# %%
cancer_df.head(5)
# %% markdown
# ### Partitioning Dataset into the Set of Descriptive Features and the Target Feature
# %% markdown
# Next, we partition `cancer_df` columns into the set of descriptive features and the target.
# %%
# The ".values" part below converts the data frame to a 2-dimensional numpy array
Data = cancer_df.drop(columns = 'diagnosis').values
target = cancer_df['diagnosis']

# %% markdown
# ### Encoding Target
# %% markdown
# Keep in mind that `scikit-learn` always requires all data to be numeric, so the target needs to be encoded as 0 and 1.
# %%
from sklearn import preprocessing

target = preprocessing.LabelEncoder().fit_transform(target)

# %% markdown
# Note that the `LabelEncoder` labels in an alphabetical order. That is, "B" is labeled as 0 whereas "M" as labeled as 1 (see the code below).
# %%
np.unique(target, return_counts = True)
# %% markdown
# ### Scaling Descriptive Features
# %% markdown
# It's always a good idea to scale your descriptive features before fitting any models. Here, we use the "min-max scaling" so that each descriptive feature is scaled to be between 0 and 1. In the rest of this tutorial, we work with scaled data.
# %%
Data = preprocessing.MinMaxScaler().fit_transform(Data)
# %% markdown
# ### Spliting Data into Training and Test Sets 
# 
# We split the descriptive features and the target feature into a `training set` and a `test set` by a ratio of 70:30. That is, we use 70% of the data to build our classifiers and evaluate their performance on the remaining 30% of the data. This is to ensure that we measure model performance on unseen data in order to avoid overfitting. We also set a random state value so that we can replicate our results later on.
# %%
from sklearn.model_selection import train_test_split

D_train, D_test, t_train, t_test = train_test_split(Data, 
                                                    target, 
                                                    test_size = 0.3,
                                                    random_state=999)
# %% markdown
# ### Fitting a Nearest Neighbor Classifier
# %% markdown
# Let's fit a nearest neighbor classifier with 5 neighbors using the Euclidean distance. We fit the model on the train data and evaluate its performance on the test data.
# 
# Below, the `score` method returns the accuracy of the classifier on the test data. Accuracy is defined as the ratio of correctly predicted observations to the total number of observations.
# %%
from sklearn.neighbors import KNeighborsClassifier

knn_classifier = KNeighborsClassifier(n_neighbors=5, p=2)
knn_classifier.fit(D_train, t_train)
knn_classifier.score(D_test, t_test)
# %% markdown
# If you would like to see which parameters are available for a classifier, just type the name of the classifier followed by a question mark, e.g., "KNeighborsClassifier?".
# %%
# KNeighborsClassifier?
# %% markdown
# ### Fitting a Decision Tree Classifier
# %% markdown
# Let's fit a decision tree classifier with the entropy split criterion and a maximum depth of 4 on the train data, and then evaluate its performance on the test data. 
# %%
from sklearn.tree import DecisionTreeClassifier

dt_classifier = DecisionTreeClassifier(criterion='entropy', max_depth=4)
dt_classifier.fit(D_train, t_train)
dt_classifier.score(D_test, t_test)
# %% markdown
# ### Fitting a Random Forest Classifier
# %% markdown
# An ensemble method is a collection of many sub-classifiers. The final outcome is determined by a majority voting of the sub-classifiers. Random forest classifier is a popular ensemble method based on the idea of "bagging" where the sub-classifiers are decision trees. Let's fit a random forest classifier with 100 decision trees.
# %%
from sklearn.ensemble import RandomForestClassifier

rf_classifier = RandomForestClassifier(n_estimators=100)
rf_classifier.fit(D_train, t_train)
rf_classifier.score(D_test, t_test)
# %% markdown
# ### Fitting a Gaussian Naive Bayes Classifier
# %% markdown
# Another model we would like to fit to the breast cancer dataset is the Gaussian Naive Bayes classifier with a variance smoothing value of $10^{-3}$.
# %%
from sklearn.naive_bayes import GaussianNB

nb_classifier = GaussianNB(var_smoothing=10**(-3))
nb_classifier.fit(D_train, t_train)
nb_classifier.score(D_test, t_test)
# %% markdown
# ### Fitting a Support Vector Machine
# %% markdown
# One last model we fit is the SVM with all the default values.
# %%
from sklearn.svm import SVC

svm_classifier = SVC()
svm_classifier.fit(D_train, t_train)
svm_classifier.score(D_test, t_test)
# %% markdown
# ### Making Predictions with a Fitted Model
# %% markdown
# Once a model is built, a prediction can be made using the `predict` method of the fitted classifier.
# 
# For example, suppose we would like to use the fitted nearest neighbor classifier as our model, and we would like to find out the model's prediction for the first three rows in the input data. Of course, we already know the labels of these  rows (which are all malignant), so this is just to illustrate how you would make a prediction for a new observation.
# %%
new_obs = Data[0:3]
knn_classifier.predict(new_obs)
# %% markdown
# The model's prediction for these three rows is that they are all "1", that is, they are all "malignant". Thus, in this particular case, we observe that the model correctly predicts the first three rows in the input data.
# %% markdown
# ## Summary
# 
# This tutorial illustrates that Python and `Scikit-Learn` together provide a unified interface to model fitting and evaluation and they greatly simplify the machine learning workflow.
# 
# Of course, there is a whole lot more to supervised machine learning than what is shown in here, such as 
# 1. Other classification algorithms
# 2. Solving prediction problems where the target feature is numeric (a.k.a. regression problems)
# 3. Using other model performance metrics (e.g., precision, recall, mean squared error for regression, etc.)
# 4. More sophisticated model performance assessment methods (such as cross-validation)
# 5. How model parameters can be optimized (also known as hyperparameter tuning)
# 
# We shall cover these topics in the upcoming tutorials.
# %% markdown
# ***
# MATH2319 - Machine Learning @ RMIT University