
import re

def doGetHashtags(
    fName = 'data/raw/with-hashtags/data-array-with-hashtags.txt',
    tweetThres = 50,
    ):

    fName = 'data/raw/with-hashtags/data-array-with-hashtags.txt'

    from collections import Counter

    hashtags = []
    # our term frequency counter
    termFreqCounter = Counter()

    with open(fName, 'r') as f:
        for line in f:
            try:
                tweet_line_as_string = "".join(str(x) for x in line)
                m = tweet_line_as_string.split('[', 1)[1].split(']')[0]
                m = m.replace('\'', '')

                if(m != ''):
                    tweet_hashtags = [x.strip() for x in m.split(',')]
                    for hashtag in tweet_hashtags:
                        hashtag = hashtag.lower()
                        hashtags.append(hashtag)
            except:
                print('')

        # update count
        termFreqCounter.update(hashtags)

    freqNum = tweetThres
    for term, count in termFreqCounter.most_common(freqNum):
        print(term + ': ' + str(count))


# # %%
# #
# # COSC2671 Social Media and Network Analytics
# # @author Jeffrey Chan, 2019
# #
# # %%
# def getHashtags(tweet):
#     """
#     Extracts the associated hashtags of tweet.
# 
#     @param tweet: The tweet, which is in the tweepy json format, and which we wish to extract its associated hashtags.
# 
#     @returns: list of hashtags (in lower case)
#     """
#     entities = tweet.get('entities', {})
#     hashtags = entities.get('hashtags', [])
# 
#     return [tag['text'].lower() for tag in hashtags]
# # %%
# from collections import Counter
# import json
# import os
# script_dir = os.path.dirname(__file__)
# 
# def doGetHashtags(
#     fJsonName = 'rmitCsTwitterTimeline.json',
#     tweetThres = 30,
#     ):
# 
#     # load json file
#     # TODO: note usually we would do some checks, but for clarify's sake we haven't implement that code here
#     # fJsonName = 'rmitCsTwitterTimeline.json'
# 
#     # number of tweets to display
#     # tweetThres = 50
# 
#     # open file and use Counter to count the number of times the hash tags appears
#     with open(fJsonName, 'r') as f:
#         hashtagsCounter = Counter()
#         # for each line in file (which corresponds to a tweet), load it, get the hashtags and insert them into the
#         # Counter
#         for line in f:
#             tweet = json.loads(line)
#             hashtagsInTweet = getHashtags(tweet)
#             # print(hashtagsInTweet)
#             hashtagsCounter.update(hashtagsInTweet)
# 
#         for tag, count in hashtagsCounter.most_common(tweetThres):
#             print(tag + ": " + str(count))
