# %% markdown
# # Data Preparation for Statistical Modeling and Machine Learning
# ***
# %% markdown
# This tutorial's topic is data preparation for statistical modeling and machine learning. Our terminology is that the feature we would like to predict is called the "target" feature. The other features that we use for the prediction are called the "descriptive" features. There is a certain format for the data before we can perform modeling using `Scikit-Learn`. In general, the following steps will be necessary for data preparation **in this specific order**:
# 1. Outliers and unusual values (such as a negative age) are taken care of: they are either imputed, dropped, or set to missing values. We do not cover this subject and refer the reader to Chapters 2 and 3 in our FMLPDA textbook.
# 2. Missing values are imputed or the rows containing them are dropped.
# 3. Any categorical descriptive feature is encoded to be numeric as follows: 
#    - one-hot-encoding for nominals, 
#    - one-hot-encoding or integer-encoding for ordinals.
# 4. All descriptive features (which are all numeric at this point) are scaled.
# 5. In case of a classification problem, the target feature is label-encoded (in case of a binary problem, the positive class is encoded as 1).
# 6. If the dataset has too many observations, only a small random subset of entire dataset is selected to be used during model tuning and model comparison. 
# 7. Before fitting any `Scikit-Learn` models, any `Pandas` series or data frame is converted to a `NumPy` array using the `values` method in Pandas.
# 
# We now briefly describe the above steps. We will first have to make sure there are no missing values anywhere, neither in the descriptive features nor the target feature. Dealing with missing values can involve various imputation techniques in practice. However, we will stick to our topic of modeling and we will simply remove any rows with any missing values in this tutorial. 
# 
# Next, we will have to ensure that all categorical features are encoded correctly. For **nominal** categorical descriptive features, we will use one-hot-encoding where a categorical feature with $q$ levels is replaced with $q$ binary variables indicating membership of the $q$-th level. For **ordinal** categorical descriptive features, we can use either one-hot-encoding or integer-encoding.
# 
# For categorical **target** features, we will use label-encoding so that a categorical target feature with $t$ levels is encoded as integers in the range $0, 1, \ldots, t-1$. Here, the encoding is done in alphabetical order. That is, the level that would be the first after an alphabetical sorting will be encoded as 0, and so forth. However, as we will see in tutorial **SK Part 4: Evaluation**, in the case of a binary classification, we need the "positive" class to be encoded as "1" and the negative class to be encoded as "0". So, we will have to make sure that regardless of the alphabetical order, the positive class is always encoded as 1. 
# 
# For regression problems where the target feature is numerical, apparently no label-encoding shall be necessary. On the other hand, if the range of the numerical target feature is quite large (salaries might be a good example here), then a `log` transformation might be useful.
# 
# Many machine learning algorithms require **numerical descriptive** features to be scaled in some fashion (such as nearest neighbor methods) and, scaling usually does not hurt the other type of algorithms. So, it is always a good idea to scale the numerical descriptive features before modeling.
# 
# Sometimes your dataset will have too many observations for your computer to handle (as in millions of rows). If this is the case, it might be good idea to select a small random subset of the entire set of observations before trying out any models. Once you decide on which model to use, you can then use the entire dataset for final training  before deploying your model.
# 
# `Scikit-Learn` models do not play well with `Pandas` series or data frames. For this reason, before fitting any models, we have to ensure that any `Pandas` variable is converted to a `NumPy` array using its `values` method.
# 
# In this tutorial, we will see how the data preparation steps described above can be performed using the `NumPy`, `Pandas`, and `Scikit-Learn` modules.
# 
# ## Learning Objectives
# 
# - Load datasets from `sklearn` as well as from the Cloud
# - Perform initial data preparation steps
# - Deal with missing values
# - Discretize numeric features and make categorical features numeric
# - Encode categorical target features in classification problems
# - Scale numerical descriptive features: min-max, standard, and robust scaling
# - Select a small random subset of available rows
# %% markdown
# ## Table of Contents
# 
# - [Binary Classification Example: Breast Cancer Wisconsin Data](#2)
# - [First Steps](#2.1)
# - [Checking for Missing Values](#2.2.0)
# - [Discretizing Numeric Features](#2.2.1)
# - [Making Categorical Features Numeric](#2.2.2)
# - [Encoding The Target Feature](#2.3)
# - [Scaling Descriptive Features](#2.4)
# - [Sampling Observations](#2.5)
# %% markdown
# ## Binary Classification Example: Breast Cancer Wisconsin Data <a class="anchor" id="2"></a>
# 
# This dataset contains 569 observations and has 30 input features from breast cancer screening tissue samples. The target feature has two classes: 212 malignant ("M") and 357 benign ("B"). 
# 
# We can load the data from `sklearn` (as shown further below), or we can read the data from the following github account. The reason we prefer the github account here is that the version in `sklearn` does not have column names.
# %%
import warnings
warnings.filterwarnings("ignore")

import numpy as np
import pandas as pd
import io
import requests

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
# Let's have a look at 10 randomly selected rows in this raw dataset.
# %%
cancer_df.sample(n=10, random_state=8)
# %% markdown
# ## First Steps <a class="anchor" id="2.1"></a>
# 
# Before undertaking more involved data preparation steps, we need to perform some basic steps, which are described below.
# %% markdown
# ### ID Columns for Rows
# 
# Sometimes the dataset at hand will have a unique value for each row, such as Customer ID, Patient ID, Record ID, etc. Such features are irrelevant in machine learning. As an example, consider a new patient whose ID 84537. How is this ID going to help us with predicting this patient's health status? For this reason, we need to remove any column whose unique value count is the same as the number of rows. We can achieve this as follows for a dataset object `df`.
# ```Python
# df = df.loc[:, df.nunique() != df.shape[0]]
# ```
# 
# ### Constant Features
# 
# Sometimes a dataset will have constant features (that have only one unique value). Such features are also irrelevant for machine learning, so they need to be removed as follows.
# ```Python
# df = df.loc[:, df.nunique() != 1]
# ```
# 
# ### Other Irrelevant Features
# 
# While being problem-specific, any feature that is not relevant for "learning" needs to be removed. For instance, suppose there is a column in your dataset that shows the particular database this row was extracted from. If this information is purely for record-keeping purposes, then you should remove this column before fitting any models.
# 
# ### Redundant Features
# 
# A descriptive feature is "redundant" if it conveys the same information as another feature. Suppose a customer's salary is stored in two columns: one in US Dollars and the other one in AU Dollars. You need only one of these columns.
# 
# ### Date and Time Features
# 
# Date and time features need careful attention. Date features such as birthdays cannot be used as they are and they must be transformed. In the birthday example, the logical approach would be be convert it to a new feature called "age". For the conversion, you need to [subtract](https://docs.python.org/3/library/datetime.html) the birth date from the current date and cast the result to a year quantity. As for time features, they should be transformed to durations, such as number of hours since a particular reference point in time.
# %% markdown
# ## Checking for Missing Values <a class="anchor" id="2.2.0"></a>
# %% markdown
# Models in `Scikit-Learn` do not work with data with missing values. Let's check to see which columns have missing values in our dataset. Missing values are a bit complicated in Python as they can be denoted by either "na" or "null" in `Pandas` (both mean the same thing). Furthermore, `NumPy` denotes missing values as "NaN" (that is, "not a number").
# %%
cancer_df.isna().sum()
# %% markdown
# We observe that there are no columns with a missing value, which is good. In case there were any missing values, we would have to either impute them or drop the corresponding rows. Dealing with missing values can get rather complicated and they are beyond our scope in this tutorial (please see Chapter 3 in the textbook for more details). For simplicity, we advocate just dropping the rows where at least one element is missing. We can accomplish this using the `dropna()` method in `Pandas`:
# %%
cancer_df = cancer_df.dropna()
# %% markdown
# ## Discretizing Numeric Features <a class="anchor" id="2.2.1"></a>
# %% markdown
# Sometimes it's a good idea to discretize a numeric feature and make it a categorical feature. For instance, instead of treating an age variable as numeric, it might be a better option to discretize is as young, middle-aged, and old.
# 
# Let's briefly digress here and see how we can discretize the `mean_area` numeric feature in the cancer dataset as "small", "average", and "large" using equal-frequency binning. We can use the `qcut` method in the `Pandas` module, which performs quantile-based discretization. We can also supply names for the resulting discretization.
# 
# First, we will make a copy of the original dataset and give it a different name.
# %%
cancer_df_cat = cancer_df.copy()

cancer_df_cat['mean_area'] = pd.qcut(cancer_df_cat['mean_area'], q=3, 
                                     labels=['small', 'average', 'large'])
# %% markdown
# Let's make sure we performed the dicretization correctly using the `value_counts` method in `Pandas`.
# %%
cancer_df_cat['mean_area'].value_counts()
# %% markdown
# Let's have a look at the first 5 rows in the categorized dataset. You will notice that `mean area` is now categorical.
# %%
cancer_df_cat.head(5)
# %% markdown
# ## Making Categorical Features Numeric  <a class="anchor" id="2.2.2"></a>
# %% markdown
# Keep in mind that `Scikit-Learn` **requires all features to be numeric**, so you need to encode your categorical features as numeric.
# 
# ### Nominal vs. Ordinal Categorical Features 
# 
# There are two types of categorical features: nominal and ordinal. Levels of a **nominal** (categorical) feature do not have a natural ordering. Some examples of nominal categorical features are as follows:
# - Gender
# - Seasons
# - Days of a week
# - ID features (such as country IDs, device type IDs)
# - States in a country
# - Breed of a dog
# - Colors of a car brand
# 
# On the other hand, levels of an **ordinal** (categorical) feature have a natural ordering. Some examples are as follows:
# - The likert scale (strongly disagree, disagree, neutral, agree, strongly agree)
# - Performance levels (poor, satisfactory, good, excellent)
# - Education levels (none, elementary, secondary, bachelors, masters, doctorate)
# - Age of a customer (young, middle-aged, old)
# 
# ### Encoding Nominal Descriptive Features
# 
# Nominal **descriptive** features must be encoded using "one-hot-encoding", which is described below. This type of encoding creates a binary variable for each unique value of the nominal feature we are encoding. 
# 
# We need to be careful here: **Sometimes a feature that appears to be numeric is actually nominal!** For instance, you might have a feature for country IDs that is numerical. However, these numbers indicate IDs, not numerical quantities! So, we will have to treat this feature as nominal. That is, whenever we have a numerical feature that actually represents categorical quantities (such as IDs), we must consider them as nominal and we must encode them using one-hot-encoding.
# 
# ### Encoding Ordinal Descriptive Features
# 
# For ordinal **descriptive** features, we have two options:
# - **One-hot-encoding:** We can encode ordinal features using one-hot-encoding as well. The benefit of this encoding is that we would not be assuming any arithmetic relationship between the levels. The downside is that we would be introducing $q$ additional binary variables.
# - **Integer-encoding:** We can perform integer-encoding (starting at 0) where the ordering is preserved. For instance, the likert scale above can be encoded as {0, 1, 2, 3, 4} where 0 corresponds to strongly disagree and 4 corresponds to strongly agree. The benefit of integer-encoding is that we would be replacing the original ordinal feature with just one feature that is numerical. The downside is that we would be introducing an arithmetic relationship between the levels, such as neutral (2) is "twice as much" as disagree (1).
# 
# Deciding which type of encoding is more appropriate for an ordinal feature is almost always problem-specific as we would be making a trade-off with either option with respect to its benefit and downside. However, if doubt, we recommend choosing the one-hot-encoding option.
# %% markdown
# ### One-Hot-Encoding
# 
# In the discussion below, we make no particular distinction between the terms "dummy variable" and "binary variable" and we use them interchangeably. We also make no distinction between Python "functions" and "methods" as they both refer to some piece of code.
# 
# Nominal descriptive features must always be encoded using one-hot-encoding. We can use the `get_dummies()` method in the `Pandas` module for one-hot-encoding. This is a very simple and effective method as you can do one-hot-encoding for multiple features at once and you can even supply a custom prefix for each categorical feature. If you omit the `columns` parameter, the `get_dummies()` method will intelligently do one-hot-encoding for *all* features that are not numeric. Thus, `get_dummies()` can be used in "automatic" mode.
# 
# As a side note, for the `get_dummies()` function to work correctly in the automatic mode, we would have to make sure that categorical features that look like numerical (such as country IDs) are set to the "string" type so that `get_dummies()` knows that it needs to one-hot-encode them too. You can achieve this as follows: 
# ```python
# dataframe['cat_feature'] = dataframe['cat_feature'].astype(str)
# ```
# Once you adapt the line above for your problem and then run it, the feature "cat_feature" becomes a string and therefore `get_dummies()` will one-hot-encode it correctly. While performing one-hot-encoding on a nominal descriptive feature with $q$ unique levels, we can actually define $q-1$ binary variables, but we would lose the base level as a feature and this would be problematic when performing feature selection. For instance, suppose we encode days of week using just 6 binary variables by dropping Monday. However, while doing feature selection for the most important days of the week, Monday will not even be one of the options. So, we will be using exactly $q$ binary variables in our tutorials. 
# 
# An exception here is the case of a binary nominal feature where $q=2$. In this case, we define only one binary variable by setting the `drop_first` option in `get_dummies()` to "True". As an example, we would encode the gender feature using only one binary variable. During feature selection, we would be deciding on whether the gender feature is important at all.
# 
# It should also be noted that if you are **not** planning to do any feature selection, then you should define $q-1$ dummy variables for a nominal feature, not the full set of $q$ dummy variables. The reason is that defining $q$ dummy variables results in multicollinearity and this becomes problematic while fitting models such as generalized linear models (this phenomenon is referred to as the "dummy variable trap").
# 
# Sometimes a nominal descriptive feature will have dozens of levels (such as country IDs) and using one-hot-encoding will therefore result in dozens of new (binary) variables. Well, welcome to the curse of dimensionality! To mitigate this issue, you might want to try feature selection. A more elegant solution would be to cluster countries into similar-looking groups, say in to 10 groups, and use this new group feature (which will be nominal) instead of the country ID feature, but we do not cover clustering here.
# 
# As a good practice, we should first take care of any integer-encoding procedures before any one-hot-encoding so that `get_dummies()` works correctly in the automatic mode.
# 
# Suppose we first performed any integer-encoding procedures (if required) and our dataset now has a mix of numerical and categorical descriptive features (represented by `Data`) where all categorical descriptive features are nominal. We can implement a proper one-hot-encoding logic as below in Python.
# 
# ```Python
# # get the list of categorical descriptive features
# categorical_cols = Data.columns[Data.dtypes==object].tolist()
# 
# # if a categorical descriptive feature has only 2 levels,
# # define only one binary variable
# for col in categorical_cols:
#     n = len(Data[col].unique())
#     if (n == 2):
#         Data[col] = pd.get_dummies(Data[col], drop_first=True)
#    
# # for other categorical features (with > 2 levels), 
# # use regular one-hot-encoding 
# # if a feature is numeric, it will be untouched
# Data = pd.get_dummies(Data)
# ```
# 
# As a simple example, let's see how we can use one-hot-encoding for encoding the "mean_area" categorical descriptive feature.
# %%
cancer_df_cat_onehot = pd.get_dummies(cancer_df_cat, columns=['mean_area'])

cancer_df_cat_onehot.head(5)
# %% markdown
# We notice that the "mean_area" feature is now replaced with three binary features at the end of the dataset.
# 
# ### Integer-Encoding
# 
# A nominal descriptive feature always needs be encoded using one-hot-encoding. However, an ordinal descriptive feature can be encoded via either one-hot-encoding or integer-encoding. For the latter, we can use the `replace()` function in `Pandas`. Let's do a simple example. The "mean_area" feature we defined above can in fact be considered to be "ordinal" as there is a natural ordering between the levels of small, average, and large. Let's encode this feature using integer-encoding where each level corresponds to the integers 0, 1, and 2 respectively. Before using the `replace()` function, we need define a mapping between the levels and the integers using a dictionary as below.
# %%
level_mapping = {'small': 0, 'average': 1, 'large': 2}
# %% markdown
# Once we define the mapping, we can go ahead and perform the integer-encoding using the `replace()` function. After the encoding, we notice that the "mean_area" feature is now of integer data type.
# %%
cancer_df_cat_integer = cancer_df_cat.copy()

cancer_df_cat_integer['mean_area'] = cancer_df_cat_integer['mean_area'].replace(level_mapping)

cancer_df_cat_integer.head(5)
# %% markdown
# Let's check to make sure the type of the integer-encoded "mean_area" feature is integer.
# %%
cancer_df_cat_integer['mean_area'].dtype
# %% markdown
# Once we encode an ordinal descriptive feature as an integer, we will have to treat it just like another numerical feature. For instance, it's important to keep in mind that integer-encoded ordinal features need to be scaled like other numerical features.
# 
# ### Why Integer-Encoding a Nominal Descriptive Feature is a BAD Idea
# 
# Integer encoding inherently assumes an ordering. Suppose you encode "Monday" as 1 and "Tuesday" as 2. If you feed this into a linear regression, for instance, the model will assume that Tuesday is "twice as much" as Monday. Is that really the case? Absolutely not, of course. Monday and Tuesday are just two different days of the week and clearly they are not comparable. That is, there is no natural ordering between the days of the week. However, using integer-encoding on weekdays will introduce an ordering that is not there! Thus, any subsequent modeling you perform will be incorrect and your results will be fundamentally invalid.
# %% markdown
# ## Encoding The Target Feature <a class="anchor" id="2.3"></a>
# %% markdown
# Interestingly, while we never use integer-encoding for nominal **descriptive** features, we need to do just that for a nominal **target** feature! That is, we encode a nominal target feature using integers starting with 0. When a nominal target feature has more than 2 levels, i.e., the multinomial (a.k.a. the multiclass) case, the ordering is unimportant. In fact, we use `sklearn` module's `LabelEncoder()` function for this type of integer-encoding (which is simply called "label-encoding") and this function performs the encoding based on the alphabetical order of the feature levels. However, when a nominal target feature has exactly 2 levels, i.e., the binary classification case, we need to make sure that the "positive" class is encoded as "1" regardless of the  alphabetical order of the target feature levels, as described below.
# 
# To be clear, "label-encoding" is a `Scikit-Learn` terminology that refers to a particular form of integer-encoding where (1) encoding starts with 0, (2) numbering is done sequentially, and (3) ordering is done alphabetically.
# 
# Now, we split `cancer_df` into the set of descriptive features and the target respectively. Note that we are using the original dataset here and not the categorized one, which was only for demonstration purposes. 
# 
# **WARNING:** Below, by using the `values` method of `Pandas` for "Data" and "target", we are converting them to `NumPy` arrays. Here, we make no distinction between a "vector" or a "matrix" as both are simply referred to as `NumPy` arrays with the latter being a two-dimensional array. `NumPy` arrays are usually harder to work with. **For instance, when we convert "Data" from a data frame to a `NumPy` array, we lose column names!** The reason we do this transformation is that `Scikit-Learn` only works with `NumPy` arrays and not `Pandas` variables (series or data frames). If you pass in a `Pandas` variable to a `Scikit-Learn` method, sometimes it will work! But sometimes it won't, yet the error message you get will confuse you even further! ***For this reason, in order to avoid unnecessary dramas, you should never pass in any `Pandas` variables into `Scikit-Learn` methods***. In case you need to, you will first have to make sure that you use the `values` method of the `Pandas` variable in order to convert it to a `NumPy` array beforehand.
# %%
Data = cancer_df.drop(columns = 'diagnosis').values

target = cancer_df['diagnosis'].values
# %% markdown
# Remember, `Scikit-Learn` requires all data to be numeric, so the target feature in our example needs to be encoded as 0 and 1. Note that if we had more than two levels, their label encoding would be 0,1,2,3, etc.
# 
# So, how does `Scikit-Learn` know if 0, 1, 2, 3 etc. is actually a numeric target feature, or it's label-encoding of a categorical target feature? We tell this to `Scikit-Learn` with the type of machine learning algorithm we use. For predicting numerical target features, we fit a "regressor" whereas for predicting categorical target features, we fit a "classifier".
# 
# First, let's count how many instances each label has in the target feature in the cancer dataset. 
# %%
np.unique(target, return_counts=True)
# %% markdown
# As expected, "B" (Benign) and "M" (Malignant) have 357 and 212 observations respectively. Next, let's encode these as 0 and 1 using `LabelEncoder` from the `sklearn` preprocessing module.
# %%
from sklearn import preprocessing

le = preprocessing.LabelEncoder()
le_fit = le.fit(target)
target_encoded_le = le_fit.transform(target)
# %% markdown
# Note that the `LabelEncoder` labels in an alphabetical order. That is, "B" is labeled as 0 whereas "M" as labeled as 1. 
# 
# Let's check how the encoding was done. Here, you need to be careful with respect to `NumPy` vs. `Pandas` variables. The return value of label encoding is a `NumPy` array, so you now need to use the `np.unique` method; because `value_counts` method belongs to the `Pandas` module and it will not work with a `NumPy` object.
# %%
import numpy as np

print("Target Type:", type(target))

print("Counts Using NumPy:")
print(np.unique(target_encoded_le, return_counts = True))

# this will not work:
# ### target_encoded_le.value_counts()

# but this works:
print("Counts Using Pandas:")
print(pd.Series(target_encoded_le).value_counts())
# %% markdown
# ***
# **NOTE:** Keep in mind that you can always go back and forth between a `NumPy` array and a `Pandas` series or data frame as below where `s` denotes a series, `df` denotes a data frame, and `a` denotes an array:
# * `NumPy` to `Pandas`: pd.Series(`a`) (or pd.DataFrame(`a`))
# * `Pandas to Numpy`: `s`.values (or `df`.values)
# %% markdown
# ***
# So, once encoded, how do we recover the original labels? We can do that using the `inverse_transform` method of the `LabelEncoder`.
# %%
target_original_values = le_fit.inverse_transform(target_encoded_le)

# here is an example of NumPy array to pandas Series conversion:
pd.Series(target_original_values).value_counts()
# %% markdown
# In general, the positive class (the class that we are interested in) needs to be encoded as "1" and the negative class needs to be encoded as "0" so that the performance metrics we define work correctly (we will discuss these in more detail in **SK 4: Evaluation**). In this case, we got lucky because "M" comes after "B" in the alphabet! So, label encoder correctly encoded the malignant class as "1". But we cannot rely on luck all the time, so in case the label encoding does not give us the result we want, we will have to manually define the labels ourselves. For this purpose, we can use the `where()` function in `NumPy` to perform a vectorized "if-else" operation as below. The syntax for this function is follows:
# ```R
# np.where(condition, value when condition is true, value when condition is false)
# ```
# %%
target_encoded_where = np.where(target=='M', 1, 0)

np.unique(target_encoded_where, return_counts = True)
# %% markdown
# We observe that manually encoding the target feature using the `where()` function gives us the encoding we want. As an alternative to the `where()` function, we can actually use the `replace()` function in `Pandas` for the same encoding. Keep in mind that the `replace()` function is quite handy for replacing/ mapping values in a series.
# %%
# first convert "target" to a Series so that we can use the replace function
target_encoded_replace = pd.Series(target).replace({'B': 0, 'M': 1}).values

np.unique(target_encoded_replace, return_counts = True)
# %% markdown
# In case you are wondering, there is really nothing special about "label-encoding" in `Scikit-Learn` as it is simply a "find-replace" logic as we did using the `where()` or `replace()` functions. To verify that both label-encoding and our manual "find-replace" logic using the `where()` function result in the same output, let's confirm that the arrays `target_encoded_where` and `target_encoded_le` are exactly the same!
# %%
np.array_equal(target_encoded_where, target_encoded_le)
# %% markdown
# ## Scaling Descriptive Features <a class="anchor" id="2.4"></a>
# %% markdown
# Once all categorical descriptive features are encoded, all features in this transformed dataset will be numerical. It is always a good idea to scale these numerical descriptive features before fitting any models, as scaling is mandatory for some important class of models such as nearest neighbors, SVMs, and deep learning.
# 
# Three popular types of scaling are as follows:
# 1. **Min-Max Scaling:** Each descriptive feature is scaled to be between 0 and 1. Min-max scaling for a numerical feature is done as follows: 
# 
#     $\mbox{scaled_value} = \frac{\mbox{value - min_value}}{\mbox{max_value - min_value}}$
# 
# 2. **Standard Scaling:** Scaling of each descriptive feature is done via standardization. That is, each value of the descriptive feature is scaled by removing the mean and dividing by the standard deviation of that feature. This ensures that, after scaling, each descriptive feature has a 0 mean and 1 standard deviation. Standard scaling is done as follows: 
# 
#     $\mbox{scaled_value} = \frac{\mbox{value - mean}}{\mbox{std. dev.}}$
# 
# 3. **Robust Scaling:** Robust scaling is similar to standard scaling. However, this scaling type is robust to potential outliers in the feature as the median is used instead of mean, and MAD (median absolute deviation) is used instead of the standard deviation. If you suspect that there are outliers in your dataset, you may prefer to use robust scaling, which is done as follows:
# 
#  $\mbox{scaled_value} = \frac{\mbox{value - median}}{\mbox{MAD}}$
#  
# 
# All of the above scaling types can be easily performed using the `preprocessing` module in `sklearn`. Let's have a look at a simple example.
# %%
from sklearn import preprocessing

x = np.arange(10).reshape(-1, 1)
x = np.vstack((x, 100.0))

min_max = preprocessing.MinMaxScaler().fit_transform(x).ravel()
standard = preprocessing.StandardScaler().fit_transform(x).ravel()
robust = preprocessing.RobustScaler().fit_transform(x).ravel()

x_scaled_df = pd.DataFrame({'x': x.ravel(), 'min_max': min_max, 'standard': standard, 'robust': robust})
x_scaled_df.round(2)
# %% markdown
# Let's scale the descriptive features in our breast cancer dataset before fitting any classifiers. Here, we use the `MinMaxScaler` scaler as an illustration. 
# %%
Data = preprocessing.MinMaxScaler().fit_transform(Data)
# %% markdown
# ## Sampling Observations <a class="anchor" id="2.5"></a>
# 
# Sometimes your dataset will just have too many rows for your computer to handle. In this case, the smart thing to do will be to select only a small subset of the entire dataset during modeling. 
# 
# We can use the `sample` function in `Pandas` for selecting a small random subset of the entire data. We can use the this function with either one of these two options: "frac" for selecting a certain fraction of the entire data, say 0.2, or "n" for selecting a certain number of rows, say 100 rows.
# 
# In the example below, we load the same dataset (though with no column names) directly from `sklearn` to illustrate how we can still select a random subset even if the descriptive features and the target feature are in different arrays. In particular, since in this case data and target are in different `NumPy` arrays, we need to set a common random state so that we select exactly the same rows in both the data and the target. Of course, the Breast Cancer dataset is already quite small with only 569 observations, so we do this sampling only for illustration purposes. 
# 
# In the code below, we use a simple trick to use the `sample` function: since this is a `Pandas` function, we first convert the data and the target to a data frame, use the `sample` function, and then revert them back to a `NumPy` array using the `values` function.
# %%
import pandas as pd
from sklearn.datasets import load_breast_cancer

cancer_df = load_breast_cancer()

Data, target = cancer_df.data, cancer_df.target

Data_sample = pd.DataFrame(Data).sample(n=100, random_state=8).values
target_sample = pd.DataFrame(target).sample(n=100, random_state=8).values
# %% markdown
# Let's check to see both the data and the target are still `NumPy` arrays and that they now have exactly 100 rows.
# %%
print(type(Data_sample))
print(type(target_sample))

print(Data_sample.shape)
print(target_sample.shape)
# %% markdown
# ***
# 
# MATH2319 - Machine Learning @ RMIT University