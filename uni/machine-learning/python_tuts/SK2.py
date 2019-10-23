#%% Change working directory from the workspace root to the ipynb file location. Turn this addition off with the DataScience.changeDirOnImportExport setting
import os
try:
	os.chdir(os.path.join(os.getcwd(), 'python_tuts'))
	print(os.getcwd())
except:
	pass
#%% [markdown]
# # scikit-learn: Part 2
# 
# * * *
# 
# **Learning objectives**:
# 
# - Perform a grid search to identify optimal hyperparameter values for k and p in nearest neighbor models
# - Run different cross-validation methods
# - Utilize machine learning pipeline
# - Fire up your computer cores to speed up machine learning pipeline (parallel processing)
# - Save and load trained models
# 
# **Prerequisites**
# 
# - Know how to use `numpy`, `matplotlib`, `pandas` and `scikit` (Part 1)
# - Understand the concepts behind decision-tree and KNN models
# 
# **Preamble**
# 
# As in Part 1, we shall use the following datasets for regression, binary, and multiclass classification problems.
# 
# 1. [Breast Cancer Wisconsin Data](https://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+%28Diagnostic%29). The target feature is binary, i.e., if a cancer diagnosis is "malignant" or "benign".
# 2. [Boston Housing Data](https://archive.ics.uci.edu/ml/machine-learning-databases/housing/). The target feature is continuous. The target is house prices in Boston in 1970's.
# 3. [Wine Data](https://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data). The target feature is multiclass. It consists of three types of wines in Italy.
# 
# We use $k$ nearest neighbor (KNN) models to illustrate how to use cross-validation to tune hyperparameters of a nearest neighbor model via grid search by going through the Breast Cancer Data and Boston Housing Data. We will leave Wine Data and other machine learning models as exercises.
# 
# ## Table of Contents
# 
# * [Binary Classification Example: Breast Cancer Wisconsin Data](#1)
#   - [Nearest Neigbor Models](#1.1)
#   - [Cross-Validation](#1.4)
#   - [Hyperparameter Tuning and Grid Search](#1.3)
#   - [KNN Visualization](#1.7)
#   - [Preprocessing and Pipelines for Stacking Processes](#1.5)
#   - [Comparing Performance of Classifiers Using Paired T-Tests](#1.6)
# * [Regression Example: Boston Housing Data](#2)
# * [Exercises](#4)
#   - [Problems](#4.1)
#   - [Solutions](#4.2)
#%% [markdown]
# ## Binary Classification Example: Breast Cancer Wisconsin Data <a class="anchor" id="1"></a>
# 
# ### Nearest Neighbor Models <a class="anchor" id="1.1"></a>
#%% [markdown]
# Let's load the dataset, split the dataset into training and test sets, and fit a 3-Nearest-Neighbor (3-NN) classifier (`n_neighbors=3`) using the Euclidean distance (`p=2`).

#%%
from sklearn.model_selection import train_test_split
from sklearn.datasets import load_breast_cancer

cancer_df = load_breast_cancer()
Data, target = cancer_df.data, cancer_df.target
D_train, D_test, t_train, t_test = train_test_split(Data, target, test_size = 0.3, random_state=999)


#%%
from sklearn.neighbors import KNeighborsClassifier

knn_classifier = KNeighborsClassifier(n_neighbors=3, p=2)
knn_classifier.fit(D_train, t_train)
knn_classifier.score(D_test, t_test)

#%% [markdown]
# The 3-NN classifier yields an accuracy score of around 92%. So, how can we improve this score? One way is to search the set of "hyperparameters" which produces the optimal accuracy score. For a nearest neighbor model, the hyperparameters are as follows:
# 
# * Number of neighbors
# * Metric: Manhattan (p=1), Euclidean (p=2) or Minkowski (any p larger than 2)
# 
# **Refresher questions**
# 1. What are possible hyperparameters of a decision-tree model?
# 2. How many hyperparameter does a Naive Bayes model have?
# 
# To search the optimal or the "best" hyperparameters, the approaches are:
# 
# * Random search: As its name suggests, it randomly selects the hyperparameter set to train models:
# * Bayesian search: It is beyond the scope of this course. So we shall not cover it here
# * Grid search
# 
# Grid search is probably the most common approach. It exhaustively searches through all possible combinations of hyperparameters during training the model. For example, consider a KNN model. We can specify a grid of number of neighbors (K = 1, 2, 3) and two metrics (p=1, 2). The grid search starts training a model of K = 1 and p=1 and calculates its accuracy score. Then it moves to train models of (K = 2, p = 1), (K = 3, p = 1), (K = 1, p = 2), ..., and (K = 3, p = 2) and obtain their score values. Based on the accuracy scores, the grid search will rank the models and determine the optimal hyperparameter values that give the highest accuracy score. 
# 
# Before we proceed further, we shall cover other cross-validation (CV) methods since tuning hyperparameters via grid search needs to be cross-validated to avoid overfitting.
#%% [markdown]
# ### Cross-Validation <a class="anchor" id="1.4"></a>
# 
# In previous tutorial, we learn how to evaluate a machine learning model using the `train_test_split` function to split the full set into disjoint training and test sets based on a specified test size ratio. We then train the model (that, is, "fit") using the training set and evaluate it against the test set. 
# 
# There are other alternatives to a simple training/ test split. For example, we can perform K-fold cross-validation by calling the `KFold` function imported from `sklearn.model_selection` module. It randomly split the full dataset into K subsets or "folds". Then it trains the model on K-1 folds and evaluates the model against the remaining fold. This process is repeated exactly K times where each time a different fold is used for testing.
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
# ### Hyperparameter Tuning and Grid Search <a class="anchor" id="1.3"></a>
#%% [markdown]
# It's hyperparameter tuning time. First, we need to define a dictionary of KNN parameters for the grid search. Here, we will consider K values between 3 and 7 and $p$ values of 1 (Manhattan), 2 (Euclidean), and 5 (Minkowski).

#%%
import numpy as np
print(np.arange(3, 8, 1))
params_KNN = {'n_neighbors': np.arange(3, 8, 1), 
              'p': [1, 2, 5]}

#%% [markdown]
# Second, we pass the `KNeighborsClassifier()` and `KNN_params` as the model and the parameter dictionary into the `GridSearchCV` function. In addition, we include the repeated stratified cv method we defined previously (`cv=cv_method`). Also, we tell `sklearn` which metric to optimize, which is accuracy in our example (`scoring='accuracy'`, `refit='accuracy'`).

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
# We can also obtain the best estimator. We can either retrain the model with these optimal parameters using the full dataset or we can export the best estimator from the cross-validation.

#%%
gs_KNN.best_estimator_


#%%
from sklearn.externals import joblib
joblib.dump(gs_KNN.best_estimator_, 'best_KNN.pkl', compress = 1)

#%% [markdown]
# To read the saved model object, we can load it using `joblib.load` function. 

#%%
my_knn = joblib.load('best_KNN.pkl')

#%% [markdown]
# Once we load the best model, we can use it to make predictions. For instance, let's predict the target label for the first 10 rows in the full dataset.

#%%
my_knn.predict(Data[0:10,])

#%% [markdown]
# ### Visualising Hyperparameter Tuning Results <a class="anchor" id="1.7"></a>
# 
# Let's visualize the hyperparameter tuning results from the cross-validation. We define a data frame by combining `gs.cv_results_['params']` and `gs.cv_results_['mean_test_score']`. The `gs.cv_results_['params']` is an array of hyperparameter combinations. 

#%%
import warnings
warnings.filterwarnings("ignore")
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
# We visualize the results using the `matplotlib` and `seaborn` packages. The plot below shows that K = 6 produces higher accuracy scores in general whereas the Manhattan distance metric outperforms other metrics for each K.

#%%
get_ipython().magic('matplotlib inline')
get_ipython().magic("config InlineBackend.figure_format = 'retina'")
import seaborn as sns
import matplotlib.pyplot as plt
sns.set()
sns.lineplot(x="n_neighbors", 
             y="test_score", 
             hue='metric', 
             data=results_KNN, 
             marker="o")
plt.ylabel('Mean CV Score')
plt.xlabel('Number of Neighbors')
plt.legend(bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0.)
plt.show()

#%% [markdown]
# ### Preprocessing and Pipelines for Stacking Processes  <a class="anchor" id="1.5"></a>
# 
# In Part 1, we saw that models can perform better (in terms of accuracy score) after scaling the data. We can "stack" the scaling (preprocessing) and the grid search for hyperparameter tuning via cross-validation in a "pipeline". In the following chunks of code, we show how we can run scaling using `StandardScaler` and then train a KNN model using `Pipeline` function. In addition, we can speed up the pipeline by firing up number of cores to 2 (`n_jobs=2`). Note that we need to declare the model label from `pipe` in the `params`. In our case, we label our model as `knn`. In `params` we need to specify the parameter name starting with `knn__` i.e. `knn__n_neighbors` and `knn__p`. The general format is `<model_label_for_pipe>__<model_parameter>.`

#%%
from sklearn.pipeline import Pipeline
from sklearn.model_selection import GridSearchCV
from sklearn.preprocessing import StandardScaler

pipe_KNN = Pipeline([('scaler', StandardScaler()), 
                     ('knn', KNeighborsClassifier() )])

params_KNN = {'knn__n_neighbors': np.arange(3, 8, 1),
              'knn__p': [1, 2, 5]}
 
gs_pipe_KNN = GridSearchCV(pipe_KNN, 
                        params_KNN, 
                        cv=cv_method,
                        n_jobs=2, 
                        scoring='accuracy', 
                        verbose=1)


#%%
gs_pipe_KNN.fit(Data, target);


#%%
gs_pipe_KNN.best_params_


#%%
gs_pipe_KNN.best_score_

#%% [markdown]
# After scaling, notice that the optimal K changed from 6 to 3, and the accuracy score increased from 94% to 97%. 
#%% [markdown]
# Before we wrap up this section, let's digress a bit to discuss how we can speed up the pipeline. 
# 
# Some `sklearn` functions (in this example, `GridSearchCV)`) have an argument named `n_jobs` i.e., the number of cores used to train the model in parallel. By default, the `sklearn` functions set `n_jobs=1` resulting in a slower process. Though we do not recommend, you can set `n_jobs=-1` to fire up all cores in your computer. This parallel approach is known as "multiprocessing". 
# 
# However, multiprocessing might cause what is called a "memory leak", which is the failure to release unused memory. Memory leaks result in poor performance. To mitigate this, we can switch to "multi-threading" as below.

#%%
with joblib.parallel_backend('threading'):
    gs_pipe_KNN.fit(Data, target)


#%%
gs_pipe_KNN.best_params_

#%% [markdown]
# ## Comparing Performance of Classifiers Using Paired T-Tests <a class="anchor" id="1.6"></a>
#%% [markdown]
# For performance assessment of classifiers, we used repeated cross-validation. However, cross-validation is a random process and we need statistical tests in order to determine if any difference between the performance of any two classification methods is statistically significant; or if it is within the sample variation and the difference is statistically insignificant.
# 
# Let's now fit a decision tree model and optimize its hyperparameters.

#%%
from sklearn.tree import DecisionTreeClassifier

params_DT = {'criterion': ['gini', 'entropy'],
             'max_depth': [2, 3, 4, 5, 6, 7],
             'min_samples_split': [2, 3, 10]}

df_classifier = DecisionTreeClassifier(random_state=999)

gs_DT = GridSearchCV(df_classifier, 
                     params_DT, 
                     cv=cv_method,
                     verbose=1, 
                     scoring='accuracy', 
                     refit='accuracy')

gs_DT.fit(Data, target);


#%%
gs_DT.best_params_


#%%
gs_DT.best_score_

#%% [markdown]
# We observe that the best criterion is entropy and the best tree depth is 4.
# 
# Next we compare the best tree estimator to the best nearest neighbor estimator **before** scaling, but this time using a stratified 5-fold cross-validation with 10 repetitions.

#%%
from sklearn.model_selection import cross_val_score

cv_method_ttest = RepeatedStratifiedKFold(n_splits=5, 
                                          n_repeats=10, 
                                          random_state=999)

cv_results_KNN = cross_val_score(gs_KNN.best_estimator_,
                                 Data,
                                 target, 
                                 cv=cv_method_ttest, 
                                 scoring='accuracy')
cv_results_KNN.mean().round(3)


#%%
cv_results_DT = cross_val_score(gs_DT.best_estimator_,
                                Data,
                                target, 
                                cv=cv_method_ttest, 
                                scoring='accuracy')
cv_results_DT.mean().round(3)

#%% [markdown]
# Since we fixed the random state to be same for both cross-validation procedures, both classifiers were fitted and then tested on exactly the same data partitions. This indicates that our experiments were actually paired. Conducting experiments in a paired fashion reduces the variability significantly compared to conducting experiments in an independent fashion.
# 
# Let's now conduct paired t-tests to see if the difference between the best tree and best nearest neighbor models is statistically significant.
# 
# For a paired t-test in Python, we use the `stats.ttest_rel` function inside the `scipy` module and look at the p-values. At a 95% significance level, if the p-value is smaller than 0.05, we  conclude that the difference is statistically significant.

#%%
from scipy import stats
print(stats.ttest_rel(cv_results_DT, cv_results_KNN).pvalue.round(3))

#%% [markdown]
# The p-value of our paired t-test is 0.25, which is higher than 0.05. Thus, we conclude that, even though the accuracy of KNN is slightly higher compared to that of DT (94.2% vs. 93.8%), this difference is not statistically significant and the performances of these two classifiers are comparable for the dataset at hand.
# 
# As a side note, we do not recommend using more than 10 repetitions. The reason is that, one can set an extremely high number of repetitions and, in this case, even a very small difference becomes statistically significant. In addition, you need to think about the difference in practical terms. For instance, suppose the difference between two classifiers, say A and B, is 1.5%, and it is statistically significant. However, is it really the case that there is a practical difference and classifier A is always better than B? After all, the dataset you have is a small subset of the entire population in most cases, and the dataset itself is random. Another selection of a dataset from the same population might perhaps would have reversed the situation, this time making classifier B better than A (for example, consider another independent set of 569 patients for breast cancer screening). Thus, setting the repetitions too high ends up **overfitting** the dataset and it is generally not a good idea.
# 
# As an execise, try setting `n_repeats` to 100 in `cv_method_ttest` above and you will see that you get a difference of 0.8% and it becomes statistically significant with a p-value of 0.0!
# 
# As another exercise, this time compare the best tree model to the best KNN model **after** scaling using `gs_pipe_KNN.best_estimator_`.
#%% [markdown]
# ## Regression Example: Boston Housing Data <a class="anchor" id="2"></a>
#%% [markdown]
# Let's consider the Boston housing dataset. We can call `KNeighborsRegressor` to run KNN on this regression problem. The KNN regression pipeline is similar to its classification counterpart except for the differences below.
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
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler
cv_method = RepeatedKFold(n_splits=10, n_repeats=5, random_state=999)

from sklearn.model_selection import GridSearchCV


pipe = Pipeline([('scaler', StandardScaler()), 
                 ('knn', KNeighborsRegressor() )])

params = {'knn__n_neighbors': np.arange(3, 8, 1),
          'knn__p': [1, 2, 5]}

gs = GridSearchCV(pipe, params, cv=cv_method)

gs.fit(Data, target);

#%% [markdown]
# After 3 repeated 5-fold cross-validation, we observe that the best parameters and best score are as follows.

#%%
gs.best_params_


#%%
gs.best_score_

#%% [markdown]
# ## Exercises <a class="anchor" id="4"></a>
# 
# ### Problem <a class="anchor" id="4.1"></a>
# 
# Run a Decision Tree Model on Wine Data and tune the hyperparameter using a stratified CV.
# 
# ### Possible Solution <a class="anchor" id="4.2"></a>
# 
# ```
# from sklearn.datasets import load_wine
# from sklearn import tree
# 
# wine = load_wine()
# Data, target = wine.data, wine.target
# 
# from sklearn.model_selection import RepeatedKFold, GridSearchCV
# from sklearn.pipeline import Pipeline
# from sklearn.preprocessing import StandardScaler
# from sklearn.model_selection import RepeatedStratifiedKFold
# 
# cv_method = RepeatedStratifiedKFold(n_splits = 5, 
#                                     n_repeats = 3, 
#                                     random_state = 999)
# 
# from sklearn.model_selection import GridSearchCV
# 
# 
# pipe = Pipeline([('scaler', StandardScaler()), 
#                  ('DT', tree.DecisionTreeClassifier() )])
# 
# params = {'DT__criterion': ['gini', 'entropy'],
#           'DT__max_depth': [2, 3, 4, 5]}
# 
# gs = GridSearchCV(pipe, params, cv=cv_method)
# 
# print(gs.fit(Data, target))
# print(gs.best_params_)
# print(gs.best_score_)
# 
# ```
#%% [markdown]
# ***
# 
# Machine Learning @ RMIT University

