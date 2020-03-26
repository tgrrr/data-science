# #%% [markdown]
# #
# # COSC2671 Social Media and Network Analytics
# # Assignment 1
# # @author Phil Steinke, 2019
# # Due 30 August/ 2019
# # 15 marks
# 
# #%% Change working directory from the workspace root to the ipynb file location. Turn this addition off with the DataScience.changeDirOnImportExport setting
# # ms-python.python added
# # import os
# # try:
# # 	os.chdir(os.path.join(os.getcwd(), 'uni/social-media/w2-text-analysis/lab'))
# # 	print(os.getcwd())
# # except:
# # 	pass
# 
# 
# # - [ ] Get Twitter data
# # - [ ] Do market research
# # - [ ] 
# # - [ ] 
# # - [ ] 
# 
# #%%
# # working directory
# # cwd = os.getcwd()
# # cwd
# # working directory should be ... '/charity_ml_scraping_social_media'
# 
# # packages
# import tweepy
# import csv
# import pandas as pd
# import os
# 
# # python scripts
# # TODO: later from src.api.twitter.twitterClient import * # twitterAuth, twitterClient
# # TODO: later from src.api.twitter.getHashtags import * # getHashtags
# 
# twitterClient()
# 
# # Test API works: return one of my own tweets
# # auth = twitterAuth()
# # api = tweepy.API(auth,wait_on_rate_limit=True)
# # public_tweets = api.home_timeline()
# # 
# # for tweet in public_tweets:
# #     print(tweet.text)
# 
# # %% [markdown]
# #
# # 0. Setup
# # - [ ] a few thousand tweets per week in your data.
# # 
# # auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
# # auth.set_access_token(access_token, access_token_secret)
# # api = tweepy.API(auth,wait_on_rate_limit=True)
# 
# # params
# csvFile = open('charity_machine_learning_tweets.csv', 'a')
# csvWriter = csv.writer(csvFile)
# 
# start_date = '2018-09-01'
# 
# def writeToCsv(_tweet, _full_text):
#     csvWriter.writerow([
#         _full_text.encode('utf-8'), 
#         _tweet.created_at,
#         _tweet.user.id,
#         # _tweet.user.screen_name,
#         # _tweet.user.friends_count,
#         # _tweet.user.followers_count,
#         ])
#         #     csvWriter.writerow([
#         #         tweet.text.encode('utf-8'), 
#         #         tweet.created_at,
#         #         tweet.user.id,
#         #         tweet.user.screen_name,
#         #         tweet.user.friends_count,
#         #         tweet.user.followers_count,
#         #         ])
# 
# 
# def handle_fulltext_twitter_json_loc(tweet):
#     if hasattr(tweet, 'retweeted_status'):
#     # if 'retweeted_status' in tweet._json:
#         _full_text = (tweet._json['retweeted_status']['full_text'])
# 
#     else:
# 
#         _full_text = tweet.full_text 
# 
#     writeToCsv(tweet, _full_text)
#     # print(_full_text)
# 
# search_term = 'charity'
# tweepyParams = {
#     "q": search_term,
#     "count": 1,
#     "include_entities": True,
#     "lang": "en",
#     "monitor_rate_limit": True, 
#     "result_type": 'recent',
#     "since": start_date, # until: '2017-02-17',
#     "wait_on_rate_limit": True,
#     "tweet_mode": "extended",
#     # rpp=1,
#     # page=1,
# }
# 
# def fetchTweets(_search_term):
#     """
#         Fetch Tweets using Tweepy
# 
#         @returns:
#         api: http://docs.tweepy.org/en/v3.5.0/api.html#API.search
#     """
#     try:
#         print('Fetch Tweets')
#         for tweet in tweepy.Cursor(api.search,
#                                 **tweepyParams,
#                                 ).items():
#             try:
#                 handle_fulltext_twitter_json_loc(tweet)
# 
#             except tweepy.TweepError as e:
#                 print('Error: %s', e)
#             except:
#                 print('Something else went wrong during the api query')
#     except:
#         print('something went wrong')
#     finally:
#         os.system( 'say beep' )
#         print('And... donesky')
# 
# fetchTweets(search_term)
# 
# #%% [markdown]
# #
# # ## 1. Data Pre-processing 
# #
# #
# 
# 
# 
# #%% [markdown]
# #
# # ### 1.1 Data Cleaning (Pre-processing)
# #
# #
# 
# #%% [markdown]
# #
# # ### 1.2 Initial Exploration (Pre-processing)
# #
# # - [ ] number of tweets, top K unique hashtags and words etc
# # - [ ] Are there characters that aren't useful for analysis
# 
# #%% [markdown]
# #
# # ## 2. Analysis Methodology
# #
# # ### Initial Analysis
# #
# # ### Does the approach selected have parameters
# # 
# # ### What effect does the parameter settings have on the results
# #
# # ### Would a different approach produce different answer?
# #
# # ### 
# #
# # ###
# #
# 
# #%% [markdown]
# #
# # ### 2.1 Selection and Parameter choices (Methodology)
# #
# #
# 
# #%% [markdown]
# #
# # ### 2.1 Justify parameters with explanations (Methodology)
# #
# 
# #%% [markdown]
# #
# # ## Analysis & Discussion
# #
# # - what are the topics been discussed about a user via a top-K terms
# # - word-cloud of the topics discovered by topic modelling
# # - what are the topics
# # - does it correspond to recent news
# # - other sources of information
# # - if the results don’t correspond to background knowledge, why you think that is so?
# 
# #%% [markdown]
# #
# # ### Discussion of results (Discussion)
# #
# # - Describe your data
# # - Outline and describe your approach, your findings and insights to the questions
# # - Use tables, plots/graphs, word clouds and other visualisations to help you communicate the results (in addition to text
# 
# #%% [markdown]
# #
# # ### Explain what the results indicate (Discussion)
# #
# #
# 
# 
# #%% [markdown]
# #
# #  ##### Other Rubric
# #  - [ ] Report Presentation 15%
# #  - [ ] Code Style and Readability
# #
# 
# #%% [markdown]
# #
# # ### Sample of the Data (1st 1000 tweets, embed)
# #
# #
# 
# #%% [markdown]
# #
# # ### Bibleography
# #
# # - Use citethisforme tool
# 
# 

<!--  # Initial Analysis


A: Not particularly



# %% markdown
#
### 2.1 Selection and Parameter choices (Methodology)

TODO:  # What effect does the parameter settings have on the results?


# %% markdown
#
### 2.1 Justify parameters with explanations (Methodology)


# %% markdown
#
## Analysis & Discussion -->


# %%
# FIXME: after MD do I need this bit?
df = 'data/raw/charity_tweets_11110.json'
df.head()
df = pd.DataFrame(df, columns=['text',  'date',  'user_id'])


