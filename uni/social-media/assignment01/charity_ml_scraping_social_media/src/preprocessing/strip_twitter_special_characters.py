import re,string
from src.common.util import *

# credit: https://stackoverflow.com/a/38119388/3281978
# NOTE: data['result'] = data['result'].map(lambda x: x.lstrip('+-').rstrip('aAbBcC'))
def strip_links(text):
    link_regex    = re.compile('((https?):((//)|(\\\\))+([\w\d:#@%/;$()~_?\+-=\\\.&](#!)?)*)', re.DOTALL)
    links         = re.findall(link_regex, text)
    for link in links:
        text = text.replace(link[0], ', ')    
    return text

def strip_all_entities(text):
    entity_prefixes = ['@','#']
    for separator in  string.punctuation:
        if separator not in entity_prefixes :
            text = text.replace(separator,' ')
    words = []
    for word in text.split():
        word = word.strip()
        if word:
            if word[0] not in entity_prefixes:
                words.append(word)
    return ' '.join(words)

def remove_newline(str):
    # remove all underscores:
    str = str.replace("\\n", "")
    return str

def remove_underscore(str):
    # remove all underscores:
    str = str.replace("_", "")
    return str

def strip_unicode_characters(_str):
    # str="\x01\x02\x10\x13\x20\x21hello world"
    # print(_str)
    escapes = ''.join([chr(char) for char in range(1, 32)])
    t = _str.translate(None, escapes)
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

def do_strip_tweet(str):
    _tweet_without_newlines = remove_newline(str)
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