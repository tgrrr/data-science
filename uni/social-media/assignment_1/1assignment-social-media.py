#%% [markdown]
#
# COSC2671 Social Media and Network Analytics
# Assignment 1
# @author Phil Steinke, 2019
# Due 30 August/ 2019
# 15 marks

#%% Change working directory from the workspace root to the ipynb file location. Turn this addition off with the DataScience.changeDirOnImportExport setting
# ms-python.python added
import os
try:
	os.chdir(os.path.join(os.getcwd(), 'uni/social-media/w2-text-analysis/lab'))
	print(os.getcwd())
except:
	pass


# - [ ] Get Twitter data
# - [ ] Do market research
# - [ ] 
# - [ ] 
# - [ ] 


#%%
import tweepy
import os
from dotenv import load_dotenv

# %load_ext dotenv
# %reload_ext dotenv
# %dotenv



# get and set api keys from .env
load_dotenv(verbose=True)

_TWITTER_ACCESS_TOKEN = os.getenv("TWITTER_ACCESS_TOKEN")
_TWITTER_ACCESS_TOKEN_SECRET = os.getenv("TWITTER_ACCESS_TOKEN_SECRET")
_TWITTER_CONSUMER_KEY = os.getenv("TWITTER_CONSUMER_KEY")
_TWITTER_CONSUMER_SECRET = os.getenv("TWITTER_CONSUMER_SECRET")

# authorise tweepy
auth = tweepy.OAuthHandler(
	_TWITTER_CONSUMER_KEY, 
	_TWITTER_CONSUMER_SECRET,
	# callback_url
	)


#%% [markdown]
#
# 0. Setup
# - [ ] a few thousand tweets per week in your data.
# 



#%% [markdown]
#
# ## 1. Data Pre-processing 
#
#



#%% [markdown]
#
# ### 1.1 Data Cleaning (Pre-processing)
#
#

#%% [markdown]
#
# ### 1.2 Initial Exploration (Pre-processing)
#
# - [ ] number of tweets, top K unique hashtags and words etc
# - [ ] Are there characters that aren't useful for analysis

#%% [markdown]
#
# ## 2. Analysis Methodology
#
# ### Initial Analysis
#
# ### Does the approach selected have parameters
# 
# ### What effect does the parameter settings have on the results
#
# ### Would a different approach produce different answer?
#
# ### 
#
# ###
#

#%% [markdown]
#
# ### 2.1 Selection and Parameter choices (Methodology)
#
#

#%% [markdown]
#
# ### 2.1 Justify parameters with explanations (Methodology)
#

#%% [markdown]
#
# ## Analysis & Discussion
#
# - what are the topics been discussed about a user via a top-K terms
# - word-cloud of the topics discovered by topic modelling
# - what are the topics
# - does it correspond to recent news
# - other sources of information
# - if the results don’t correspond to background knowledge, why you think that is so?

#%% [markdown]
#
# ### Discussion of results (Discussion)
#
# - Describe your data
# - Outline and describe your approach, your findings and insights to the questions
# - Use tables, plots/graphs, word clouds and other visualisations to help you communicate the results (in addition to text

#%% [markdown]
#
# ### Explain what the results indicate (Discussion)
#
#


#%% [markdown]
#
#  ##### Other Rubric
#  - [ ] Report Presentation 15%
#  - [ ] Code Style and Readability
#

#%% [markdown]
#
# ### Sample of the Data (1st 1000 tweets, embed)
#
#

#%% [markdown]
#
# ### Bibleography
#
# - Use citethisforme tool


