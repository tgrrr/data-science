#%% Change working directory from the workspace root to the ipynb file location. Turn this addition off with the DataScience.changeDirOnImportExport setting
import os
try:
	os.chdir(os.path.join(os.getcwd(), 'python_tuts'))
	print(os.getcwd())
except:
	pass
#%% [markdown]
# # scikit-learn Part 3: Cross-Validation and Hyperparameter Tuning
# * * *
#%% [markdown]
# ## Learning Objectives
# 
# - Implement various cross-validation strategies.
# 
# - Perform grid search to identify optimal hyperparameter values.
# 
# 
# As in Part 1, we shall use the following datasets for regression, binary, and multiclass classification problems.
# 
# 1. [Breast Cancer Wisconsin Data](https://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+%28Diagnostic%29). The target feature is binary, i.e., if a cancer diagnosis is "malignant" or "benign".
# 2. [Boston Housing Data](https://archive.ics.uci.edu/ml/machine-learning-databases/housing/). The target feature is continuous. The target is house prices in Boston in 1970's.
# 3. [Wine Data](https://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data). The target feature is multiclass. It consists of three types of wines in Italy.
# 
# We use KNN, DT, and NB models to illustrate how cross-validation is used to tune hyperparameters of a machine learning algorithm via grid search by going through the Breast Cancer Data and Boston Housing Data. We will leave Wine Data and other machine learning models as exercises.
#%% [markdown]
# ## Table of Contents
# 
# * [Binary Classification Example: Breast Cancer Wisconsin Data](#1)
#   - [Data Preparation](#1.0)
#   - [Nearest Neigbor Models](#1.1)
#   - [Cross-Validation](#1.2)
#   - [KNN Hyperparameter Tuning and Visualization](#1.3)
#   - [DT Hyperparameter Tuning and Visualization](#1.4)
#   - [NB Hyperparameter Tuning and Visualization](#1.5)
# * [Regression Example: Boston Housing Data](#2)
# * [Exercises](#3)
#   - [Problems](#3.1)
#   - [Solutions](#3.2)
#%% [markdown]
# ## Binary Classification Example: Breast Cancer Wisconsin Data <a class="anchor" id="1"></a>
#%% [markdown]
# ### Data Preparation <a class="anchor" id="1.0"></a>
#%% [markdown]
# Let's prepare the dataset for modeling by performing the following:
# - load the dataset from `sklearn` (unlike the Cloud version, this version does not have column names), 
# - normalize the descriptive features so that they have 0 mean and 1 standard deviation, and
# - split the dataset into training and test sets.

#%%
import warnings
warnings.filterwarnings("ignore")

from sklearn.model_selection import train_test_split
from sklearn.datasets import load_breast_cancer
from sklearn import preprocessing

cancer_df = load_breast_cancer()
Data, target = cancer_df.data, cancer_df.target

# target is already encoded
Data = preprocessing.MinMaxScaler().fit_transform(Data)

D_train, D_test, t_train, t_test = train_test_split(Data, target, test_size = 0.3, random_state=999)

#%% [markdown]
# ### Nearest Neighbor Models <a class="anchor" id="1.1"></a>
#%% [markdown]
# Let's fit a 1-nearest neighbor (1-NN) classifier (`n_neighbors=1`) using the Euclidean distance (`p=2`).

#%%
from sklearn.neighbors import KNeighborsClassifier

knn_classifier = KNeighborsClassifier(n_neighbors=1, p=2)

knn_classifier.fit(D_train, t_train)
knn_classifier.score(D_test, t_test)

#%% [markdown]
# The 1-NN classifier yields an accuracy score of around 94.7%. So, how can we improve this score? One way is to search the set of "hyperparameters" which produces the highest accuracy score. For a nearest neighbor model, the hyperparameters are as follows:
# 
# * Number of neighbors.
# * Metric: Manhattan (p=1), Euclidean (p=2) or Minkowski (any p larger than 2). Technically, p=1 and p=2 are also Minkowski metrics, but in this notebook, we shall adopt the convention that the Minkowski metric corresponds to $p \geq 3$.
# 
# To search for the "best" set of hyperparameters, popular approaches are as follows:
# 
# * Random search: As its name suggests, it randomly selects the hyperparameter set to train models.
# * Bayesian search: It is beyond the scope of this course. So we shall not cover it here.
# * Grid search.
# 
# Grid search is the most common approach. It exhaustively searches through all possible combinations of hyperparameters during training the phase. For example, consider a KNN model. We can specify a grid of number of neighbors (K = 1, 2, 3) and two metrics (p=1, 2). The grid search starts training a model of K = 1 and p=1 and calculates its accuracy score. Then it moves to train models of (K = 2, p = 1), (K = 3, p = 1), (K = 1, p = 2), ..., and (K = 3, p = 2) and obtain their score values. Based on the accuracy scores, the grid search will rank the models and determine the set of hyperparameter values that give the highest accuracy score. 
# 
# Before we proceed further, we shall cover other cross-validation (CV) methods since tuning hyperparameters via grid search is usually cross-validated to avoid overfitting.
#%% [markdown]
# ### Cross-Validation <a class="anchor" id="1.2"></a>
# 
# In the previous tutorial, we learn how to evaluate a machine learning model using the `train_test_split` function to split the full set into disjoint training and test sets based on a specified test size ratio. We then train the model (that is, "fit") using the training set and evaluate it against the test set. 
# 
# There are other alternatives to a simple training/ test split. For example, we can perform K-fold cross-validation by calling the `KFold` function imported from `sklearn.model_selection` module. It randomly splits the full dataset into K subsets or "folds". Then it trains the model on K-1 folds and evaluates the model against the remaining fold. This process is repeated exactly K times where each time a different fold is used for testing.
# 
# Other cross-validation variants from `scikit-learn` are as follows:
# 
# * `model_selection.RepeatedKFold()`: Repeated K-Fold cross-validator
# * `model_selection.RepeatedStratifiedKFold()`: Repeated Stratified K-Fold cross-validator
# * `model_selection.StratifiedKFold()`: Stratified K-Fold cross-validator
# * `model_selection.LeaveOneOut()`: Leave One Out cross-validator
# 
# To learn more about cross-validators, please refer to [scikit-learn documentation](https://scikit-learn.org/stable/modules/classes.html#module-sklearn.model_selection).
# 
# **Refresher questions**
# 
# 1. What are the disadvantages of a simple test/ train split?
# 2. Can you tell the difference between the cross-validators above?
# 
# In the following example, we illustrate how we can conduct a stratified 5-fold (`n_splits = 5`) cross-validation with 3 repetitions (`n_repeats = 3`) using the `RepeatedStratifiedKFold` function. Since the target labels have fewer `malignant` labels than `benign`, stratification ensures that the proportion of the two labels in both train and test sets are the same as the proportion in the full dataset in each cross-validation repetition.

#%%
from sklearn.model_selection import RepeatedStratifiedKFold

cv_method = RepeatedStratifiedKFold(n_splits=5, 
                                    n_repeats=3, 
                                    random_state=999)

#%% [markdown]
# ### KNN Hyperparameter Tuning and Visualization <a class="anchor" id="1.3"></a>
#%% [markdown]
# It's hyperparameter tuning time. First, we need to define a dictionary of KNN parameters for the grid search. Here, we will consider K values between 3 and 7 and $p$ values of 1 (Manhattan), 2 (Euclidean), and 5 (Minkowski).

#%%
import numpy as np
params_KNN = {'n_neighbors': [1, 2, 3, 4, 5, 6, 7], 
              'p': [1, 2, 5]}

#%% [markdown]
# Second, we pass the `KNeighborsClassifier()` and `KNN_params` as the model and the parameter dictionary into the `GridSearchCV` function. In addition, we include the repeated stratified CV method we defined previously (`cv=cv_method`). Also, we tell `sklearn` which metric to optimize, which is accuracy in our example (`scoring='accuracy'`, `refit='accuracy'`).

#%%
from sklearn.model_selection import GridSearchCV

gs_KNN = GridSearchCV(KNeighborsClassifier(), 
                      params_KNN, 
                      cv=cv_method,
                      verbose=1, 
                      scoring='accuracy', 
                      refit='accuracy',
                      return_train_score=True)

#%% [markdown]
# The last step is to fit a KNN model using the full dataset.

#%%
gs_KNN.fit(Data, target);

#%% [markdown]
# To get the best parameter values, we call the `best_params_` attribute.

#%%
gs_KNN.best_params_

#%% [markdown]
# After stratified 5-fold cross-validation with 3 repeatitions, we observe that the optimal parameters are 6 neighbors using the Manhattan (p=1) distance metric. The mean cross-validation accuracy with the optimal parameters can be extracted using the `best_score` attribute.

#%%
gs_KNN.best_score_

#%% [markdown]
# To extract more cross-validation results, we can call `gs.csv_results` - a dictionary consisting of run details for each fold. 

#%%
gs_KNN.cv_results_['mean_test_score']

#%% [markdown]
# Let's visualize the hyperparameter tuning results from the cross-validation. We define a data frame by combining `gs.cv_results_['params']` and `gs.cv_results_['mean_test_score']`. The `gs.cv_results_['params']` is an array of hyperparameter combinations. 

#%%
import pandas as pd

results_KNN = pd.DataFrame(gs_KNN.cv_results_['params'])


#%%
results_KNN['test_score'] = gs_KNN.cv_results_['mean_test_score']

#%% [markdown]
# Let's create a new column called "metric" that stores the name of the metric for each $p$ value.

#%%
results_KNN['metric'] = results_KNN['p'].replace([1,2,5], ["Manhattan", "Euclidean", "Minkowski"])
results_KNN

#%% [markdown]
# We visualize the results using the `altair` module. The plot below shows that K = 3 with the Manhattan distance metric (p=1) outperforms other combinations.

#%%
import altair as alt

alt.Chart(results_KNN, 
          title='KNN Performance Comparison'
         ).mark_line(point=True).encode(
    alt.X('n_neighbors', title='Number of Neighbors'),
    alt.Y('test_score', title='Mean CV Score', scale=alt.Scale(zero=False)),
    color='metric'
)

#%% [markdown]
# ### DT Hyperparameter Tuning and Visualization <a class="anchor" id="1.4"></a>
#%% [markdown]
# Let's fit a decision tree model and optimize its hyperparameters using a grid search. We shall perform a grid search over split criterion, maximum depth, and minimum samples split parameters.

#%%
from sklearn.tree import DecisionTreeClassifier

df_classifier = DecisionTreeClassifier(random_state=999)

params_DT = {'criterion': ['gini', 'entropy'],
             'max_depth': [1, 2, 3, 4, 5, 6, 7, 8],
             'min_samples_split': [2, 3]}

gs_DT = GridSearchCV(df_classifier, 
                     params_DT, 
                     cv=cv_method,
                     verbose=1, 
                     scoring='accuracy', 
                     refit='accuracy')

gs_DT.fit(Data, target);

#%% [markdown]
# Let's have a look at the best performing parameter combination.

#%%
gs_DT.best_params_


#%%
gs_DT.best_score_

#%% [markdown]
# Let's define a new data frame to store the DT grid search results for visualization.

#%%
results_DT = pd.DataFrame(gs_DT.cv_results_['params'])
results_DT['test_score'] = gs_DT.cv_results_['mean_test_score']
results_DT.columns

#%% [markdown]
# Now let's do the plotting with respect to split criterion and maximum depth while taking the average of `min_samples_split` parameter.

#%%
alt.Chart(results_DT, 
          title='DT Performance Comparison'
         ).mark_line(point=True).encode(
    alt.X('max_depth', title='Maximum Depth'),
    alt.Y('test_score', title='Mean CV Score', aggregate='average', scale=alt.Scale(zero=False)),
    color='criterion'
)

#%% [markdown]
# We observe that the best set of hyperparameters is as follows: entropy split criterion with a maximum depth of 4 and `min_samples_split` value of 2.
#%% [markdown]
# ### NB Hyperparameter Tuning and Visualization <a class="anchor" id="1.5"></a>
#%% [markdown]
# Let's fit a Gaussian Naive Bayes model and optimize its only parameter, `var_smoothing`, using a grid search. Recall that Gaussian NB assumes that each one of the descriptive features follow a Gaussian, that is, normal distribution. This is highly unlikely in practice, but we can perform what is called a "power transformation" on each feature to make it more or less normally distributed. The link [here](https://www.statisticshowto.datasciencecentral.com/box-cox-transformation/) is a good place to start learning about power transformations via its more specific case of Box-Cox transformations.
# 
# We perform power transformation using the `PowerTransformer` method in `sklearn`, but you need to make sure that you have the latest version of `sklearn` because this is a relatively new method. By default, `PowerTransformer` results in features that have a 0 mean and 1 standard deviation.
#%% [markdown]
# Let's first have a look at an example of a power transformation. We define an exponential random variable with a mean of 2 and sample 1000 numbers from this distribution. Numbers sampled from this distribution are always positive and this distribution is quite right skewed as you can see in the plot below. 

#%%
import numpy as np
import altair as alt
from sklearn.preprocessing import PowerTransformer

np.random.seed(999)

sample_size = 1000
x_exponential = np.random.exponential(2, sample_size).reshape(-1, 1)
x_transformed = PowerTransformer().fit_transform(x_exponential)

df1 = pd.DataFrame(x_exponential)
df1['distribution'] = 'exponential'

df2 = pd.DataFrame(x_transformed)
df2['distribution'] = 'transformed'

# combine the two data frames into one to be used for plotting
df = pd.concat([df1, df2], axis=0)
df.rename(columns={0: 'x'}, inplace=True)

print(df.sample(n=10))

#%% [markdown]
# Once we perform a power transformation, we observe that the transformed numbers are centered at 0 and their distribution look like bell-curved.

#%%
alt.Chart(df, 
          width=500,
          title='Power Transformation Example'
         ).mark_bar(opacity=0.90).encode(
    alt.X('x', bin=alt.Bin(maxbins=150)),
    alt.Y('count()'),
    color = 'distribution'
)

#%% [markdown]
# The `var_smoothing` parameter's default value is $10^{-9}$. We will conduct the grid search in the "logspace", that is, we will search over the powers of 10. We will start with $10^0$ and end with $10^{-9}$ and we will try 100 different values. For this search, we will use the `logspace` function in the `numpy` module.
#%% [markdown]
# Here is how the logspace looks with 10 different values.

#%%
np.logspace(0,-9, num=10)


#%%
from sklearn.naive_bayes import GaussianNB

np.random.seed(999)

nb_classifier = GaussianNB()

params_NB = {'var_smoothing': np.logspace(0,-9, num=100)}

gs_NB = GridSearchCV(nb_classifier, 
                     params_NB, 
                     cv=cv_method,
                     verbose=1, 
                     scoring='accuracy', 
                     refit='accuracy')

Data_transformed = PowerTransformer().fit_transform(Data)

gs_NB.fit(Data_transformed, target);


#%%
gs_NB.best_params_


#%%
gs_NB.best_score_

#%% [markdown]
# Let's define a new data frame to store the NB grid search results for visualization.

#%%
results_NB = pd.DataFrame(gs_NB.cv_results_['params'])
results_NB['test_score'] = gs_NB.cv_results_['mean_test_score']

#%% [markdown]
# Now let's do the plotting with respect to the `var_smoothing` parameter. We define the plot to be interactive so that we can zoom in. Specifically, you can zoom in and out using your mouse. This is why we like `altair` so much.

#%%
alt.Chart(results_NB, 
          title='NB Performance Comparison'
         ).mark_line(point=True).encode(
    alt.X('var_smoothing', title='Var. Smoothing'),
    alt.Y('test_score', title='Mean CV Score', scale=alt.Scale(zero=False))
).interactive()

#%% [markdown]
# We observe that the best variance smoothing parameter for NB is 0.43, though the difference between other values in terms of the mean CV score is very small per the range of the y-axis.
#%% [markdown]
# ## Regression Example: Boston Housing Data <a class="anchor" id="2"></a>
#%% [markdown]
# Let's consider the Boston housing dataset. We call `KNeighborsRegressor` to run KNN on this regression problem. The KNN regression grid search is similar to its classification counterpart except for the differences below.
# 
# * We can no longer use stratified K-fold validation since the target is not multiclass or binary. However, we can use other methods such as K-fold or Repeated K-fold.
# * The model performance metric is no longer "accuracy", but MSE (Mean Squared Error). We do not need to specify "mse" in `GridSearchCV` since `sklearn` is smart enough to figure out that the target is a continuous variable.

#%%
from sklearn.datasets import load_boston
from sklearn.neighbors import KNeighborsRegressor

housing_data = load_boston()
Data, target = housing_data.data, housing_data.target


#%%
from sklearn.model_selection import RepeatedKFold, GridSearchCV
from sklearn.preprocessing import StandardScaler

cv_method = RepeatedKFold(n_splits=5, 
                          n_repeats=3, 
                          random_state=999)

Data = StandardScaler().fit_transform(Data)

knn_regressor = KNeighborsRegressor()

params_knn_regressor = {'n_neighbors': [1,2,3,4,5], 
                        'p': [1, 2, 5]}

gs_knn_regressor = GridSearchCV(knn_regressor, 
                  params_knn_regressor, 
                  verbose=1, 
                  cv=cv_method)

gs_knn_regressor.fit(Data, target);

#%% [markdown]
# After 3 repeated 5-fold cross-validation, we observe that the best parameters and best score are as follows.

#%%
gs_knn_regressor.best_params_


#%%
gs_knn_regressor.best_score_

#%% [markdown]
# ## Exercises <a class="anchor" id="3"></a>
# 
# ### Problem <a class="anchor" id="3.1"></a>
# 
# Run a decision tree model on Wine Data and tune its hyperparameters using a stratified repeated CV.
# 
# ### Possible Solution <a class="anchor" id="3.2"></a>
# 
# ```
# from sklearn.datasets import load_wine
# from sklearn.tree import DecisionTreeClassifier
# from sklearn.model_selection import RepeatedStratifiedKFold, GridSearchCV
# from sklearn.preprocessing import StandardScaler
# 
# wine = load_wine()
# Data, target = wine.data, wine.target
# 
# Data = StandardScaler().fit_transform(Data)
# 
# cv_method = RepeatedStratifiedKFold(n_splits = 5, 
#                                     n_repeats = 3, 
#                                     random_state = 999)
# 
# dt_classifier = DecisionTreeClassifier(random_state=999)
# 
# params_DT = {'criterion': ['gini', 'entropy'],
#              'max_depth': [2, 3, 4, 5]}
# 
# gs = GridSearchCV(dt_classifier, 
#                   params_DT, 
#                   cv=cv_method,
#                   verbose=1, 
#                   scoring='accuracy', 
#                   refit='accuracy')                  
# 
# print(gs.fit(Data, target))
# print(gs.best_params_)
# print(gs.best_score_)
# 
# ```
#%% [markdown]
# ***
# MATH2319 - Machine Learning @ RMIT University

