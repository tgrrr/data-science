# %%
"""
COSC2671 Social Media and Network Analytics
@author Jeffrey Chan, RMIT 2019

"""
# %%
%load_ext autoreload
%autoreload 1
%aimport twitterClientOwn
# %%
import string
from nltk.tokenize import TweetTokenizer
from nltk.corpus import stopwords
import numpy as np
import math

from tweepy import Cursor
from tweepy import api
from twitterClient import twitterClient

from sklearn.feature_extraction.text import CountVectorizer
from sklearn.decomposition import LatentDirichletAllocation

import matplotlib.pyplot as plt
# %%
def process(text, tokeniser=TweetTokenizer(), stopwords=[]):
    """
    Perform the processing.  We used a a more simple version than week 4, but feel free to experiment.

    @param text: the text (tweet) to process
    @param tokeniser: tokeniser to use.
    @param stopwords: list of stopwords to use.

    @returns: list of (valid) tokens in text
    """

    text = text.lower()
    tokens = tokeniser.tokenize(text)

    return [tok for tok in tokens if tok not in stopwords and not tok.isdigit()]
# %%
#
# TWitter parameters
#

# Instead of own timeline, will retrieve the specified user's timeline (default is rmit_csit)
user = 'rmit_csit'
# uncomment this to use own account (note you do need to have at least resultsToRetrieve number of tweets)
# user = None
# The number of tweets to retrieve and print (default = 500)
resultsToRetrieve = 500
# %%
"""
Performs topic modelling on a twitter timeline.
"""

# use built-in nltk tweet tokenizer
# there is definitely scope to improve this
tweetTokenizer = TweetTokenizer()
punct = list(string.punctuation)
stopwordList = stopwords.words('english') + punct + ['rt', 'via', '...']

# construct twitter client
client = twitterClientOwn.twitterClient()

# this will store the list of tweets we read from timeline
lTweets = []

# own timeline
if user == None:
    for tweet in Cursor(client.home_timeline).items(resultsToRetrieve):
        lTokens = process(text=tweet.text, tokeniser=tweetTokenizer, stopwords=stopwordList)
        lTweets.append(' '.join(lTokens))
# else retrieve timeline of specified user (available in user parameter)
else:
    for tweet in Cursor(client.user_timeline, id=user).items(resultsToRetrieve):
        lTokens = process(text=tweet.text, tokeniser=tweetTokenizer, stopwords=stopwordList)
        lTweets.append(' '.join(lTokens))

# %%
#
# LDA parameters
#

# number of topics to discover (default = 10)
topicNum = 10
# maximum number of words to display per topic (default = 10)
wordNumToDisplay = 10
# this is the number of features/words to used to describe our documents
# please feel free to change to see effect
featureNum = 1500
# %%
"""
Performs counting via CountVectorizer and then apply the LDA model.
"""

#
# Count Vectorizer
#

tfVectorizer = CountVectorizer(max_df=0.95, min_df=2, max_features=featureNum, stop_words='english')
tf = tfVectorizer.fit_transform(lTweets)
# extract the names of the features (in our case, the words)
tfFeatureNames = tfVectorizer.get_feature_names()


#
# LDA MODEL
#

# Run LDA (see documentation about what the arguments means)
ldaModel = LatentDirichletAllocation(n_components =topicNum, max_iter=10, learning_method='online').fit(tf)
# %%
def display_topics(model, featureNames, numTopWords):
    """
    Prints out the most associated words for each feature.

    @param model: lda model.
    @param featureNames: list of strings, representing the list of features/words.
    @param numTopWords: number of words to print per topic.
    """

    # print out the topic distributions
    for topicId, lTopicDist in enumerate(model.components_):
        print("Topic %d:" % (topicId))
        print(" ".join([featureNames[i] for i in lTopicDist.argsort()[:-numTopWords - 1:-1]]))
# %%
#
# Diplays discovered topics
#

display_topics(ldaModel, tfFeatureNames, wordNumToDisplay)
# %%
#
# pyLDAvis
#

# TODO: Add the pyLDAvis code here
# note if you also implemented the word cloud, that will display first, then once you close that
# file, then this will display
# %%
def displayWordcloud(model, featureNames):
    """
    Displays the word cloud of the topic distributions, stored in model.

    @param model: lda model.
    @param featureNames: list of strings, representing the list of features/words.
    """

    # this normalises each row/topic to sum to one
    # use this normalisedComponents to display your wordclouds
    normalisedComponents = model.components_ / model.components_.sum(axis=1)[:, np.newaxis]

    # TODO: complete the implementation
# %%
#
# Word Cloud
#

# display wordcloud
# TODO: go to the function definition and complete its implementation
displayWordcloud(ldaModel, tfFeatureNames)
# %%
