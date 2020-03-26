
# /Applications/Anaconda/anaconda3/bin/jupyter
#%%
msg = "Hello World"
print(msg)

#%%
msg = "Hello again"
print(msg)

# **foobar**

#%%
import pandas as pd
import numpy as np
raw_data = {'car_owners_name': ['Jason', np.nan, 'Tina', 'Jake', 'Amy'], 
        'last_name': ['Miller', np.nan, 'Ali', 'Milner', 'Cooze'], 
        'normalized-losses': [42, np.nan, 36, 24, 73], 
        'sex': ['m', np.nan, 'f', 'm', 'f'], 
        'number-of-doors': [4, np.nan, np.nan, 2, 3],
        'postTestScore': [25, np.nan, np.nan, 62, 70]}
automobile = pd.DataFrame(raw_data, columns = ['car_owners_name', 'last_name', 'normalized-losses', 'sex', 'number-of-doors', 'postTestScore'])
automobile['normalized-losses'].fillna(automobile['normalized-losses'].mean(axis=0), inplace=True)
print(automobile)

# df["postTestScore"].fillna(df.groupby(
#     "sex")["postTestScore"].transform("mean"), inplace=True)
# df


# # /////

# So, here’s the answers I’m going off, from Stack Overflow:

# With a list of
# ```py
# df.dropna(subset=['column1_name', 'column2_name', 'column3_name'])
# ```


# ```py
# df = df[np.isfinite(df['EPS'])]
# # or
# pandas.notnull
# ```


#%%
