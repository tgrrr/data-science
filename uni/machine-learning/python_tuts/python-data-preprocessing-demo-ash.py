import pandas as pd
import numpy as np

raw_data = {'car_owners_name': ['Jason', np.nan, 'Tina', 'Jake', 'Amy'], 
        'last_name': ['Miller', np.nan, 'Ali', 'Milner', 'Cooze'], 
        'normalized-losses': [42, np.nan, 36, 24, 73], 
        'sex': ['m', np.nan, 'f', 'm', 'f'], 
        'number-of-doors': [4, np.nan, np.nan, 2, 3],
        'postTestScore': [25, np.nan, np.nan, 62, 70]}
automobile = pd.DataFrame(raw_data, columns = ['car_owners_name', 'last_name', 'normalized-losses', 'sex', 'number-of-doors', 'postTestScore'])

columns = ['car_owners_name', 'last_name', 'normalized-losses',
           'sex', 'number-of-doors', 'postTestScore']

def my_test(columnName):
    for ix in df.index():
        automobile[columnName] = 
                automobile[columnName]
                        .fillna(automobile[columnName].mean(axis=0), inplace=True)
    return # TODO: do I need to return something?

automobile.apply(lambda row: my_test(row['a'], row['c']), axis=1)

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
