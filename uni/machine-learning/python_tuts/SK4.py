#%% Change working directory from the workspace root to the ipynb file location. Turn this addition off with the DataScience.changeDirOnImportExport setting
import os
try:
	os.chdir(os.path.join(os.getcwd(), 'python_tuts'))
	print(os.getcwd())
except:
	pass
#%% [markdown]
# # scikit-learn Part 4: Pipelines and Statistical Model Comparison
# * * *
# 
# In this tutorial, we build up upon previous tutorials and we exclusively work with the Breast Cancer Wisconsin dataset.
# 
# ## Learning Objectives
# 
# - Utilize the machine learning pipeline
# - Use parallel processing and multi-threading for model evaluation
# - Save and load trained models
# - Conduct statistical tests for model performance comparison
#%% [markdown]
# ## Table of Contents
# 
# * [Pipelines for Stacking Processes](#1)
# * [Parallel Processing and Multi-Threading](#2) 
# * [Saving and Loading Models](#3)
# * [Comparing Performance of Classifiers Using Paired T-Tests](#4)
#%% [markdown]
# ## Pipelines for Stacking Processes  <a class="anchor" id="1"></a>  
#%% [markdown]
# In Part 1, we saw that models can perform better (in terms of accuracy score) after scaling the data. We can "stack" the scaling (preprocessing), feature selection, and the grid search for hyperparameter tuning via cross-validation in a "pipeline". 
# 
# In the following chunks of code, we show how to perform the following using `Pipeline` function:
# 1. Perform feature selection using `SelectKBest`. We shall use the `F-Score` score function with 10, 20, and full set of features.
# 2. Train a KNN model with different k and p values.
# 
# The general format for specifying parameters of the pipe processes is `<model_label_for_pipe>__<model_parameter>.`
# 
# As an example, we label our learning model as `knn`. Thus, in `params`, we specify the parameter names starting with `knn__`, i.e., `knn__n_neighbors` and `knn__p`. 

#%%
from sklearn.pipeline import Pipeline
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import GridSearchCV
from sklearn import preprocessing
from sklearn.feature_selection import SelectKBest
from sklearn.feature_selection import f_classif
from sklearn.model_selection import RepeatedStratifiedKFold
from sklearn.datasets import load_breast_cancer

cv_method = RepeatedStratifiedKFold(n_splits=5, 
                                    n_repeats=3, 
                                    random_state=999)

cancer_df = load_breast_cancer()
Data, target = cancer_df.data, cancer_df.target

# target is already encoded
Data = preprocessing.MinMaxScaler().fit_transform(Data)

pipe_KNN = Pipeline([('fselector', SelectKBest(score_func=f_classif)), 
                     ('knn', KNeighborsClassifier())])

params_pipe_KNN = {'fselector__k': [10, 20, Data.shape[1]],
                   'knn__n_neighbors': [1, 2, 3, 4, 5],
                   'knn__p': [1, 2]}
 
gs_pipe_KNN = GridSearchCV(pipe_KNN, 
                           params_pipe_KNN, 
                           cv=cv_method,
                           scoring='accuracy', 
                           refit='accuracy',
                           verbose=1)

#%% [markdown]
# After defining the pipeline, we can go ahead and fit our data.

#%%
gs_pipe_KNN.fit(Data, target);


#%%
gs_pipe_KNN.best_params_


#%%
gs_pipe_KNN.best_score_

#%% [markdown]
# We observe that we get the best performance with all the features, with 3 nearest neighbors, and with the Manhattan distance metric for an accuracy score of 97%. 
#%% [markdown]
# ## Parallel Processing and Multi-Threading <a class="anchor" id="2"></a>
#%% [markdown]
# Let's discuss how we can speed up execution the pipeline. Some `sklearn` functions (in this example, `GridSearchCV`) have an argument named `n_jobs`, i.e., the number of cores used to train the model in parallel. By default, `sklearn` functions set `n_jobs=1` resulting in a slower traing process. You can set `n_jobs=-1` to fire up all cores in your computer. This parallel approach is known as "multiprocessing". 
# 
# Notice that below we set `n_jobs` to -1 to use all the cores.

#%%
gs_pipe_KNN_all_cores = GridSearchCV(pipe_KNN, 
                           params_pipe_KNN, 
                           cv=cv_method,
                           n_jobs=-1, 
                           scoring='accuracy', 
                           verbose=1)

gs_pipe_KNN_all_cores.fit(Data, target);

#%% [markdown]
# However, multiprocessing might cause what is called a "memory leak", which is the failure to release unused memory. Memory leaks result in poor performance. To mitigate this, we can resort to "multi-threading" as below.

#%%
from sklearn.externals import joblib

gs_pipe_KNN_multi_threading = GridSearchCV(pipe_KNN, 
                           params_pipe_KNN, 
                           cv=cv_method,
                           n_jobs=+1, # make sure you are using only one core here
                           scoring='accuracy', 
                           verbose=1)

with joblib.parallel_backend('threading'):
    gs_pipe_KNN_multi_threading.fit(Data, target)

#%% [markdown]
# Whether parallel processing or multi-threading is the faster option approach depends on your dataset's characteristics (too small or too big), your algorithm, your pipeline, and your computer's hardware. So, you might want to experiment with this for your particular problem.
#%% [markdown]
# ## Saving and Loading Models <a class="anchor" id="3"></a>
#%% [markdown]
# Once we execute a pipeline and obtain the best estimator, we can retrain the model with these optimal parameters using the full dataset before we make a new prediction. Alternatively, we can save the best estimator from the pipeline and load it whenever we need it.
# 
# The best model from the pipeline is shown below.

#%%
gs_pipe_KNN.best_estimator_

#%% [markdown]
# Let's save the best model as "best_KNN.pkl" in a `pickle` format. This is a compressed format for Python.

#%%
from sklearn.externals import joblib

joblib.dump(gs_pipe_KNN.best_estimator_, 'best_KNN.pkl', compress = 1)

#%% [markdown]
# To retreive the saved model object, we load it using `joblib.load` function. 

#%%
saved_knn = joblib.load('best_KNN.pkl')

#%% [markdown]
# Once we load the best model, we can use it to make predictions. For instance, let's predict the target label for the first 20 rows in the full dataset.

#%%
saved_knn.predict(Data[0:20,])

#%% [markdown]
# ## Comparing Performance of Classifiers Using Paired T-Tests <a class="anchor" id="4"></a>
#%% [markdown]
# For performance assessment of classifiers and regressors, we use repeated cross-validation. However, cross-validation itself is a random process and we need statistical tests in order to determine if any difference between the performance of any two classification methods is statistically significant; or if it is within the sample variation and the difference is statistically insignificant.
# 
# Let's now do the following: select the best 3 features among the descriptive features using the F-Score metric and compare the best tree estimator to the best nearest neighbor estimator using these 3 features. 
# 
# First, we execute another KNN pipeline with the same parameters, but with 3 features only.

#%%
params_pipe_KNN_fs = {'fselector__k': [3],
                      'knn__n_neighbors': [1, 2, 3, 4, 5],
                      'knn__p': [1, 2]}
 
pipe_KNN_fs = Pipeline([('fselector', SelectKBest(score_func=f_classif)), 
                        ('knn', KNeighborsClassifier())])

gs_pipe_KNN_fs = GridSearchCV(pipe_KNN_fs, 
                           params_pipe_KNN_fs, 
                           cv=cv_method,
                           n_jobs=-1,
                           scoring='accuracy', 
                           refit='accuracy',
                           verbose=1)

gs_pipe_KNN_fs.fit(Data, target);


#%%
gs_pipe_KNN_fs.best_params_


#%%
gs_pipe_KNN_fs.best_score_

#%% [markdown]
# Next, let's execute the DT pipeline with the same 3 features as selected by the F-Score.

#%%
from sklearn.tree import DecisionTreeClassifier

df_classifier = DecisionTreeClassifier(random_state=999)

params_pipe_DT_fs = {'fselector__k': [3],                  
                  'dt__criterion': ['gini', 'entropy'],
                  'dt__max_depth': [1, 2, 3, 4]}
 
pipe_DT_fs = Pipeline([('fselector', SelectKBest(score_func=f_classif)), 
                    ('dt', df_classifier)])

gs_pipe_DT_fs  = GridSearchCV(pipe_DT_fs, 
                           params_pipe_DT_fs, 
                           cv=cv_method,
                           n_jobs=-1,
                           scoring='accuracy', 
                           refit='accuracy',
                           verbose=1)

gs_pipe_DT_fs.fit(Data, target);


#%%
gs_pipe_DT_fs.best_params_

#%% [markdown]
# We see that the best parameters are the entropy split criterion with a maximum depth of 3, but with only 5 features!

#%%
gs_pipe_DT_fs.best_score_

#%% [markdown]
# Now we are ready to compare the best DT estimator against the best KNN estimator.
# 
# This time let's use a stratified 5-fold cross-validation with 5 repetitions.

#%%
from sklearn.model_selection import cross_val_score

cv_method_ttest = RepeatedStratifiedKFold(n_splits=5, 
                                          n_repeats=5, 
                                          random_state=999)

cv_results_KNN = cross_val_score(gs_pipe_KNN_fs.best_estimator_,
                                 Data,
                                 target, 
                                 cv=cv_method_ttest, 
                                 scoring='accuracy')
cv_results_KNN.mean().round(3)


#%%
cv_results_DT = cross_val_score(gs_pipe_DT_fs.best_estimator_,
                                Data,
                                target, 
                                cv=cv_method_ttest, 
                                scoring='accuracy')
cv_results_DT.mean().round(3)

#%% [markdown]
# Since we fixed the random state to be same for both cross-validation procedures, both classifiers were fitted and then tested on exactly the same data partitions. This indicates that our experiments were actually paired. Conducting experiments in a paired fashion reduces the variability significantly compared to conducting experiments in an independent fashion.
# 
# Let's now conduct paired t-tests to see if the difference between the best tree and best nearest neighbor models is statistically significant (93.2% vs. 92.8%).
# 
# For a paired t-test in Python, we use the `stats.ttest_rel` function inside the `scipy` module and look at the p-values. At a 95% significance level, if the p-value is smaller than 0.05, we  conclude that the difference is statistically significant.

#%%
from scipy import stats

print(stats.ttest_rel(cv_results_DT, cv_results_KNN).pvalue.round(3))

#%% [markdown]
# The p-value of our paired t-test is 0.34, which is higher than 0.05. Thus, we conclude that, at a 95% level, even though the accuracy of best KNN model is slightly higher compared to that of DT, this difference is not statistically significant and the performances of these two classifiers are comparable for the dataset at hand (with only 3 features).
# 
# Another observation here is that performances of the classifiers with only 3 features is not bad at all; they are just a few percentage points lower compared to corresponding classifiers trained with the full set of 30 features.
# 
# As a side note, we do not recommend using more than 5 repetitions within a repeated CV scheme. The reason is that, one can set an extremely high number of repetitions and, in this case, even a very small difference becomes statistically significant. In addition, you need to think about the difference in practical terms. For instance, suppose the difference between two classifiers, say A and B, is 1.5%, and it is statistically significant. However, is it really the case that there is a practical difference and classifier A is always better than B? After all, the dataset you have is a small subset of the entire population in most cases, and the dataset itself is random. Another selection of a dataset from the same population might perhaps would have reversed the situation, this time making classifier B better than A (for example, consider another independent set of 569 patients for breast cancer screening). Thus, setting the repetitions too high ends up **overfitting** the dataset and it is generally not a good idea.
# 
# As an execise, try setting `n_repeats` to 100 in `cv_method_ttest` above and you will see that you get the difference you get becomes statistically significant.
# 
# As another exercise, this time use the full set of features and compare the best tree model with the best KNN model.
#%% [markdown]
# ***
# MATH2319 - Machine Learning @ RMIT University

