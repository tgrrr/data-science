# To add a new cell, type '#%%'
# To add a new markdown cell, type '#%% [markdown]'
#%% Change working directory from the workspace root to the ipynb file location. Turn this addition off with the DataScience.changeDirOnImportExport setting
# ms-python.python added
from tweepy import Cursor
import os
try:
	os.chdir(os.path.join(os.getcwd(), 'w3-sentiment/lab/lab03CodeAns'))
	print(os.getcwd())
except:
	pass
#%%
from IPython import get_ipython


#%%
#
# COSC2671 Social Media and Network Analytics
# @author Jeffrey Chan, 2019
#


#%%
get_ipython().run_line_magic('load_ext', 'autoreload')
get_ipython().run_line_magic('autoreload', '1')
get_ipython().run_line_magic('aimport', 'twitterClientOwn')


#%%


#%%
client = twitterClientOwn.twitterClient()


#%%
# retrieve the first 10 tweets in your timeline
for tweet in Cursor(client.home_timeline).items(10):
    # print out the tweet's text content
    print(tweet.text)


#%%
