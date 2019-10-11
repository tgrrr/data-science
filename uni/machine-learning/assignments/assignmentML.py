#%% [markdown]
#   # Machine learning Assignment
#  ### MATH2319 - Phase II report
#  ### Authors: Phil Steinke s3725547 Ash Olney s3686808

#%% [markdown]
#  ## Methodology
#
#  NEW: The Google advertising dataset which we explored in detail in Phase I will be 
#  further transformed as appropriate for machine learning. This includes encoding 
#  the categorical variables, such as country_id and company_id, into binary variables
#  by oneHotEncoding. The features and the target variable are then scaled between 0 and 1. 
#  As the original dataset is >200k rows, we have taken a random sample of 5000 rows and then 
#  split this sample further into training and testing data.  

#  The target variable, 'y', is a continuous numeric variable so we will be using 
#  regression algorithms to predict the outcome.   
#  - neural network
#  - k-nearest neighbor regressior 
#  - decision tree regressor

#  Each of these algorithms were optimised within a pipeline to fine tune the hyperparameters. This includes feature selection. 
#  As the encoded data had over 200 variables, we had to limit the range of features which could be selected during this process. 
#  The limited scope for hyperparameters to test was indended to manage our execution time. 

#  The best parameters as identified by the pipeline by the mean squared error are selected for the model and
#  cross-validated. 

#%% [markdown]
#  ## Algorithm's tuning process
#  - [-] ~old_todo~RUBRIC (10 points) Details of the algorithms’ tuning process,

#  NEW: Feature selection is inlcuded in the pipeline process for algorithm fine tuning.
#  Included is f-regression and mutual info regression. The pipeline iterates through 
#  5, 10, 15, 20, and 100 variables. The entire set of variables is not included in the pipeline
#  to reduce execution time. 
#  The pipeline algorithm for k-nearest neighbour includes the feature selection, and 
#  also the hyperparameters k, and p. k-neighbours runs from 1 through 10 and includes distance = 1, and 2. 
#  The pipeline algorithm for the decision tree regressor included feature selection, and 
#  hyperparameters max depth, and minimum sample split. 
# NEW ~old_todo~ NN
#  The criteria for fine tuning was mean negative squared error. 


#%% [markdown]
#  ## Setup
# ### Phase I Updated Code

#%%
import io, joblib, math, numpy as np, os, pandas as pd, sklearn, warnings
from scipy import stats
warnings.filterwarnings("ignore")
# all of the sklearn libraries:
from sklearn import feature_selection as fs
from sklearn import preprocessing
from sklearn import preprocessing
from sklearn.ensemble import RandomForestRegressor
from sklearn.feature_selection import SelectKBest
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import cross_val_score, RepeatedStratifiedKFold
from sklearn.model_selection import GridSearchCV
from sklearn.model_selection import RepeatedKFold
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.neighbors import KNeighborsRegressor
from sklearn.neural_network import MLPRegressor
from sklearn.pipeline import Pipeline
import sklearn.metrics as metrics
from sklearn.tree import DecisionTreeRegressor

#%%
# from google.colab import files
# uploaded = files.upload()
#%%
# from google.colab import drive
# drive.mount('/content/drive')
# !ls "/content/drive/My Drive/" # this line will let you know if it's mounted correctly

#%% [markdown]
#  Import data in Google Colab
#%%
# Running locally:
# import os
# try:
# 	os.chdir(os.path.join(os.getcwd(), '..'))
# 	print(os.getcwd())
# except:
# 	pass

#%% [markdown]
#  Import data in Jupyter / Atom / VS Code:
#%%
# os.getcwd()
# os.chdir('/Users/ashleigholney/Desktop/MATH2319-Machine-Learning/Course Project') # ash's
os.chdir('/Users/phil/code/data-science-next/uni/machine-learning/assignments') # phil's
__file__ = 'advertising_train.csv'
data = pd.read_csv(__file__)

#%% [markdown]
# consistent naming of columns (minus camelCase):
#%%
labelNames = [
    'case_id', 'company_id', 'country_id', 'device_type', 'day', 'dow', 
    'price1', 'price2', 'price3', 'ad_area', 'ad_ratio', 'requests', 
    'impression', 'cpc', 'ctr', 'viewability', 'ratio1', 'ratio2', 'ratio3', 
    'ratio4', 'ratio5', 'y', ]
data.columns = labelNames

#%% [markdown]
#  Common code/functions we reuse throughout code
#%%
numeric = list(data.select_dtypes(exclude = ['object']).columns) # NEW ~old_todo~ haven't used this
numericColumnsList = list(data[(numeric)].columns.values) # NEW ~old_todo~ haven't used this
objects = list(data.select_dtypes(include = ['object']).columns) # NEW ~old_todo~ haven't used this
numericFeatureList = [
    'price1', 'price2', 'price3', 'ad_area', 'ad_ratio', 'requests', 
    'impression', 'cpc', 'ctr', 'viewability', 'ratio1', 'ratio2', 'ratio3', 
    'ratio4', 'ratio5', ] # NEW ~old_todo~ haven't used this
categoricalFeatureList = [
    'company_id', 'country_id', 'device_type', 'day', 'dow'
    ]

#%% [markdown]
#  ## source Pre-processing
#  Remove any index columns:
#%%
data = data.loc[:, data.nunique() != data.shape[0]]
data.shape

#%% [markdown]
#  Remove any constant features (that have only one unique value):
#%%
data = data.loc[:, data.nunique() != 1]
data.shape

#%% [markdown]
#  #### check for nulls:
#%%
print(data.isnull().sum())

#%% [markdown]
#  ## Encode Categorical Variables:
#%%
data['dow'] = data['dow'].str.lower()
data = pd.get_dummies(data, columns = categoricalFeatureList)
print(data.dtypes)
data.shape

#%% [markdown]
#  Our data is now 226 features wide
#  ## Outlier detection

#%% [markdown]
#  Check if we have outliers
#%%
def get_outliers(df):
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
# ### Phase II Code

#%% [markdown]
#  ## Split into target/data
#  Split `y` into separate dataset before normalisation
#%%
source = data.drop(columns='y')
target = data['y']

#%% [markdown]
#  Normalise our source
#%%
sourceNormalised = source.copy()
sourceNormalised = preprocessing.MinMaxScaler().fit_transform(sourceNormalised)

targetNormalised = target.copy().to_frame(name=None)
targetNormalised = preprocessing.MinMaxScaler().fit_transform(targetNormalised)

#%% [markdown]
#  ## Sample our data
#%%
# NEW: refactored samples to a set of 100 for testing pipelines,
# then in production set the sample = 5000
# NOTE: This smaller sample size is limited by computing power
# In a production environment, we would set this to a much larger sample
# sample = 100
# Setting random_state makes sampling reproducible 
samples = 5000

# numpy version
sourceSample = pd.DataFrame(
    sourceNormalised,
    ).sample(n = samples, random_state = 8).values
targetSample = pd.DataFrame(
    targetNormalised,
    ).sample(n = samples, random_state = 8).values


#%% [markdown]
#  - The Cross Validation method (CV) utilised `n_splits = 3` because ~old_todo~
#  - `random_state` is set for reproducibility
#%%
cv_method = RepeatedKFold(n_splits = 3, random_state = 999)

#  NEW: 
#  - We refactored the parameter pipeline code (using DRY methodology) into the 
#  following dictionary:
#  - It is merged with the 4 pipeline dict's using `**` (requires python>3.5)
# Parameters:
# - k - set to numerous options from 5 - 100
# - Score function: tested the:
#     - `f_regression`: ~old_todo~ 
#     - `mutual_info_regression`: ~old_todo~ 
# 

#%%
cv_method = RepeatedKFold(n_splits = 3, random_state = 999)
# parameter pipeline for `fselector` to use in 3 functions
params_pipe_fselector = {
    'fselector__score_func': [
        fs.f_regression, 
        fs.mutual_info_regression
        ],
    'fselector__k': [5, 10, 15, 20, 100], 
    # 'fselector__k': [5, 10, source.shape[1]],
}

#%% [markdown]
#  ## Neural Network

#%% [markdown]
#  We are testing with ~old_todo~
#%%
    """
    Attributes
    ----------
    nn__hidden_layer_sizes : 
        [(5,)(10,),(100,)],
    nn__activation : 
        ['identity', 'logistic', 'tanh', 'relu'],
        default 'relu'
    nn__solver : 
        ['lbfgs', 'sgd', 'adam',],
        default 'adam'
    nn__learning_rate : 
        ['constant', 'invscaling', 'adaptive'],
    """
params_pipe_NN_fs = {
    **params_pipe_fselector, # pylint: disable=syntax-error,
    'nn__alpha': [0.001],
    'nn__hidden_layer_sizes': [(5,10,100,)],      # default: (100,)
    'nn__max_iter': [200],                  # default is 200
    'nn__activation': ['identity', 'logistic', 'tanh', 'relu'],# default 'relu'
    'nn__solver': ['lbfgs', 'sgd', 'adam',],   # default 'adam'
    'nn__verbose': [True],
    'nn__learning_rate': ['constant', 'invscaling', 'adaptive'],
}

steps_NN = [
    ('fselector', SelectKBest()),
    ('nn', MLPRegressor()),
    ]

pipe_NN_fs = Pipeline(steps_NN)

grid_NN_fs = GridSearchCV(
    estimator = pipe_NN_fs,
    param_grid = params_pipe_NN_fs,
    cv = cv_method,
    n_jobs = -1,
    scoring = 'neg_mean_squared_error',
    refit = 'neg_mean_squared_error',  
    verbose = 1,
)
#%%
grid_NN_fs.fit(sourceSample, targetSample)

#%%
# save our model output:
joblib.dump(grid_NN_fs.best_estimator_, 'pipe_NN_fs.pkl', compress=1)
# saved_knn = joblib.load('pipe_NN_fs.pkl')

#%%
grid_NN_fs.best_score_
#%%
grid_NN_fs.best_params_

#%% [markdown]
#  ## Nearest Neighbour Pipelines
#%%
steps_KNN = [
    ('fselector', SelectKBest()),
    ('knn', KNeighborsRegressor()),
    ]
pipe_KNN = Pipeline(steps_KNN)

#%% [markdown]
#  #### the algorithms’ tuning process,
#  `'fselector__k': [5, 10]` are feature selection
#  `'knn__n_neighbors'`
#  `'knn__p': [1, 2]` is distance

#%%
params_pipe_KNN = {
    **params_pipe_fselector,        # copies from above
    'knn__n_neighbors': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    'knn__p': [1, 2]}

grid_KNN = GridSearchCV(
    estimator = pipe_KNN,
    param_grid = params_pipe_KNN,
    cv = cv_method,
    n_jobs = -1, # CHECKME: this was set to -2
    scoring = 'neg_mean_squared_error',
    verbose = 1)


#%%
grid_KNN.fit(sourceSample, targetSample)

#%% [markdown]
# Fitting 30 folds for each of 80 candidates, totalling 2400 fits
#
# pink block:
#
# ```
# Parallel(n_jobs=-2)]: Using backend LokyBackend with 7 concurrent workers.
# [Parallel(n_jobs=-2)]: Done  36 tasks      | elapsed:    2.3s
# [Parallel(n_jobs=-2)]: Done 251 tasks      | elapsed:    5.9s
# [Parallel(n_jobs=-2)]: Done 689 tasks      | elapsed: 13.9min
# [Parallel(n_jobs=-2)]: Done 1039 tasks      | elapsed: 60.9min
# [Parallel(n_jobs=-2)]: Done 1489 tasks      | elapsed: 79.9min
# [Parallel(n_jobs=-2)]: Done 2039 tasks      | elapsed: 110.7min
# [Parallel(n_jobs=-2)]: Done 2400 out of 2400 | elapsed: 154.8min finished
# ```
#
# ```
# GridSearchCV(
#     cv = <sklearn.model_selection._split.RepeatedKFold object at 0x11e2eaa90>,
#     error_score = 'raise-deprecating',
#     estimator = Pipeline(
#         memory = None,
#         steps = [
#             ('fselector',
#             SelectKBest(
#                 k = 10,
#                 score_func = <function f_classif at 0x11cde1a60>)
#                 ),
#             ('knn',
#             KNeighborsRegressor(
#                 algorithm = 'auto',
#                 leaf_size = 30,
#                 metric = 'minkowski',
#                 metric_params = None,
#                 n_jobs = None,
#                 n_neighbors = 5, 
#                 p = 2,
#                 weights = 'uniform'))],
#                 verbose = False),
#             iid = 'warn', 
#             n_jobs = -2,
#             param_grid = {
#                 'fselector__k': [5, 10],
#                 'fselector__score_func': [
#                     <function f_regression at 0x11cde1bf8>,
#                     <function mutual_info_regression at 0x11d4558c8>
#                     ],
#                 'knn__n_neighbors': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
#                 'knn__p': [1, 2]
#                 },
#         pre_dispatch = '2*n_jobs', 
#         refit = True, 
#         return_train_score = False,
#         scoring = 'neg_mean_squared_error', 
#         verbose = 1
#     )
# ```

#%%
# save our model output:
joblib.dump(grid_KNN.best_estimator_, 'best_KNN.pkl', compress = 1)
# saved_knn = joblib.load('best_KNN.pkl')

#%%
grid_KNN.best_params_

#%% [markdown]
# `{'fselector__k': 10,
#  'fselector__score_func': 
#   <function sklearn.fs.univariate_selection.f_regression(X, y, center=True)>,
#  'knn__n_neighbors': 10,
#  'knn__p': 1}`

#%%
grid_KNN.best_score_

#%% [markdown]
# -0.000652080088372151
#  ~old_todo~ rubric - and detailed performance analysis of each algorithm
#  ## Decision Tree Pipelines
#  ~old_todo~ @ash
#  Details of feature selection,

#%%
df_regressor = DecisionTreeRegressor(random_state=999)

#%% [markdown]
#  ~old_todo~ @ash
#  #### the algorithms’ tuning process,
#  ~old_todo~ rubric - and detailed performance analysis of each algorithm

#%%
params_pipe_DT_fs = {
    **params_pipe_fselector,        # copied from above
    'dt__criterion': ['mse'],
    'dt__max_depth': [1, 2, 3, 4],
    'dt__min_samples_split': [5, 50, 100, 150]
}

steps = [
    ('fselector', SelectKBest(score_func = fs.f_regression)),
    ('dt', df_regressor)
    ]

pipe_DT_fs = Pipeline(steps)

grid_DT_fs = GridSearchCV(
    pipe_DT_fs,
    params_pipe_DT_fs,
    cv = cv_method,
    n_jobs = -1,
    scoring = 'neg_mean_squared_error',
    refit = 'neg_mean_squared_error',
    verbose = 1
)

#%%
pipe_DT_fs.fit(sourceSample, targetSample)

#%%
# save our model output:
joblib.dump(grid_DT_fs.best_estimator_, 'grid_DT_fs.pkl', compress=1)
# saved_DT = joblib.load('grid_DT_fs.pkl')

#%%
grid_DT_fs.best_score_

#%%
grid_DT_fs.best_params_
#%% [markdown]
#  the best parameters are at the upper bounds of what was tested.
#  the pipeline will be extended

#%%
params_pipe_DT2 = {
    'fselector__k': [26],
    'dt__criterion': ['mse'],
    'dt__max_depth': [5, 10, 15, 20],
    'dt__min_samples_split': [150, 200, 250, 300, 350, 400, 450, 500]}

steps = [
    ('fselector', SelectKBest(score_func = fs.f_regression)),
    ('dt', df_regressor)
]
pipe_DT2 = Pipeline(steps)

pipe_DT2 = GridSearchCV(
    pipe_DT2,
    params_pipe_DT2,
    cv = cv_method,
    n_jobs = -1,
    scoring = 'neg_mean_squared_error',
    refit = 'neg_mean_squared_error',
    verbose = 1
)
#%%
pipe_DT2.fit(sourceSample, targetSample)

#%% [markdown]
# pink bit:
# ```
# [Parallel(n_jobs=-1)]: Using backend LokyBackend with 8 concurrent workers.
# [Parallel(n_jobs=-1)]: Done  34 tasks      | elapsed:    0.7s
# [Parallel(n_jobs=-1)]: Done 316 tasks      | elapsed:    3.9s
# [Parallel(n_jobs=-1)]: Done 816 tasks      | elapsed:    9.3s
# [Parallel(n_jobs=-1)]: Done 960 out of 960 | elapsed:   10.8s finished
# ```

#%%
# save our model output:
joblib.dump(pipe_DT2.best_estimator_, 'pipe_DT2.pkl', compress=1)
# saved_knn = joblib.load('pipe_DT2.pkl')

#%%
pipe_DT2.best_params_

#%% [markdown]
# ```
# {'dt__criterion': 'mse',
#  'dt__max_depth': 20,
#  'dt__min_samples_split': 200,
#  'fselector__k': 26}
# ```

#%%
pipe_DT2.best_score_

#%% [markdown]
# -0.0007118538116185094


#%%
cv_method_ttest = RepeatedKFold(n_splits = 10, random_state = 1)

#%% [markdown]
#  NEW:
#  ## Cross Validation Testing
#  ### Using paired t-test
#  - Changed Cross Validation test to `RepeatedKFold()` because 
#  `RepeatedStratifiedKFold()` doesn't work for regression

# ~old_todo~ Test this function
cv_method_ttest = RepeatedKFold(n_splits = 10, random_state = 1)

# ~old_todo~ Test this function
def do_cross_val_score(estimator):
    """generates and compares the test to the real target (y) 
    for the test data

    Parameters
    ----------
    estimator : type
        Description of parameter `estimator`.

    Returns
    -------
    type
        Mean Squared Error

    """
    cv_results = cross_val_score(
        estimator = estimator,
        X = sourceSample,
        y = targetSample,
        cv = cv_method_ttest,
        n_jobs = -2,
        scoring = 'neg_mean_squared_error')
    return(cv_results)

#%%
cv_results_KNN = do_cross_val_score(pipe_KNN.best_estimator_)
cv_results_KNN.mean().round(3)

#%%
cv_results_NN = do_cross_val_score(pipe_NN.best_estimator_)
cv_results_NN.mean().round(3)

#%%
cv_results_DT = do_cross_val_score(pipe_DT.best_estimator_)
cv_results_DT.mean().round(3)

#%%
cv_results_DT2 = do_cross_val_score(pipe_DT2.best_estimator_)
cv_results_DT2.mean().round(3)

#%%
print(stats.ttest_rel(cv_results_KNN, cv_results_NN))
print(stats.ttest_rel(cv_results_KNN, cv_results_DT2))
print(stats.ttest_rel(cv_results_DT2, cv_results_NN))


#%% [markdown]
#  ## Algorithm Performance Analysis

# | Rank | Model | negative MSE | Execution time (min) |
# | ---- | ----- | ------------ | -------------------- |
# | 1    | KNN   | -0.0006579   | 359.1                |
# | 2    | DT    | -0.0006866   | 278.8                |
# | 3    | NN    | -0.0007560   | 618.6                |

#  As you can see above:
#  - the K-Nearest Neighbor has the best MSE (closest to 0)
#  - The execution time required to run the decision tree was most efficient

#%% [markdown]
#  NEW:
#  Our methodology has several weaknesses and limitations. 
#  - We did not know the context of the data, or it's target, as the company and what the target variable is, were not included in the Kaggle competition.
#  - We did not know what the target data was, as the company and what the target variable is, were not included in the Kaggle competition.
#  - We did not do in-depth feature selection and only included several options within the pipeline (i.e. 5 or 10 features).
#  - We used a small sample of the entire dataset in order to perform our analysis (5000 rows of a total possible ~200k).
#  - These limitations were put in place to reduce execution time; to improve the accuaracy of these models in future
#  - the hyperparameters of each algorithm could be further optimised
#  - As our data required us to perform regression our only performance metric was mean squared error. 



#%% [markdown]
#  ## Conclusion
#  NEW: @PhilIsHere
#
#  This report examined an unknown companies Google Ads exported data.
#  It compared three machine learning models to find the best parameters to 
#  maximise the ROI on advertising against an unknown parameter (y).
#
#  Ranked by MSE, the Nearest Neighbour (KNN) is the most performant model 
#  with the parameters: `n_neighbors: 10` and `p: 1` using the feature 
#  selection of `SelectKBest()`
#
#  The t-test p-value is significant (p < 0.05) when we compare it to both the 
#  Neural Network, and the Decision Tree model.
