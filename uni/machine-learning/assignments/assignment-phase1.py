# TODO: Data cleaning:
# - [ ] how to handle 14-15% outliers

# - [x] separate target data from the rest of variables (this is something he does in his examples)
# - [x] consistent naming of label rows
# - [x] deal with outliers/data well outside range of 0-1 normalised data (RobustScaler)
# - [x] change other nominal variables to binary variable (e.g. country_id?) (Deal with in Phase II)
# - [x] pylint -P
# - [x] Add comment: check if nulls are signified by a character. If this was the case, we would get it with numerical values
# - [x] change weekday to binary variable (i.e. monday = 0, 1)
# - [x] change data back to pandas data frame from numpy array after normalisation
# - [x] clean up outliers section
# - [x] turn notes about data into table
# - [x] refactor (extract variables/functions/etc)
# - [x] Check docs - convert to pandas dataframe (see code inline line #80)

# TODO: Data Visualisation
# - [ ] univariate data visualisation
# - [ ] multivariate data visualisation (scatter plots etc)
# - [ ] add figure labels to each visualisation 

# THEN:
# - [ ] turn these done todo's into notes

# quick:
# - [ ] mark which data was not actually normalised in table
# - [ ] description of requests, impressions, etc

# ### Maybe

# - [ ] Rearrange variable titles (dow at end?)
# - [ ] should we tidy data from wide to long
# - [ ] setup py tests
# - [ ] mulitivariate PCA's

# - [ ] group similar variables together (e.g. box plots for ratio1-ratio5)
# - [ ] * group into weekday/weekend
# - [ ] * [do we need to encode any sequences for Scikit learn with `oneHotEncode()`?](https://scikit-learn.org/stable/modules/preprocessing.html#encoding-categorical-features)
#       * for company_id, country_id, devices
#       * for days of the week? Are they a time sequence?
#            Have you considered adding the (sine, cosine) transformation of the time of day variable? This will ensure that the 0 and 23 hour for example are close to each other, thus allowing the cyclical nature of the variable to shine through
#            https://datascience.stackexchange.com/questions/17759/encoding-features-like-month-and-hour-as-categorial-or-numeric
# - [ ] Kable
# - [x] equations (latex)

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #


#%% [markdown]
# # TODO: Objective
#

#%% [markdown]
# ## Setup

#%%
import pandas as pd
import numpy as np
import altair as alt
import math
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
# from google.colab import drive
# drive.mount('/content/drive')
# !ls "/content/drive/My Drive/" # this line will let you know if it's mounted correctly

#%%
# os.getcwd()
__file_name__ = 'advertising_train.csv'
data = pd.read_csv(__file_name__)
# consistent naming of columns (minus camelCase):
labelNames = ['case_id', 'company_id', 'country_id', 'device_type', 'day', 'dow', 'price1', 'price2', 'price3', 'ad_area', 'ad_ratio', 'requests', 'impression', 'cpc', 'ctr', 'viewability', 'ratio1', 'ratio2', 'ratio3', 'ratio4', 'ratio5', 'y',]
data.columns = labelNames

#%% [markdown]
# ## The Data

# Features in this data set are as follows:

# | Feature Name                           | Data Type   | Description                                                                                             | Transform TODO                                                                                                                                                                                              | # DataVis?                                                                                                                                                                                                                                      |
# | -------------------------------------- | ----------- | ------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
# | **company_id**                          | categorical | Company ID of record                                                                                    | oneHotEncode()                                                                                                                                                                                              # |                                                                                                                                                                                                                                               |
# | **country_id**                          | categorical | Country ID of record _iso3166 1.0_                                                                      | oneHotEncode()?binary/scaling it                                                                                                                                                                            | _iso3166 1.0_ to # country                                                                                                                                                                                                                      |
# | **device_type**                         | categorical | Device type of record                                                                                   | oneHotEncode()                                                                                                                                                                                              | FIXME:1 Desktop, 2 mobile, 3 tablet, 5 # ConnectedTv                                                                                                                                                                                            |
# | * **day**                              | integer     | Day of record <br/> - between 1 (oldest) and 30 for train, <br/> - between 31 (oldest) and 35 for test, | TODO: add a global variable for whether it's training/test                                                                                                                                                  # |                                                                                                                                                                                                                                               |
# | * **dow**                              | categorical | Day of week of the record                                                                               | - oneHotEncode? <br /> dow_friday <br /> dow_monday <br />  dow_saturday <br />   dow_sunday <br />   dow_thursday <br /> dow_tuesday <br />  dow_wednesday <br /> - maybe: split into weekday and weekend? | Note: normally we would have [transformed `dow` data as time series](https://datascience.stackexchange.com/questions/17759/# encoding-features-like-month-and-hour-as-categorial-or-numeric). However, the assignment specifies not to do this. |
# | **price1,<br /> price2, <br />price3** | numeric     | Price combination for the record set by the company                                                     |                                                                                                                                                                                                             # |                                                                                                                                                                                                                                               |
# | **ad_area**                            | numeric     | area of advertisement (normalized between 0 and 1)                                                      |                                                                                                                                                                                                             # |                                                                                                                                                                                                                                               |
# | **ad_ratio**                           | numeric     | ratio of advertisement's length to its width (normalized between 0 and 1)                               |                                                                                                                                                                                                             # |                                                                                                                                                                                                                                               |
# | **requests**                           | numeric     | TODO:                                                                                                   |                                                                                                                                                                                                             # |                                                                                                                                                                                                                                               |
# | **impression**                         | numeric     | TODO:                                                                                                   |                                                                                                                                                                                                             # |                                                                                                                                                                                                                                               |
# | **cpc**                                | numeric     | TODO:                                                                                                   |                                                                                                                                                                                                             # |                                                                                                                                                                                                                                               |
# | **ctr**                                | numeric     | TODO:                                                                                                   |                                                                                                                                                                                                             # |                                                                                                                                                                                                                                               |
# | **viewability**                        | numeric     | TODO:                                                                                                   |                                                                                                                                                                                                             # |                                                                                                                                                                                                                                               |
# | **ratio1, ..., ratio5**                | numeric     | Ratio characteristics related to the record (normalized between 0 and 1)                                |                                                                                                                                                                                                             # |                                                                                                                                                                                                                                               |
# | **y (target feature)**                 | numeric     | revenue-related metric                                                                                  | - split into separate dataset <br /> - don't normalise                                                                                                                                                      # |                                                                                                                                                                                                                                               |

#%% [markdown]
# Note: `ad_area` and `ad_ratio` data description states that it is normalised
# However, it's max of `36` and `5` means this is a mistake.
# `ratio1` ... `ratio5` apear to be between 0 to 1. 
# However, because they are ratios, they may not be normalised, and we have
# normalised the data anyway (because "ratio" implies that it may be between 0-1)

#%%
# Shape:
print(data.shape)

#%%
# Dataset datatypes:
print(data.dtypes)

#%%
# Common functions for reuse throughout code:
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

#%%
#split `y` into separate dataset before normalisation
dataUnscaled = data.drop(columns = 'y')
dataTarget = data['y']
# type(dataTarget) # pandas series
# TODO:reorganise the days so that y is at the end

#%% [markdown] 
# ### Data Normalisation

#%%
dataNormalised = dataUnscaled.copy() # create copy of dataUnscaled
numericFeaturesToScale = [ 'price1', 'price2', 'price3', 'ad_area', 'ad_ratio', 'requests', 'impression', 'cpc', 'ctr', 'viewability', 'ratio1', 'ratio2', 'ratio3', 'ratio4', 'ratio5', ]
data_scaler = preprocessing.RobustScaler().fit(dataNormalised[numericFeaturesToScale])
# Normalise numerical features, as a pandas Dataframe:
dataNormalised[numericFeaturesToScale] = data_scaler.transform(dataNormalised[numericFeaturesToScale])

def get_outliers(df): #https://www.programcreek.com/python/example/100340/scipy.stats.zscore
    absolute_normalized = np.abs(stats.zscore(df))
    return absolute_normalized > 3

def get_length_unique_outliers(df):
    # get boolean array of outliers
    outliers = get_outliers(df)
    outliersIndexList = df[outliers].index.values.astype(int)
    # avoid counting a record with multiple outliers twice
    uniqueOutliersIndexList = np.unique(outliersIndexList)
    print len(np.unique(outliersIndexList))
    # return len(np.unique(outliersIndexList))

get_length_unique_outliers(data) # 31258 ~15% outliers
lengthDataOutliers = get_length_unique_outliers(dataUnscaled) # 28167, ~13% outliers after we removed target
lengthDataNormalisedOutlisers = get_length_unique_outliers(dataNormalised) # 28167, ~13%
# lengthDataOutliers == lengthDataNormalisedOutlisers
# len(dataUnscaled) = 214128
# we have ~13% outliers both before and after normalisation.

# better Ourlier detection:
from sklearn.ensemble import IsolationForest
clf = IsolationForest(behaviour = 'new', max_samples=100, random_state = 1, contamination= 'auto')
preds = clf.fit_predict(dataUnscaled[numericFeaturesToScale])
preds

isolationForestOutliers = dataUnscaled[preds == -1]
get_length_unique_outliers(isolationForestOutliers)

# dataUnscaled[numericFeaturesToScale] = dataUnscaled[preds]




# np.unique(preds, return_counts=True)

data[preds]



# where are the outliers?
def get_outliers_column_count(df):
    for i in numericFeaturesToScale:
        try:
            print(i)
            get_length_unique_outliers(df[i])
        except:
            print i

get_outliers_column_count(dataNormalised)

# reduce outliers with natural logarithm
def get_natural_log(arr, cols):
    for i in cols:
        try:
            arr[i] = np.log(arr[i]+10)
        except:
            print i
get_natural_log(dataUnscaled, numericFeaturesToScale)

get_length_unique_outliers(dataUnscaled)
# outliers with natural log are reduced to 11.2%

#%% [markdown]
# ## Data Visualisation
#
# ### Univariate

############# Ash editing here down ###################
#%%
source = data.sample(n=10000)

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
source = data.sample(n=10000)

alt.Chart(source).mark_bar().encode(
    x = "device_type:O",
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
sample = data.sample(n=5000)
sample.boxplot(column = ['ratio1','ratio2', 'ratio3','ratio4','ratio5'])

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #
#%% [markdown]
# ## Data Visualisation
# ### TODO: Multivariate

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #

# WIP:
#%%
# TODO: compare to this library: https://pypi.org/project/iso-3166-1/
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
# # Data
#

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
