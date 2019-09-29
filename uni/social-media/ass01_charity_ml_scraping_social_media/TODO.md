# TODO

text = text.lower()

topydo
- from GTD
`/commands/` folder

@focus
Update name of processing tweet functions. They do different things

- [ ] LATER: getHashtags from src.api.twitter.getHashtags

LATER: Tweepy errors:
https://www.programcreek.com/python/example/13279/tweepy.TweepError


<!-- # search_term = 'chatbots'
# search_term = 'charity%20artificial%20intelligence'
# search_term = 'charity'
# search_term = '"charity"%20(machine%20OR%20learning%20OR%20artificial%20OR%20intelligence)%20(%23ml%20OR%20%23ai)' -->


def log_tweep_error(logger, tweep_error):
    """Log a TweepError exception."""
    if tweep_error.api_code:
        if tweep_error.api_code == 32:
            logger.error("invalid API authentication tokens")
        elif tweep_error.api_code == 34:
            logger.error("requested object (user, Tweet, etc) not found")
        elif tweep_error.api_code == 64:
            logger.error("your account is suspended and is not permitted")
        elif tweep_error.api_code == 130:
            logger.error("Twitter is currently in over capacity")
        elif tweep_error.api_code == 131:
            logger.error("internal Twitter error occurred")
        elif tweep_error.api_code == 135:
            logger.error("could not authenticate your API tokens")
        elif tweep_error.api_code == 136:
            logger.error("you have been blocked to perform this action")
        elif tweep_error.api_code == 179:
            logger.error("you are not authorized to see this Tweet")
        else:
            logger.error("error while using the REST API: %s", tweep_error)
    else:
        logger.error("error with Twitter: %s", tweep_error) 
        
        
        # %%
        #
        # COSC2671 Social Media and Network Analytics
        # @author Jeffrey Chan, 2019
        #
        # %%
        %load_ext autoreload
        %autoreload 1
        %aimport twitterClientOwn
        # %%
        from tweepy import Cursor
        # %%
        client = twitterClientOwn.twitterClient()
        # %%
        # retrieve the first 10 tweets in your timeline
        for tweet in Cursor(client.home_timeline).items(10):
            # print out the tweet's text content
            print(tweet.text)

        # %%


        # Test API works: return one of my own tweets
        # auth = twitterAuth()
        # api = tweepy.API(auth,wait_on_rate_limit=True)
        # public_tweets = api.home_timeline()
        # # 
        # for tweet in public_tweets:
        #     print(tweet.text)
            
        # auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
        # auth.set_access_token(access_token, access_token_secret)
        # api = tweepy.API(auth,wait_on_rate_limit=True)
        # ---------------------------------------------------------

