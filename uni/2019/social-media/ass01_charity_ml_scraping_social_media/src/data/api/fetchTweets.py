import tweepy
import json
from src.data.auth import * # twitterAuth, twitterClient
from src.data.auth.twitterClient import * # twitterAuth, twitterClient
from src.data.api import * # fetchTweets, twitterScraper
from src.data import *

def better_twitter_api_parse(tweet):
    """
    # eg. fetchTweets('charity', '2019-01-01')
    """

    out = []

    if 'retweeted_status' in tweet._json:
        # print('Retweeted')
        
        _full_text = (tweet._json['retweeted_status']['full_text'])

    else:
        # print('tweet')
        _full_text = json.dumps(tweet.full_text)

    try:
        # print('hashtags!')
        hashtags = tweet.entities['hashtags']
    except Exception as e:
        print('Error: %s', e)
        hashtags = []

    out.append(_full_text)
    out.append(hashtags)

    # return {_full_text, *hashtags}
    return(out)

    # return {'full_text': _full_text, 'hashtags': hashtags, }

def tweepy_item(tweepyParams, api):
    # _auth = twitterAuth()
    # api = tweepy.API(
    #     _auth,
    #     # wait_on_rate_limit=True,
    #     # BUG: parser=tweepy.parsers.JSONParser() see: https://github.com/tweepy/tweepy/issues/538
    #     )

    # tweepyParams = {
    #     "q": search_term,
    #     "count": 1,
    #     "include_entities": True,
    #     "lang": "en",
    #     "monitor_rate_limit": True, 
    #     "result_type": 'recent',
    #     "since": start_date,
    #     "wait_on_rate_limit": True,
    #     "tweet_mode": "extended",
    # }

    # start_date = '2018-08-01'
    # search_term = '"charity"%20(machintodo1e%20OR%20learning%20OR%20artificial%20OR%20intelligence)%20(%23ml%20OR%20%23ai)'

    tweets_formatted = []
        
    for tweet in tweepy.Cursor(api.search,
                            **tweepyParams,
                            ).items():
        try:
            out = better_twitter_api_parse(tweet)

            created_at = datetimeConvertToString(tweet.created_at)

            _hashtags = tweet.entities['hashtags']
            hashtags = []
            for h in _hashtags:
                hashtags.append(h['text'])
            
            user_id = tweet.user.id

            user_mentions = tweet.entities['user_mentions']

            outputFormat = [
                out[0], # full_text
                created_at,
                user_id,
                # user_mentions,
                hashtags,
                # tweet.text.encode('utf-8'), 
                # _tweet.user.screen_name,
                # _tweet.user.friends_count,
                # _tweet.user.followers_count,
            ]

            # TODO: rename tweets_formatted
            # TODO: turn tweet, full_text into single json
            tweets_formatted.append(outputFormat)
            
        except tweepy.TweepError as e:
            print('error in tweepy_item')
            print('Error: %s', e)
        except Exception as e:
            print('error in tweepy_item')
            print('Error: %s', e)
            print('Something else went wrong during the api query')

    with open('data.txt', 'w') as text_file:
        print(f"{tweets_formatted}", file=text_file)

    text_file.close()
    
    # statuses = []
    # for s in tweepy.Cursor(api.user_timeline, id=PROFILE_HANDLE).items(10):
    #     print "We have currently fetched %d tweets" % len(statuses)
    #     statuses.append(s)

def fetchTweets(search_term, start_date):
    """
    @summary: Fetch Tweets using Tweepy
    @author:  Phil S

    eg. fetchTweets('charity', '2019-01-01')

    @param    search_term: Description of parameter `search_term`.
    @type:    string

    @param    start_date: Date formatted string `start_date`.
    @type:    string

    @return:  None

    api docs: http://docs.tweepy.org/en/v3.5.0/api.html#API.search

    TODO:
    @doctests:
    >>> [fetchTweets(n, n) for n in range(6)]
    [1, 1, 2, 6, 24, 120]
    """
    
    _auth = twitterAuth()
    api = tweepy.API(
        _auth,
        # wait_on_rate_limit=True,
        # BUG: parser=tweepy.parsers.JSONParser() see: https://github.com/tweepy/tweepy/issues/538
        )

    tweepyParams = {
        "q": search_term,
        "count": 20000,
        "include_entities": True,
        "lang": "en",
        "monitor_rate_limit": True, 
        "result_type": 'recent',
        "since": start_date,
        "wait_on_rate_limit": True,
        "tweet_mode": "extended",
    }
        # other possible tweepy params:
        # rpp=1,
        # page=1,
        # until: '2017-02-17',

    try:
        print('Fetch Tweets')
        tweepy_item(tweepyParams, api)

    except Exception as e:
        print('Error in fetchTweets: %s', e)
        print('Non-tweepy error')

    finally:
        os.system( 'say beep' )
        print('And... donesky')
