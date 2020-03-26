# %%
import networkx as nx

from argparse import ArgumentParser


import numpy as np
import matplotlib.pyplot as plt
import sys
import praw
# %%
replyFilename='lab9.graphml'


# read it back in to demonstrate it works
replyGraph = nx.readwrite.read_graphml(replyFilename)


# computing the degree centrality and plotting it
lDegCentrality = nx.degree_centrality(replyGraph)


#
# TODO: write code to compute eigenvetor and katz centrality
# lEigenVectorCentrality = ...
#



# plot histograms
plt.subplot(1,3,1)
plt.hist(list(lDegCentrality.values()))
plt.title('Degree')
plt.xlabel('centrality')

#
# TODO: plot the other two histograms
# eigenvector centrality
#

#
# katz centrality
#



plt.show()


#
# TODO: update the node attributes with centrality
#
# eigenvector centrality, stored in node attribute 'eigen'


# katz centrality, stored in node attribute 'katz'

#
# TODO: write out graph to new file
#



#
# TODO: compute the other SNA measures specified in the lab
#

#
# compute clustering
# the networkx code is within format(...)
#



#
# compute components
#



#
# compute bridges
#

# %%
