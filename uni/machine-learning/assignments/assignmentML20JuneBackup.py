#%% [markdown]
# ##### PHASE II ######
#  Your Phase II report must include the following (30 points total):
#  (4 points) A detailed complete overview of your methodology
#  (10 points) Details of
#  - feature selection,
#  - the algorithms’ tuning process,
#  - and detailed performance analysis of each algorithm
#  (4 points) Performance comparison of the algorithms as appropriate (cross-validation, AUC, etc.) using paired t-tests
#  (4 points) A critique of your approach: underlying assumptions, its limitations, its strengths and its weaknesses
#  (4 points) Summary and conclusions of your entire project
#  (4 points) Overall quality of your project report: clarity, conciseness, coherence, and, general good writing practices.
#  -------------------
#  NEW for Assignment 2 6
#  - [x] encode device type, and other stuff
#  - [x] add import packages @ash added
#  - [x] check data and target set (I think its sourceNormalised ?) @ash added
#  - [x] choose num_features @ash added
#  - [x] get rid of integers
#  - [x] how to handle 14-15% outliers
#  - one hot encoding needs to be done before scaling
#  - [ ] abstract
#  - [ ] clarify what our target feature is
#  - [x] sample dataset
#  - [ ] ~old_todo~ Objective/goal
#  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #
#%% [markdown]
#  # ~old_todo~ (4 points) A detailed complete overview of your methodology
#%% [markdown]
#  # ~old_todo~ Objective
#  - Target variable 'y' is numeric
#  - Will be using descriptive features from the test data for regression
#  - algorithms: k-nearest neighbor regression, decision tree regressor, and neural network
#%% [markdown]
#  ## Setup

#%%
import io, math, numpy as np, os, pandas as pd, sklearn, warnings
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

#%%
# from google.colab import files
# uploaded = files.upload()
#%%
# from google.colab import drive
# drive.mount('/content/drive')
# !ls "/content/drive/My Drive/" # this line will let you know if it's mounted correctly
# import os
# try:
# 	os.chdir(os.path.join(os.getcwd(), '..'))
# 	print(os.getcwd())
# except:
# 	pass
#%%
# ~old_fixme~ remove the chdir line at the end
# os.getcwd()
# os.chdir('/Users/ashleigholney/Desktop/MATH2319-Machine-Learning/Course Project') # ash's
os.chdir('/Users/phil/code/data-science-next/uni/machine-learning/assignments') # phil's
__file__ = 'advertising_train.csv'
data = pd.read_csv(__file__)


# consistent naming of columns (minus camelCase):
labelNames = [
    'case_id', 'company_id', 'country_id', 'device_type', 'day', 'dow', 
    'price1', 'price2', 'price3', 'ad_area', 'ad_ratio', 'requests', 
    'impression', 'cpc', 'ctr', 'viewability', 'ratio1', 'ratio2', 'ratio3', 
    'ratio4', 'ratio5', 'y', ]
data.columns = labelNames

#%% [markdown]
#  Common code/functions we reuse throughout code

#%%
numeric = list(data.select_dtypes(exclude = ['object']).columns)
numericColumnsList = list(data[(numeric)].columns.values)
objects = list(data.select_dtypes(include = ['object']).columns)
numericFeatureList = [
    'price1', 'price2', 'price3', 'ad_area', 'ad_ratio', 'requests', 
    'impression', 'cpc', 'ctr', 'viewability', 'ratio1', 'ratio2', 'ratio3', 
    'ratio4', 'ratio5', ]

#%% [markdown]
#  ## source Pre-processing
#  Remove any index columns

#%%
data = data.loc[:, data.nunique() != data.shape[0]]
data.shape

#%% [markdown]
#  Remove any constant features (that have only one unique value)

#%%
data = data.loc[:, data.nunique() != 1]
data.shape

#%% [markdown]
#  #### check for nulls

#%%
print(data.isnull().sum())

#%% [markdown]
#  ## Encoding Categorical Variables

#%%
data['dow'] = data['dow'].str.lower()
categoricalFeatureList = [
    'company_id', 'country_id', 'device_type', 'day', 'dow'
    ]
data = pd.get_dummies(data, columns = categoricalFeatureList)
print(data.dtypes)
data.shape

#%% [markdown]
#  Our data is now 226 features wide
#  ## Outlier detection

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
#  ~old_fixme~ this is 1
#  ## Split into target/data
#  Split `y` into separate dataset before normalisation

#%%
# pandas version:
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
#  ## Sample it
#%%
# numpy version
sourceSample = pd.DataFrame(
    sourceNormalised,
    ).sample(n = 5000, random_state = 8).values
targetSample = pd.DataFrame(
    targetNormalised,
    ).sample(n = 5000, random_state = 8).values
# pandas versions
dataSamplePanda = pd.DataFrame(data).sample(n = 5000, random_state=8)
sourceSamplePanda = pd.DataFrame(source).sample(n = 5000, random_state=8)
sourceNormalisedSample = pd.DataFrame(
	sourceNormalised).sample(n = 5000, random_state = 8)

#%% [markdown]
#  # PHASE II
#  ~old_todo~
#   (10 points) Details of:
#   - feature selection,
#   - the algorithms’ tuning process,
#   - and detailed performance analysis of each algorithm

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#

#%% [markdown]
#  ## Neural Network WIP @philIsHere

#%%
cv_method = RepeatedKFold(n_splits = 3, random_state = 999)

#%%
X_train, X_test, y_train, y_test = train_test_split(
    sourceSample,
    targetSample,
)

nn = MLPRegressor(
    alpha = 0.001,
    hidden_layer_sizes = (10,),
    max_iter = 50000,
    activation = 'logistic',
    verbose = 'True',
    learning_rate = 'adaptive',
)

nn.fit(X_train, y_train)

nn_predict_train = nn.predict(X_train)
# ~old_todo~ this repeats function below (refactor?)
nn_predict_test = nn.predict(X_test)

train_mse = mean_squared_error(y_train, nn_predict_train)
test_mse = mean_squared_error(y_test, nn_predict_test)

#%%
# ~old_fixme~ this doesn't work
nn.best_params_
nn.best_score_

#%%
train_mse  # 0.0007085603373979959
#%%
test_mse  # 0.0008310443180945765


#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#

# ~old_fixme~ problem:
params_pipe_NN_fs = {
    'fselector__k': [5, 10, source.shape[1]],
    'dt__criterion': ['mse'],
    'dt__max_depth': [1, 2, 3, 4],
    'dt__min_samples_split': [5, 50, 100, 150]
}

# good
nn = MLPRegressor(
    alpha = 0.001,
    hidden_layer_sizes = (10,),        # default: (100,)
    max_iter = 50000,                  # default is 200
    activation = 'logistic',           # OR {‘identity’, ‘logistic’, ‘tanh’, ‘relu’}, default ‘relu’
    #   solver = 'adam',               # New! {‘lbfgs’, ‘sgd’, ‘adam’}, default ‘adam’
    verbose = True,
    learning_rate = 'adaptive',        # {‘constant’, ‘invscaling’, ‘adaptive’}
)

steps = [
    # ('min/max scaler', MinMaxScaler(feature_range=(0.0, 1.0))),
    ('neural network', nn),
    ]
    # [
    #     ('scaler', StandardScaler()), 
    #     ('SVM', SVC()),
    #     ('fselector', SelectKBest(score_func = feature_selection.f_regression)),
    #     ('dt', df_regressor)
    # ]
pipe_NN_fs = Pipeline(steps)

gs_pipe_NN_fs = GridSearchCV(
    pipe_NN_fs,                         # imported here
    params_pipe_NN_fs,
    cv = cv_method,
    n_jobs = -1,                        # somewhere said it should be even
    scoring = 'neg_mean_squared_error', #
    refit = 'neg_mean_squared_error',   #
    verbose = 1,
)
gs_pipe_NN_fs.fit(sourceSample, targetSample)
gs_pipe_NN_fs.best_score_
gs_pipe_NN_fs.best_params_


#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#

#%% [markdown]
#  ## Nearest Neighbour Pipelines

# steps = [
#     ('fselector', SelectKBest(score_func = feature_selection.f_regression)),
#     ('dt', df_regressor)
#     ]

steps_KNN = [
    ('fselector', SelectKBest()),
    ('knn', KNeighborsRegressor())
    ]

pipe_KNN = Pipeline(steps_KNN)

#%% [markdown]
#  #### the algorithms’ tuning process,
#  `'fselector__k': [5, 10]` are feature selection
#  `'knn__n_neighbors'`
#  `'knn__p': [1, 2]` is distance

#%%
params_pipe_KNN = {
    'fselector__score_func': [
        fs.f_regression, 
        fs.mutual_info_regression],
    'fselector__k': [5, 10],  # source.shape[1]],
    'knn__n_neighbors': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    'knn__p': [1, 2]}

gs_pipe_KNN = GridSearchCV(
    estimator = pipe_KNN,
    param_grid = params_pipe_KNN,
    cv = cv_method,
    n_jobs = -2,
    scoring = 'neg_mean_squared_error',
    verbose = 1)

#%%
gs_pipe_KNN.fit(sourceSample, targetSample)

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
gs_pipe_KNN.best_params_

#%% [markdown]
# `{'fselector__k': 10,
#  'fselector__score_func': 
#   <function sklearn.feature_selection.univariate_selection.f_regression(X, y, center=True)>,
#  'knn__n_neighbors': 10,
#  'knn__p': 1}`

#%%
gs_pipe_KNN.best_score_

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
#  'fselector__k': [5, 10, source.shape[1]],
#  'dt__criterion': ['mse'],
#  'dt__max_depth': [1, 2, 3, 4],
#  'dt__min_samples_split': [5, 50, 100, 150]
#  ~old_todo~ rubric - and detailed performance analysis of each algorithm

params_pipe_DT_fs = {
    'fselector__k': [5, 10, source.shape[1]],
    'dt__criterion': ['mse'],
    'dt__max_depth': [1, 2, 3, 4],
    'dt__min_samples_split': [5, 50, 100, 150]
}

steps = [
    ('fselector', SelectKBest(score_func = feature_selection.f_regression)),
    ('dt', df_regressor)
    ]

pipe_DT_fs = Pipeline(steps)

gs_pipe_DT_feature_selection. = GridSearchCV(
    pipe_DT_fs,
    params_pipe_DT_fs,
    cv = cv_method,
    n_jobs = -1,
    scoring = 'neg_mean_squared_error',
    refit = 'neg_mean_squared_error',
    verbose = 1
)

gs_pipe_DT_fs.fit(sourceSample, targetSample)

gs_pipe_DT_fs.best_score_

gs_pipe_DT_fs.best_params_
#%% [markdown]
#  the best parameters are at the upper bounds of what was tested.
#  the pipeline will be extended

#%%
params_pipe_DT2 = {'fselector__k': [26],
    'dt__criterion': ['mse'],
    'dt__max_depth': [5, 10, 15, 20],
    'dt__min_samples_split': [150, 200, 250, 300, 350, 400, 450, 500]}

steps = [
    ('fselector', SelectKBest(score_func = fs.f_regression)),
    ('dt', df_regressor)
]
pipe_DT2 = Pipeline(steps)

gs_pipe_DT2 = GridSearchCV(
    pipe_DT2,
    params_pipe_DT2,
    cv = cv_method,
    n_jobs = -1,
    scoring = 'neg_mean_squared_error',
    refit = 'neg_mean_squared_error',
    verbose = 1
)

gs_pipe_DT2.fit(sourceSample, targetSample)

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
gs_pipe_DT2.best_params_

#%% [markdown]
# ```
# {'dt__criterion': 'mse',
#  'dt__max_depth': 20,
#  'dt__min_samples_split': 200,
#  'fselector__k': 26}
# ```

#%%
gs_pipe_DT2.best_score_

#%% [markdown]
# -0.0007118538116185094

#%% [markdown]
#  Performance Comparison of Algorithms
#  ~old_todo~ rubric (4 points) Performance comparison of the algorithms as 
#  appropriate (cross-validation, AUC, etc.) using paired t-tests

#%%
cv_results_KNN

#%%
cv_results_NN

#%%
cv_results_DT

#%%

cv_method_ttest = RepeatedKFold(n_splits = 10, random_state = 1)

# ~old_todo~ Test this function
# ~old_todo~ Doc this function
# function predicts the target (y) for the test data
# then compares the predicted target to the real target (y) from the test data
def do_cross_val_score(estimator):
    cv_results = cross_val_score(
        estimator = estimator,
        X = X_test,
        y = y_test,
        cv = cv_method_ttest,
        n_jobs = -2,
        scoring = 'neg_mean_squared_error')
    return(cv_results.mean())

#%%
cv_results_KNN = do_cross_val_score(gs_pipe_KNN.best_estimator_)
# cv_results_NN = do_cross_val_score(gs_pipe_NN.best_estimator_)
cv_results_DT2 = do_cross_val_score(gs_pipe_DT2.best_estimator_)

#%%
cv_results_KNN
# cv_results_NN = do_cross_val_score(gs_pipe_NN.best_estimator_)

#%%
cv_results_DT2

#%%
# print(stats.ttest_rel(cv_results_KNN, cv_results_NN))
print(stats.ttest_rel(cv_results_DT2, cv_results_KNN))
# print(stats.ttest_rel(cv_results_DT, cv_results_NN))

#%% [markdown]
#  A critique of your approach
#  ~old_todo~ rubric
#  (4 points) A critique of your approach: underlying assumptions, 
#  its limitations, its strengths and its weaknesses
