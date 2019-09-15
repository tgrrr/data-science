# 76 Line version Question
# %%
#
# COSC2671 Social Media and Network Analytics
# @author Jeffrey Chan, 2019
# LATER: @author Phil Steinke, 2019 UPDATED
#
# %%
def processTweet(text, tokenizer, stemmer, stopwords):
    """
    Perform tokenisation, normalisation (lower case and stemming) and stopword and twitter keyword removal.

    @param text: tweet text
    @param tokenizer: tokeniser used.
    @param stemmer: stemmer used.
    @param stopwords: list of stopwords used

    @returns: a list of processed tokens
    """

    # covert all to lower case
    text = text.lower()
    # tokenise
    lTokens = tokenizer.tokenize(text)
    # strip whitespaces before and after
    lTokens = [token.strip() for token in lTokens]
    # stem (we use set to remove duplicates)
    lStemmedTokens = set([stemmer.stem(tok) for tok in lTokens])

    # remove stopwords, digits
    return [tok for tok in lStemmedTokens if tok not in stopwords and not tok.isdigit()]

# %%
import sys
import json
import string
from collections import Counter
import nltk

# %%

# New function:
def doProcessTweet(
    fJsonName, 
    key = 'full_text', 
    freqNum = 10,
    ):
    
    # tweet tokeniser to use
    tweetTokeniser = nltk.tokenize.TweetTokenizer()
    # use the punctuation symbols defined in string.punctuation
    lPunct = list(string.punctuation)
    # use stopwords from nltk and a few other twitter specific terms like 'rt' (retweet)
    lStopwords = nltk.corpus.stopwords.words('english') + lPunct + ['rt', 'via']
    # we use the popular Porter stemmer
    tweetStemmer = nltk.stem.PorterStemmer()

    # our term frequency counter
    termFreqCounter = Counter()

    # open json file and process it tweet by tweet
    with open(fJsonName, 'r') as f:
        for line in f:
            tweet = json.loads(line)
            tweetText = tweet.get(key, '')
            # tokenise, filter stopwords and get convert to lower case
            lTokens = processTweet(text=tweetText, tokenizer=tweetTokeniser, stemmer=tweetStemmer, stopwords=lStopwords)
            # update count
            termFreqCounter.update(lTokens)

    # print out most common terms
    for term, count in termFreqCounter.most_common(freqNum):
        print(term + ': ' + str(count))