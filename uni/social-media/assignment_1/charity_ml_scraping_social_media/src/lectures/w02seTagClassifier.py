# %%
import json
from argparse import ArgumentParser
from nltk.corpus import stopwords
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.svm import LinearSVC
from sklearn.multiclass import OneVsRestClassifier
from sklearn.preprocessing import MultiLabelBinarizer
from sklearn.model_selection import cross_validate
from sklearn.decomposition import TruncatedSVD
import numpy as np
import nltk
nltk.download('stopwords')
# %%
inputPostFile='filteredPosts.json'
max_df=1.0
min_df=3
# %%
# set of stop words we be using (nltk)
stop_list = stopwords.words('english')

# list of posts
lPosts = []
# list of labels, note the indices of this and lPosts should match.
llLabels = []

# open the input file and parse the posts and tags
with open(inputPostFile, 'r') as f:
    for sLine in f:
        doc = json.loads(sLine)

        # parse post has title, then combine the title and body text together
        if 'Title' in doc:
            post = doc['Title'] + doc['Body']
        else:
            # parse just parse the body
            post = doc['Body']

        lPosts.append(post)

        # split the string of tags into a list of tags then add to llLabels
        llLabels.append(doc['Tags'].split(' '))



    # will do tokenisation, convert to lower cases, remove stop words etc, as well as reweighting using TF-IDF scheme
    # and put all of this into a document-word matrix.
    # Look at the documentation for more stuff you can do with this class.
    vectorizer = TfidfVectorizer(min_df=min_df,
                                    stop_words=stop_list,
                                    max_df=max_df,
                                    lowercase=True)


    # Actually build the document-word matrix (X)
    X = vectorizer.fit_transform(lPosts)


    # scikit learn has another great class, MultiLabelBinarizer, which constructs binary vectors of multilabelled data
    # that is, for each class there is a corresding entry in the vector, with a value of '1' if a label is present
    # in a document/posts, otherwise '0'
    mlb = MultiLabelBinarizer()
    y = mlb.fit_transform(llLabels)

    # here we can play with a number of different classifiers
    # We have started with a SVM with a linear kernel
    classifier = OneVsRestClassifier(LinearSVC())


    lScoringMetric = ['precision_micro', 'recall_micro', 'f1_micro']
    lScores = cross_validate(classifier, X, y=y,
                             cv=10,
                             scoring=lScoringMetric,
                             return_train_score=False)
    
    
    # finally output the average F1 score
    print("Average precision: " + str(np.mean(lScores['test_'+lScoringMetric[0]])))
    print("Average recall: " + str(np.mean(lScores['test_' + lScoringMetric[1]])))
    print("Average F1: " + str(np.mean(lScores['test_' + lScoringMetric[2]])))
    
# %%
print(lPosts)
# %%
