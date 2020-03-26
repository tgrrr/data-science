from src.api import * # twitterAuth, twitterClient

# Test API works: return one of my own tweets
auth = twitterAuth()
api = tweepy.API(auth,wait_on_rate_limit=True)
public_tweets = api.home_timeline()
# 
for tweet in public_tweets:
    print(tweet.text)
    
# auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
# auth.set_access_token(access_token, access_token_secret)
# api = tweepy.API(auth,wait_on_rate_limit=True)
