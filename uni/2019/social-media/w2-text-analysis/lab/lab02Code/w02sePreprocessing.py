# %%
tagsFile='Tags.json'
postsFile='Posts.json'
outputFile='filteredPosts.json'
minTagFreq=15
# %%
import json

lValidTags = []
# read in set of tags and filter out non-relevant ones
with open(tagsFile, 'r') as fTags:
    for sLine in fTags:
        tag = json.loads(sLine)

        if int(tag['Count']) >= minTagFreq:
            lValidTags.append(tag['TagName'])
# %%
# read in posts, and only output question posts
with open(postsFile, 'r') as fIn, open(outputFile, 'w') as fOut:
    for sLine in fIn:
        doc = json.loads(sLine)

        # store the ids of all docs, to figure out what is the question and what is the answer
        docType = doc['PostTypeId']
        lTagsKept = []

        # we only interested in storing questions and associated tags
        if docType == '1':
            lCurrTags = doc['Tags'].split(' ')
            # only keep tags that are 'valid', or appear greater than min_df number of times
            lTagsKept = [tag for tag in lCurrTags if tag in lValidTags]

            # if there are associated tags (there should be, but if there isn't we don't output the question post)
            if len(lTagsKept) > 0:
                # update document tags and convert the tagsKept list to a string
                doc['Tags'] = ' '.join(lTagsKept)
                # write to json format
                fOut.write("{}\n".format(json.dumps(doc)))
# %%
