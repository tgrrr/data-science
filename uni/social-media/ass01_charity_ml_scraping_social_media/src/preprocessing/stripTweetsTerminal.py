
import collections.abc
import os
os.chdir('/Users/phil/code/data-science-next/uni/social-media/ass01_charity_ml_scraping_social_media')

def isString(obj):
    # is not string:
    if isinstance(obj, collections.abc.Sequence) and not isinstance(obj, str):
        # "obj is a sequence (list, tuple, etc) but not a string")
        return False
    else:
        return True

# --------------

# TODO: move to function in preprocessing folder
import re,string
import json
# from src.common.util import *


# credit: https://stackoverflow.com/a/38119388/3281978
# NOTE: data['result'] = data['result'].map(lambda x: x.lstrip('+-').rstrip('aAbBcC'))
def strip_links(text):
    link_regex    = re.compile('((https?):((//)|(\\\\))+([\w\d:#@%/;$()~_?\+-=\\\.&](#!)?)*)', re.DOTALL)
    links         = re.findall(link_regex, text)
    for link in links:
        text = text.replace(link[0], ' ')    
    return text

def strip_all_entities(text):
    entity_prefixes = ['@','#']
    for separator in  string.punctuation:
        if separator not in entity_prefixes :
            text = text.replace(separator, ' ')
    words = []
    for word in text.split():
        word = word.strip()
        if word:
            if word[0] not in entity_prefixes:
                words.append(word)
    return ' '.join(words)

def remove_newline(text):
    # remove all underscores:
    text = text.replace('\\n', '')
    return text

def remove_underscore(text):
    # remove all underscores:
    text = text.replace('_', '')
    return text

def strip_unicode_characters(text):
    # str="\x01\x02\x10\x13\x20\x21hello world"
    # print(text)
    escapes = ''.join([chr(char) for char in range(1, 32)])
    t = text.translate(None, escapes)
    t

# NOTE: not used in code
def remove_unicode(sentence):
    """
    removed any unicode
    """

    # `ignore` handles errors while encoding to ascii, which strips everything
    sentence.encode('ascii', 'ignore').decode('utf8')

    # result = []
    # for word in sentence.split():
    #     word.encode('ascii', 'ignore').decode('utf8')
    #     if word.isalnum():
    #         result.append(''.join(map(str, word)))
    #         out = ' '.join(_word for _word in result)
    # print(out)

def do_strip_tweet(text):
    _tweet_without_newlines = remove_newline(text)
    _tweet_without_underscore = remove_underscore(_tweet_without_newlines)
    # _tweet_without_unicode = remove_unicode(_tweet_without_underscore)
    stripped = strip_all_entities(strip_links(_tweet_without_underscore))
    return stripped

def strip_twitter_special_characters(tweets):
    """
    Function to apply updates
    Works for strings and lists    
    """
    if(isString(tweets)):
        tweet = tweets # handle a single tweet
        stripped = do_strip_tweet(tweet)
        return(stripped)
    else:
        stripped_tweets = []
        for tweet in tweets:
            stripped = do_strip_tweet(tweet)
            stripped_tweets.append([stripped])
        return(stripped_tweets)
        
def decode_byte_to_string(tweet):
    # deal with tweet full text
    tweet_text_wrong_datatype = tweet.get('full_text', '')
    # HACK: because it imports as string, however, it is a byte:
    tweet_text_bytes = eval(tweet_text_wrong_datatype.encode('ascii', 'ignore').decode('utf8'))
    tweet_text_string = tweet_text_bytes.decode('utf8')
    return(tweet_text_string)

def strip_tweet(
    fJsonName, 
    out='data.json'
    ):
    with open(fJsonName) as f:
        tweets_proccessed = []

        for line in f:
            tweet = json.loads(line)

            tweet_text_string = decode_byte_to_string(tweet)
            stripped = strip_twitter_special_characters(tweet_text_string)
            print(stripped)

            # append the stripped text to our json as tweets_proccessed
            tweet.update({'full_text_stripped' : stripped})

            tweets_proccessed.append(tweet)
                    
        f.close()

    with open(out, 'w') as outfile:
        json.dump(tweets_proccessed, outfile)

import os

class Constants:
    path = "/Users/phil/code/data-science-next/uni/social-media/ass01_charity_ml_scraping_social_media/"

os.chdir(Constants.path)

        
fJsonName = 'data/raw/charity_tweets_11110.json'
out = 'data/processed/data.json'
strip_tweet(fJsonName, out)
