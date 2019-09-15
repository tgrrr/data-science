import tweepy
import json
from src.data.auth import * # twitterAuth, twitterClient
from src.data.auth.twitterClient import * # twitterAuth, twitterClient
from src.data.api import * # twitterAuth, twitterClient
from src.data import *

def better_twitter_api_parse(tweet):
    """
    # eg. fetchTweets('charity', '2019-01-01')
    """

    out = []

    if 'retweeted_status' in tweet._json:
        print('Retweeted')
        
        _full_text = (tweet._json['retweeted_status']['full_text'])

    else:
        print('tweet')
        _full_text = json.dumps(tweet.full_text)

    try:
        print('hashtags!')
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

    tweets_formatted = []
    
    for tweet in tweepy.Cursor(api.search,
                            **tweepyParams,
                            ).items():
        try:

            out = better_twitter_api_parse(tweet)
            # print(out)
            # full_text, hashtags = better_twitter_api_parse(tweet)
            foo = out[1]
            print(foo)
            print(type(foo))
            # _full_text = better_twitter_api_parse(tweet)
            _created_at = datetimeConvertToString(tweet.created_at)

            # @focus the problem is I can get the list of retweets.
            # but I can't then include it in the output format.
            # BAM!

            outputFormat = {
                out[0], # full_text
                _created_at,
                tweet.user.id,
                # *foo, # hashtags
                # tweet.text.encode('utf-8'), 
                # _tweet.user.screen_name,
                # _tweet.user.friends_count,
                # _tweet.user.followers_count,
            }

            # TODO: rename tweets_formatted
            # TODO: turn tweet, full_text into single json
            # tweets_formatted.append(tweet, _full_text)
            tweets_formatted.append(outputFormat)

            # disabled: for json (our next library requires json)
            # writeToCsv(tweet, _full_text)
            
        except tweepy.TweepError as e:
            print('Error: %s', e)
        except Exception as e:
            print('Error: %s', e)
            print('Something else went wrong during the api query')
    
    # TODO: test if empty, and appends to json file (doesn't overwrite)

# ------------------------------------------
    writeToJson(tweets_formatted)
     # file:

    print(tweets_formatted)

    # NEXTUP: move this outside writeToJson, and pass the entire object in
    # statuses = []
    # for s in tweepy.Cursor(api.user_timeline, id=PROFILE_HANDLE).items(10):
    #     print "We have currently fetched %d tweets" % len(statuses)
    #     statuses.append(s)

    # TODO: show which part of 
    # with open('data.json', 'w') as outfile:
    #     json.dump(tweets_out, outfile, indent=4)

# ------------------------------------------

# def dofetchTweets(_search_term, tweepyParams):
def fetchTweets(search_term, start_date):
    """
        Fetch Tweets using Tweepy
        
        eg. fetchTweets('charity', '2019-01-01')

        @returns:
        api: http://docs.tweepy.org/en/v3.5.0/api.html#API.search
    """
    _auth = twitterAuth()
    api = tweepy.API(
        _auth,
        # wait_on_rate_limit=True,
        # BUG: parser=tweepy.parsers.JSONParser() see: https://github.com/tweepy/tweepy/issues/538
        )

    tweepyParams = {
        "q": search_term,
        "count": 1,
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
        print('Error: %s', e)
        print('Non-tweepy error')

    finally:
        os.system( 'say beep' )
        print('And... donesky')
        
    # dofetchTweets(search_term, tweepyParams)
