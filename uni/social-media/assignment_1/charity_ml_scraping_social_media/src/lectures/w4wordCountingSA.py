# %%
"""
COSC2671 Social Media and Network Analytics
@author Jeffrey Chan, 2019

"""
# %%
# pip install colorama
# %%
# importing packages and nltk data libraries
import string
import json
import codecs
import re

import nltk
from nltk.tokenize import TweetTokenizer
from nltk.corpus import stopwords
from nltk.sentiment.vader import SentimentIntensityAnalyzer
nltk.download('vader_lexicon')

from colorama import Fore, Back, Style
import pandas as pd
import matplotlib.pyplot as plt
# %%
# load the twitter processing python class for use
# for those code that we repeatingly use but doesn't change much, or only change due to input, it is good to write them as
# functions and call later, which we are doing here.
# As the weeks goes by, we will increasingly do and make use of the benefits of scripts but also the interactivity of
# interactive Jupyter notebooks
%load_ext autoreload
%autoreload 1

# we are importing TwitterProcessing.py and its contents
%aimport TwitterProcessing
# %%
def countWordSentimentAnalysis(setPosWords, setNegWords, sTweetsFilename, bPrint, tweetProcessor):
    """
    Basic sentiment analysis.  Count the number of positive words, count the negative words, overall polarity is the
    difference in the two numbers.

    @param setPosWords: set of positive sentiment words
    @param setNegWords: set of negative sentiment words
    @param sTweetsFilename: name of input file containing a json formated tweet dump
    @param bPrint: whether to print the stream of tokens and sentiment.  Uses colorama to highlight sentiment words.
    @param tweetProcessor: TweetProcessing object, used to pre-process each tweet.

    @returns: list of tweets, in the format of [date, sentiment]
    """


    lSentiment = []
    # open file and process tweets, one by one
    with open(sTweetsFilename, 'r') as f:
        for line in f:
            # each line is loaded according to json format, into tweet, which is actually a dictionary
            tweet = json.loads(line)

            try:
                tweetText = tweet.get('text', '')
                tweetDate = tweet.get('created_at')
                # pre-process the tweet text
                lTokens = tweetProcessor.process(tweetText)

                
                #               
                # TODO: compute the sentiment 
                #
                
                # TODO: count the number of positive words (hint: use setPosWords)

                # TODO: count the number of negative words (hint: use setNegWords)

                # TODO: compute the sentiment value
                # replace the right hand side with the computed value of sentiment 
                # the '0' value is currently a placeholder
                sentiment = 0
                
                
                #
                # End of TODO part
                #
                

                # save the date and sentiment of each tweet (used for time series)
                lSentiment.append([pd.to_datetime(tweetDate), sentiment])

                # if we are printing, each token is printed and coloured according to red if positive word, and blue
                # if negative
                if bPrint:
                    for token in lTokens:
                        if token in setPosWords:
                            print(Fore.RED + token + ', ', end='')
                        elif token in setNegWords:
                            print(Fore.BLUE + token + ', ', end='')
                        else:
                            print(Style.RESET_ALL + token + ', ', end='')

                    print(': {}'.format(sentiment))


            except KeyError as e:
                pass

    return lSentiment

# %%
def vaderSentimentAnalysis(sTweetsFilename, bPrint, tweetProcessor):
    """
    Use Vader lexicons instead of a raw positive and negative word count.

    @param sTweetsFilename: name of input file containing a json formated tweet dump
    @param bPrint: whether to print the stream of tokens and sentiment.  Uses colorama to highlight sentiment words.
    @param tweetProcessor: TweetProcessing object, used to pre-process each tweet.

    @returns: list of tweets, in the format of [date, sentiment]
    """

    # this is the vader sentiment analyser, part of nltk
    sentAnalyser = SentimentIntensityAnalyzer()


    lSentiment = []
    # open file and process tweets, one by one
    with open(sTweetsFilename, 'r') as f:
        for line in f:
            # each line is loaded according to json format, into tweet, which is actually a dictionary
            tweet = json.loads(line)

            try:
                tweetText = tweet.get('text', '')
                tweetDate = tweet.get('created_at')
                # pre-process the tweet text
                lTokens = tweetProcessor.process(tweetText)

                # this computes the sentiment scores (called polarity score in nltk, but mean same thing essentially)
                # see lab sheet for what dSentimentScores holds
                dSentimentScores = sentAnalyser.polarity_scores(" ".join(lTokens))

                # save the date and sentiment of each tweet (used for time series)
                lSentiment.append([pd.to_datetime(tweetDate), dSentimentScores['compound']])

                # if we are printing, we print the tokens then the sentiment scores.  Because we don't have the list
                # of positive and negative words, we cannot use colorama to label each token
                if bPrint:
                    print(*lTokens, sep=', ')
                    # uncomment this (and comment above line) if you are analysing the tweets directly, instead of the tokens
                    # print(tweetText)
                    for cat,score in dSentimentScores.items():
                        print('{0}: {1}, '.format(cat, score), end='')
                    print()

            except KeyError as e:
                pass


    return lSentiment

# %%
# arguments for this notebook
# modify as needed if you want to do similar analaysis for other purposes

# input file of set of postive words
posWordFile = 'positive-words.txt'
# input file of set of negative words
negWordFile = 'negative-words.txt'
# input file of set of tweets (json format)
tweetsFile = 'rmitCsTwitterTimeline.json'
# flag to determine whether to print out tweets and their sentiment
flagPrint = True
# specify the approach to take, one of [count, vader]
# change this to use a different sentiment approach
approach = 'count'
# %%
"""
This is the main part of the notebook, that will can and run the various methods defined before.
"""


# construct the tweet pro-processing object
tweetTokenizer = TweetTokenizer()
lPunct = list(string.punctuation)
# standard 'English' stopwords plus we want to remove things like 'rt' (retweet) etc
lStopwords = stopwords.words('english') + lPunct + ['rt', 'via', '...', '…', '"', "'", '`']

# call the TwitterProcessing python script
tweetProcessor = TwitterProcessing.TwitterProcessing(tweetTokenizer, lStopwords)


# load set of positive words
lPosWords = []
with open(posWordFile, 'r', encoding='utf-8', errors='ignore') as fPos:
    for sLine in fPos:
        lPosWords.append(sLine.strip())

setPosWords = set(lPosWords)


# load set of negative words
lNegWords = []
with codecs.open(negWordFile, 'r', encoding='utf-8', errors='ignore') as fNeg:
    for sLine in fNeg:
        lNegWords.append(sLine.strip())

setNegWords = set(lNegWords)

# %%
# compute the sentiment
# to change method, update parameter settings, particularly the variable 'approach' and rerun the parameter setting cell,
# and also this cell
lSentiment = []
if approach == 'count':
    lSentiment = countWordSentimentAnalysis(setPosWords, setNegWords, tweetsFile, flagPrint, tweetProcessor)
elif approach == 'vader':
    lSentiment = vaderSentimentAnalysis(tweetsFile, flagPrint, tweetProcessor)
# %%
#
# TODO: timeseries part
#

# determine if we should output a time series of sentiment scores across time
# TODO: write code to display the time series (delete 'pass' below when you do)
pass
# %%
