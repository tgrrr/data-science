# LATER: this code was at the top to import tweets
    %%
    def process(text, tokeniser=TweetTokenizer(), stopwords=[]):
        """
        Perform the processing.  We used a a more simple version than week 4, but feel free to experiment.
    
        @param text: the text (tweet) to process
        @param tokeniser: tokeniser to use.
        @param stopwords: list of stopwords to use.
    
        @returns: list of (valid) tokens in text
        """
    
        text = text.lower()
        tokens = tokeniser.tokenize(text)
    
        return [tok for tok in tokens if tok not in stopwords and not tok.isdigit()]
    %%
    
    TWitter parameters
    

    # FIXME:
    # Instead of own timeline, will retrieve the specified user's timeline (default is own timeline)
    # user = 'Scrapey4'
    # uncomment this to use own account (note you do need to have at least resultsToRetrieve number of tweets)
    user = None
    # The number of tweets to retrieve and print (default = 500)
    resultsToRetrieve = 500
    %%
    """
    Performs topic modelling on a twitter timeline.
    """
    
    # use built-in nltk tweet tokenizer
    # there is definitely scope to improve this
    tweetTokenizer = TweetTokenizer()
    punct = list(string.punctuation)
    stopwordList = stopwords.words('english') + punct + ['rt', 'via', '...']
    
    from src.data.auth.twitterClient import * # twitterAuth, twitterClient
    import tweepy

    _auth = twitterAuth()
    api = tweepy.API(
        _auth,
        # wait_on_rate_limit=True,
        # BUG: parser=tweepy.parsers.JSONParser() see: https://github.com/tweepy/tweepy/issues/538
        )

    construct twitter client
    FIXME: client = twitterClientOwn.twitterClient()

    client = twitterClient()


    this will store the list of tweets we read from timeline
    lTweets = []
    # own timeline
    if user == None:
        for tweet in Cursor(client.home_timeline).items(resultsToRetrieve):
            lTokens = process(text=tweet.text, tokeniser=tweetTokenizer, stopwords=stopwordList)
            lTweets.append(' '.join(lTokens))
    # else retrieve timeline of specified user (available in user parameter)
    else:
        for tweet in Cursor(client.user_timeline, id=user).items(resultsToRetrieve):
            lTokens = process(text=tweet.text, tokeniser=tweetTokenizer, stopwords=stopwordList)
            lTweets.append(' '.join(lTokens))
