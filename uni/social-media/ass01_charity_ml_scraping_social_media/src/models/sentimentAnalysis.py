# FIXME:

"""
COSC2671 Social Media and Network Analytics
@author Jeffrey Chan, 2019

"""

import re

class TwitterProcessing:
    """
    This class is used to pre-process tweets.  This centralises the processing to one location.  Feel free to add.
    """

    def __init__(self, tokeniser, lStopwords):
        """
        Initialise the tokeniser and set of stopwords to use.

        @param tokeniser:
        @param lStopwords:
        """

        self.tokeniser = tokeniser
        self.lStopwords = lStopwords



    def process(self, text):
        """
        Perform the processing.
        @param text: the text (tweet) to process

        @returns: list of (valid) tokens in text
        """

        text = text.lower()
        tokens = self.tokeniser.tokenize(text)
        tokensStripped = [tok.strip() for tok in tokens]

        # pattern for digits
        # the list comprehension in return statement essentially remove all strings of digits or fractions, e.g., 6.15
        regexDigit = re.compile("^\d+\s|\s\d+\s|\s\d+$")
        # regex pattern for http
        regexHttp = re.compile("^http")

        return [tok for tok in tokensStripped if tok not in self.lStopwords and regexDigit.match(tok) == None and regexHttp.match(tok) == None]

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# FIXME:
# lTweets = lTweets_sample

# To add a new cell, type '#%%'
# To add a new markdown cell, type '#%% [markdown]'
#%% Change working directory from the workspace root to the ipynb file location. Turn this addition off with the DataScience.changeDirOnImportExport setting
# ms-python.python added
# import os
# try:
# 	os.chdir(os.path.join(os.getcwd(), 'w4-topic-detection/lab/lab04CodeAns'))
# 	print(os.getcwd())
# except:
# 	pass
# #%%
# from IPython import get_ipython


#%%
"""
COSC2671 Social Media and Network Analytics
@author Jeffrey Chan, 2019

"""


#%%
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


#%%
# load the twitter processing python class for use
# for those code that we repeatingly use but doesn't change much, or only change due to input, it is good to write them as
# functions and call later, which we are doing here.
# As the weeks goes by, we will increasingly do and make use of the benefits of scripts but also the interactivity of
# interactive Jupyter notebooks
# get_ipython().run_line_magic('load_ext', 'autoreload')
# get_ipython().run_line_magic('autoreload', '1')

# we are importing TwitterProcessing.py and its contents
# get_ipython().run_line_magic('aimport', 'TwitterProcessing')


#%%

# FIXME:

def doSentimentAnalysis(
    sTweetsFilename = 'data/processed/data-multi-json.json',
    approach = 'count'

    ):

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

        # LATER:
        # load_tweets_list(sTweetsFilename)

        lSentiment = []
        # open file and process tweets, one by one
        with open(sTweetsFilename, 'r') as f:
            for line in f:
                # each line is loaded according to json format, into tweet, which is actually a dictionary
                tweet = json.loads(line)
                # print(tweet)

                # each line is loaded according to json format, into tweet, which is actually a dictionary

            # original
            # for line in f:
            #     # each line is loaded according to json format, into tweet, which is actually a dictionary
            #     tweet = json.loads(line)

                try:
                    tweetText = tweet.get('full_text_stripped', '')
                    tweetDate = tweet.get('date')
                    # pre-process the tweet text
                    lTokens = tweetProcessor.process(tweetText)

                    #
                    # TODO: compute the sentiment 
                    # Answer below.
                    #

                    # TODO: count the number of positive words (hint: use setPosWords)
                    posNum = len([tok for tok in lTokens if tok in setPosWords])

                    # TODO: count the number of negative words (hint: use setNegWords)
                    negNum = len([tok for tok in lTokens if tok in setNegWords])

                    # TODO: compute the sentiment value
                    # replace the right hand side with the computed value of sentiment 
                    # the '0' value is currently a placeholder
                    sentiment = posNum - negNum


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
                                print(Fore.RED + '\+' + token + ', ', end='')
                            elif token in setNegWords:
                                print(Fore.BLUE + '\-' + token + ', ', end='')
                            else:
                                print(Style.RESET_ALL + token + ', ', end='')

                        print(': {}'.format(sentiment))

                except KeyError as e:
                    pass

        return lSentiment


    #%%
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
                        for cat,score in dSentimentScores.items():
                            print('{0}: {1}, '.format(cat, score), end='')
                        print()

                except KeyError as e:
                    pass


        return lSentiment


    #%%
    # arguments for this notebook
    # modify as needed if you want to do similar analaysis for other purposes

    # input file of set of postive words
    posWordFile = 'data/positive-words.txt'
    # input file of set of negative words
    negWordFile = 'data/negative-words.txt'
    # input file of set of tweets (json format)
    tweetsFile = sTweetsFilename
    # flag to determine whether to print out tweets and their sentiment
    flagPrint = True
    # specify the approach to take, one of [count, vader]
    # change this to use a different sentiment approach
    # approach = 'count'


    #%%
    """
    This is the main part of the notebook, that will can and run the various methods defined before.
    """

    # construct the tweet pro-processing object
    tweetTokenizer = TweetTokenizer()
    lPunct = list(string.punctuation)
    # standard 'English' stopwords plus we want to remove things like 'rt' (retweet) etc
    lStopwords = stopwords.words('english') + lPunct + ['rt', 'via', '...', '…', '"', "'", '`']

    # call the TwitterProcessing python script
    # original: tweetProcessor = TwitterProcessing.TwitterProcessing(tweetTokenizer, lStopwords)
    tweetProcessor = TwitterProcessing(tweetTokenizer, lStopwords)
    # tweetProcessor = lTweets_sample

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


    #%%
    # compute the sentiment
    lSentiment = []
    if approach == 'count':
        lSentiment = countWordSentimentAnalysis(setPosWords, setNegWords, tweetsFile, flagPrint, tweetProcessor)
    elif approach == 'vader':
        lSentiment = vaderSentimentAnalysis(tweetsFile, flagPrint, tweetProcessor)


    #%%
    #
    # TODO: timeseries part
    #

    # determine if we should output a time series of sentiment scores across time
    # TODO: write code to display the time series (delete 'pass' below when you do)

    # we are using pandas for this, but first we need to get it into a pandas data frame structure
    series = pd.DataFrame(lSentiment, columns=['date', 'sentiment'])
    # tell pandas that the date column is the one we use for indexing (or x-axis)
    series.set_index('date', inplace=True)

    # pandas makes a guess at the type of the columns, but to make sure it doesn't get it wrong, we set the sentiment
    # column to floats
    series[['sentiment']] = series[['sentiment']].apply(pd.to_numeric)

    # This step is not necessary, but pandas has a neat function that allows us to group the series at different
    # resultion.  The 'how=' part tells it how to group the instances.  In this example, it sames we want to group
    # by day, and add up all the sentiment scores for the same day and create a new time series called 'newSeries'
    # with this day resolution
    # LATER: play with this for different resolution, '1H' is by hour, '1M' is by minute etc
    # newSeries = series.resample('1D', how='sum')
    # this plots and shows the time series
    series.plot()
    # newSeries.plot()
    plt.show()

# def main():
#     doSentimentAnalysis()
#     os.system( 'say beep' )
# 
# main()