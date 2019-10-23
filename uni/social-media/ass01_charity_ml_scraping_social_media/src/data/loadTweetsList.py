import json

def load_tweets_list(
    fName = 'data/processed/data.json',
    ):
    """
    @summary: Loads a list of tweet strings from list of dictionaries.
    @author:  Phil S

    @param    fName: json filename `fName`.
    @type:    list of dictionaries NOT JSON

    @return:  list of tweets.
    @rtype:   list

    """
    # fName = 'data/processed/data.json'
    # TODO: refactor into load_tweets_list()
    with open(fName) as f:    
        data_json = json.load(f)

    lTweets = []
    for json_dict in data_json:
        stripped_tweet_text = json_dict['full_text_stripped']
        # print(stripped_tweet_text)
        lTweets.append(stripped_tweet_text)
    
    return lTweets
