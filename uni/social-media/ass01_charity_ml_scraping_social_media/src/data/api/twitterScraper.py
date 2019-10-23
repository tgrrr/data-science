from src.data import *
import json

def handle_fulltext_twitter_json_loc(tweet):
    # if hasattr(tweet, 'retweeted_status'):
    if 'retweeted_status' in tweet._json:
        _full_text = (tweet._json['retweeted_status']['full_text'])

    else:
        _full_text = json.dumps(tweet.full_text)

    return _full_text
