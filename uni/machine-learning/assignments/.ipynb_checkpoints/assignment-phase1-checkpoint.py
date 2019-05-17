#%% [markdown]
# # TODO: Objective
#
#%% [markdown]
# Hey there cutie

# TODO: Data cleaning:
# - [ ] separate target data from the rest of variables (this is something he does in his examples)
# - [ ] deal with outliers/data well outside range of 0-1 normalised data
# - [x] Add comment: check if nulls are signified by a character. If this was the case, we would get it with numerical values
# - [ ] consistent naming of label rows
# - [x] change weekday to binary variable (i.e. monday = 0, 1)
# - [ ] change other nominal variables to binary variable (e.g. countryId?)
# - [x] pylint -P

# TODO: Data Visualisation
# - [ ] univariate data visualisation
# - [ ] multivariate data visualisation (scatter plots etc)

# ### Maybe
# - [ ] refactor (extract variables/functions/etc)
# - [ ] Check docs - convert to pandas dataframe (see code inline line #80)
# - [ ] Rearrange variable titles (dow at end?)
# - [ ] should we tidy data from wide to long
# - [ ] setup py tests

# - [ ] group similar variables together (e.g. box plots for ratio1-ratio5)
# - [ ] * group into weekday/weekend
# - [ ] * [do we need to encode any sequences for Scikit learn with `oneHotEncode()`?](https://scikit-learn.org/stable/modules/preprocessing.html#encoding-categorical-features)
#       * for companyId, countryId, devices
#       * for days of the week? Are they a time sequence?
#            Have you considered adding the (sine, cosine) transformation of the time of day variable? This will ensure that the 0 and 23 hour for example are close to each other, thus allowing the cyclical nature of the variable to shine through
#            https://datascience.stackexchange.com/questions/17759/encoding-features-like-month-and-hour-as-categorial-or-numeric
# - [ ] Kable

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #

#%% [markdown]
#  # MATH2319 Machine Learning
#  #### Phase 1 - Assignment 1 - Semester 1, 2019
#  #### Ash Olney s3686808 Phil Steinke s3725547
#%% [markdown]
#  ------------------------------------------

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #
#%% [markdown]
# ## Setup


#%%
import pandas as pd
import numpy as np
import altair as alt
from scipy import stats
from sklearn import preprocessing
# !pip install iso3166 # to install if in Colab
# from iso3166 import countries
import os
import io

#%%
# from google.colab import files
# uploaded = files.upload()
#%%
# FIXME: use this auth code: 4/PAFcAWF6qf6kjcKmzPXysqJoAQZdys52vS4GlHyFoPdWFw6XchbtmF0
# from google.colab import drive
# drive.mount('/content/drive')
# !ls "/content/drive/My Drive/" # this line will let you know if it's mounted correctly

#%%
# os.getcwd()
__file_name__ = 'advertising_train.csv'
data = pd.read_csv(__file_name__)

#%%
# data = pd.read_csv(io.BytesIO(uploaded['advertising_train.csv'])) # reference code for import from github
# data = pd.read_csv("/content/drive/My Drive/advertising_train.csv")

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #
#%% [markdown]
# ## The Data

- mark which ones are actually normalised
- 

#%% [markdown]
# ### Original Data

# Features in this data set are as follows:
# * **companyId**: Company ID of record (categorical)
# * **countryId**: _iso3166 1.0_ Country ID of record (categorical)
# * **deviceType**: Device type of record (categorical) corresponding to:
#   * 4 device types
#     * 1 desktop
#     * 2 mobile
#     * 3 tablet
#     * 5 ConnectedTv
# * **day**: Day of record (integer between 1 (oldest) and 30 for train, 31 and 35 (most recent) for test)
# * **dow**: Day of week of the record (categorical)
# * **price1, price2, price3**: Price combination for the record set by the company (numeric)
# * **ad_area**: area of advertisement (normalized between 0 and 1)
# * **ad_ratio**: ratio of advertisement's length to its width (normalized between 0 and 1)
# * **requests**: TODO: (numeric)
# * **impression**: TODO: (numeric)
# * **cpc**: Cost per click TODO: (numeric)
# * **ctr**: TODO: (numeric) 
# * **viewability**: TODO: (numeric)
# * **ratio1, ..., ratio5**: Ratio characteristics related to the record (normalized between 0 and 1)
# * **y **(target feature): revenue-related metric (numeric)

#%% [markdown]
# ### Data preprocessing target goal for transformation

# Features in this data set are as follows:
# * **companyId**: Company ID of record (categorical)
- oneHotEncode() 
# * **countryId**: _iso3166 1.0_ Country ID of record (categorical)
    either:
        - oneHotEncode()
        - making it really wide binary/binning
        - label the dataVis with the Country Name
        - scaling it?
# * **deviceType**: Device type of record (categorical corresponding to
#   * 4 device types
#     * 1 desktop
#     * 2 mobile
#     * 3 tablet
#     * 5 ConnectedTv
        - oneHotEncode()

# * **day**: Day of record (integer between 1 (oldest) and 30 for train, 
    - TODO: does this need to be split? 31 and 35 (most recent) for test)
    - add a global variable for whether it's 1-30 or 31 - 35
# * **dow**: Day of week of the record (categorical)
dow_friday,
dow_monday,
dow_saturday,
dow_sunday,
dow_thursday,
dow_tuesday,
dow_wednesday,
- maybe: split into weekday and weekend?
- oneHotEncode ?

# - * Note: normally we would have transformed `dow` data as time series. 
# However, the assignment specifies not to do this.
# See [encoding time series features as categorical or numerical](https://datascience.stackexchange.com/questions/17759/encoding-features-like-month-and-hour-as-categorial-or-numeric)
# 
# * **price1, price2, price3**: Price combination for the record set by the company (numeric)
# * **ad_area**: area of advertisement (normalized between 0 and 1)
# * **ad_ratio**: ratio of advertisement's length to its width (normalized between 0 and 1)
# * **requests**: TODO: (numeric)

# * **impression**: TODO: (numeric)
# * **cpc**: TODO: (numeric)
# * **ctr**: TODO: (numeric) 
# * **viewability**: TODO: (numeric)
# * **ratio1, ..., ratio5**: Ratio characteristics related to the record (normalized between 0 and 1)
- TODO: what kind of data is this? numeric?

# * **y **(target feature): revenue-related metric (numeric)
- split into separate dataset
- don't normalise

#%%
# TODO:
# Convert to DataFrame
# df = data.convert_objects(
#     # convert_dates=True,
#     convert_numeric=True,
#     convert_timedeltas=True,
#     copy=True
#     )

#%%
# Shape:
print(data.shape)

#%%
# Dataset datatypes:
print(data.dtypes)

#%%
# Common code functions for reuse throughout code
numeric = list(data.select_dtypes(exclude=['object']).columns)
numericColumnsList = list(data[(numeric)].columns.values)
objects = list(data.select_dtypes(include=['object']).columns)

#%%
# Numerical Column Upper and Lower limits
pd.concat(
    [data[(numeric)].max().round(), 
    data[(numeric)].min().round()],
    keys=['Max', 'Min'],
    axis=1)

#%% [markdown]
# Note: `ad_area` and `ad_ratio` data description states that it is normalised
# However, it's max of `36` and `5` means this is a mistake.
# `ratio1` ... `ratio5` apear to be between 0 to 1. 
# However, because they are ratios, they may not be normalised, and we have
# normalised the data anyway (because "ratio" implies that it may be between 0-1)

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #
#%% [markdown]
# ## Data Pre-processing

#%%
# convert weekday to lowercase
data['dow'] = data['dow'].str.lower()
# convert weekday object to binary variables
# to get around the issue of creating nonsensical quantitative relationships between category codes
data = pd.get_dummies(data, columns=['dow'], prefix=['dow'])

print(data.dtypes)

#%%
# check for nulls
print(data.isnull().sum())

#%%
# summary statistics
print(data.describe())

# TODO: ? Scale these features only
scaleTheseFeatures = [
'price1',
'price2',
'price3',
'ad_area',
'ad_ratio',
'requests',
'impression',
'cpc',
'ctr',
'viewability',
'ratio1',
'ratio2',
'ratio3',
'ratio4',
'ratio5',
]

#%%
# TODO: split `y` into separate dataset before normalisation


#%%
# TODO: normalise everything not already between 1 and 0
# WIP:
# Compare outliers with this after normalisation
data_scaler = preprocessing.RobustScaler().fit(data)
dataNormalised = data_scaler.transform(data)

data = dataNormalised # TODO: compare outliers between data and dataNormalised

# scaleTheseFeatures = ['A', 'B']
# data[scaleTheseFeatures] = scaler.fit_transform(data[scaleTheseFeatures])
# doScikitLearn(data[scaleTheseFeatures])
type(dataNormalised)
# dataNormalised.sample(n=10000)

#%%
# check for outliers
z = np.abs(stats.zscore(data))
# error - need to deal with weekdays first

data.head()

def find_outliers(data):
    absolute_normalized = np.abs(stats.zscore(data))
    return absolute_normalized > 3

outliers = find_outliers(data) #https://www.programcreek.com/python/example/100340/scipy.stats.zscore
outliers

data[outliers]

lenData = len(data)
lenData
lenOutliers = len(data[outliers])
lenOutliers

for index, row in data.head(n=1).iterrows():
    # absolute_normalized_row = np.abs(stats.zscore(data[row]))
    type(row)
    print(row)
    # print(index, row)
# for x in data[x]:
#        print x

data.boxplot(column = ['price2'])

# about 25%
# TODO: (len(data[outliers]))/(len(outliers))

outliersIndexList = data[outliers].index.values.astype(int)

uniqueOutliersIndexList = np.unique(outliersIndexList)
len(np.unique(outliersIndexList)) # about 14%

# data.iloc(uniqueOutliersIndexList)

# data['price2'][5]
#
# data['price2'].loc[5]
#
# data['price2'].loc[data.price2 = ]
# | data.D

# need to figure out what to do with outliers (if any)



# figure out conversion between np and pd objects

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #
#%% [markdown]
# ## Data Visualisation
#
# ### Univariate

#%%
source = data.sample(n=10000)

chart = alt.Chart(source).mark_bar().encode(
    x = "companyId:N",
    y = 'count()',
)
# chart
# show chart in browser
chart.serve()


#%%
source = data.sample(n=10000)

alt.Chart(source).mark_bar().encode(
    x = "countryId:N",
    y = 'count()',
)


#%%
source = data.sample(n=10000)

alt.Chart(source).mark_bar().encode(
    x = "deviceType:O",
    y = 'count()',
)


#%%
source = data.sample(n=10000)

alt.Chart(source).mark_bar().encode(
    x = "day:O",
    y = 'count()',
)


#%%
source = data.sample(n=10000)

alt.Chart(source).mark_bar().encode(
    x = "dow:O",
    y = 'count()',
)


#%%
source = data[['price1','price2', 'price3']].sample(n=10000)


# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #
#%% [markdown]
# ## Data Visualisation
# ### TODO: Multivariate


# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #

# WIP:
#%%
# TODO: compare to this library: https://pypi.org/project/iso-3166-1/
# def do_country(x):
#     foo = int(df['countryId'][193])
#     print countries.get(int(foo))

# df['countryId'].apply(do_country)
#%%
# countries.get(int(df['countryId'][193]))
# countries.get(df['countryId'][234])
# for c in countries: # undefined variable
#        print(c)

#%% [markdown]
# # Data
#


#%% [markdown]
# ## Notes
#
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
#


#%%
# Atom Data explorer Working on
# Enable the table_schema option in pandas,
# data-explorer makes this snippet available with the `dx` prefix:
# pd.options.display.html.table_schema = True
# pd.options.display.max_rows = None
# source = data.sample(n=10000)
# source


#%%
# # NEW - Phil
# Not necessary to include, but want the function for other stuff for reference
# numeric = list(data.select_dtypes(exclude=['object']).columns)
# numericColumnsList = list(data[(numeric)].columns.values)
# # objects = list(data.select_dtypes(include=['object']).columns)

# # TODO: Count of each numerical Column
# def get_value_counts(x):
#     print x.value_counts()
# data[numericColumnsList].apply(get_value_counts)
