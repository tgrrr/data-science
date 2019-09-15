#
# COSC2671 Social Media and Network Analytics
# @author Jeffrey Chan, 2019
# @author updated Phil Steinke 2019
#

import sys
import tweepy as tw
import os
from dotenv import load_dotenv

load_dotenv(verbose=True)
_TWITTER_ACCESS_TOKEN = os.getenv("TWITTER_ACCESS_TOKEN")
_TWITTER_ACCESS_TOKEN_SECRET = os.getenv("TWITTER_ACCESS_TOKEN_SECRET")
_TWITTER_CONSUMER_KEY = os.getenv("TWITTER_CONSUMER_KEY")
_TWITTER_CONSUMER_SECRET = os.getenv("TWITTER_CONSUMER_SECRET")

def twitterAuth():
    """
        Setup Twitter API authentication.
        Replace keys and secrets with your own.

        @returns: tweepy.OAuthHandler object
    """

    try:
        consumerKey = _TWITTER_CONSUMER_KEY
        consumerSecret = _TWITTER_CONSUMER_SECRET
        accessToken = _TWITTER_ACCESS_TOKEN 
        accessSecret = _TWITTER_ACCESS_TOKEN_SECRET
        
        auth = tw.OAuthHandler(consumerKey, consumerSecret)
        auth.set_access_token(accessToken, accessSecret)

        return auth

    except KeyError:
        sys.stderr.write("Key or secret token are invalid.\n")
        sys.exit(1)

def twitterClient():
    """
        Setup Twitter API client.

        @returns: tweepy.API object
    """

    auth = twitterAuth()
    client = tw.API(auth)
    return client
