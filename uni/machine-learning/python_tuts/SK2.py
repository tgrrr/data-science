#%% Change working directory from the workspace root to the ipynb file location. Turn this addition off with the DataScience.changeDirOnImportExport setting
# ms-python.python added
import os
try:
	os.chdir(os.path.join(os.getcwd(), 'python_tuts'))
	print(os.getcwd())
except:
	pass
#%% [markdown]
# # SK Part 2: Feature Selection and Ranking
# ***
#%% [markdown]
# The topics of this tutorial are feature selection and feature ranking (such as "what are the most important 5 features?"). Feature selection is usually an overlooked issue in machine learning. In many cases, using all the descriptive features that are available can lead to excessive computational times, overfitting, and poor performance in general. It's always a good idea to check to see if we can achieve better performance by employing some sort of feature selection before fitting a model. Feature selection can also be performed in conjunction with the modeling process (as part of a machine learning pipeline), which is discussed in **SK Part 5**.
# 
# ## Learning Objectives
# * Perform feature selection and ranking using the following methods:
#   - F-score (a statistical filter method)
#   - Mutual information (an entropy-based filter method)
#   - Random forest importance (an ensemble-based filter method)
#   - SPSA (a new wrapper method developed by [V. Aksakalli et al.](https://arxiv.org/abs/1804.05589))
# * Compare performance of feature selection methods using paired t-tests. 
# 
# First, let's discuss some terminology.
# 
# The classifier used to assess performance of the feature selection methods is called the "wrapper". Here, we use the 1-nearest neighbor as the wrapper. As for the sample data, we use the breast cancer Wisconsin dataset.
# 
# The first three methods are "filter methods": they examine the relationship between the descriptive features and the target feature and they select features only once regardless of which classifier shall be used subsequently.
# 
# The last method is a "wrapper method": it selects a different set of features for each wrapper. Wrapper feature selection methods are relatively slow and they need to be executed again when a different wrapper is used. For instance, the best 5 features selected by a wrapper method for 1-nearest neighbor will probably be different than the best 5 features for decision trees. However, wrapper methods attempt to solve the "real problem": "what the best subset of features when, say, the 1-nearest neighbor classifier is used?". They tend to perform somewhat better than the filter methods at the cost of more computational resources and a different set of features for each classifier.
#%% [markdown]
# ## Table of Contents
#   * [Data Preparation](#Data-Preparation)
#   * [Performance with Full Set of Features](#Performance-with-Full-Set-of-Features)
#   * [Feature Selection Using F-Score](#Feature-Selection-Using-F-Score)
#   * [Feature Selection Using Mutual Information](#Feature-Selection-Using-Mutual-Information)
#   * [Feature Selection Using Random Forest Importance](#Feature-Selection-Using-Random-Forest-Importance)
#   * [Feature Selection Using SPSA](#Feature-Selection-Using-SPSA)
#   * [Performance Comparison Using Paired T-Tests](#Performance-Comparison-Using-Paired-T-Tests)
#%% [markdown]
# ## Data Preparation

#%%
import warnings
warnings.filterwarnings("ignore")
import numpy as np
import pandas as pd
from sklearn.model_selection import cross_val_score, RepeatedStratifiedKFold
import sklearn.metrics as metrics
from sklearn.ensemble import RandomForestClassifier
from sklearn import preprocessing
from sklearn import feature_selection as fs
from sklearn.neighbors import KNeighborsClassifier

#%% [markdown]
# Let's load the dataset from the Cloud.

#%%
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

cancer_df.shape

#%% [markdown]
# Let's have a look at the first 5 rows to see what the dataset looks like. Here, the last column "diagnosis" is the target variable.

#%%
cancer_df.head()

#%% [markdown]
# Let's do some pre-processing:
# - Split the dataset columns into `Data` and `target`.
# - Make target numeric by label-encoding.
# - Normalize each descriptive feature in `Data` to be between 0 and 1.

#%%
Data = cancer_df.drop(columns = 'diagnosis').values
target = cancer_df['diagnosis']
Data = preprocessing.MinMaxScaler().fit_transform(Data)
target = preprocessing.LabelEncoder().fit_transform(target)

#%% [markdown]
# ## Performance with Full Set of Features
#%% [markdown]
# As wrapper, we use the 1-nearest neighbor classifier.

#%%
clf = KNeighborsClassifier(n_neighbors=1)

#%% [markdown]
# First, we would like to assess performance using all the features in the dataset. For assessment, we shall use stratified 5-fold cross-validation with 3 repetitions. We set the random state to 999 so that our results can be replicated and verified later on exactly as they are.

#%%
cv_method = RepeatedStratifiedKFold(n_splits=5, 
                                     n_repeats=3,
                                     random_state=999)

#%% [markdown]
# For scoring, we use the accuracy score.

#%%
scoring_metric = 'accuracy'

#%% [markdown]
# Let's perform the cross-validation using the `cross_val_score` function.

#%%
cv_results_full = cross_val_score(estimator=clf,
                             X=Data,
                             y=target, 
                             cv=cv_method, 
                             scoring=scoring_metric)

#%% [markdown]
# The array `cv_results_full` contains 15 values corresponding to each one of the 3-repetition/ 5-fold combinations.

#%%
cv_results_full

#%% [markdown]
# We compute the average cross-validation performance as the mean of the `cv_results_full` array.

#%%
cv_results_full.mean().round(3)

#%% [markdown]
# So, with the full set of features and with the 1-nearest neighbor classifier as our wrapper, we achieve an average accuracy of 95.4%.
# 
# Let's now select the best 5 features in the dataset using different methods.

#%%
num_features = 5

#%% [markdown]
# ## Feature Selection Using F-Score
#%% [markdown]
# The F-score method is a filter feature selection method that looks at the relationship between each descriptive feature and the target feature using the F-distribution. 
# 
# The code below returns the indices of the 5 features that have the highest f-score value sorted from the highest to the lowest. Pay attention that the wrapper is not used in any way when selecting features using the F-score method.

#%%
fs_fit_fscore = fs.SelectKBest(fs.f_classif, k=num_features)
fs_fit_fscore.fit_transform(Data, target)
fs_indices_fscore = np.argsort(fs_fit_fscore.scores_)[::-1][0:num_features]
fs_indices_fscore

#%% [markdown]
# Let's see what these 5 best features are.

#%%
best_features_fscore = cancer_df.columns[fs_indices_fscore].values
best_features_fscore

#%% [markdown]
# Based on the F-scores, we observe that, out of the top 5 features, the most important feature is "worst_concave_points" and the least important feature is "mean_perimeter".
#%% [markdown]
# The F-score importances of these features are given below.

#%%
feature_importances_fscore = fs_fit_fscore.scores_[fs_indices_fscore]
feature_importances_fscore

#%% [markdown]
# We define a function for plotting so that we can plot other importance types as well corresponding to different feature selection methods.

#%%
import altair as alt

def plot_imp(best_features, scores, method_name, color):
    
    df = pd.DataFrame({'features': best_features, 
                       'importances': scores})
    
    chart = alt.Chart(df, 
                      width=500, 
                      title=method_name + ' Feature Importances'
                     ).mark_bar(opacity=0.75, 
                                color=color).encode(
        alt.X('features', title='Feature', sort=None, axis=alt.AxisConfig(labelAngle=45)),
        alt.Y('importances', title='Importance')
    )
    
    return chart


#%%
plot_imp(best_features_fscore, feature_importances_fscore, 'F-Score', 'red')

#%% [markdown]
# We can select those features from the set of descriptive features `Data` using slicing as shown below.

#%%
Data[:, fs_indices_fscore].shape

#%% [markdown]
# Let's now assess performance of this feature selection method using cross validation with the 1-nearest neighbor classifier.

#%%
cv_results_fscore = cross_val_score(estimator=clf,
                             X=Data[:, fs_indices_fscore],
                             y=target, 
                             cv=cv_method, 
                             scoring=scoring_metric)
cv_results_fscore.mean().round(3)

#%% [markdown]
# ## Feature Selection Using Mutual Information
#%% [markdown]
# The mutual information method is a filter feature selection method that looks at the relationship between each descriptive feature and the target feature using the concept of entropy.
# 
# The code below returns the indices of the 5 features that have the highest mutual information value. As in the F-score method, the wrapper is not used in any way when selecting features using the mutual information method.

#%%
fs_fit_mutual_info = fs.SelectKBest(fs.mutual_info_classif, k=num_features)
fs_fit_mutual_info.fit_transform(Data, target)
fs_indices_mutual_info = np.argsort(fs_fit_mutual_info.scores_)[::-1][0:num_features]
best_features_mutual_info = cancer_df.columns[fs_indices_mutual_info].values
best_features_mutual_info


#%%
feature_importances_mutual_info = fs_fit_mutual_info.scores_[fs_indices_mutual_info]
feature_importances_mutual_info


#%%
plot_imp(best_features_mutual_info, feature_importances_mutual_info, 'Mutual Information', 'blue')

#%% [markdown]
# Now let's evaluate the performance of these features.

#%%
cv_results_mutual_info = cross_val_score(estimator=clf,
                             X=Data[:, fs_indices_mutual_info],
                             y=target, 
                             cv=cv_method, 
                             scoring=scoring_metric)
cv_results_mutual_info.mean().round(3)

#%% [markdown]
# ## Feature Selection Using Random Forest Importance
#%% [markdown]
# The random forest importance (RFI) method is a filter feature selection method that uses the total decrease in node impurities from splitting on a particular feature as averaged over all decision trees in the ensemble. For classification, the node impurity is measured by the Gini index and for regression, it is measured by residual sum of squares.
# 
# Let's perform RFI feature selection using 100 trees.

#%%
model_rfi = RandomForestClassifier(n_estimators=100)
model_rfi.fit(Data, target)
fs_indices_rfi = np.argsort(model_rfi.feature_importances_)[::-1][0:num_features]

#%% [markdown]
# Here are the best features selected by RFI.

#%%
best_features_rfi = cancer_df.columns[fs_indices_rfi].values
best_features_rfi


#%%
feature_importances_rfi = model_rfi.feature_importances_[fs_indices_rfi]
feature_importances_rfi


#%%
plot_imp(best_features_rfi, feature_importances_rfi, 'Random Forest', 'green')

#%% [markdown]
# Now let's evaluate the performance of these features.

#%%
cv_results_rfi = cross_val_score(estimator=clf,
                             X=Data[:, fs_indices_rfi],
                             y=target, 
                             cv=cv_method, 
                             scoring=scoring_metric)
cv_results_rfi.mean().round(3)

#%% [markdown]
# ## Feature Selection Using SPSA
#%% [markdown]
# SPSA is a new wrapper-based feature selection method that uses binary stochastic approximation. An R implementation is available within the `spFSR` package and a Python implementation can be found on [github](https://github.com/vaksakalli/spsaml_py). Please refer to this [arxiv](https://arxiv.org/abs/1804.05589) paper for more information on this method.
#%% [markdown]
# In order for this example to work, you need to make sure that you download and copy the Python file `SpFtSel.py` under the same directory as your Jupyter notebook so that the import works correctly.
#%% [markdown]
# Let's define a SpFtSel object with our feature selection problem with 'accuracy' as our performance metric.

#%%
from SpFtSel import SpFtSel

sp_engine = SpFtSel(Data, target, clf, 'accuracy')

#%% [markdown]
# Let's now run the SPSA method and the indices of the best features.

#%%
np.random.seed(999)
sp_output = sp_engine.run(num_features).results

#%% [markdown]
# Let's get the indices of the best features.

#%%
fs_indices_spsa = sp_output.get('features')
fs_indices_spsa

#%% [markdown]
# Let's have a look at the top 5 features selected by SPSA.

#%%
best_features_spsa = cancer_df.columns[fs_indices_spsa].values
best_features_spsa


#%%
feature_importances_spsa = sp_output.get('importance')
feature_importances_spsa


#%%
plot_imp(best_features_spsa, feature_importances_spsa, 'SPSA', 'brown')

#%% [markdown]
# Finally, let's evaluate the performance of the SPSA feature selection method.

#%%
cv_results_spsa = cross_val_score(estimator=clf,
                             X=Data[:, fs_indices_spsa],
                             y=target, 
                             cv=cv_method, 
                             scoring=scoring_metric)
cv_results_spsa.mean().round(3)

#%% [markdown]
# We observe that we get a cross-validation accuracy of 96.4% with SPSA with just 5 features. Recall that the cross-validation accuracy with the full set of features is 95.4%. So, in this particular case, it is remarkable that we can achieve even slightly better results with 5 features selected by SPSA as opposed to using all the 30 features. However, we will need to conduct a t-test to determine if this difference is statistically significant or not.
#%% [markdown]
# ## Performance Comparison Using Paired T-Tests
#%% [markdown]
# For performance assessment, we used repeated cross-validation. However, cross-validation is a random process and we need statistical tests in order to determine if any difference between the performance of any two feature selection methods is statistically significant; or if it is within the sample variation and the difference is statistically insignificant.
# 
# Since we fixed the random state to be same for all cross-validation procedures, all feature selection methods were fitted and then tested on exactly the same data partitions. This indicates that our experiments were actually paired. Conducting experiments in a paired fashion reduces the variability significantly compared to conducting experiments in an independent fashion.
# 
# Let's now conduct paired t-tests to see which differences between full set of features, filter methods, and SPSA are statistically significant. Let's first remind ourselves the performances.

#%%
print('Full Set of Features:', cv_results_full.mean().round(3))
print('F-Score:', cv_results_fscore.mean().round(3))
print('Mutual Information:', cv_results_mutual_info.mean().round(3))
print('RFI:', cv_results_rfi.mean().round(3))
print('SPSA:', cv_results_spsa.mean().round(3)) 

#%% [markdown]
# For a paired t-test in Python, we use the `stats.ttest_rel` function inside the `scipy` module and look at the p-values. At a 95% significance level, if the p-value is smaller than 0.05, we  conclude that the difference is statistically significant.

#%%
from scipy import stats
print(stats.ttest_rel(cv_results_spsa, cv_results_fscore).pvalue.round(3))
print(stats.ttest_rel(cv_results_spsa, cv_results_mutual_info).pvalue.round(3))
print(stats.ttest_rel(cv_results_spsa, cv_results_rfi).pvalue.round(3))

#%% [markdown]
# For SPSA vs. all the other three feature selection methods, we observe a p-value of 0, which indicates SPSA is statically better than F-score, mutual information, and RFI methods.

#%%
stats.ttest_rel(cv_results_spsa, cv_results_full).pvalue.round(3)

#%% [markdown]
# For SPSA vs. full set of features, we observe a p-value of 0.06, indicating that the difference is not statically significant. Thus, SPSA with 5 features performs at similar levels as the full set of features, at least for the 1-nearest neighbor classifier.
#%% [markdown]
# **Note**: In this notebook, we use all the data to train the feature selection methods and then tested them again on the entire dataset using cross-validation. Despite its simplicity, this approach potentially results in overfitting. In order to mitigate this issue, a more appropriate procedure would be to perform this comparison within a repeated cross-validation scheme: we use two nested for loops (the outer loop for the repetitions and the inner loop for the folds). In the inner loop, we use a particular 80% of the entire data for fitting the feature selection methods and the remaining 20% for evaluation.
#%% [markdown]
# ***
# 
# MATH2319 - Machine Learning @ RMIT University

