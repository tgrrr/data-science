# Data science in the wild

## tl;dr

- Bias In = Bias Out
- Our most important job is to **design the right question**
- Data and methods should **fit the question**
- Ethics: Our responsibility extends beyond the delivery of the model

- [ ] ~old_todo~~old_later~ good points about why data science
- [ ] ~old_todo~~old_later~ (from video) - Our problems have evolved
- [ ] ~old_todo~ ethics summary

## Ethics tl;dr (grabbed throughout these notes):
- Diversity in teams
- Responsibility
- Discriminate with machine learning. Eg. racism, sexism
- Datascience techniques can reduce bias:
  - Additional data sources
  - Sample dataset to remove bias – double-edged sword 
  - Transparency of techniques
- Fake news
- Understand the context and impact of our work
+ Similarity drives user engagement <- (could be a problem)

## Our problems have evolved
~old_todo~~old_later~ (from video)
- Datasets are not simply big, they are granular 
- Moved away from domain expertise
- Tools, tools, tools!
- Is this really my problem?

#### Eg. Problem statement:
- Determine fraudulent profiles from user names
A classifier generally improves with the number of data points
- White male names are straightforward to classify
- Statistical patterns that apply to the majority might be invalid within a minority group
- Fewer people (if any) carry the same name in some ethnic groups
  -> A typical sign of a ‘fake’ profile in Anglo societies
  
### Ethics: What is My Responsibility?
- Domain knowledge should not be ignored
- Understand the data
- Investigate where your model does not perform well
  - Break into separate models
  - Up-sample minorities
  - More complex decision rules (use with caution)
  - Feed back model performance

## Bias In = Bias Out

Eg. Problem statement:
 - Match candidate resumes to job roles
- Where to start?
 - Large text dataset
 - Word embeddings from process such as word2vec
- This could take a while...
 - https://code.google.com/archive/p/word2vec/
 - Pre-trained vectors based on Google News dataset (~ 100 billion words) 
  - 300-dimensional vectors 
  - for 3 million words

#### Ethics: What Is My Responsibility? (again)
- Awareness of how the model recommendations are implemented
- Critical evaluation of model performance “in the wild”
- Apply techniques to reduce/remove bias
  - Additional data sources
  - Sample dataset to remove bias – double-edged sword 
  - Transparency of techniques

## The Devil Is In The Question
- Eg. Problem statement:
 -  Improve user engagement as measured by clicks and shares
- People like similarity
 -  Movie recommendations
 -  Search
- Similarity drives user engagement
 -  More of what I like
 -  More of what my friends like
 -  More from the organisations I like

= success

## The Questions We Ask Matter
- Media is driven by likes, clicks and recommender systems
- Traditional goal of media has been unbiased content
  - Point and Counter-Point
  - How to differentiate ‘right to live’ from ‘right to choose’?
- Fake news works when it is close to our beliefs 
- Are we asking the right question?

## The Social Data Scientist

- With great power comes great responsibility
- Understand the context and impact of our work 
- Put questions and data above methods and tools
- Diversity in Data Science teams
- What's the legacy