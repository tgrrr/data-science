# %% markdown
#
# ## COSC2671 Social Media and Network Analytics
# ### Assignment 1
# @author Phil Steinke, 2019
# 15 marks

# %% markdown
#
# TODO: Introduction
# - Describe what/who is your selected entity
# - Describe why it is interesting to find the sentiment and topics 
# (answer questions) of this entity
#
# ### Goals:
# - [ ] What are the trending concepts and topics associated with this person or event?
# - [ ] What are the perceptions and feelings towards this person or event?
# - [x] Get Twitter data
# - [ ] Do market research

# %%
#
# packages
# python scripts
import os
from src.config.constants import Constants
os.chdir(Constants.path)
from src.common.util import *

# %% markdown
#
# TODO: 0. Data Collection
# - [ ] Describe how you collected the data, and briefly why you chose that approach (restful vs stream)
# - [ ] Report some statistics of your collected data
# - [x] A few thousand tweets per week in your data.
# Initially, we searched for multiple terms with the search term: 
# "charity" (data OR science OR artificial OR intelligence OR machine OR learning OR ai OR ml)

# %%
from src.data.api import * #fetchTweets

# params:
start_date = '2018-08-01'
search_term = '"charity"%20(machintodo1e%20OR%20learning%20OR%20artificial%20OR%20intelligence)%20(%23ml%20OR%20%23ai)'
fetchTweets(search_term, start_date)

# %% markdown
# Then we can refine it to charity:

# %%
search_term = 'charity'
# NOTE: only run this once, it's an expensive function
fetchTweets(search_term, start_date)

# %% markdown
#
# Obstacles:
# - Text is trunicated
# Solution: wrote function `handle_fulltext_twitter_json_loc(tweet)` to deal 
# with getting full text from tweets. Because `full_text` is present in a 
# different location in the json for retweets and regular tweets
# see: http://docs.tweepy.org/en/latest/extended_tweets.html#examples

# %% markdown
#
# ## 1. Data Pre-processing 
#
# TODO: Pre-processing and Data Cleaning
# - [ ] Describe what pre-processing you performed
# - [ ] Show examples of noisy data, plot some graphs, 
# etc to show why you decided to do those pre-processing

# %%
from src.preprocessing import * # convert_csv_to_json

# %% markdown
# Convert CSV to json
# Initially I scraped into a CSV, so this code converts it into json format:

# %% markdown
#
# ### 1.1 Data Cleaning (Pre-processing)

# %%
#
colnames=['full_text', 'date', 'id'] 
convert_csv_to_json('data/raw/charity_tweets_heaps_11110', colnames)

# %% markdown
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

# %%
# FIXME: df = 'data/raw/charity_tweets_heaps_11110.json'

from src.preprocessing import *

# why do we need to decode it again to utf8?
# grab a part of our encoded text:
encoded_sample = b'didn\xe2\x80\x99t'
# type(encoded_sample) # bytes
# however, the type(tweet) # string of our tweet
b'didn\xe2\x80\x99t'.decode('utf-8') # output is `didn't`
# So formatting it to utf-8 works

# %% markdown
# Function to remove @username, #hashtags, links, underscores, and escaped char

# %% 
fJsonName = 'data/raw/charity_tweets_heaps_sample_100.json'
out = 'data/processed/data_sample.json'
strip_tweet(fJsonName, out)

# NOTE: expensive process, run in terminal using python preproccessing/stripTweetsTerminal.py
fJsonName = 'data/raw/charity_tweets_heaps_11110.json'
out = 'data/processed/data.json'
strip_tweet(fJsonName, out)

# %% markdown
#
# ### Demo stripping:
# FIXME: removes

# %%
# import pandas as pd
# test_tweets = [
#     "The * Mooch*...apt nickname...you're not truthful so it's doubtful the * proceeds * go to any charity that isn't an LLC for *Mooch's Piggy Bank*... https://t.co/YA9pey2ljW",
#     "FBI eyes Jones' charity, UAW officials' California junkets https://t.co/iQfIjLCyxL",
#     "@johnpavlovitz @2LarryJohnson7 I hope Larry Johnson boxes you for charity.",
#     "#TheBiblicalStandard it's only the HONORABLE MESSIAH who will help the church to reach the Bibilical standards. HE offered the Sarcrifice of attonment outside the gate on a tree for you and me to see GOD face to face.Uuuuuuuuii this is greater love."
# ]
# 
# cols = ['tweet']
# df = pd.DataFrame(test_tweets, columns=cols)

# test_tweet = df.iloc[1,0]
# print(test_tweet)
# # test_tweet = "b\The * Mooch*...apt nickname...you're not truthful so it's doubtful the * proceeds * go to any charity that isn't an LLC for *Mooch's Piggy Bank*... https://t.co/YA9pey2ljW"
# 
# # FIXME: for demo. This works in the test dataset
# stripped_tweet = do_strip_tweet(test_tweets)
# stripped_tweet
# %% 
# save as dataframe

# %% markdown
# Done: 
# - [x] Each tweet starts with 'b"
# - [x] Special characters removed are \\xf0\\x9f\\xa4\\x96, etc and escaped
# - [x] Remove links
# - [x] Remove @usernames
# - [x] Remove #hashtags
#
# Note for later:
# It would be great to analyse emojis for sentiment analaysis, so I have left them in

# %% markdown
#
# TODO: Analysis Approach
# - [ ] Describe what analysis you performed to answer the questions
# - [ ] What type of sentiment analysis did you do?  Briefly explain your rationale for doing it as such.
# - [ ] What type of topic modelling did you do?  Again, briefly explain your rationale for your approach.

# %% markdown
#
# ### 1.2 Initial Exploration (Pre-processing)
#
# - [ ] number of tweets, 
# - [ ] top K unique hashtags
# - [x] Are there characters that aren't useful for analysis
# Removed above

# %%
# # - [ ] Top K unique words
from src.features import *
from src.preprocessing import *
# from src.common.util import *


# doProcessTweet('data/processed/data.json', 'full_text_stripped', 30)
doProcessTweet('data/processed/data.json', 'full_text_stripped', 30, isJson=True)

# %%
# TODO: scrape it again, with hashtags and mentions
# BUG: doGetHashtags('data/processed/data.json', 30)
BUG: doGetMentions('data/processed/data.json', 30)

# %% markdown
#
# ## 2. Analysis Methodology
# 
# ### Initial Analysis
#
# ### Does the approach selected have parameters
# 
# A: Not particularly

# ### Would a different approach produce different answer?
# A: Yes. Given _more_ time I would have a look at combinations of two 
# or multiple word groups of sentences

# %% markdown
#
# ### 2.1 Selection and Parameter choices (Methodology)
#
# TODO: ### What effect does the parameter settings have on the results?

# %% markdown
#
# ### 2.1 Justify parameters with explanations (Methodology)
#

# %% markdown
#
# ## Analysis & Discussion
#
# - what are the topics been discussed about a user via a top-K terms

# TODO: check in notebook
# charities: 8703
# this: 1902
# raise: 1803
# donate: 1769
# money: 1440
# ha: 1390 TODO:
# help: 1309
# support: 1253
# world: 1221
# hi: 1121
# amp: 969
# ever: 938
# wa: 897 TODO:
# watch: 852
# create: 815
# people: 797
# day: 788
# clean: 768
# porn: 758
# ocean: 748
# dirtiest: 744
# thanks: 707
# work: 701
# us: 691
# get: 686
# go: 663
# one: 654
# year: 651
# please: 631


# - word-cloud of the topics discovered by topic modelling
# - what are the topics

# - does it correspond to recent news
# A: Given the heart foundations recent 
# (controversy)[https://www.abc.net.au/news/2019-05-31/heart-foundation-apologises-for-heartless-words-ad-campaign/11167870]
# I became interested in how people feel about charities.
# Eg. Are people generally positive about charity? Or do they have 'compassion
# fatigue'? Can organisations like the Heart foundation justify shocking people
# into doing what they want?
# - other sources of information
# - if the results don’t correspond to background knowledge, why you think that is so?

# %% markdown
#
# TODO: Conclusion
#	 •	Provide a short conclusion about your entity, analysis and what you found
#
# ### Discussion of results (Discussion)
#
# - Describe your data
# - Outline and describe your approach, your findings and insights to the questions
# - Use tables, plots/graphs, word clouds and other visualisations to help you communicate the results (in addition to text

# %% markdown
#
# ### Explain what the results indicate (Discussion)

# %% markdown
#
#  ##### Other Rubric
#  - [ ] Report Presentation 15%
#  - [ ] Code Style and Readability

# %% markdown
#
# ### Sample of the Data (1st 1000 tweets, embed)

# %% markdown
#
# ### Bibleography
#
# - Use citethisforme tool


