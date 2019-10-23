# To add a new cell, type '#%%'
# To add a new markdown cell, type '#%% [markdown]'
#%% Change working directory from the workspace root to the ipynb file location. Turn this addition off with the DataScience.changeDirOnImportExport setting
# ms-python.python added
import os
try:
	os.chdir(os.path.join(os.getcwd(), 'w7/w7-lab/lab07Code'))
	print(os.getcwd())
except:
	pass
#%% [markdown]
# """
# COSC2671 Social Media and Network Analytics
# @author Jeffrey Chan, RMIT 2019
# 
# """
#%% [markdown]
# The first two cells are used to process Twitter text and same as pervious labs.  

#%%
def process(text, tokeniser, stopwords=[]):
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


#%%
# use built-in nltk tweet tokenizer
# there is definitely scope to improve this
from nltk.tokenize import TweetTokenizer
from nltk.corpus import stopwords
import string

tweetTokenizer = TweetTokenizer()
punct = list(string.punctuation)
stopwordList = stopwords.words('english') + punct + ['rt', 'via', '...']   

#%% [markdown]
# The following loads the data (cell 3 in lab sheet) into global variables used later for computing ratios.

#%%
"""
Loads the data.
"""

import codecs
import csv
import datetime
import glob
from collections import Counter

# data files, do not change
sFilename = 'WorldCupData/WorldCup/*.txt'

# global datastructures to read in the date and text, and a word frequency counter
llDateTime = []
llTweetsText = []
ldFreq = []

# we go through each of the data files and read them into the above global datastructures
for sTextFile in glob.glob(sFilename):
    # to track progress, we print out the filename
    print(sTextFile)
    
    # open file in unicode
    with codecs.open(sTextFile, encoding='utf-8', mode='r') as f:
        # we use csv reader to read in data, whose fields are delimited by '|'
        csvF = csv.reader(f, delimiter='|')
        
        # local structures to read in each file's data
        lCurrDateTime = []
        lCurrTweetsText = []
        dFreq = Counter()
        
        # process each line in file
        for lLine in csvF:
            sDateTime = lLine[0]
            if sDateTime == 'None':
                continue
            try:
                # read in datetime format
                dt = datetime.datetime.strptime(sDateTime, '%a-%b-%d-%H:%M:%S')
                # the dates don't have a year, so we add one in (they are all in 2014)
                dt = dt.replace(2014)
            except ValueError:
                continue
        
            # update local structures
            # datetime
            lCurrDateTime.append(dt)
        
            # text
            sText = lLine[1]
            lTokens = process(text=sText, tokeniser=tweetTokenizer, stopwords=stopwordList)
            lCurrTweetsText.append(' '.join(lTokens))
            
            # frequency of keywords
            dFreq.update(lTokens)
        
        # update global structures
        llDateTime.append(lCurrDateTime)
        llTweetsText.append(lCurrTweetsText)
        ldFreq.append(dFreq)
 
#%% [markdown]
# head
# Sat-May-31-14:00:02|sundai ferguson station 115 amaz local vendor food entertain|[-17.3,31.1] [-17.3,31.1]
# Sat-May-31-14:00:03|polic polic polic mobil|[18.1,-77.2] [35.2,74.1]
# Sat-May-31-14:00:10|utah law land|[47.1,-116.4] [-27.3,23.7]
# Sat-May-31-14:00:10|zon commun cancer research conclus futur depend adequ support fund|[41.8,-87.6][-44.2,170.8] [25.4,68.0]
# Sat-May-31-14:00:11|hear|[-1.2,116.8] [14.6,-17.1]
# Sat-May-31-14:00:17|awesom work bro race mugello qualifi 2nd learn improv|[47.5,-110.8] [-25.9,27.0]
# Sat-May-31-14:00:19|love veggi altern courgett fritter|[38.8,-81.5] [-29.5,31.1]
# Sat-May-31-14:00:21|daili walk dead pic sat maggi|[45.2,24.3] [37.6,-92.3]
# Sat-May-31-14:00:22|she boss porsch carrera cup deutschland work|[-24.3,30.5] [39.7,-99.4]
# Sat-May-31-14:00:23|friend vet veteran|[36.5,-82.6] [-27.3,23.7]

#%%
def updateRatio(dWordRatio, key, value):
    """
    Utility function to update a dictionary that scores maximum values.
    """
    
    # we check if key is in the dictionary then compare if so
    if key in dWordRatio:
        if value > dWordRatio[key]:
            dWordRatio[key] = value
    # otherwise not in dictionary so we can just update the value
    else:
        dWordRatio[key] = value

#%% [markdown]
# This cell is to set the window datetimes, so we can get correct labels when printing and plotting.

#%%
# these are used to construct hourly time periods to print out time labels
startDate = datetime.datetime(year=2014, month=5, day=31, hour=14, minute=0, second=0)
windowDelta = datetime.timedelta(0, 0, 0, 0, 0, 1)
# windowDelta = datetime.timedelta(0, 3600)
endDate = startDate + windowDelta
# endDate: datetime.datetime(2014, 5, 31, 15, 0)

#%% [markdown]
# The following computes the Simple Frequency Ratio (cell 6 in lab sheet).

#%%
"""
Use the Simple Frequency Ratio to compute trending words between each window (in this lab, it is just between adjacent
time periods, i.e.,. hour).
"""

import numpy as np
from operator import itemgetter

# threshold to determine if a word is 'trending' between two windows
# parameter to explore
trendThresholdFreq = 10

# construct dates
startDate1 = startDate
endDate1 = startDate1 + windowDelta

# maximum ratios for each word
dMaxWordRatio = {}
# time series of ratios for each word, will be used for time series illustration in following cells
dlWordRatio = {}


# loop through each adjacent set of 1 hour 'windows'
for t in range(len(ldFreq)-1):
    expFreq = ldFreq[t]
    obsFreq = ldFreq[t+1]
    # need to compute union to ensure we compare all possible words between expected and observed windows/periods
    unionWords = set(expFreq).union(set(obsFreq))
    
    # store ratios between each window
    dRatio = {}
    
    for word in unionWords:
        dRatio[word] = 0
        # only for the case that expected and observed frequencies are non-zero is the ratio not zero
        if word in expFreq and word in obsFreq:
            dRatio[word] = float(obsFreq[word]) / expFreq[word]
            updateRatio(dMaxWordRatio, word, dRatio[word])

    # print out periods
    print('Trending words between times ' + str(startDate1) + ' and ' + str(endDate1))
    startDate1 = endDate1
    endDate1 = endDate1 + windowDelta
    
    # print out top words between each window
    for k, v in sorted(dRatio.items(), key=itemgetter(1), reverse=True):
        if v > trendThresholdFreq:
            print('{0:s}: {1:.2f}'.format(k,v))
            # add to word ratios we want to print
            if k not in dlWordRatio:
                dlWordRatio[k] = np.zeros(len(ldFreq))    
            dlWordRatio[k][t+1] = v

            

#%% [markdown]
# The following plots the keyword frequencies and ratios (cell 7 in lab sheet).

#%%
"""
Plot keywords frequencies and ratios.
"""
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.dates as mdates

# number of keywords we want to plot in time series
keywordNum = 5

lKeywords = [w for w, v in sorted(dMaxWordRatio.items(), key=itemgetter(1), reverse=True)[:keywordNum]]
llKeywordFreq = []
for i in range(len(lKeywords)):
    llKeywordFreq.append([])

# extract frequency data into a dataframe to plot with pandas
for i,dFreq in enumerate(ldFreq):
    for j, keyword in enumerate(lKeywords):
        llKeywordFreq[j].append(dFreq[keyword])

        
endDate2 = startDate + windowDelta
lDates = []
for i,dFreq in enumerate(ldFreq):
    lDates.append(endDate2)
    endDate2 = endDate2 + windowDelta

# plot each figure for keywords
for k, keyword in enumerate(lKeywords):
    idx = pd.DatetimeIndex(lDates)
    mySeries = pd.Series(llKeywordFreq[k], index=idx)
    mySeries2 = pd.Series(dlWordRatio[keyword], index=idx)

    # we plot both frequencies and ratios on the same plot and using the same x-axis (time)
    fig, ax = plt.subplots()
    ax.grid(True)
    ax.set_title("Top trending words using Freq. ratios: " + keyword)
    days = mdates.DayLocator(interval=24)
    date_formatter = mdates.DateFormatter('%m-%d')

    firstColour = 'tab:blue'
    secondColour = 'tab:red'
    # first plot word frequency
    ax.xaxis.set_major_locator(days)
    ax.xaxis.set_major_formatter(date_formatter)
    ax.set_ylabel('freq', color=firstColour)
    ax.plot(mySeries.index, mySeries, color=firstColour)

    # now plot the ratio
    ax2 = ax.twinx()
    ax2.set_ylabel('Ratio', color=secondColour)
    ax2.plot(mySeries.index, mySeries2, color=secondColour, alpha=0.5)

    fig.tight_layout()


# -----------------------------------------------------------------------------

#%% [markdown]
# In a nutshell:

def burstiness(observed, expected):

	# • If observed > expected, then burstiness score is:	
	if observed > expected:
		

# 𝑂−𝐸/𝐸
  # otherwise IfE=0:
# • Add one smoothing ((𝑂+1)−(𝐸+1))^2 / E + 1 = (𝑂−𝐸)^2 / E + 1
# $$\frac{((O+1)-(E+1))^{2}}{E+1}=\frac{(O-E)^{2}}{E+1}$$


# 𝐸+1 𝐸+1
   # • If low frequencies still dominate, use thresholds or Yate’s
# |𝑂 − 𝐸| − 0.5 𝐸
# correction:
# 2

#%%




