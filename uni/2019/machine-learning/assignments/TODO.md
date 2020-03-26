| Rank | Model | negative MSE | Execution time (min) |
| ---- | ----- | ------------ | -------------------- |
| 1    | KNN   | -0.0006579   | 359.1                |
| 2    | DT    | -0.0006866   | 278.8min             |
| 3    | NN    | -0.0007560   | 618.6                |

- We refactored the parameter pipeline code (using DRY methodology) into the 
following dictionary:
- It is merged with the 4 pipeline dict's using `**` (requires python>3.5)

Parameters:
- k - set to numerous options from 5 - 100
- Score function: tested the:
   - `f_regression`: ~old_todo~ 
   - `mutual_info_regression`: ~old_todo~ 

   Attributes
   ----------
   
### Parameters
- hidden_layer_sizes : number of neurons in the ith hidden layer - 5 - 100
- activation: Activation function for the hidden layer (default 'relu')

- solver: The solver for weight optimization (default 'adam')
- learning_rate: Learning rate schedule for weight updates (default 'constant')




#  Plagarism

#  - Each classifier was trainned to make probability predictions so that we were able to adjust prediction threshold to refine the performance.
#  - For fine-tuning process, we ran a five-folded cross-validation stratified sampling on each classifier. Stratified sampling was used to cater the slight imbalance class of the target feature.

#  - Next, for each classsifer, we determined the optimal probability threshold. Using the tuned hyperparameters and the optimal thresholds, we made predictions on the test data.

#  - During model training (hyperparameter tuning and threshold adjustment), we relied on mean misclassification error rate (mmce). In addition to mmce, we also used the confusion matrix on the test data to evaluate classifiers' performance. The modelling was implemented in `R` with the `mlr` package[@mlr].



#%% [markdown]
# ####
#%%

params_pipe_NN_regressor = {
    hidden_layer_sizes=(3), 
    activation='tanh', 
    solver='lbfgs'
}



hidden_layer_sizes=(10,),  
activation='relu', 
solver='adam', 
alpha=0.001, 
batch_size='auto',
learning_rate='constant',
learning_rate_init=0.01,
power_t=0.5,
max_iter=1000,
shuffle=True,
random_state=9,
tol=0.0001,
verbose=False,
warm_start=False,
momentum=0.9,
nesterovs_momentum=True,
early_stopping=False,
validation_fraction=0.1,
beta_1=0.9,
beta_2=0.999,
epsilon=1e-08)




['fselector',
 'fselector__k',
 'fselector__score_func',
 'memory',
 'nn',
 'nn__activation',
 'nn__alpha',
 'nn__batch_size',
 'nn__beta_1',
 'nn__beta_2',
 'nn__early_stopping',
 'nn__epsilon',
 'nn__hidden_layer_sizes',
 'nn__learning_rate',
 'nn__learning_rate_init',
 'nn__max_iter',
 'nn__momentum',
 'nn__n_iter_no_change',
 'nn__nesterovs_momentum',
 'nn__power_t',
 'nn__random_state',
 'nn__shuffle',
 'nn__solver',
 'nn__tol',
 'nn__validation_fraction',
 'nn__verbose',
 'nn__warm_start',
 'steps',
 'verbose']



```python
from sklearn.preprocessing import StandardScaler
from sklearn.neural_network import MLPRegressor
from sklearn.pipeline import Pipeline
from sklearn.model_selection import GridSearchCV
from sklearn.datasets import load_boston
from sklearn.model_selection import train_test_split
import numpy as np

x,y = load_boston(return_X_y=True)
xtrain, xtest, ytrain, ytest = train_test_split(x,y, random_state=6784)

grid_params_MLPRegressor = [{
    'MLPRegressor__solver': ['lbfgs'],
    'MLPRegressor__max_iter': [100,200,300,500],
    'MLPRegressor__activation':['relu','logistic','tanh'],
    'MLPRegressor__hidden_layer_sizes':
        [(2,), (4,),(2,2),(4,4),(4,2),(10,10),(2,2,2)],
}]

pipe_MLPRegressor = Pipeline([
    ('scaler', StandardScaler()),
    ('MLPRegressor', MLPRegressor(random_state = 42))])



CV_mlpregressor = GridSearchCV(
    estimator = pipe_MLPRegressor,
    param_grid = grid_params_MLPRegressor,
    cv = 5,
    return_train_score=True, 
    verbose=0)

CV_mlpregressor.fit(xtrain, ytrain)

ypred=CV_mlpregressor.predict(xtest)

print np.c_[ytest, ypred]
```
# $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

MLPRegressor(
    hidden_layer_sizes=(10,),  activation='relu', solver='adam', alpha=0.001, batch_size='auto',
    learning_rate='constant', learning_rate_init=0.01, power_t=0.5, max_iter=1000, shuffle=True,
    random_state=9, tol=0.0001, verbose=False, warm_start=False, momentum=0.9, nesterovs_momentum=True,
    early_stopping=False, validation_fraction=0.1, beta_1=0.9, beta_2=0.999, epsilon=1e-08)


#%%
from sklearn.neural_network import MLPRegressor
mlp = MLPRegressor(hidden_layer_sizes=(13,13,13),max_iter=500)
mlp.fit(X_train,y_train)

#%% [markdown]
# ## Neural Network Pipelines (SK4/5)

#%%
cv_method = MLPRegressor(hidden_layer_sizes=(13,13,13),max_iter=500)
#%% [markdown]
# define a pipeline with two processes
# if you like, you can put MinMaxScaler() in the pipeline as well
#%%
pipe_KNN = Pipeline([('MLPselector', SelectKBest()),
                     ('MLP', KNeighborsRegressor())])

params_pipe_KNN = {'fselector__score_func': [fs.f_regression, fs.mutual_info_regression],
                   'fselector__k': [5, 10], #source.shape[1]],
                   'knn__n_neighbors': [1, 2, 3, 4, 5],
                   'knn__p': [1, 2]}

gs_pipe_KNN = GridSearchCV(estimator=pipe_KNN, 
                           param_grid=params_pipe_KNN,
                           cv=cv_method,
                           n_jobs=-2,
                           scoring='neg_mean_squared_error',
                           verbose=1)
#%%
gs_pipe_KNN.fit(sourceSample, targetSample)
#%%
gs_pipe_KNN.best_params_
#%%
gs_pipe_KNN.best_score_


# $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

#%% [markdown]
# Splitting the dataset into the Training set and Test set
#%%
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)  

# $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

from sklearn.decomposition import PCA
pca = PCA()  
X_train = pca.fit_transform(X_train)  
X_test = pca.transform(X_test) 
explained_variance = pca.explained_variance_ratio_  
# pca = PCA(n_components=1)  
X_train = pca.fit_transform(X_train)  
X_test = pca.transform(X_test) 
from sklearn.ensemble import RandomForestClassifier
classifier = RandomForestClassifier(max_depth=2, random_state=0)  
classifier.fit(X_train, y_train)
# Predicting the Test set results
y_pred = classifier.predict(X_test) 
from sklearn.metrics import confusion_matrix  
from sklearn.metrics import accuracy_score
cm = confusion_matrix(y_test, y_pred)  
print(cm)  
print('Accuracy' + accuracy_score(y_test, y_pred)) 



=================

Order that Vural does things in tuts

In `Data_Prep`

Binary Classification Example: Breast Cancer Wisconsin Data
First Steps
Checking for Missing Values
Discretizing Numeric Features
Making Categorical Features Numeric
Encoding The Target Feature
Scaling Descriptive Features
Sampling Observations

# Sk5
Getting Started
Working with Large Datasets
Pipelines for Stacking Processes
Parallel Processing
Saving and Loading Models
Comparing Performance of Classifiers Using Paired T-Tests
Model Deployment






MinMaxScaler

Day: correlation with y variable

day: 
- @ash thinks categorical
- @phil thinks integer

## Nice to have:
dow:
  weekend split

ad_area and ratio into groups

  


old data vis code (not necessary in pt2)

#%% [markdown]
# ## Data Visualisation
# ~old_fixme~ Broke after we changed to numpy
#
# ### Univariate

#%%
source = dataNormalised.sample(n=10000)

chart = alt.Chart(source).mark_bar().encode(
    x = "company_id:N",
    y = 'count()',
)
# chart
# show chart in browser
chart.serve()

#%%
source = data.sample(n=10000)

alt.Chart(source).mark_bar().encode(
    x = "country_id:N",
    y = 'count()',
)

#%%
alt.Chart(source).mark_bar().encode(
    x = "device_type:O",
    y = 'count()',
)

#%%
alt.Chart(source).mark_bar().encode(
    x = "day:O",
    y = 'count()',
)

#%%
alt.Chart(source).mark_bar().encode(
    x = "dow:O",
    y = 'count()',
)

#%%
source5000 = data.sample(n=5000)
source5000.boxplot(column = ['ratio1','ratio2', 'ratio3','ratio4','ratio5'])

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #
#%% [markdown]
# ## Data Visualisation
# ### ~old_todo~ Multivariate






# Old code to transform countries for data-vis:

# WIP:
#%%
# ~old_todo~ compare to this library: https://pypi.org/project/iso-3166-1/
# def do_country(x):
#     foo = int(df['country_id'][193])
#     print countries.get(int(foo))

# df['country_id'].apply(do_country)
#%%
# countries.get(int(df['country_id'][193]))
# countries.get(df['country_id'][234])
# for c in countries: # undefined variable
#        print(c)

#%% [markdown]
# ## Notes
#
# #### [Viewability - metrics for viewable ads](https://support.google.com/google-ads/answer/7029393)
# >   A display ad is counted as viewable when at least 50% of its area is visible on the screen for at least 1 second.
# >       Note: For large display ads of 242,500 pixels or more, the ad is counted as viewable when at least 30% of it's area is visible for at least 1 second.
# >    A video ad is counted as viewable when at least 50% of its area is visible on the screen while the video is playing for at least 2 seconds.
# + Active View
#
# #### [bidding strategy](https://support.google.com/google-ads/answer/1704424?hl=en)
#
# Does it look like they're using a daily budget? A maximum CPC, a daily average, enhanced CPC (to maintain a position on Google), CPA,
# https://support.google.com/google-ads/answer/1704424?hl=en
