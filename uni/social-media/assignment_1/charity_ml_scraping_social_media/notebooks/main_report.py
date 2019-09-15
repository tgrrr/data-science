#%% [markdown]
#
# COSC2671 Social Media and Network Analytics
# Assignment 1
# @author Phil Steinke, 2019
# Due 30 August/ 2019
# 15 marks

#%% [markdown]
#
# TODO: Introduction
# 	•	Describe what/who is your selected entity
# 	•	Describe why it is interesting to find the sentiment and topics (answer questions) of this entity
#     Goal:
#         What are the trending concepts and topics associated with this person or event?
#         • What are the perceptions and feelings towards this person or event?
# - [ ] Get Twitter data
# - [ ] Do market research

#%%
#
# packages
# python scripts
import os
from src.config.constants import Constants
os.chdir(Constants.path)
from src.common.util import *

# %% [markdown]
#
# TODO: Data Collection
# 	•	Describe how you collected the data, and briefly why you chose that approach (restful vs stream)
# 	•	Report some statistics of your collected data
# 0. Setup
# - [x] a few thousand tweets per week in your data.
# Initially, we searched for multiple terms with the search: 
# "charity" (data OR science OR artificial OR intelligence OR machine OR learning OR ai OR ml)

# %%
# TODO: for charity, machine learning, etc
# params
# start_date = '2018-08-01'
from src.data.api import *

start_date = '2018-08-01'
# search_term = '"charity"%20(machintodo1e%20OR%20learning%20OR%20artificial%20OR%20intelligence)%20(%23ml%20OR%20%23ai)'
# NOTE: only run this once
fetchTweets(search_term, start_date)

# %% [markdown]
# Then we can refine it to charity:

# %%
search_term = 'charity'
# NOTE: only run this once
fetchTweets(search_term, start_date)

# %% [markdown]
#
# Obstacles:
# - Text is trunicated
# wrote function `handle_fulltext_twitter_json_loc(tweet)` to deal with getting full text from 
# tweets. Because `full_text` is present in a different location in the json for 
# retweets and regular tweets
# see: http://docs.tweepy.org/en/latest/extended_tweets.html#examples

#%% [markdown]
#
# ## 1. Data Pre-processing 
#
# TODO: Pre-processing and Data Cleaning
# 	•	Describe  what pre-processing you performed
# 	•	Show examples of noisy data, plot some graphs, etc to show why you decided to do those pre-processing

# %%
from src.preprocessing import *

# %% [markdown]
# Convert CSV to json
# Initially I scraped into a CSV, so this code converts it into json format:

# %%
#
colnames=['full_text', 'date', 'id'] 
convert_csv_to_json('data/raw/charity_tweets_heaps_11110', colnames)

#%% [markdown]
#
# ### 1.1 Data Cleaning (Pre-processing)
#

#%% [markdown]
#
# Sample tweet
# Lets grab a sample tweet:
# From the scraper we get:
#
# > 'b"don\'t use just #artificialintelligence for the sake of it. #AI needs to solve a problem - @somenmondal @ideal What kind of problems could #AI solve in your #charity? https://t.co/BaO22oyQDW"'
# 
# We want:
# > don't use just artificialintelligence for the sake of it. AI needs to solve a problem - What kind of problems could AI solve in your charity?

# What we need to do:
# - Each of the tweets when we get the full_text tweet starts with `b'`
# Initially, this appears as byte data, however, it's actually a string
# - [ ] Each tweet starts with 'b"
# - [ ] Special characters are \\xf0\\x9f\\xa4\\x96, etc and escaped
# - [ ] Remove links
# - [ ] Remove @usernames
# - [ ] Remove #hashtags

# FIXME: do I need this bit?
# df.head()
# 
# df = pd.DataFrame(df,columns=['text',  'date',  'user_id'])

#%%
# FIXME: df = 'data/raw/charity_tweets_heaps_11110.json'
fJsonName = 'data/raw/charity_tweets_heaps_sample_100.json'

import json
from io import open
import pandas as pd

from src.preprocessing import strip_twitter_special_characters

# why do we need to decode it again to utf8?
# grab a part of our encoded text:
encoded_sample = b'didn\xe2\x80\x99t'
# type(encoded_sample) # bytes
# however, the type(tweet) # string of our tweet
b'didn\xe2\x80\x99t'.decode('utf-8') # output is `didn't`
# So formatting it to utf-8 works

# LATER: move to preprocessing function
def decode_byte_to_string(tweet):
    # deal with tweet full text
    tweet_text_wrong_datatype = tweet.get('full_text', '')
    # HACK: because it imports as string, however, it is a byte:
    tweet_text_bytes = eval(tweet_text_wrong_datatype.encode('ascii', 'ignore').decode('utf8'))
    tweet_text_string = tweet_text_bytes.decode('utf8')
    return(tweet_text_string)

with open(fJsonName) as f:
    tweets_proccessed = []

    for line in f:
        tweet = json.loads(line)

        tweet_text_string = decode_byte_to_string(tweet)
        stripped = strip_twitter_special_characters(tweet_text_string)

        # append the stripped text to our json as tweets_proccessed
        tweet.update({'full_text_stripped' : stripped})

        # BUG: doesn't work:
        # with open('data/processed/data.json', 'w') as outfile:
        #     f.write(json.dump(tweet, outfile)) 
            
        tweets_proccessed.append(tweet)
                
    f.close()

with open('data/processed/data.json', 'w') as outfile:
    json.dump(tweets_proccessed, outfile)

# ---

# LATER:
# cols = ['tweet']
# df = pd.DataFrame(tweets, columns=cols)    

# Done:
# - [x] Each tweet starts with 'b"
# - [x] Special characters removed are \\xf0\\x9f\\xa4\\x96, etc and escaped

#%% [markdown]
#

#%%
from src.preprocessing import strip_twitter_special_characters
# original tweet:
# FIXME: Update to our own sample
# ### Remove unnecessary text
# Function to remove @username, #hashtags, links, and underscores using regex:

#%%
test_tweet = df.iloc[1,0]
print(test_tweet)

#%% [markdown]
#
# ### Demo the stripper:

#%%

# FIXME: add tweets list again

stripped_tweets = strip_twitter_special_characters(tweets)
stripped_tweets

#%% [markdown]
#
# Done: 
#
# - [x] Remove links
# - [x] Remove @usernames
# - [x] Remove #hashtags
#
# Note for later:
# It would be great to analyse rather than remove emojis

# NOTE: https://towardsdatascience.com/5-methods-to-remove-the-from-your-data-in-python-and-the-fastest-one-281489382455

# %% [markdown]
#
# TODO: Analysis Approach
# 	•	Describe what analysis you performed to answer the questions
# 	•	What type of sentiment analysis did you do?  Briefly explain your rationale for doing it as such.
# 	•	What type of topic modelling did you do?  Again, briefly explain your rationale for your approach.

# %% [markdown]
#
# ### 1.2 Initial Exploration (Pre-processing)
#
# - [ ] number of tweets, 
# - [ ] top K unique hashtags

# - [x] Are there characters that aren't useful for analysis
# Removed above

#%%
# # - [ ] Top K unique words
from src.features import *

doProcessTweet('data/processed/data.json', 'full_text_stripped', 30)

# BUG: doGetHashtags('data/processed/data.json', 30)
# BUG: doGetMentions('data/processed/data.json', 30)

#%% [markdown]
#
# ## 2. Analysis Methodology
# 
# ### Initial Analysis
#
# ### Does the approach selected have parameters
# 
# Not particularly

# ### Would a different approach produce different answer?
# A: Yes. Given _more_ time I would have a look at combinations of two 
# or multiple word groups of sentences

#%% [markdown]
#
# ### 2.1 Selection and Parameter choices (Methodology)
#
# ### What effect does the parameter settings have on the results
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
# A: Given the heart foundations recent (controversy)[https://www.abc.net.au/news/2019-05-31/heart-foundation-apologises-for-heartless-words-ad-campaign/11167870]
# I became interested in how people feel about charities.
# Eg. Are people generally positive about charity? Or do they have 'compassion
# fatigue'? Can organisations like the Heart foundation justify shocking people
# into doing what they want?
# - other sources of information
# - if the results don’t correspond to background knowledge, why you think that is so?

#%% [markdown]
#
# TODO: Conclusion
#	 •	Provide a short conclusion about your entity, analysis and what you found
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

#%% [markdown]
#
# ### Bibleography
#
# - Use citethisforme tool


