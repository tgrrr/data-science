# %%
"""
COSC2671 Social Media and Network Analytics
@author Jeffrey Chan, 2018

"""


import networkx as nx
from argparse import ArgumentParser

import os
os.chdir('/Users/phil/code/data-science-next/uni/social-media/w9/lab09')

from redditClient import redditClient

import matplotlib.pyplot as plt
# %%
#Should print your userName if successful
client = redditClient()
print(client.user.me())
# %%

"""
Builds a reply graph from Reddit API.

"""

replyFilename = 'lab9.graphml'

# command line parsing
#parser = buildParser()
#args = parser.parse_args()

# construct Reddit client
client = redditClient()

# construct directed graph
replyGraph = nx.DiGraph()

# this dictionary used to track the ids of submissions and posts, in order for us to construct
# the links in the graph
dSubCommentId = dict()

# specify which subreddit we are interested in - 'python'
subreddit = client.subreddit('python')

# loop through the hot submissions
for submission in subreddit.hot():
    # print('Submission: {}'.format(submission.title))
    # pprint.pprint(vars(submission))

    # check if author name is in the reply graph - if so, we update the number of submissions
    # associated with this user
    # if not, we construct a new node with 1 associated submission
    if submission.author.name in replyGraph:
        print(submission.author.name)
        print(replyGraph.node[submission.author.name])
        print(replyGraph.nodes(data=True))
        replyGraph.node[submission.author.name]['subNum'] += 1
    else:
        replyGraph.add_node(submission.author.name, subNum=1)

    submissionId = submission.name;
    # this stores the submissionId (in submission.name) and associate it to the author
    # (submission.author.name).
    dSubCommentId[submissionId] = {submissionId : submission.author.name}

    print(submission.author.name)

    # for the current submission, retrieve the associated comments
    submission.comments.replace_more(limit=None)
    for comment in submission.comments.list():
        # print('Comment: {}'.format(comment.body))
        # pprint.pprint(vars(comment))
        # print(comment.id)
        # print(comment.author.name)

        # only add if not external user or the comment isn't deleted

        # some data checking to cater for deleted comments
        # we only add a link if the comment hasn't been deleted
        if comment.author is not None and comment.author.name != 'ExternalUserError':
            # print('Add to dSubCommentId: {}'.format(comment.author.name))
            dSubCommentId[submissionId].update({comment.name : comment.author.name})


            # print(dSubCommentId.keys())
            # print(dSubCommentId[submissionId].keys())



            # check if we have seen the comment's parent yet.  If not, then parent comment has been
            # deleted
            if comment.parent_id in dSubCommentId[submissionId]:
                # print('Two: {}'.format(dSubCommentId[submissionId][comment.parent_id]))
                # if edge exists, increment the replyNum, otherwise add a new edge
                if replyGraph.has_edge(comment.author.name, dSubCommentId[submissionId][comment.parent_id]):
                    replyGraph[comment.author.name][dSubCommentId[submissionId][comment.parent_id]]['replyNum'] += 1
                else:
                    # need to check if the nodes have been added yet, if not add it and set subNum to 0
                    if not comment.author.name in replyGraph:
                        replyGraph.add_node(comment.author.name, subNum=0)

                    if not dSubCommentId[submissionId][comment.parent_id] in replyGraph:
                        replyGraph.add_node(dSubCommentId[submissionId][comment.parent_id], subNum=0)

                    replyGraph.add_edge(comment.author.name, dSubCommentId[submissionId][comment.parent_id], replyNum=1)


print(replyGraph.nodes)

#
# TODO: save graph to file









# %%
