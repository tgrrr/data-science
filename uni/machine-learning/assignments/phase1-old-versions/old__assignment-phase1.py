#%% [markdown]
# # Project Title
# #### MATH2319 Machine Learning
# #### Assignment 1 - Semester 1, 2019
# #### Phil Steinke s3725547
#%% [markdown]
# ------------------------------------------
#%% [markdown]
# # ~old_todo~~old_later~
#
# - text: between 3 to 10 pages for each phase
# - total: between 3 to 10 pages for each phase
# - Table of contents
# - Clearly identify your dependent variable
# - each step needs to be clearly articulated
# - Your analyses should be tied to your goals and objectives rather than being just random.
# - Present a good real-world understanding
#
#%% [markdown]
# ---------------------------------------------------------------------
#%% [markdown]
# # Phase 1

#%%
#import warnings
#warnings.filterwarnings("ignore")
import pandas as pd
import io
import requests
import os
# __working_directory__ = r"/Users/ashleigholney/Desktop/MATH2319 Machine Learning/Course Project/raw-data/"
__working_directory__ = os.getcwd()
# __data_directory__ = ""

#%%
__file_name__ = 'advertising_train.csv'
df = pd.read_csv(__file_name__)

#%%
# Check the df dimensions
df.shape 

# Get 5 randomly sampled
df.sample(n=5) 

# ~old_todo~ move df to github:
# cancer_url = 'https://raw.githubusercontent.com/vaksakalli/datasets/master/breast_cancer_wisconsin.csv'
# url_content = requests.get(cancer_url).content
# cancer_df = pd.read_csv(io.StringIO(url_content.decode('utf-8')))

#%%
#%% check-for-na
# Check for N/A's
col_nulls = {col: df[col].isnull().sum()
             for col in df.columns if df[col].isnull().sum() > 0}
print(col_nulls)
# ~old_todo~ does this check for everything?

#%% [markdown]
# ## Source and Description - Rubric 3/20
#     NOTE: (Detailed descriptive statistical analysis of the data)
#     NOTE: categorical or regression (numerical), not time-series

# Features in this data set are as follows:
# • companyId: Company ID of record (categorical)
# • countryId: Country ID of record (categorical)
# • deviceType: Device type of record (categorical corresponding to desktop, mobile, tablet)
# • day: Day of record (integer between 1 (oldest) and 30 for train, 31 and 35 (most recent) for test)
# • dow: Day of week of the record (categorical)
# • price1, price2, price3: Price combination for the record set by the company (numeric)
# • ad_area: area of advertisement (normalized between 0 and 1)
# • ad_ratio: ratio of advertisement’s length to its width (normalized between 0 and 1)
# • requests, impression, cpc, ctr, viewability: Various metrics related to the record (numeric)
# • ratio1, ..., ratio5: Ratio characteristics related to the record(normalized between 0 and 1)
# • y (target feature): revenue - related metric(numeric)

# Problem:
# The problem at hand is to predict the value of y for each website traffic record in
# the test data. Even though the dataset contains a day value, you must treat the day
# feature(or any new features you derive from the day and / or dow features) as just
# another input to your algorithm and avoid using time series / forecasting methods in your solution.

#%% [markdown]
# ## Goals and Objectives - Rubric 3/20
#     NOTE: clear statement of your goals and objectives
# 
#%% [markdown]
# ## Data Preprocessing - Rubric 5/20
#     NOTE: (dealing with missing values, outliers, data transformation, data aggregation, etc.)
#     NOTE: **Data preprocessing ** is more than just filling in missing values or removing outliers. I suggest you have a look at the sample project phase 1 report for some examples. You should also take a look at Chapter 3 in the textbook that talks about data preprocessing.
#     NOTE: If your dataset is completely preprocessed, that's OK, but in this case we will expect that you spend some more effort on the descriptive statistics / initial data analysis tasks.
#     ### 2.1. Preliminaries - demoReport
#     ### 2.2 Data Cleaning

#%%
from IPython.core.interactiveshell import InteractiveShell
InteractiveShell.ast_node_interactivity = "all"


#%%
import numpy as np
import pandas as pd
import matplotlib

#%% [markdown]
#   ## Data Analysis - Rubric 5/20
#     ### 3.1 Univariate Visualisation
#       ### 3.1.1 Numerical Features
#       ### 3.1.2 Categorical Features
#     ### 3.2 Multvariate Visualisation
#       ### 3.2.1. Scatterplot Matrix
#       ### 3.2.2 Others
#%% [markdown]
# ----------------------------------------------------------------
#%% [markdown]
# # Phase 2
#%% [markdown]
# ## Overview of Methodology - Rubric 4/30
#     NOTE: three different ML algorithms
# 
#%% [markdown]
# ## Algorithm Fine-tuning and Performance Analysis - Rubric 10/30
# 
#%% [markdown]
# ## Performance comparison - Rubric 4/30
#     NOTE:  present performance comparisons to indicate which method seems to work best
# 
#%% [markdown]
# ## A Critique of Your Approach - Rubric 4/30
# 
#%% [markdown]
# ## Summary and Conclusions - Rubric 4/30
# 
#%% [markdown]
# ------------------------------------------------------------------
#%% [markdown]
# # Data Source

