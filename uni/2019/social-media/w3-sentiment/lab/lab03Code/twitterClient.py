#
# COSC2671 Social Media and Network Analytics
# @author Jeffrey Chan, 2019
#

import sys
import tweepy as tw


def twitterAuth():
    """
        Setup Twitter API authentication.
        Replace keys and secrets with your own.

        @returns: tweepy.OAuthHandler object
    """

    try:
        consumerKey = "..."
        consumerSecret = "..."
        accessToken = "..."
        accessSecret = "..."
    except KeyError:
        sys.stderr.write("Key or secret token are invalid.\n")
        sys.exit(1)

    auth = tw.OAuthHandler(consumerKey, consumerSecret)
    auth.set_access_token(accessToken, accessSecret)

    return auth



def twitterClient():
    """
        Setup Twitter API client.

        @returns: tweepy.API object
    """

    auth = twitterAuth()
    client = tw.API(auth)

    return client
