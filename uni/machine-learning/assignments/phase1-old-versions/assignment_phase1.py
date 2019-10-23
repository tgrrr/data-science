# testing sync
#%% 
print('ash is a cutie')

#%% [markdown]
#  # MATH2319 Machine Learning
#  #### Phase 1 - Assignment 1 - Semester 1, 2019
#  #### Ash Olney s3686808 Phil Steinke s3725547
#%% [markdown]
#  ------------------------------------------
#%% [markdown]
#  # ~old_todo~~old_later~
#
#  - text: between 3 to 10 pages for each phase
#  - total: between 3 to 10 pages for each phase
#  - Table of contents
#  - Clearly identify your dependent variable
#  - each step needs to be clearly articulated
#  - Your analyses should be tied to your goals and objectives rather than being just random.
#  - Present a good real-world understanding
#
#%% [markdown]
#  ---------------------------------------------------------------------
#%% [markdown]
#  ## Source and Description - Rubric 3/20
#      NOTE: (Detailed descriptive statistical analysis of the data)
#      NOTE: categorical or regression (numerical), not time-series
#  Features in this data set are as follows:
#  - companyId: Company ID of record (categorical)
#  - countryId: iso3166 1.0 Country ID of record (categorical)
#  - deviceType: Device type of record (categorical corresponding to desktop, mobile, tablet)
#  - day: Day of record (integer between 1 (oldest) and 30 for train, 31 and 35 (most recent) for test)
#  - dow: Day of week of the record (categorical)
#  - price1, price2, price3: Price combination for the record set by the company (numeric)
#  - ad_area: area of advertisement (normalized between 0 and 1)
#  - ad_ratio: ratio of advertisement's length to its width (normalized between 0 and 1)
#  - requests, impression, cpc, ctr, viewability: Various metrics related to the record (numeric)
#  - ratio1, ..., ratio5: Ratio characteristics related to the record(normalized between 0 and 1)
#  - y (target feature): revenue - related metric(numeric)
#
#  Problem:
#  The problem at hand is to predict the value of y for each website traffic record in
#  the test data. Even though the dataset contains a day value, you must treat the day
#  feature(or any new features you derive from the day and / or dow features) as just
#  another input to your algorithm and avoid using time series / forecasting methods in your solution.
#%% [markdown]
#  ## Goals and Objectives - Rubric 3/20
#      NOTE: clear statement of your goals and objectives
#
#%%
# from IPython.core.interactiveshell import InteractiveShell
# InteractiveShell.ast_node_interactivity = "all"
#import warnings
#warnings.filterwarnings("ignore")
import altair as alt
import io
# from iso3166 import countries
import matplotlib
import numpy as np
import pandas as pd
import os
# import requests
from scipy import stats

#%%
__file_name__ = 'advertising_train.csv'
df = pd.read_csv(__file_name__)
# list(df.columns.values)
# ~old_todo~ , names=['companyId', 'countryId', 'deviceType', 'day', 'dow', 'price1', 'price2', 'price3', 'ad_area', 'ad_ratio', 'requests', 'impression', 'cpc', 'ctr', 'viewability', 'ratio1', 'ratio2', 'ratio3', 'ratio4', 'ratio5', 'y']

# VS: Google Colab
# from google.colab import files
# uploaded = files.upload()
#%%
# df = pd.read_csv(io.BytesIO(uploaded['advertising_train.csv']))
#
# VS: If we wanted to import from github:
# df_url = 'https://raw.githubusercontent.com/tgrrr/data-science/master/datasets/advertising_train.csv'
# df = pd.read_csv(df_url)
# url_content = requests.get(df_url, auth=(name, password)).content
# df = pd.read_csv(io.StringIO(url_content.decode('utf-8')))
#%%
# Check the df dimensions
df.shape
# Get 5 randomly sampled
df.sample(n=5)

# # Summary statistics
# print(df.describe())

#%% [markdown]
#  ## Data Preprocessing - Rubric 5/20
#      NOTE: (dealing with missing values, outliers, data transformation, data aggregation, etc.)
#      NOTE: **Data preprocessing ** is more than just filling in missing values or removing outliers. I suggest you have a look at the sample project phase 1 report for some examples. You should also take a look at Chapter 3 in the textbook that talks about data preprocessing.
#      NOTE: If your dataset is completely preprocessed, that's OK, but in this case we will expect that you spend some more effort on the descriptive statistics / initial data analysis tasks.
#      ### 2.1. Preliminaries - demoReport
#      ### 2.2 Data Cleaning

#%% checkForNA
#  ## Missing Values - Data Preprocessing
# Check for N/A's
checkForNA = {col: df[col].isnull().sum()
             for col in df.columns if df[col].isnull().sum() > 0}
checkForNA == {} # there are no N/As, so no impute necessary

#%% [markdown]
#  ## Outliers - Rubric 5/20

# select columns with numeric values by removing columns with object class
numeric = list(df.select_dtypes(exclude=['object']).columns)
numericColumnsList = list(df[(numeric)].columns.values)
objects = list(df.select_dtypes(include=['object']).columns)

#%%
# calculate z scores for numeric columns
# ~old_todo~ check this
# - should we remove the entire row?
# - should we adjust 3?
# - are there any other methods?
z = np.abs(stats.zscore(df[(numeric)]))
# remove rows with outliers (outlier is z > 3)
df = df[(z < 3).all(axis=1)]
print(df.shape)
# ~old_fixme~ type(z)
# ~old_todo~ Removing rows with outliers has removed 7% of the original data

#%%
# Logic Checks - Numerical Column Upper and Lower limits
pd.concat(
    [df[(numeric)].max(), df[(numeric)].min()],
    keys=['Max', 'Min'],
    axis=1)

#%%
# ~old_todo~ Count of each numerical Column
def get_value_counts(x): 
    print x.value_counts()
df[numericColumnsList].apply(get_value_counts)

# ~old_todo~
# def get_value_counts_length(x): print len(x.value_counts())
# df[numericColumnsList].apply(get_sublist)

#%%
# numericColumnsList

# 
# Don't fix or include this
# 'day',


# Normalise this:
# 'requests', 19925
# 'impression', length 15656
# 'cpc': 12489
# 'ctc': 2687
# 'viewability': 10237
# 'ratio 1, 2, 3, 4, 5'
# 'y'

# Price max, min only
# price1: 
# - this is limited to 1

numericWeMightCareAbout = [
  'companyId',
  'deviceType',
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
  'y'
  ]

#%% [markdown]
#  ## Data Aggregation - Rubric 5/20
#%% [markdown]
# ## Data Transformation

#%% [markdown]
# #### deviceType
# > deviceType: Device type of record (categorical corresponding to desktop, mobile, tablet)
#%%
df['deviceType'].value_counts()
df['deviceType'].replace(1, 'desktop', inplace=True)
df['deviceType'].replace(2, 'mobile', inplace=True)
df['deviceType'].replace(3, 'tablet', inplace=True)
print(df['deviceType'].value_counts())

# ~old_todo~ Fixthis:
# 'countryId',
# ? 'ad_area',
# 'ad_ratio',

#%% [markdown]
#  ### 2.2 Data Cleaning
#%% [markdown]
# #### Country
# > countryId: iso3166 1.0 Country ID of record (categorical)
# countries.get(8)
# Country(name=u'Albania', alpha2='AL', alpha3='ALB', numeric='008')

#%%
df['countryId'].apply(get_value_counts)

#%%
def do_country(x): 
    foo = int(df['countryId'][193])
    print countries.get(int(foo))
# df['countryId'].apply(do_country)

#%%
# countries.get(int(df['countryId'][193]))
# countries.get(df['countryId'][234])
for c in countries:
       print c

# #%%
# # ~old_todo~ check for illogical values

#%%
# ~old_todo~ check outliers
#%% [markdown]
# calculate z scores
# z = np.abs(stats.zscore(df)
#
# POSSIBLE SOLUTION: remove rows with outliers (outlier = z > 3)
#
# df = df[(z < 3).all(axis=1)] # Check shape


#%% [markdown]
#  ## Tidy Data - Rubric 5/20
#%% [markdown]
#    ## Data Analysis - Rubric 5/20
#      ### 3.1 Univariate Visualisation
#        ### 3.1.1 Numerical Features
#        ### 3.1.2 Categorical Features
#      ### 3.2 Multvariate Visualisation
#        ### 3.2.1. Scatterplot Matrix
#        ### 3.2.2 Others


