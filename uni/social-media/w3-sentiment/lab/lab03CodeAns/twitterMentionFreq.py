# To add a new cell, type '#%%'
# To add a new markdown cell, type '#%% [markdown]'
#%% Change working directory from the workspace root to the ipynb file location. Turn this addition off with the DataScience.changeDirOnImportExport setting
# ms-python.python added
import os
try:
	os.chdir(os.path.join(os.getcwd(), 'w3-sentiment/lab/lab03CodeAns'))
	print(os.getcwd())
except:
	pass

#%%
#
# COSC2671 Social Media and Network Analytics
# @author Jeffrey Chan, 2018
#


#%%
def getMentions(tweet):
    """
    Extracts the associated mentions of tweet.

    @param tweet: The tweet, which is in the tweepy json format, and which we wish to extract its associated mentions.

    @returns: list of hashtags (in lower case)
    """

    # compared with twitterHashtagFreq, the only difference is really here, where we extract the mentions from the tweet
    # dicitionary structure that the tweets are saved as
    entities = tweet.get('entities', {})
    userMentions = entities.get('user_mentions', {})

    # not all tweets have mentions, hence we check for this and only retrieved the mentioned user if there is a mention
    if len(userMentions) > 0:
        lMentionedScreenName = [entry.get('screen_name', '') for entry in userMentions]
        return lMentionedScreenName
    else:
        return []


#%%
import sys
from collections import Counter
import json


"""
Prints out the mentioned users in the input tweet file.
"""

# load json file
# note usually we would do some checks, but for clarify's sake we haven't implement that code here
# Specify the json file that we want to analyse the mentions 
fJsonName = 'rmitCsTwitterTimeline.json'

# number of tweets to display
tweetThres = 50

# open file and use Counter to count the number of times the hash tags appears
with open(fJsonName, 'r') as f:
    mentionsCounter = Counter()
    # for each line in file (which corresponds to a tweet), load it, get the hashtags and insert them into the
    # Counter
    for line in f:
        tweet = json.loads(line)
        mentionsInTweet = getMentions(tweet)
        mentionsCounter.update(mentionsInTweet)

    for mention, count in mentionsCounter.most_common(tweetThres):
        print(mention + ": " + str(count))


#%%



