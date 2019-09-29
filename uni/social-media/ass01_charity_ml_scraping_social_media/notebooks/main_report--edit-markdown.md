%% markdown

## COSC2671 Social Media and Network Analytics
### Assignment 1
### @author Phil Steinke, 2019

%% markdown

## Introduction

*Describe what/who is your selected entity*

I'm searching for sentiment analysis about the topic `Charity` on Twitter

*Describe why it is interesting to find the sentiment and topics (answer questions) of this entity*
A: Given the heart foundations recent [controversy](https://www.abc.net.au/news/2019-05-31/heart-foundation-apologises-for-heartless-words-ad-campaign/11167870) I became interested in how people feel about charities.

Eg. Are people generally positive about charity? Or do they have 'compassion fatigue'? Can organisations like the Heart foundation justify shocking people into doing what they want?

> please-note: All code chunks are available at [github/tgrrr/data-science](https://github.com/tgrrr/data-science/tree/social-media-assignment1/uni/social-media/assignment01)

%%

packages
python scripts
import os
import pdb

from src.common.util import *
from src.config.constants import Constants
os.chdir(Constants.path)

%% markdown

## 0. Data Collection

*Describe how you collected the data, and briefly why you chose that approach (restful vs stream)*

- Data was scraped via REST interface via Tweepy API
- I initially scrapped the data into a `csv`, then a `json` with the format:
 
```
[{tweet1}, {tweet2}, {tweet3}]
```

I then discovered that the code was well written, however I had confused the output as json, when it was actually a lines of `dictionaries`:

```
{tweet1}
{tweet2}
{tweet3}
```

- This means that I have rewritten some of the code to work for json, rather than dictionaries
- Filenames for data using the dictionaries is denoted with `-multi-json`

Initially, we searched for multiple terms with the search term: 

```
"charity" (data OR science OR artificial OR intelligence OR machine OR learning OR ai OR ml)
```

However, searching for multiple results on Twitter returned only a handful of
results with Tweepy, compared to the twitter website

%%
from src.data.api import * # includes fetchTweets

# params:
start_date = '2018-08-01'
search_term = '"charity"%20(machintodo1e%20OR%20learning%20OR%20artificial%20OR%20intelligence)%20(%23ml%20OR%20%23ai)'
fetchTweets(search_term, start_date)

%% markdown

The dataset is not big enough, so we can refine our scrape to charity:

%%
search_term = 'charity'
please note: only run this once, it's an expensive function
fetchTweets(search_term, start_date)

%% markdown

## 1. Data Pre-processing and Data Cleaning

### What obstacles do we need to overcome?

- **Obstacle:** Twitter text is trunicated
- **Solution:** wrote function `handle_fulltext_twitter_json_loc(tweet)` to deal 
with getting full text from tweets. Because `full_text` is present in a 
different location in the json for retweets and regular tweets
see: http://docs.tweepy.org/en/latest/extended_tweets.html#examples

Also note that I filtered the returned tweets to only include the:
- `tweet`
- `date`
- `userId`

- TODO:  Plot some graphs, etc to show why you decided to do those pre-processing


%% markdown

**Convert CSV to json**

Initially I scraped into a `csv`, so this code converts it into json format:

%%
from src.preprocessing import * # convert_csv_to_json

colnames=['full_text', 'date', 'id'] 
convert_csv_to_json('data/raw/charity_tweets_11110', colnames)

%% markdown

#### About the data

- TODO: Report some statistics of your collected data
- [x] A few thousand tweets per week in your data.
> 11110 tweets collected

%%

lengths = [len(i) for i in my_list]

#### Show examples of noisy data

#####**Sample tweet:**

Lets grab a sample tweet. From the scraper we get:

> `'b"don\'t use just #artificialintelligence for the sake of it. #AI needs to solve a problem - @somenmondal @ideal What kind of problems could #AI solve in your #charity? https://t.co/BaO22oyQDW"'`

After conversion, we would like:

> `don't use just artificialintelligence for the sake of it. AI needs to solve a problem - What kind of problems could AI solve in your charity?`


### - [x] Describe what pre-processing you performed

- Each of the tweets when we get the full_text tweet starts with `b'`
Initially, this appears as byte data, however, it's actually a string
-  Special characters are \\xf0\\x9f\\xa4\\x96, etc and escaped
-  Remove links
-  Remove @usernames
-  Remove #hashtags

%%

FIXME: after MD do I need this bit?
df = 'data/raw/charity_tweets_11110.json'
df.head()
df = pd.DataFrame(df,columns=['text',  'date',  'user_id'])

%% markdown

### Decode utf8

##### Why do we need to decode it again to utf8?

If we sample a part of our encoded text:

%%
encoded_sample = b'didn\xe2\x80\x99t'
type(encoded_sample) # bytes
# however, the:
type(tweet) # `string` of our tweet
b'didn\xe2\x80\x99t'.decode('utf-8') # output is `didn't`
# So reformatting it to utf-8 works

%% markdown

#### Function to remove @username, #hashtags, links, underscores, and escaped char

%% 

from src.preprocessing import *

fJsonName = 'data/raw/charity_tweets_sample_100.json'
out = 'data/processed/data_sample.json'
strip_tweet(fJsonName, out)

# please note: This is an expensive process, so run it in terminal using 
# `python preproccessing/stripTweetsTerminal.py`
fJsonName = 'data/raw/charity_tweets_11110.json'
out = 'data/processed/data.json'
strip_tweet(fJsonName, out)

%% markdown

### Demo stripping:
FIXME: does this demo work?

%%
import pandas as pd
test_tweets = [
      "The * Mooch*...apt nickname...you're not truthful so it's doubtful the * proceeds * go to any charity that isn't an LLC for *Mooch's Piggy Bank*... https://t.co/YA9pey2ljW",
    "FBI eyes Jones' charity, UAW officials' California junkets https://t.co/iQfIjLCyxL",
    "@johnpavlovitz @2LarryJohnson7 I hope Larry Johnson boxes you for charity.",
    "#TheBiblicalStandard it's only the HONORABLE MESSIAH who will help the church to reach the Bibilical standards. HE offered the Sarcrifice of attonment outside the gate on a tree for you and me to see GOD face to face.Uuuuuuuuii this is greater love."
]

cols = ['tweet']
df = pd.DataFrame(test_tweets, columns=cols)

test_tweet = df.iloc[1,0]
print(test_tweet)
# test_tweet = "b\The * Mooch*...apt nickname...you're not truthful so it's doubtful the * proceeds * go to any charity that isn't an LLC for *Mooch's Piggy Bank*... https://t.co/YA9pey2ljW"

# FIXME: pt2 for demo. This works in the test dataset
stripped_tweet = do_strip_tweet(test_tweets)
stripped_tweet

%% markdown

- [x] Are there characters that aren't useful for analysis

Note for future analysis:

- It would be great to analyse emojis for sentiment analaysis, so I have left them in
- In future, it would be great to separate out additional text and remove duplicate text in retweets

%% markdown

### 1.2 Initial Exploration (Pre-processing)

- TODO: top K unique hashtags

%%

# Top K unique words
from src.features import *
from src.preprocessing import *
from src.common.util import *

doProcessTweet('data/processed/data.json', 'full_text_stripped', 30)
doProcessTweet('data/processed/data.json', 'full_text_stripped', 30, isJson=True)

%%
TODO: after MD scrape it again, with hashtags and mentions
BUG: doGetHashtags('data/processed/data.json', 30)
BUG: doGetMentions('data/processed/data.json', 30)

%% markdown

- Please note that I was unable to scrape the tweet entities json because of bug in my code, so was unable to create the outputs for the above scripts

%% markdown

## 2. Analysis Methodology

- TODO: Describe what analysis you performed to answer the questions
- TODO: What type of sentiment analysis did you do?  Briefly explain your rationale for doing it as such.
- TODO: What type of topic modelling did you do?  Again, briefly explain your rationale for your approach.

%% markdown

- what are the topics been discussed about a user via a top-K terms

FIXME: after MD
> charities: 8703
> this: 1902
> raise: 1803
> donate: 1769
> money: 1440
> ha: 1390 
> help: 1309
> support: 1253
> world: 1221
> hi: 1121
> amp: 969
> ever: 938
> wa: 897 
> watch: 852
> create: 815
> people: 797
> day: 788
> clean: 768
> porn: 758
> ocean: 748
> dirtiest: 744
> thanks: 707
> work: 701
> us: 691
> get: 686
> go: 663
> one: 654
> year: 651
> please: 631


### Topic Analysis - what are the topics?

%%
from src.visualization import *
from src.data import *
lTweets_sample = load_tweets_list('data/processed/data_sample.json')
doDisplayWordcloud(lTweets_sample)

lTweets = load_tweets_list('data/processed/data.json')
doDisplayWordcloud(lTweets)

%% markdown
#### Topic Analysis Word Cloud

- **Topic 0:** charity new today work amp support event help local great helping looking need challenge charities
- **Topic 1:** like shop charity good month people luck yes life fantastic time 50 thank end receive
- **Topic 2:** charity match proceeds funds final organisations 16 hate million dedicated held alongside stadium distributed combatting
- **Topic 3:** charity amp donate amazing just year don ve make people going uk time aid great
- **Topic 4:** president charity donating 10 000 donate project help campaign let trump salary rich known vets
- **Topic 5:** charity raised donations world did million tour sell massive 29 harry 90 seconds styles years
- **Topic 6:** cancer charity want people support thank help link use saturday research way thanks august donated
- **Topic 7:** charity day september raising love team 2019 golf health community amp does know days family
- **Topic 8:** porn charity money raise world watch created clean dirtiest oceans home follow begins doesn girl
- **Topic 9:** charity money god heart like government taking jesus think doing amp head isn shops good

%% markdown

#### Sentiment Analysis

%%

from src.models import *
doSentimentAnalysis('data/processed/data_sample-multi-json.json')

%% markdown

*Fig1. Hourly sentiment analysis of the term Charity*
![image](../reports/figures/charity_sentiment_analysis_timeseries_count.png)

- There is no clear trend. It would be good to do time-series analysis on this data
- TODO: I adjusted the parameters could be adjusted for daily, hourly, weekly. However, the topic has no clear time-series trend, ACF, etc. 
- We would need a much longer sample of data to detect sentiment over seasonality. Eg. Are people more positive about charity near Christmas?
- It would be good to increase the dictionary of terms available for positive and negative sentiment


%% markdown

## Conclusion

- TODO: Provide a short conclusion about your entity, analysis and what you found
### Goals:
- [x] What are the trending concepts and topics associated with this person or event?
- [x] What are the perceptions and feelings towards this person or event?
- [x] Get Twitter data
- [x] Do market research

### Discussion of results (Discussion)

- Describe your data
- Outline and describe your approach, your findings and insights to the questions
- Use tables, plots/graphs, word clouds and other visualisations to help you communicate the results (in addition to text

**Does it correspond to recent news**

Yes, please see notes in introduction about Heart Foundation

**Other sources of information** 

- See comments about Red Cross above
- It would be good to examine other data sources

**If the results don’t correspond to background knowledge, why you think that is so?**

It does correspond to my background knowledge and understanding of the subject

##### Future Analysis

- If I expanded on this report, it would be good to find and separate our retweet text. In some cases, the retweet may include a comment which we can analyse the sentiment of. 
- In other cases, it would simply be a retweet, which has effected the topic and sentiment analysis

### Explain what the results indicate (Discussion)

The results indicate that there are positive and negative trends 

%% markdown

### Embed Sample of the Data (1st 1000 tweets)


[CSV sample of first 1000 tweets](https://github.com/tgrrr/data-science/blob/assignment%2Fmachine-learning-ass1/uni/social-media/assignment_1/charity_ml_scraping_social_media/data/raw/charity_tweets_sample_1000.csv)
[List of Dictionary sample of first 1000 tweets](https://github.com/tgrrr/data-science/blob/assignment%2Fmachine-learning-ass1/uni/social-media/assignment_1/charity_ml_scraping_social_media/data/raw/charity_tweets_sample_1000.json)

%% markdown

### Bibleography

Nothing cited

### Appendix for code

note: All code chunks are available at [github/tgrrr/data-science](https://github.com/tgrrr/data-science/tree/social-media-assignment1/uni/social-media/assignment01)


<!-- ### Initial Analysis

### Does the approach selected have parameters

A: Not particularly

### Would a different approach produce different answer?
A: Yes. Given _more_ time I would have a look at combinations of two 
or multiple word groups of sentences

%% markdown

### 2.1 Selection and Parameter choices (Methodology)

TODO: ### What effect does the parameter settings have on the results?

%% markdown

### 2.1 Justify parameters with explanations (Methodology)

%% markdown

## Analysis & Discussion -->

