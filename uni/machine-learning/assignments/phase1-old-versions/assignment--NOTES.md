normalising function

# for index, row in data.head(n=1).iterrows():
#     # absolute_normalized_row = np.abs(stats.zscore(data[row]))
#     type(row)
#     print(row)
#     # print(index, row)
# # for x in data[x]:
# #        print x
# about 25%
# ~old_todo~ (len(data[outliers]))/(len(outliers))





TO TRANSFER TO WORK WITH ASH

TIDY DATA:
EG PRICE INTO SAME COL


#  - countryId: iso3166 1.0 Country ID of record (categorical)
from iso3166 import countries

#%%
# ~old_todo~ Count of each numerical Column
def get_value_counts(x): 
    print x.value_counts()
df[numericColumnsList].apply(get_value_counts)


WIP:
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




# ~old_todo~
# - outliers
# - missing values
# - check normality and assumptions
# - check if variables are independent
# - data vis
#  scatter matrix plot
#  30 day distribution

keys = 'foo'

def some_function(df, keys, other_silly_variable=None):
    """Fetches rows from a Bigtable.
    
    :param name: The name to use.
    :type name: str.
    :param state: Current state to be in.
    :type state: bool.
    :returns:  int -- the return code.
    :raises: AttributeError, KeyError
    """
    output = (multiply(3, 4)
    print(output)


some_function(df, keys)

# from unnecessary_math import multiply

def some_function():
    assert(multiply(3, 4) == 12)
    assert(p > 0.05)





<!-- ============================= -->

Square and rectangle 	 
200 × 200
 	Small square
240 × 400
 	Vertical rectangle
250 × 250
 	Square
250 × 360
 	Triple widescreen
300 × 250
 	Inline rectangle
336 × 280
 	Large rectangle
580 × 400
 	Netboard
Skyscraper 	 
120 × 600
 	Skyscraper
160 × 600
 	Wide skyscraper
300 × 600
 	Half-page ad
300 × 1050
 	Portrait
Leaderboard 	 
468 × 60
 	Banner
728 × 90
 	Leaderboard
930 × 180
 	Top banner
970 × 90
 	Large leaderboard
970 × 250
 	Billboard
980 × 120
 	Panorama
Mobile 	 
300 × 50
 	Mobile banner
320 × 50
 	Mobile banner
320 × 100
 	Large mobile banner

200, 200, "Small square", "Square and rectangle",
240, 400, "Vertical rectangle", "Square and rectangle",
250, 250, "Square", "Square and rectangle",
250, 360, "Triple widescreen", "Square and rectangle",
300, 250, "Inline rectangle", "Square and rectangle",
336, 280, "Large rectangle", "Square and rectangle",
580, 400, "Netboard", "Square and rectangle",
120, 600, "Skyscraper", "Skyscraper",
160, 600, "Wide skyscraper", "Skyscraper",
300, 600, "Half-page ad", "Skyscraper",
300, 1050, "Portrait", "Skyscraper",
468, 60,  "Banner", "Leaderboard",
728, 90,  "Leaderboard", "Leaderboard",
930, 180, "Top banner", "Leaderboard",
970, 90,  "Large leaderboard", "Leaderboard",
970, 250, "Billboard", "Leaderboard",
980, 120, "Panorama", "Leaderboard",
300, 50,  "Mobile banner", "Mobile",
320, 50,  "Mobile banner", "Mobile",
320, 100, "Large mobile banner", "Mobile",



#%%
# ~old_fixme~ Working on doing the count in one go
# def get_sublist(x):
    # return x.value_counts()
# df[['ad_ratio']].apply(get_sublist)
#%%
# df[numericColumnsList].apply(get_sublist)
# df[numericColumnsList].apply(get_sublist, axis=1)
# df['col_3'] = df.apply(lambda x: get_sublist(x.col_1, x.col_2), axis=1)


# I THINK THIS WAS ASH'S ASSIGNMENT BELOW

#%% Change working directory from the workspace root to the ipynb file location. Turn this addition off with the DataScience.changeDirOnImportExport setting
import os
try:
	os.chdir(os.path.join(os.getcwd(), '../../../../../Downloads'))
	print(os.getcwd())
except:
	pass

#%%
#Task 1: Data Preparation
# "You will start by loading the CSV data from the file (using appropriate pandas functions) 
# and checking whether the loaded data is equivalent to the data in the source CSV file.
# Then, you need to clean the data by using the knowledge we taught in the lectures. You need 
# to deal with all the potential issues/errors in the data appropriately (such as: typos, 
# extra whitespaces, sanity checks for impossible values, and missing values etc). "

# Please structure code as follows: 
# always provide one line of comments to explain the purpose of the code, e.g. load the data, 
# checking the equivalent to original data, checking typos (do this for each other types of errors)

# import packages 
import pandas as pd
import numpy as np
from scipy import stats
import matplotlib
import matplotlib.pyplot as plt

# import data set with column names
df = pd.read_csv("df.csv", sep = '#', header = None,
                         names = ['symboling', 'normalized-losses', 'make', 'fuel-type', 'aspiration', 
                     'num-of-doors', 'body-style', 'drive-wheels', 'engine-location', 'wheel-base',
                     'length', 'width', 'height', 'curb-weight', 'engine-type', 'num-of-cylinders', 
                     'engine-size', 'fuel-system', 'bore', 'stroke', 'compression-ratio', 'horsepower', 
                     'peak-rpm', 'city-mpg', 'highway-mpg', 'price'])

# check data set attributes with original data set
df.head(5)
print(df.shape)


# Dealng with missing values 

# function to detect which columns contain nulls 
col_nulls = {col: df[col].isnull().sum() for col in               df.columns if df[col].isnull().sum() > 0}
print(col_nulls)

# Impute nulls in columns with continuous data to the column mean:
df['normalized-losses'].fillna(df['normalized-losses'].mean(axis=0), inplace=True)
df['bore'].fillna(df['bore'].mean(axis=0), inplace=True)
df['stroke'].fillna(df['stroke'].mean(axis=0), inplace=True)
df['horsepower'].fillna(df['horsepower'].mean(axis=0), inplace=True)
df['price'].fillna(df['price'].mean(axis=0), inplace=True)
df['peak-rpm'].fillna(df['peak-rpm'].mean(axis=0), inplace=True)

# Impute nulls for num-of-doors to -1 
# (Null value doesn't mean zero doors, and mean value of 'two' and 'four' doesn't make sense)
df['num-of-doors'].fillna(-1, inplace=True)


# Outlier detection

# select columns with numeric values by removing columns with object class
numeric = list(df.select_dtypes(exclude=['object']).columns)
# calculate z scores for numeric columns
z = np.abs(stats.zscore(df[(numeric)]))
# remove rows with outliers (outlier = z > 3)
df = df[(z < 3).all(axis=1)]
print(df.shape)
# Removing rows with outliers has removed 7% of the original data 

# Logic Checks

print(df[(numeric)].max()) 
print(df[(numeric)].min()) 

# change ilogical value (4 to 3)
df['symboling'].replace(4, 3, inplace=True)


# String Manipulation

objects = list(df.select_dtypes(include=['object']).columns)

# function to change all string values to lower case 
df[(objects)] = df[(objects)].apply(lambda x: x.astype(str).str.lower(), axis = 1) 

# function to strip all extra white space from string values
df[(objects)] = df[(objects)].apply(lambda x: x.astype(str).str.strip(), axis = 1)

# Make
df['make'].value_counts()
df['make'].replace('vol00112ov', 'volvo', inplace=True)
print(df['make'].value_counts())

# Fuel type
print(df['fuel-type'].value_counts())

# Aspiration
df['aspiration'].value_counts()
df['aspiration'].replace('turrrrbo', 'turbo', inplace = True)
print(df['aspiration'].value_counts())

# Number of cylinders: eight, five, four, six, three, twelve, two
print(df['num-of-cylinders'].value_counts())

# Num of Doors
df['num-of-doors'].value_counts()
df['num-of-doors'].replace('fourr', 'four', inplace = True)
print(df['num-of-doors'].value_counts())

# Body Style 
print(df['body-style'].value_counts())

# Drive Wheels
print(df['drive-wheels'].value_counts())

# Engine type: dohc, dohcv, l, ohc, ohcf, ohcv, rotor
print(df['engine-type'].value_counts())

# Fuel system: 1bbl, 2bbl, 4bbl, idi, mfi, mpfi, spdi, spfi
print(df['fuel-system'].value_counts())

# Engine Location
print(df['engine-location'].value_counts())


#%%
# Task 2: Data Exploration
# 1. Choose 1 column with nominal values, 1 column with ordinal Values, and 1 column with numerical values


#Code goes after this line

# subset data with nominal (drive-wheels), ordinal (symboling), and numerical (price) values
x = df[['symboling','drive-wheels','price']]
    
# "A value of +3 indicates that the auto is risky, -3 that it is probably pretty safe"

# summary statistics 
print(x.describe())
print(x['drive-wheels'].value_counts())

# pie chart for drive-wheels
plt.figure(1)   
x['drive-wheels'].value_counts().plot(kind='pie',autopct='%.2f')      
plt.title('Figure 1: Distribution of Car Drive Type by Percentage')
plt.savefig('1.png')
# A pie chart is a good way to visualise the spread of nominal data 

# bar chart for symboling
plt.figure(2)   
symbol_order = [-3, -2, -1, 0, 1, 2, 3]
data = x['symboling'].value_counts()
data.loc[symbol_order].plot(kind='bar')
plt.title('Figure 2: Frequency of Car Risk Factor Symbols')
plt.xlabel('Risk Factor Symbol')
plt.ylabel('Frequency')
plt.savefig('2.png')
# A bar chart is a good way to visualise the distribution of ordinal data

# histogram for price
plt.figure(3)
data = x['price']
data.plot(kind='hist')
plt.title('Figure 3: Frequency of Car Price')
plt.savefig('3.png')
# Price is a continuous numerical value so can be visualised with a histogram


#%%
# Task 2: Data Exploration
# 2. Explore the relationships between columns; at least 3 visualisations with plausible hypothesis

#Code goes after this line

plt.figure(4)
x.boxplot(column='price', by='symboling')
plt.xlabel('Risk Factor Symbol')
plt.ylabel('Price')
plt.savefig('4.png')
plt.show()


plt.figure(5)
x.boxplot(column='price', by='drive-wheels')
plt.xlabel('Drive Type')
plt.ylabel('Price')
plt.savefig('5.png')
plt.show()


plt.figure(6)
symbol_order = [-3, -2, -1, 0, 1, 2, 3]
data = x['symboling'].value_counts()
data.loc[symbol_order].plot(kind='bar')
plt.title('Figure 6')
plt.xlabel('Risk Factor Symbol')
plt.ylabel('Frequency')
plt.show()
# ~old_todo~ group by drive-wheels

#%%
# Task 2: Data Exploration
# 3. Scatter matrix for all numerical columns

#Code goes after this line

from pandas.plotting import scatter_matrix

scatter_matrix(df[(numeric)], diagonal = 'hist', figsize = (16,16))
plt.savefig('7.png')
plt.show()




<!-- =========================
=========================
========================= -->

# Course Project
The idea with the course project is to apply what you have learned in class, and more importantly, to have fun!
This project entails applying machine learning techniques on a problem of your own choosing. The project shall be submitted in two phases.

#### Programming Language for the Project


#### The first phase includes the following two tasks:
(1) **Detailed descriptive statistical analysis of the data** (charts, graphs, interactions, etc) as appropriate.
(2) **Data preprocessing** (dealing with missing values, outliers, data transformation, data aggregation, etc.) as appropriate.

#### The second phase shall include applications of machine learning techniques as appropriate.

#### Important notes about the project:
The project needs to be on a **supervised machine learning** problem as we will not cover unsupervised methods in this class. 
Both **classification (categorical response)** and **regression (numerical response)** problems are accepted.
- Not time series

**Data preprocessing** is more than just filling in missing values or removing outliers. I suggest you have a look at the sample project phase 1 report for some examples. You should also take a look at Chapter 3 in the textbook that talks about data preprocessing.
- If your dataset is completely preprocessed, that's OK, but in this case we will expect that you spend some more effort on the descriptive statistics/ initial data analysis tasks.

In Phase 2, you must try least **three different ML algorithms** on your problem and you must **present performance comparisons** to indicate which method seems to work best. If you like, you may also use algorithms not covered in class (deep learning, etc).

Sum of the text portions of your reports (that is, materials other than your computer code and their outputs such as tables, graphs, etc.), must be **between 3 to 10 pages for each phase**. Together with your computer code and their outputs (tables, graphs, etc.), **your reports must be between 10 to 30 pages for each phase.**
 
Please follow the instructions below for both Phase 1 and Phase 2:
The project reports must be a single PDF file compiled from R markdown or Python jupyter notebook. 
The reports should contain a **Table of Contents** on the first page, though this is not a strict requirement.

Submissions are to be made via Canvas by the due date and time.
You are to work alone or in groups of at most two members (this is a strict requirement: no more than two members).
Group work is strongly recommended as expectations shall be the same for solo and team work. In case of a team, both members shall receive the same grade.
Please avoid unnecessary content in your reports. For instance, you will definitely lose points for pages and pages of meaningless computer output or any other content that serves no purpose other than increasing your page count.

Kaggle competitions are accepted as a project provided that the work you submit belongs entirely to you.
You will lose points for any instructions that you fail to follow.
Please see Course Policies for late report submission penalties.

 

Group Submission Instructions:
If you are working in a group, the report must contain the names and student ID's of both group members at the top of the first page.
You must make only one submission per group. The group member making the submission will get the Canvas feedback. The other member will just see their group's mark. For this reason, the group member receiving the feedback is required to inform the other group member of this feedback.
If you would like to change your group membership between project phases, you must inform course coordinator of this change.
 

## Project Phase 1:
Weight: **10%**

Learning Objectives Assessed:
This assessment task supports CLOs 1, 2, 3 & 4
Rubric:
Your Phase I report must include the following (20 points total):

(3 points) 
- Appropriateness, 
- the source, 
- and a clear description of the dataset under consideration. 

In particular, the project topic you choose must be appropriate for a major machine learning course project. You also need to **cite your data source properly** and you need to **clearly identify your dependent variable**.
(3 points) Appropriateness and a **clear statement of your goals and objectives** for learning from this particular data. 
(5 points) **Data preprocessing** as appropriate. The preprocessing steps need to be justified and **each step needs to be clearly articulated**.
(5 points) 
- **Charts, graphs, numerical summaries, etc. as appropriate**. 
- Your analyses should be **tied to your goals and objectives** rather than being just random. 
Specifically, you need to present a good **real-world understanding** of the dataset you are working on.  
(4 points) 
- Overall quality of your project report: clarity, conciseness, coherence, and, general good writing practices.

## Project Phase 2:
Weight: 15%

Learning Objectives Assessed:
This assessment task supports CLOs 1, 2, 3 & 4
Rubric:
Your Phase II report must include the following (30 points total):

(4 points) A detailed complete overview of your **methodology**
(10 points) Details of the algorithms’ **fine-tuning process** and **detailed performance analysis** of each algorithm
(4 points) **Performance comparison** of the algorithms as appropriate **(cross-validation, AUC, etc.)**
(4 points) A **critique of your approach**: underlying assumptions, its limitations, its strengths and its weaknesses
(4 points) **Summary and conclusions** of your entire project
(4 points) Overall quality of your project report: clarity, conciseness, coherence, and, general good writing practices.
 

Miscellenous:
~old_todo~~old_later~ Sources for project ideas is here Actions  .
How to convert jupyter notebooks to professional looking PDF files: (pdf Actions  ) (sample_zip)

Sample Course Project in Python:
Phase 1: (pdf Actions) (zip)
Phase 2: Coming soon

Disclaimer: These sample reports are provided to give you a rough idea on what you could possibly do for your project. You should not assume that these sample reports fully address all the requirements as outlined in the Course Project module. You must read all the instructions therein and follow them closely in order not to lose any points.