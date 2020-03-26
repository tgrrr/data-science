#%% [markdown]
# ~old_todo~ NEW for Assignment 2 6 Junez
# - [ ] encode device type, and other stuff
# - [ ] add import packages @ash added
# - [ ] check data and target set (I think its sourceNormalised ?) @ash added
# - [ ] choose num_features @ash added
# - [ ] get rid of integers
# - [ ] how to handle 14-15% outliers
# - one hot encoding needs to be done before scaling
# - [ ] abstract
# - [ ] clarify what our target feature is
# - [ ] sample dataset

# [Discretizing Numeric Features](file:///Users/phil/code/data-science/downloads-datascience/Data_Prep.html#2.2.1)
# - eg as: as "small", "average", and "large"
# Feedback from assignment 1:
# > you should never use integer-encoding for nominal categorical descriptive features
# - [ ] No major issue despite formatting issues.
# - [ ] It would be more professionally if you include some explanations in markdown, instead of comments within codes.
# - [ ] source wrangling was careful except using Isolation forest to detect outliers.
# - [ ] You might want to use a different random seed to check if you will get similar outlier detection results.
# - [ ] Is your target feature a numeric or multiclass variable? Is it a classification or regression problem?
# - [ ] multivariate highest correlating factors

# NOTE:
# Why Integer-Encoding a Nominal Descriptive Feature is a BAD Idea¶
# Integer encoding inherently assumes an ordering. Suppose you encode "Monday" as 1 and "Tuesday" as 2. If you feed this into a linear regression, for instance, the model will assume that Tuesday is "twice as much" as Monday. Is that really the case? Absolutely not, of course. Monday and Tuesday are just two different days of the week and clearly they are not comparable. That is, there is no natural ordering between the days of the week. However, using integer-encoding on weekdays will introduce an ordering that is not there! Thus, any subsequent modeling you perform will be incorrect and your results will be fundamentally invalid.

# NOTE:
# > We need to be careful here: Sometimes a feature that appears to be numeric is actually nominal! For instance, you might have a feature for country IDs that is numerical. However, these numbers indicate IDs, not numerical quantities! So, we will have to treat this feature as nominal. That is, whenever we have a numerical feature that actually represents categorical quantities (such as IDs), we must consider them as nominal and we must encode them using one-hot-encoding.

# Maybe:
# - [ ] PCAs?
# - [ ] write tests
# THEN:
# - [ ] turn these done todo's into notes
# - [ ] group similar variables together (e.g. box plots for ratio1-ratio5)
# - [ ] * group into weekday/weekend
# - [ ] * [do we need to encode any sequences for Scikit learn with `oneHotEncode()`?](https://scikit-learn.org/stable/modules/preprocessing.html#encoding-categorical-features)
#       * for company_id, country_id, devices
#       * for days of the week? Are they a time sequence?
#            Have you considered adding the (sine, cosine) transformation of the time of day variable? This will ensure that the 0 and 23 hour for example are close to each other, thus allowing the cyclical nature of the variable to shine through
#            https://datascience.stackexchange.com/questions/17759/encoding-features-like-month-and-hour-as-categorial-or-numeric
# - [ ] Kable
# - [ ] mark which data was not actually normalised in table
# - [ ] ~old_todo~ Objective/goal

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #

#%% [markdown]
# # ~old_todo~ Objective

#%% [markdown]
# ## Setup

#%%
# import altair as alt
import pandas as pd
import numpy as np
import altair as alt
import io
# from iso3166 import countries
import math
import os
from scipy import stats
from sklearn import preprocessing
from sklearn.model_selection import cross_val_score, RepeatedStratifiedKFold
import sklearn.metrics as metrics
from sklearn.ensemble import RandomForestRegressor
from sklearn import preprocessing
from sklearn import feature_selection as fs
from sklearn.neighbors import KNeighborsClassifier
# !pip install iso3166 # to install if in Colab
from sklearn.neighbors import KNeighborsRegressor
from sklearn.model_selection import RepeatedKFold
from sklearn.pipeline import Pipeline
from sklearn.model_selection import GridSearchCV
from sklearn.feature_selection import SelectKBest
from sklearn.metrics import mean_squared_error
import warnings
warnings.filterwarnings("ignore")

#%%
# from SpFtSel import SpFtSel

#%% [markdown]
# NOTE: download (SpFtSel)[https://github.com/vaksakalli/spsaml_py/blob/master/SpFtSel.py]
# and save it in the same folder as the python script/Jupyter notebook file

#%%
# from google.colab import files
# uploaded = files.upload()
#%%
# from google.colab import drive
# drive.mount('/content/drive')
# !ls "/content/drive/My Drive/" # this line will let you know if it's mounted correctly

#%%
# os.getcwd()
os.chdir('/Users/ashleigholney/Desktop/MATH2319-Machine-Learning/Course Project') # ash's
os.chdir('/Users/phil/code/data-science-next/uni/machine-learning/assignments/') # phil's
__file_name__ = 'advertising_train.csv'
data = pd.read_csv( __file_name__)
# consistent naming of columns (minus camelCase):
labelNames = ['case_id', 'company_id', 'country_id', 'device_type', 'day', 'dow', 'price1', 'price2', 'price3', 'ad_area', 'ad_ratio', 'requests', 'impression', 'cpc', 'ctr', 'viewability', 'ratio1', 'ratio2', 'ratio3', 'ratio4', 'ratio5', 'y',]
data.columns = labelNames



#%% [markdown]
# #### Shape:
#%%
print(data.shape)

#%% [markdown]
# #### Dataset datatypes:
#%%
print(data.dtypes)

#%% [markdown]
# #### Summary Statistics:
#%%
print(data.describe())

#%% [markdown]
# Common code/functions we reuse throughout code
#%%
numeric = list(data.select_dtypes(exclude=['object']).columns)
numericColumnsList = list(data[(numeric)].columns.values)
objects = list(data.select_dtypes(include=['object']).columns)
numericFeatureList = [ 'price1', 'price2', 'price3', 'ad_area',
'ad_ratio', 'requests', 'impression', 'cpc', 'ctr', 'viewability',
'ratio1', 'ratio2', 'ratio3', 'ratio4', 'ratio5', ]

#%% [markdown]
# Check the numerical Column Upper and Lower limits
#%%
pd.concat(
    [data[(numeric)].max().round(),
    data[(numeric)].min().round()],
    keys=['Max', 'Min'],
    axis=1)

#%% [markdown]
# ## source Pre-processing
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #

#%% [markdown]
# NOTE: NEW: Remove any index columns
#%%
data = data.loc[:, data.nunique() != data.shape[0]]
data.shape
#%% [markdown]
# NOTE: NEW: Remove any constant features (that have only one unique value)
#%%
data = data.loc[:, data.nunique() != 1]
data.shape

#%% [markdown]
# ## Lets `oneHotEncode` some shit
# convert weekday to lowercase

#%%
# check for nulls
print(data.isnull().sum())

#%%
data['dow'] = data['dow'].str.lower()
# convert weekday object to binary variables
# CHECKME: data = pd.get_dummies(data, columns=['dow'], prefix=['dow'])

categoricalFeatureList = ['company_id', 'country_id', 'device_type', 'day', 'dow']
#data = pd.get_dummies(data, columns=['dow'])
data = pd.get_dummies(data, columns=categoricalFeatureList)
# @ash disabled to test pipeline

print(data.dtypes)
data.shape
# now 226 features wide:

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #
#%% [markdown]
# ## Outlier detection

def get_outliers(df): #https://www.programcreek.com/python/example/100340/scipy.stats.zscore
    absolute_normalized = np.abs(stats.zscore(df))
    return absolute_normalized > 3

def get_length_unique_outliers(df):
    # get boolean array of outliers:
    outliers = get_outliers(df)

    if (type(df).__module__ == np.__name__):
        # for numpy:
        # get boolean array of outliers:
        outliersIndexList = df[outliers]
    else:
        # for pandas:
        outliersIndexList = df[outliers].index.values.astype(int)

    # exclude records that include multiple outliers:
    uniqueOutliersIndexList = np.unique(outliersIndexList)
    uniqueOutliersLength = float(len(np.unique(outliersIndexList)))
    return uniqueOutliersLength

def get_proportion_unique_outliers(df):
    uniqueOutliersLength = get_length_unique_outliers(df)
    outlierPercent = round((uniqueOutliersLength/214128), 3)
    return outlierPercent

#%% [markdown]
# updated code to get outliers in numpy is only 3.3%
# ~old_fixme~
#%%
# get_proportion_unique_outliers(data) # 31258 ~14.6% outliers
# get_proportion_unique_outliers(sourceNormalised) # 3.4% outliers
# get_proportion_unique_outliers(source) # 3.4% outliers
# get_proportion_unique_outliers(target)

#%% [markdown]
# ### source Normalisation
# @ash I moved this down because it happens later in the tutorial
#%%
# create copy of source

#%% [markdown]
# ## Split into target/data
# Split `y` into separate dataset before normalisation
#%%
# pandas version:
source = data.drop(columns = 'y')
target = data['y']
# source = data.drop(['y'], axis=1)

#%% [markdown]
# Normalise our source
#%%
sourceNormalised = source.copy()
sourceNormalised = preprocessing.MinMaxScaler().fit_transform(sourceNormalised)
targetNormalised = target.copy().to_frame(name=None)
targetNormalised = preprocessing.MinMaxScaler().fit_transform(targetNormalised)
# Normalise:
# previous pandas code:
# data_scaler = preprocessing.RobustScaler().fit(sourceNormalised[numericFeatureList])
# # Normalise numerical features, as a pandas Dataframe:
# sourceNormalised[numericFeatureList] = data_scaler.transform(sourceNormalised[numericFeatureList])

#%% [markdown]
# Note: `ad_area` and `ad_ratio` data description states that it is normalised
# However, it's max of `36` and `5` means this is a mistake.
# `ratio1` ... `ratio5` apear to be between 0 to 1.
# However, because they are ratios, they may not be normalised, and we have
# normalised the data anyway (because "ratio" implies that it may be between 0-1)

#%% [markdown]
# ## Sample it
# Pandas:
# Numpy
# ~old_fixme~ sample is limited to 
sourceSample = pd.DataFrame(sourceNormalised).sample(n=100, random_state=8).values
targetSample = pd.DataFrame(targetNormalised).sample(n=100, random_state=8).values

dataSamplePanda = pd.DataFrame(data).sample(n=100, random_state=8)

sourceSamplePanda = pd.DataFrame(source).sample(n=100, random_state=8)
sourceNormalisedSample = pd.DataFrame(sourceNormalised).sample(n=100, random_state=8)


# sourceSample = pd.DataFrame(sourceNormalised).sample(n=5000, random_state=8).values
# targetSample = pd.DataFrame(targetNormalised).sample(n=5000, random_state=8).values
# 
# dataSamplePanda = pd.DataFrame(data).sample(n=5000, random_state=8)
# 
# sourceSamplePanda = pd.DataFrame(source).sample(n=5000, random_state=8)
# sourceNormalisedSample = pd.DataFrame(sourceNormalised).sample(n=5000, random_state=8)

#%%
# Our final dataset before machine learning
# data.columns.get_loc("requests")
# data['requests'] == data.iloc[:,9] # hey @phil - what is this for?
# # trying to convert numpy->pandas
# source[9]
# sourceNormalised[9]
# pd.DataFrame(sourceNormalised).sample(n=10, random_state=8)

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #

###### PHASE II ######

# From canvas:

# Your Phase II report must include the following (30 points total):
# (4 points) A detailed complete overview of your methodology
# (10 points) Details of feature selection,  the algorithms’ tuning process, and detailed performance analysis of each algorithm
# (4 points) Performance comparison of the algorithms as appropriate (cross-validation, AUC, etc.) using paired t-tests
# (4 points) A critique of your approach: underlying assumptions, its limitations, its strengths and its weaknesses
# (4 points) Summary and conclusions of your entire project
# (4 points) Overall quality of your project report: clarity, conciseness, coherence, and, general good writing practices.
# NOTE: If you use integer-encoding for any nominal categorical descriptive feature, your entire analysis will be incorrect,
# so you will automatically lose all the 10 points corresponding to the "detailed performance analysis of each algorithm" section above.

# feature selection (code from sk2)

clf = KNeighborsRegressor(n_neighbors=1)

#%%
# cross-validation
cv_method = RepeatedKFold(n_splits=5, n_repeats=3, random_state=999)

# scoring_metric = 'neg_mean_absolute_error'
scoring_metric = 'neg_mean_squared_error'

cv_results_full = cross_val_score(clf,
                             sourceSample,
                             targetSample,
                             cv=cv_method,
                             scoring=scoring_metric)
cv_results_full
cv_results_full.mean().round(3)
# neg_mean_absolute_error = -0.337

#%%
num_features = 10

#%%
# change neg_mean_squared_error positive
def get_absolute_square_root(x):
    output = round(math.sqrt(abs(x)), 3);
    return output;

def get_mean_absolute_square_root(x):
    output = round(math.sqrt(abs(x.mean())), 3);
    return output;

#%%
# feature selection using f-score
fs_fit_fscore = fs.SelectKBest(fs.f_regression, k=num_features)

fs_fit_fscore.fit_transform(sourceSample, targetSample)
fs_indices_fscore = np.argsort(fs_fit_fscore.scores_)[::-1][0:num_features]
fs_indices_fscore

best_features_fscore = sourceSamplePanda.columns[fs_indices_fscore].values
best_features_fscore

feature_importances_fscore = fs_fit_fscore.scores_[fs_indices_fscore]
feature_importances_fscore

cv_results_fscore = cross_val_score(clf,
                             sourceSample[:, fs_indices_fscore],
                             targetSample,
                             cv=cv_method,
                             scoring=scoring_metric)
# cv_results_fscore
get_mean_absolute_square_root(cv_results_fscore)
# neg_mean_absolute_error = -0.195

#%%
# feature selection using mutual information
# @ash Here's where my code stalls
fs_fit_mutual_info = fs.SelectKBest(fs.mutual_info_regression, k=num_features)
fs_fit_mutual_info.fit_transform(sourceSample, targetSample)
fs_indices_mutual_info = np.argsort(fs_fit_mutual_info.scores_)[::-1][0:num_features]
best_features_mutual_info = dataSamplePanda.columns[fs_indices_mutual_info].values
best_features_mutual_info
# output if we want to skip running this code: array(['y', 'price2', 'price3', 'price1', 'ad_area', 'viewability', 'ctr', 'ratio2', 'company_id_40', 'company_id_43'], dtype=object)

feature_importances_mutual_info = fs_fit_mutual_info.scores_[fs_indices_mutual_info]
feature_importances_mutual_info

cv_results_mutual_info = cross_val_score(clf,
                             sourceSample[:, fs_indices_mutual_info],
                             targetSample,
                             cv=cv_method,
                             scoring=scoring_metric)
# cv_results_mutual_info.mean().round(3)
get_mean_absolute_square_root(cv_results_mutual_info)

#%% [markdown]
# feature selection using random forest importance
#%%
model_rfi = RandomForestRegressor(n_estimators=100)
model_rfi.fit(dataSamplePanda, targetSample)
fs_indices_rfi = np.argsort(model_rfi.feature_importances_)[::-1][0:num_features]

best_features_rfi = sourceSamplePanda.columns[fs_indices_rfi].values
best_features_rfi

feature_importances_rfi = model_rfi.feature_importances_[fs_indices_rfi]
feature_importances_rfi

cv_results_rfi = cross_val_score(clf,
                             sourceSample[:, fs_indices_rfi],
                             targetSample,
                             cv=cv_method,
                             scoring=scoring_metric)
# cv_results_rfi.mean().round(3)
get_mean_absolute_square_root(cv_results_rfi)

#%% [markdown]
# feature selection using SPSA
# SPSA is a new wrapper-based feature selection method that uses binary stochastic approximation.
# An R implementation is available within the spFSR package and a Python implementation can be found on github.
# Please refer to this arxiv paper for more information on this method.
#
# In order for this example to work, you need to make sure that you download and copy the
# Python file SpFtSel.py under the same directory as your Jupyter notebook so that the import works correctly.

#%%
# sp_engine = SpFtSel(dataSamplePanda, targetSample, clf, cv_method)
#
# np.random.seed(999)
# sp_output = sp_engine.run(num_features).results
#
# fs_indices_spsa = sp_output.get('features')
# fs_indices_spsa
#
# best_features_spsa = data.columns[fs_indices_spsa].values
# best_features_spsa
#
# feature_importances_spsa = sp_output.get('importance')
# feature_importances_spsa
#
# cv_results_spsa = cross_val_score(clf,
#                              sourceSample[:, fs_indices_spsa],
#                              targetSample,
#                              cv=cv_method,
#                              scoring=scoring_metric,
#                              # stratified_cv=False
#                              )
# cv_results_spsa.mean().round(3)

#%% [markdown]
# OUTPUT:
# spFtSel-INFO: Algorithm run mode: regular
# spFtSel-INFO: Wrapper: KNeighborsRegressor(algorithm='auto', leaf_size=30, metric='minkowski',
                    # metric_params=None, n_jobs=None, n_neighbors=1, p=2,
                    # weights='uniform')
# spFtSel-INFO: Scoring metric: accuracy
# spFtSel-INFO: Number of features: 27
# spFtSel-INFO: Number of observations: 5000
# ~old_fixme~ ERROR: `TypeError: '(slice(None, None, None), array([13, 14,  1,  2,  3,  6,  7, 10, 25,  0]))' is an invalid key`

#%% [markdown]
# performance comparison of MSE using paired t-tests

#%%
print('Full Set of Features:', get_mean_absolute_square_root(cv_results_full))
print('F-Score:', get_mean_absolute_square_root(cv_results_fscore))
print('Mutual Information:', get_mean_absolute_square_root(cv_results_mutual_info))
print('RFI:', get_mean_absolute_square_root(cv_results_rfi))


# Full Set of Features: -0.374
# F-Score: -0.231
# Mutual Information: -0.221
# RFI: -0.214
# NOTE: there is a lower MSE for the


# ~old_fixme~ ~old_later~ print('SPSA:', cv_results_spsa.mean().round(3))

#%% [markdown]
# If we use `neg_mean_absolute_error`:
# Full Set of Features: -0.337
# F-Score: -0.195
# Mutual Information: -0.19
# RFI: -0.185



#%%
from scipy import stats
print(stats.ttest_rel(cv_results_rfi, cv_results_fscore).pvalue.round(3))
print(stats.ttest_rel(cv_results_rfi, cv_results_mutual_info).pvalue.round(3))
# print(stats.ttest_rel(cv_results_rfi, cv_results_spsa).pvalue.round(3))
# if p-value is smaller than 0.05, we conclude that the difference is statistically significant

#%% [markdown]
# compare best performing method to full set
#%%
stats.ttest_rel(cv_results_rfi, cv_results_full).pvalue.round(3)

#%% [markdown]
# ~old_fixme~
# There is no significant difference between the RandomForestRegressor and the
# full dataset. Therefore: we will chose to use the features from the
# RandomForestRegressor moving forward

#%% [markdown]
# ## Nearest Neighbour Pipelines (SK4/5)
#%%
cv_method = RepeatedKFold(n_splits=3, random_state=999)

#%% [markdown]
# define a pipeline with two processes
# if you like, you can put MinMaxScaler() in the pipeline as well
#%%
pipe_KNN = Pipeline([('fselector', SelectKBest()),
                     ('knn', KNeighborsRegressor())])

params_pipe_KNN = {'fselector__score_func': [fs.f_regression, fs.mutual_info_regression],
                   'fselector__k': [5, 10], #source.shape[1]],
                   'knn__n_neighbors': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
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

#############################

#%% [markdown]
# ## Decision Tree Pipelines (SK4/5)
#%%
from sklearn.tree import DecisionTreeRegressor

df_regressor = DecisionTreeRegressor(random_state=999)

params_pipe_DT_fs = {'fselector__k': [5, 10, source.shape[1]],                  
                  'dt__criterion': ['mse'],
                  'dt__max_depth': [1, 2, 3, 4],
                  'dt__min_samples_split': [5, 50, 100, 150]}
 
pipe_DT_fs = Pipeline([(
    'fselector', 
    SelectKBest(score_func=fs.f_regression)), 
    ('dt', df_regressor)])

gs_pipe_DT_fs = GridSearchCV(
    pipe_DT_fs, 
    params_pipe_DT_fs, 
    cv=cv_method,
    n_jobs=-1,
    scoring='neg_mean_squared_error', 
    refit='neg_mean_squared_error',
    verbose=1
)

gs_pipe_DT_fs.fit(sourceSample, targetSample);

gs_pipe_DT_fs.best_score_

gs_pipe_DT_fs.best_params_

# the best parameters are at the upper bounds of what was tested. 
# the pipeline will be extended 

params_pipe_DT2 = {'fselector__k': [26],                  
                  'dt__criterion': ['mse'],
                  'dt__max_depth': [5, 10, 15, 20],
                  'dt__min_samples_split': [150, 200, 250, 300, 350, 400, 450, 500]}
 
pipe_DT2 = Pipeline([
    ('fselector', SelectKBest(score_func=fs.f_regression)), 
    ('dt', df_regressor)
])

gs_pipe_DT2 = GridSearchCV(
    pipe_DT2, 
    params_pipe_DT2, 
    cv=cv_method,
    n_jobs=-1,
    scoring='neg_mean_squared_error', 
    refit='neg_mean_squared_error',
    verbose=1
)

gs_pipe_DT2.fit(sourceSample, targetSample);

gs_pipe_DT2.best_params_

gs_pipe_DT2.best_score_

# $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

#%% [markdown]
# ## Neural Network Pipelines
#%%
from sklearn.model_selection import train_test_split
from sklearn.neural_network import MLPRegressor

X_train, X_test, y_train, y_test = train_test_split(
    sourceSample,
    targetSample
    )

# mlp = MLPRegressor(
#     hidden_layer_sizes=(13,13,13),
#     max_iter=500
#     )

nn = MLPRegressor(
    alpha=0.001, 
    hidden_layer_sizes = (10,), 
    max_iter = 50000, 
    activation = 'logistic', 
    verbose = 'True', 
    learning_rate = 'adaptive'
    )

n = nn.fit(X_train,y_train)

nn_predict_train = mlp.predict(X_train)
nn_predict_test = mlp.predict(X_test)

train_mse = mean_squared_error(y_train, nn_predict_train)
test_mse = mean_squared_error(y_test, nn_predict_test)

nn.best_params_
nn.best_score_

train_mse 
test_mse
# training mse:


fig = plt.figure()
ax1 = fig.add_subplot(111)
ax1.scatter(x, y, s=1, c='b', marker="s", label='real')
ax1.scatter(X_test,y_test, s=10, c='r', marker="o", label='NN Prediction')
plt.show()







# yfit = mlp.fit(x[:, None], y).predict(xfit[:, None])
# 
# plt.figure(figsize = (12,10))
# plt.errorbar(x, y, 0.3, fmt='o')
# plt.plot(xfit, yfit, '-r', label = 'predicted', zorder = 10)
# plt.plot(xfit, ytrue, '-k', alpha=0.5, label = 'true model', zorder = 10)
# plt.legend()

# $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

#%% [markdown]
# ## Neural Network Pipelines
#%%
from sklearn.neural_network import MLPRegressor

nn_regressor = MLPRegressor(random_state=42)

params_pipe_NN_regressor = {
    'fselector__k': [5, 10, source.shape[1]],                  
    'dt__criterion': ['mse'],
    'dt__max_depth': [1, 2, 3, 4]
}
# colab:
params_pipe_NN_regressor = {
    'MLPRegressor__solver': ['lbfgs'],
    'MLPRegressor__max_iter': [100,200,300,500],
    'MLPRegressor__activation' : ['relu','logistic','tanh'],
    'MLPRegressor__hidden_layer_sizes':[(2,), (4,),(2,2),(4,4),(4,2),(10,10),(2,2,2)],
}
# pipe_DT2 = Pipeline([
#     ('fselector', SelectKBest(score_func=fs.f_regression)), 
#     ('dt', df_regressor)
# ])
# 
# gs_pipe_DT2 = GridSearchCV(
#     pipe_DT2, 
#     params_pipe_DT2, 
#     cv=cv_method,
#     n_jobs=-1,
#     scoring='neg_mean_squared_error', 
#     refit='neg_mean_squared_error',
#     verbose=1
# )

pipe_NN_regressor = Pipeline([
    ('fselector', SelectKBest(score_func=fs.f_regression)), 
    ('nn_regressor', nn_regressor)
])

gs_pipe_NN_regression = GridSearchCV(
    pipe_NN_regressor, 
    params_pipe_NN_regressor, 
    cv = cv_method,
    n_jobs = -1,
    scoring = 'neg_mean_squared_error', 
    refit = 'neg_mean_squared_error',
    verbose = 1
)
sorted(pipe_NN_regressor.get_params().keys())

gs_pipe_NN_regression.fit(sourceSample, targetSample);

gs_pipe_NN_regression.best_score_

gs_pipe_NN_regression.best_params_



# Performance Comparison of Algorithms

from sklearn.model_selection import cross_val_score

cv_method_ttest = RepeatedKFold(n_splits=10, random_state=1)

cv_results_KNN = cross_val_score(estimator=gs_pipe_KNN.best_estimator_,
                                 X = sourceSample,
                                 y = targetSample, 
                                 cv = cv_method_ttest, 
                                 n_jobs=-2,
                                 scoring = 'neg_mean_squared_error')
cv_results_KNN.mean()

cv_results_DT = cross_val_score(estimator=gs_pipe_DT2.best_estimator_,
                                X = sourceSample,
                                y = targetSample, 
                                cv = cv_method_ttest, 
                                n_jobs = -2,
                                scoring = 'neg_mean_squared_error')
cv_results_DT.mean()

# cv_results_NN #
# goes here #

# print(stats.ttest_rel(cv_results_KNN, cv_results_NN))
print(stats.ttest_rel(cv_results_DT, cv_results_KNN))
# print(stats.ttest_rel(cv_results_DT, cv_results_NB))

sourceSampleTest = pd.DataFrame(sourceNormalised).sample(n=1000, random_state=999).values
targetSampleTest = pd.DataFrame(targetNormalised).sample(n=1000, random_state=999).values
# ~old_todo~ check there is no overlap between sourceSample and sourceSampleTest?

pred_KNN = gs_pipe_KNN.predict(sourceSampleTest)

pred_DT = gs_pipe_DT2.predict(sourceSampleTest)

#pred_NN = gs_pipe_NN_regression(sourceSampleTest)



