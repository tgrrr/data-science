#%% Change working directory from the workspace root to the ipynb file location. Turn this addition off with the DataScience.changeDirOnImportExport setting
import os
try:
	os.chdir(os.path.join(os.getcwd(), 'python_tuts'))
	print(os.getcwd())
except:
	pass
#%% [markdown]
# # pandas
#%% [markdown]
# The `pandas` module provides high-performance, easy-to-use data structures and data analysis tools. The main data structure is the `DataFrame`, which you can think of as an in-memory 2D table (like a spreadsheet, with column names and row labels). Many features from Excel are available programmatically, such as creating pivot tables, computing columns based on other columns, plotting graphs, etc. You can also group rows by column value, or join tables much like in SQL. `pandas` is also great at handling time series.
# 
# Prerequisites: `NumPy`
#%% [markdown]
# ## Table of Contents
# * [Series](#Series)
#  - [Creating a Series](#Creating-a-Series)
#  - [Selecting and filtering in Series](#Selecting-and-filtering-in-Series)
#  - [Operations on Series](#Operations-on-Series)
#  - [Plotting a Series](#Plotting-a-Series)
# * [DataFrame](#DataFrame)
#  - [Creating a DataFrame](#Creating-a-DataFrame)
#  - [Selecting and filtering in DataFrame](#Selecting-and-filtering-in-DataFrame)
#  - [Transposing](#Transposing)
#  - [Adding and removing columns](#Adding-and-removing-columns)
#  - [Assigning new columns](#Assigning-new-columns)
#  - [Evaluating an expression](#Evaluating-an-expression)
#  - [Querying a DataFrame](#Querying-a-DataFrame)
#  - [Sorting a DataFrame](#Sorting-a-DataFrame)
#  - [Operations on DataFrame](#Operations-on-DataFrame)
#  - [Automatic alignment for DataFrames](#Automatic-alignment-for-DataFrames)
#  - [Plotting a DataFrame](#Plotting-a-DataFrame)
#  - [Handling missing data](#Handling-missing-data)
#  - [Aggregating with groupby](#Aggregating-with-groupby)
#  - [Pivot tables](#Pivot-tables)
#  - [Overview functions](#Overview-functions)
# * [Combining DataFrames](#Combining-DataFrames)
#  - [SQL like joins](#SQL-like-joins)
#  - [Concatenation](#Concatenation)
# * [Categories](#Categories)
# * [Saving and loading](#Saving-and-loading)
#  - [Saving](#Saving)
#  - [Loading](#Loading)
# * [Time series](#Time-series)
#  - [Time range](#Time-range)
#  - [Resampling](#Resampling)
#  - [Upsampling and interpolation](#Upsampling-and-interpolation)
#  - [Timezones](#Timezones)
#  - [Periods](#Periods)
# * [Exercises](#Exercises)
#  - [Possible solutions](#Possible-solutions)
#%% [markdown]
# 
# 

#%%
# first set this so that jupyter notebook prints all output from a cell, 
# not just the most recent one
from IPython.core.interactiveshell import InteractiveShell
InteractiveShell.ast_node_interactivity = "all"
# let's also suppress warnings, as they can get annoying sometimes
import warnings
warnings.filterwarnings("ignore")

#%% [markdown]
# Let's import `pandas` with the usual convention as `pd`.

#%%
import pandas as pd

#%% [markdown]
# ## Series
#%% [markdown]
# A `Series` is a one-dimensional array-like object containing a sequence of values and an associated array of data labels, called its *index*.
#%% [markdown]
# ### Creating a Series
# The simplest `Series` is formed from only an array of data.

#%%
obj = pd.Series([2,-1,3,5])
obj

#%% [markdown]
# The string representation of a `Series` displayed interactively shows the index on the
# left and the values on the right.
# You can get the array representation and index object of the `Series` via
# its values and index attributes, respectively.

#%%
obj.values


#%%
obj.index # Like range(4)


#%%
list(obj.index) # if you want the index as a list of values

#%% [markdown]
# We may want to create a `Series` with an index identifying each data point with a label.

#%%
obj2 = pd.Series([2,-1,3,5], index=['a', 'b', 'c', 'd'])
obj2


#%%
list(obj2.index)

#%% [markdown]
# A `Series` can have a `name`.

#%%
obj_withName = pd.Series([83, 68], index=["bob", "alice"], name="weights")
obj_withName

#%% [markdown]
# You can also create a `Series` object from a `dict`. The keys will be used as index labels.

#%%
weightdata = {"john": 86, "michael": 68, "alice": 68, "bob": 83}
obj3 = pd.Series(weightdata)
obj3

#%% [markdown]
# ### Selecting and filtering in Series
#%% [markdown]
# Compared with `NumPy` arrays, you can use labels in the index when selecting single values or a set of values.

#%%
obj2


#%%
obj2['a']


#%%
obj2[['b','c','d']] 
# Here ['b', 'c', 'd'] is interpreted as a list of indices, even though it contains strings instead of integers.

#%% [markdown]
# You can still access the items by integer location, like in a regular array. By default, the rank of the item in the `Series` starts at **0**. 

#%%
obj2[0]


#%%
obj2[[1,3]]


#%%
obj2[obj2 < 0]

#%% [markdown]
# Slicing with labels behaves differently than normal Python slicing in that the endpoint is inclusive.

#%%
obj2['b':'c']

#%% [markdown]
# To make it clear when you are accessing by label or by integer location, it is recommended to always use the `loc` attribute when accessing by label, and the `iloc` attribute when accessing by integer location.

#%%
obj2.loc["a"]


#%%
obj2.iloc[0]

#%% [markdown]
# Slicing a `Series` also slices the index labels.

#%%
obj2.iloc[1:3]

#%% [markdown]
# This can lead to unexpected results when using the default numeric labels, so be careful:

#%%
surprise = pd.Series([1000, 1001, 1002, 1003])
surprise


#%%
surprise_slice = surprise[2:]
surprise_slice

#%% [markdown]
# Oh look! The first element has index label **2**. The element with index label 0 is absent from the slice.
# 
# But remember that you can access elements by integer location using the iloc attribute. This illustrates another reason why it's always better to use loc and iloc to access Series objects.

#%%
surprise_slice.iloc[0]

#%% [markdown]
# ### Operations on Series
# `Series` objects behave much like one-dimensional `ndarray`s, and you can often pass them as parameters to `NumPy` functions.

#%%
import numpy as np
np.exp(obj2)

#%% [markdown]
# Arithmetic operations on `Series` are also possible, and they apply *elementwise*, just like for `ndarray`s.

#%%
obj2 + [1000,2000,3000,4000]

#%% [markdown]
# Similar to `NumPy`, if you add a single number to a `Series`, that number is added to all items in the `Series`. This is called *broadcasting*.

#%%
obj2 + 1000

#%% [markdown]
# The same is true for all binary operations and even conditional operations.
#%% [markdown]
# ### Plotting a Series
# `pandas` makes it easy to plot `Series` data using `matplotlib`. Just import `matplotlib` and call the `plot()` method:

#%%
get_ipython().magic('matplotlib inline')
import matplotlib.pyplot as plt
get_ipython().magic("config InlineBackend.figure_format = 'retina'")
plt.style.use("ggplot")
temperatures = [4.4,5.1,6.1,6.2,6.1,6.1,5.7,5.2,4.7,4.1,3.9,3.5]
s7 = pd.Series(temperatures, name="Temperature")
s7.plot()
plt.show();

#%% [markdown]
# ## DataFrame
#%% [markdown]
# A `DataFrame` represents a rectangular table of data and contains an ordered collection of columns, each of which can be a different value type (numeric, string, boolean, etc.). You can see `DataFrame`s as `dict` of `Series`.
#%% [markdown]
# ### Creating a DataFrame
# There are many ways to construct a `DataFrame`, though one of the most common is from a `dict` of equal-length lists or `NumPy` arrays.

#%%
data = {'state': ['Ohio', 'Ohio', 'Ohio', 'Nevada', 'Nevada', 'Nevada'],
'year': [2000, 2001, 2002, 2001, 2002, 2003],
'pop': [1.5, 1.7, 3.6, 2.4, 2.9, 3.2]}
df = pd.DataFrame(data)
df

#%% [markdown]
# For large `DataFrame`s, the `head` method selects only the first five rows.

#%%
df.head()

#%% [markdown]
# You can also create a `DataFrame` by passing a `dict` of `Series` objects.

#%%
people_dict = {
    "weight": pd.Series([68, 83, 112], index=["alice", "bob", "charles"]),
    "birthyear": pd.Series([1984, 1985, 1992], index=["bob", "alice", "charles"], name="year"),
    "children": pd.Series([0, 3], index=["charles", "bob"]),
    "hobby": pd.Series(["Biking", "Dancing"], index=["alice", "bob"]),
}
people = pd.DataFrame(people_dict)
people

#%% [markdown]
# A few things to note:
# * The `Series` were automatically aligned based on their index.
# * Missing values are represented as `NaN`.
# * `Series` names are ignored (the name `"year"` was dropped).
#%% [markdown]
# If you pass a list of columns and/or index row labels to the `DataFrame` constructor, it will guarantee that these columns and/or rows will exist, in that order, and no other column/row will exist.

#%%
df2 = pd.DataFrame(
        people_dict,
        columns=["birthyear", "weight", "height"],
        index=["bob", "alice", "eugene"]
     )
df2

#%% [markdown]
# Another convenient way to create a `DataFrame` is to pass all the values to the constructor as an `ndarray`, or a list of lists, and specify the column names and row index labels separately:

#%%
values = [
            [1985, np.nan, "Biking",   68],
            [1984, 3,      "Dancing",  83],
            [1992, 0,      np.nan,    112]
         ]
df3 = pd.DataFrame(
        values,
        columns=["birthyear", "children", "hobby", "weight"],
        index=["alice", "bob", "charles"]
     )
df3

#%% [markdown]
# You can access columns pretty much as you would expect. They are returned as `Series` objects.

#%%
people["birthyear"]

#%% [markdown]
# You can also get multiple columns at once.

#%%
people[["birthyear", "hobby"]]

#%% [markdown]
# To specify missing values, you can either use `np.nan` or `NumPy`'s masked arrays:

#%%
masked_array = np.ma.asarray(values, dtype=np.object)
masked_array[(0, 2), (1, 2)] = np.ma.masked
df3 = pd.DataFrame(
        masked_array,
        columns=["birthyear", "children", "hobby", "weight"],
        index=["alice", "bob", "charles"]
     )
df3

#%% [markdown]
# Instead of an `ndarray`, you can also pass a `DataFrame` object:

#%%
df4 = pd.DataFrame(
         df3,
         columns=["hobby", "children"],
         index=["alice", "bob"]
     )
df4

#%% [markdown]
# ### Selecting and filtering in DataFrame
# Let's go back to the `people`:

#%%
people

#%% [markdown]
# The `loc` attribute lets you access rows instead of columns. The result is a `Series` object in which the `DataFrame`'s column names are mapped to row index labels.

#%%
people.loc["charles"]

#%% [markdown]
# You can also access rows by integer location using the `iloc` attribute.

#%%
people.iloc[2]

#%% [markdown]
# You can also get a slice of rows, and this returns a `DataFrame` object.

#%%
people.iloc[1:3]

#%% [markdown]
# Finally, you can pass a boolean array to get the matching rows.

#%%
people[np.array([True, False, True])]

#%% [markdown]
# This is most useful when combined with boolean expressions.

#%%
people[people["birthyear"] < 1990]

#%% [markdown]
# ### Transposing
# You can swap columns and indices using the `T` attribute.

#%%
people.T

#%% [markdown]
# ### Adding and removing columns
# You can generally treat `DataFrame` objects like dictionaries of `Series`, so the following work fine.

#%%
people


#%%
people["age"] = 2018 - people["birthyear"]  # adds a new column "age"
people["over 30"] = people["age"] > 30      # adds another column "over 30"
birthyears = people.pop("birthyear")
del people["children"]

people


#%%
birthyears

#%% [markdown]
# When you add a new colum, it must have the same number of rows. Missing rows are filled with NaN, and extra rows are ignored.

#%%
people["pets"] = pd.Series({"bob": 0, "charles": 5, "eugene":1})  # alice is missing, eugene is ignored
people

#%% [markdown]
# When adding a new column, it is added at the end (on the right) by default. You can also insert a column anywhere else using the `insert()` method.

#%%
people.insert(1, "height", [172, 181, 185])
people

#%% [markdown]
# ### Assigning new columns
# You can also create new columns by calling the `assign()` method. Note that this returns a new `DataFrame` object, the original is not modified.

#%%
people.assign(
    body_mass_index = people["weight"] / (people["height"] / 100) ** 2,
    has_pets = people["pets"] > 0
)

#%% [markdown]
# Note that you cannot access columns created within the same assignment.

#%%
try:
    people.assign(
        body_mass_index = people["weight"] / (people["height"] / 100) ** 2,
        overweight = people["body_mass_index"] > 25
    )
except KeyError as e:
    print("Key error:", e)

#%% [markdown]
# The solution is to split this assignment in two consecutive assignments.

#%%
df5 = people.assign(body_mass_index = people["weight"] / (people["height"] / 100) ** 2)
df5.assign(overweight = df5["body_mass_index"] > 25)

#%% [markdown]
# Having to create a temporary variable **df5** is not very convenient. You may want to just chain the assigment calls, but it does not work because the `people` object is not actually modified by the first assignment.

#%%
try:
    (people
         .assign(body_mass_index = people["weight"] / (people["height"] / 100) ** 2)
         .assign(overweight = people["body_mass_index"] > 25)
    )
except KeyError as e:
    print("Key error:", e)

#%% [markdown]
# But fear not, there is a simple solution. You can pass a function to the `assign()` method (typically a `lambda` function), and this function will be called with the `DataFrame` as a parameter.

#%%
(people
     .assign(body_mass_index = lambda df: df["weight"] / (df["height"] / 100) ** 2)
     .assign(overweight = lambda df: df["body_mass_index"] > 25)
)

#%% [markdown]
# Problem solved!
#%% [markdown]
# ### Evaluating an expression
# A great feature supported by `pandas` is expression evaluation. This relies on the `numexpr` library which must be installed.

#%%
people.eval("weight / (height/100) ** 2 > 25")

#%% [markdown]
# Assignment expressions are also supported. Let's set `inplace=True` to directly modify the `DataFrame` rather than getting a modified copy:

#%%
people.eval("body_mass_index = weight / (height/100) ** 2", inplace=True)
people

#%% [markdown]
# You can use a local or global variable in an expression by prefixing it with `'@'`.

#%%
overweight_threshold = 30
people.eval("overweight = body_mass_index > @overweight_threshold", inplace=True)
people

#%% [markdown]
# ### Querying a DataFrame
# The `query()` method lets you filter a `DataFrame` based on a query expression.

#%%
people.query("age > 30 and pets == 0")

#%% [markdown]
# ### Sorting a DataFrame
# You can sort a `DataFrame` by calling its `sort_index` method. By default it sorts the rows by their index label, in ascending order, but let's reverse the order.

#%%
people.sort_index(ascending=False)

#%% [markdown]
# Note that `sort_index` returned a sorted *copy* of the `DataFrame`. To modify `people` directly, we can set the `inplace` argument to `True`. Also, we can sort the columns instead of the rows by setting `axis=1`.

#%%
people.sort_index(axis=1, inplace=True)
people

#%% [markdown]
# To sort the `DataFrame` by the values instead of the labels, we can use `sort_values` and specify the column to sort by.

#%%
people.sort_values(by="age", inplace=True)
people

#%% [markdown]
# ### Operations on DataFrame
# Although `DataFrame`s do not try to mimick `NumPy` arrays, there are a few similarities. Let's create a `DataFrame` to demonstrate this:

#%%
grades_array = np.array([[8,8,9],[10,9,9],[4, 8, 2], [9, 10, 10]])
grades = pd.DataFrame(grades_array, columns=["sep", "oct", "nov"], index=["alice","bob","charles","darwin"])
grades

#%% [markdown]
# You can apply `NumPy` mathematical functions on a `DataFrame`. The function is applied to all values.

#%%
np.sqrt(grades)

#%% [markdown]
# Similarly, adding a single value to a `DataFrame` will add that value to all elements in the `DataFrame`. This is called *broadcasting*.

#%%
grades + 1

#%% [markdown]
# Of course, the same is true for all other binary operations, including arithmetic (`*`,`/`,`**`...) and conditional (`>`, `==`...) operations.

#%%
grades >= 5

#%% [markdown]
# Aggregation operations, such as computing the `max`, the `sum` or the `mean` of a `DataFrame`, apply to each column, and you get back a `Series` object.

#%%
grades.mean()

#%% [markdown]
# The `all` method is also an aggregation operation: it checks whether all values are `True` or not. Let's see during which months all students got a grade greater than `5`.

#%%
(grades > 5).all()

#%% [markdown]
# Most of these functions take an optional `axis` parameter which lets you specify along which axis of the `DataFrame` you want the operation executed. The default is `axis=0`, meaning that the operation is executed vertically (on each column). You can set `axis=1` to execute the operation horizontally (on each row). For example, let's find out which students had all grades greater than `5`:

#%%
(grades > 5).all(axis = 1)

#%% [markdown]
# The `any` method returns `True` if any value is True. Let's see who got at least one grade 10:

#%%
(grades == 10).any(axis = 1)

#%% [markdown]
# If you add a `Series` object to a `DataFrame` (or execute any other binary operation), `pandas` attempts to broadcast the operation to all *rows* in the `DataFrame`. This only works if the `Series` has the same size as the `DataFrame`s rows. For example, let's substract the `mean` of the `DataFrame` (a `Series` object) from the `DataFrame`:

#%%
grades - grades.mean()  # equivalent to: grades - [7.75, 8.75, 7.50]

#%% [markdown]
# We substracted `7.75` from all September grades, `8.75` from October grades and `7.50` from November grades. It is equivalent to substracting this `DataFrame`.

#%%
pd.DataFrame([[7.75, 8.75, 7.50]]*4, index=grades.index, columns=grades.columns)

#%% [markdown]
# If you want to substract the global mean from every grade, here is one way to do it:

#%%
grades - grades.values.mean() # substracts the global mean (8.00) from all grades

#%% [markdown]
# ### Automatic alignment for DataFrames
# Similar to `Series`, when operating on multiple `DataFrame`s, `pandas` automatically aligns them by row index label, but also by column names. Let's create a `DataFrame` with bonus points for each person from October to December:

#%%
bonus_array = np.array([[0,np.nan,2],[np.nan,1,0],[0, 1, 0], [3, 3, 0]])
bonus_points = pd.DataFrame(bonus_array, columns=["oct", "nov", "dec"], index=["bob","colin", "darwin", "charles"])
bonus_points


#%%
grades + bonus_points

#%% [markdown]
# Looks like the addition worked in some cases but way too many elements are now empty. That's because when aligning the `DataFrame`s, some columns and rows were only present on one side, and thus they were considered missing on the other side (`NaN`). Then adding `NaN` to a number results in `NaN`, hence the result.
#%% [markdown]
# ### Plotting a DataFrame
# Just like for `Series`, `pandas` makes it easy to draw nice graphs based on a `DataFrame`.
# 
# For example, it is easy to create a bar plot from a `DataFrame`'s data by calling its `plot` method.

#%%
people.plot(kind = "bar", y = ["body_mass_index"])
plt.show();

#%% [markdown]
# You can pass extra arguments supported by matplotlib's functions. For example, we can create scatterplot and pass it a list of sizes using the `s` argument of matplotlib's `scatter()` function.

#%%
people.plot(kind = "scatter", x = "height", y = "weight", s=[40, 120, 200])
plt.show();

#%% [markdown]
# Again, there are way too many options to list here: the best option is to scroll through the [Visualization](http://pandas.pydata.org/pandas-docs/stable/visualization.html) page in `pandas` documentation and find the plot you are interested in.
#%% [markdown]
# ### Handling missing data
# Dealing with missing data is a frequent task when working with real life data. `pandas` offers a few tools to handle missing data.
#%% [markdown]
# The `isnull` and `notnull` functions in `pandas` can be used to detect missing data.

#%%
pd.isnull(grades)


#%%
pd.notnull(grades)

#%% [markdown]
# We may want that, for instance, missing data should result in a zero, instead of `NaN`. We can replace all `NaN` values by a any value using the `fillna()` method.

#%%
(grades + bonus_points).fillna(0)

#%% [markdown]
# It's a bit unfair that we're setting grades to zero in September, though. Perhaps we should decide that missing grades are missing grades, but missing bonus points should be replaced by zeros.

#%%
fixed_bonus_points = bonus_points.fillna(0)
fixed_bonus_points.insert(0, "sep", 0)
fixed_bonus_points.loc["alice"] = 0
grades + fixed_bonus_points

#%% [markdown]
# That's much better: although we made up some data, we have not been too unfair.
# 
# Another way to handle missing data is to interpolate. Let's look at the `bonus_points` `DataFrame` again:

#%%
bonus_points

#%% [markdown]
# Now let's call the `interpolate` method. By default, it interpolates vertically (`axis=0`), so let's tell it to interpolate horizontally (`axis=1`).

#%%
bonus_points.interpolate(axis=1)

#%% [markdown]
# Bob had 0 bonus points in October, and 2 in December. When we interpolate for November, we get the mean: 1 bonus point. Colin had 1 bonus point in November, but we do not know how many bonus points he had in September, so we cannot interpolate, this is why there is still a missing value in October after interpolation. To fix this, we can set the September bonus points to 0 before interpolation.

#%%
better_bonus_points = bonus_points.copy()
better_bonus_points.insert(0, "sep", 0)
better_bonus_points.loc["alice"] = 0
better_bonus_points = better_bonus_points.interpolate(axis=1)
better_bonus_points

#%% [markdown]
# Great, now we have reasonable bonus points everywhere. Let's find out the final grades:

#%%
grades + better_bonus_points

#%% [markdown]
# It is slightly annoying that the September column ends up on the right. This is because the `DataFrame`s we are adding do not have the exact same columns (the `grades` `DataFrame` is missing the `"dec"` column), so to make things predictable, `pandas` orders the final columns alphabetically. To fix this, we can simply add the missing column before adding.

#%%
grades["dec"] = np.nan
final_grades = grades + better_bonus_points
final_grades

#%% [markdown]
# There's not much we can do about December and Colin: it's bad enough that we are making up bonus points, but we can't reasonably make up grades (well I guess some teachers probably do). So let's call the `dropna()` method to get rid of rows that are full of `NaN`s:

#%%
final_grades_clean = final_grades.dropna(how="all")
final_grades_clean

#%% [markdown]
# Now let's remove columns that are full of `NaN`s by setting the `axis` argument to `1`:

#%%
final_grades_clean = final_grades_clean.dropna(axis=1, how="all")
final_grades_clean

#%% [markdown]
# ### Aggregating with `groupby`
# Similar to the SQL language, `pandas` allows grouping your data into groups to run calculations over each group.
# 
# First, let's add some extra data about each person so we can group them, and let's go back to the `final_grades` `DataFrame` so we can see how `NaN` values are handled:

#%%
final_grades["hobby"] = ["Biking", "Dancing", np.nan, "Dancing", "Biking"]
final_grades

#%% [markdown]
# Now let's group data in this `DataFrame` by hobby:

#%%
grouped_grades = final_grades.groupby("hobby")
for key, item in grouped_grades:
    print(grouped_grades.get_group(key), "\n")

#%% [markdown]
# We are ready to compute the average grade per hobby.

#%%
grouped_grades.mean()

#%% [markdown]
# That was easy! Note that the `NaN` values have simply been skipped when computing the means.
#%% [markdown]
# ### Pivot tables
# `pandas` supports spreadsheet-like [pivot tables](https://en.wikipedia.org/wiki/Pivot_table) that allow quick data summarization. To illustrate this, let's create a simple `DataFrame`:

#%%
bonus_points


#%%
more_grades = final_grades_clean.stack().reset_index()
more_grades.columns = ["name", "month", "grade"]
more_grades["bonus"] = [np.nan, np.nan, np.nan, 0, np.nan, 2, 3, 3, 0, 0, 1, 0]
more_grades

#%% [markdown]
# Now we can call the `pd.pivot_table()` function for this `DataFrame`, asking to group by the `name` column. By default, `pivot_table()` computes the mean of each numeric column.

#%%
pd.pivot_table(more_grades, index="name")

#%% [markdown]
# We can change the aggregation function by setting the `aggfunc` argument, and we can also specify the list of columns whose values will be aggregated.

#%%
pd.pivot_table(more_grades, index="name", values=["grade","bonus"], aggfunc=np.max)

#%% [markdown]
# We can also specify the `columns` to aggregate over horizontally, and request the grand totals for each row and column by setting `margins=True`.

#%%
pd.pivot_table(more_grades, index="name", values="grade", columns="month", margins=True)

#%% [markdown]
# Finally, we can specify multiple index or column names, and `pandas` will create multi-level indices.

#%%
pd.pivot_table(more_grades, index=("name", "month"), margins=True)

#%% [markdown]
# ### Overview functions
# When dealing with large `DataFrames`, it is useful to get a quick overview of its content. `pandas` offers a few functions for this. First, let's create a large `DataFrame` with a mix of numeric values, missing values and text values. Notice how Jupyter displays only the corners of the `DataFrame`:

#%%
much_data = np.fromfunction(lambda x,y: (x+y*y)%17*11, (10000, 26))
large_df = pd.DataFrame(much_data, columns=list("ABCDEFGHIJKLMNOPQRSTUVWXYZ"))
large_df[large_df % 16 == 0] = np.nan
large_df.insert(3,"some_text", "Blabla")
large_df.head(10)

#%% [markdown]
# The `head()` method returns the top 5 rows.

#%%
large_df.head()

#%% [markdown]
# Of course there's also a `tail()` function to view the bottom 5 rows. You can pass the number of rows you want.

#%%
large_df.tail(n=2)

#%% [markdown]
# The `info()` method prints out a summary of each columns contents.

#%%
large_df.info()

#%% [markdown]
# Finally, the `describe()` method gives a nice overview of the main aggregated values over each column:
# * `count`: number of non-null (not NaN) values
# * `mean`: mean of non-null values
# * `std`: [standard deviation](https://en.wikipedia.org/wiki/Standard_deviation) of non-null values
# * `min`: minimum of non-null values
# * `25%`, `50%`, `75%`: 25th, 50th and 75th [percentile](https://en.wikipedia.org/wiki/Percentile) of non-null values
# * `max`: maximum of non-null values

#%%
large_df.describe()

#%% [markdown]
# ## Combining DataFrames
#%% [markdown]
# ### SQL-like joins
# One powerful feature of `pandas` is it's ability to perform SQL-like joins on `DataFrame`s. Various types of joins are supported: inner joins, left/right outer joins and full joins. To illustrate this, let's start by creating a couple simple `DataFrame`s:

#%%
city_loc = pd.DataFrame(
    [
        ["CA", "San Francisco", 37.781334, -122.416728],
        ["NY", "New York", 40.705649, -74.008344],
        ["FL", "Miami", 25.791100, -80.320733],
        ["OH", "Cleveland", 41.473508, -81.739791],
        ["UT", "Salt Lake City", 40.755851, -111.896657]
    ], columns=["state", "city", "lat", "lng"])
city_loc


#%%
city_pop = pd.DataFrame(
    [
        [808976, "San Francisco", "California"],
        [8363710, "New York", "New-York"],
        [413201, "Miami", "Florida"],
        [2242193, "Houston", "Texas"]
    ], index=[3,4,5,6], columns=["population", "city", "state"])
city_pop

#%% [markdown]
# Now let's join these `DataFrame`s using the `merge()` function:

#%%
pd.merge(left=city_loc, right=city_pop, on="city")

#%% [markdown]
# Note that both `DataFrame`s have a column named `state`, so in the result they got renamed to `state_x` and `state_y`.
# 
# Also, note that Cleveland, Salt Lake City and Houston were dropped because they don't exist in *both* `DataFrame`s. This is the equivalent of a SQL `INNER JOIN`. If you want a `FULL OUTER JOIN`, where no city gets dropped and `NaN` values are added, you must specify `how="outer"`.

#%%
all_cities = pd.merge(left=city_loc, right=city_pop, on="city", how="outer")
all_cities

#%% [markdown]
# Of course `LEFT OUTER JOIN` is also available by setting `how="left"`: only the cities present in the left `DataFrame` end up in the result. Similarly, with `how="right"` only cities in the right `DataFrame` appear in the result. For example:

#%%
pd.merge(left=city_loc, right=city_pop, on="city", how="right")

#%% [markdown]
# If the key to join on is actually in one (or both) `DataFrame`'s index, you must use `left_index=True` and/or `right_index=True`. If the key column names differ, you must use `left_on` and `right_on`. For example:

#%%
city_pop2 = city_pop.copy()
city_pop2.columns = ["population", "name", "state"]
pd.merge(left=city_loc, right=city_pop2, left_on="city", right_on="name")

#%% [markdown]
# ### Concatenation
# Rather than joining `DataFrame`s, we may just want to concatenate them using `concat()` method.

#%%
result_concat = pd.concat([city_loc, city_pop], sort = False)
result_concat

#%% [markdown]
# Note that this operation aligned the data horizontally (by columns) but not vertically (by rows). In this example, we end up with multiple rows having the same index (eg. 3). `pandas` handles this rather gracefully.

#%%
result_concat.loc[3]

#%% [markdown]
# Or you can tell `pandas` to just ignore the index.

#%%
pd.concat([city_loc, city_pop], ignore_index=True, sort = False)

#%% [markdown]
# Notice that when a column does not exist in a `DataFrame`, it acts as if it was filled with `NaN` values. If we set `join="inner"`, then only columns that exist in *both* `DataFrame`s are returned.

#%%
pd.concat([city_loc, city_pop], join="inner")

#%% [markdown]
# You can concatenate `DataFrame`s horizontally instead of vertically by setting `axis=1`.

#%%
pd.concat([city_loc, city_pop], axis=1)

#%% [markdown]
# In this case it really does not make much sense because the indices do not align well (eg. Cleveland and San Francisco end up on the same row, because they shared the index label `3`). So let's reindex the `DataFrame`s by city name before concatenating:

#%%
pd.concat([city_loc.set_index("city"), city_pop.set_index("city")], axis=1, sort = False)

#%% [markdown]
# This looks a lot like a `FULL OUTER JOIN`, except that the `state` columns were not renamed to `state_x` and `state_y`, and the `city` column is now the index.
#%% [markdown]
# The `append()` method is a useful shorthand for concatenating `DataFrame`s vertically:

#%%
city_loc.append(city_pop, sort = False)

#%% [markdown]
# ## Categories
#%% [markdown]
# As always in `pandas`, the `append()` method does *not* actually modify `city_loc`: it works on a copy and returns the modified copy.
#%% [markdown]
# It is quite frequent to have values that represent categories, for example `1` for female and `2` for male, or `"A"` for Good, `"B"` for Average, `"C"` for Bad. These categorical values can be hard to read and cumbersome to handle, but fortunately `pandas` makes it easy. To illustrate this, let's take the `city_pop` `DataFrame` we created earlier, and add a column that represents a category:

#%%
city_econ = city_pop.copy()
city_econ["econ_code"] = [17, 17, 34, 20]
city_econ

#%% [markdown]
# Right now the `econ_code` column is full of apparently meaningless codes. Let's fix that. First, we will create a new categorical column based on the `econ_code`s:

#%%
city_econ["economy"] = city_econ["econ_code"].astype('category')
city_econ["economy"].cat.categories

#%% [markdown]
# Now we can give each category a meaningful name:

#%%
city_econ["economy"].cat.categories = ["Finance", "Energy", "Tourism"]
city_econ

#%% [markdown]
# Note that categorical values are sorted according to their categorical order, *not* their alphabetical order:

#%%
city_econ.sort_values(by="economy", ascending=False)

#%% [markdown]
# ## Saving and loading
#%% [markdown]
# `pandas` can save `DataFrame`s to various backends, including file formats such as CSV, Excel, JSON, HTML and HDF5, or to a SQL database. Let's create a `DataFrame` to demonstrate this:

#%%
my_df = pd.DataFrame(
    [["Biking", 68.5, 1985, np.nan], ["Dancing", 83.1, 1984, 3]], 
    columns=["hobby","weight","birthyear","children"],
    index=["alice", "bob"]
)
my_df

#%% [markdown]
# ### Saving
# Let's save it to CSV, HTML and JSON:

#%%
my_df.to_csv("my_df.csv")
my_df.to_html("my_df.html")
my_df.to_json("my_df.json")

#%% [markdown]
# Done! Let's take a peek at what was saved:

#%%
for filename in ("my_df.csv", "my_df.html", "my_df.json"):
    print("#", filename)
    with open(filename, "rt") as f:
        print(f.read())
        print()

#%% [markdown]
# Note that the index is saved as the first column (with no name) in a CSV file, as `<th>` tags in HTML and as keys in JSON.
# 
# Saving to other formats works very similarly, but some formats require extra libraries to be installed. For example, saving to Excel requires the openpyxl library:

#%%
try:
    my_df.to_excel("my_df.xlsx", sheet_name='People')
except ImportError as e:
    print(e)

#%% [markdown]
# ### Loading
# Now let's load our CSV file back into a `DataFrame`:

#%%
my_df_loaded = pd.read_csv("my_df.csv", index_col=0)
my_df_loaded

#%% [markdown]
# As you might guess, there are similar `read_json`, `read_html`, `read_excel` functions as well.  We can also read data straight from the Internet. For example, let's load all New York State Zip codes from [data.ny.gov](https://data.ny.gov):

#%%
ny_zip = None
try:
    csv_url = "https://data.ny.gov/api/views/juva-r6g2/rows.csv"
    ny_zip = pd.read_csv(csv_url, index_col=0)
    ny_zip = ny_zip.head()
except IOError as e:
    print(e)
ny_zip

#%% [markdown]
# There are more options available, in particular regarding datetime format. Check out the [documentation](http://pandas.pydata.org/pandas-docs/stable/io.html) for more details.
#%% [markdown]
# ## Time series
#%% [markdown]
# Many datasets have timestamps, and `pandas` is awesome at manipulating such data:
# * It can represent periods (such as 2016Q3) and frequencies (such as "monthly"),
# * It can convert periods to actual timestamps, and *vice versa*,
# * It can resample data and aggregate values any way you like,
# * It can handle timezones.
#%% [markdown]
# ### Time range
# Let's start by creating a time series using `pd.date_range()`. This returns a `DatetimeIndex` containing one datetime per hour for 12 hours starting on October 29th 2016 at 5:30pm.

#%%
dates = pd.date_range('2016/10/29 5:30pm', periods=12, freq='H')
dates

#%% [markdown]
# This `DatetimeIndex` may be used as an index in a `Series`.

#%%
temp_series = pd.Series(temperatures, dates)
temp_series

#%% [markdown]
# Let's plot this series:

#%%
temp_series.plot(kind="bar")

plt.grid(True)
plt.show()

#%% [markdown]
# ### Resampling
# `pandas` lets us resample a time series very simply. Just call the `resample()` method and specify a new frequency.

#%%
temp_series_freq_2H = temp_series.resample("2H")
temp_series_freq_2H

#%% [markdown]
# The resampling operation is actually a deferred operation, which is why we did not get a `Series` object, but a `DatetimeIndexResampler` object instead. To actually perform the resampling operation, we can simply call the `mean()` method: `pandas` will compute the mean of every pair of consecutive hours.

#%%
temp_series_freq_2H = temp_series_freq_2H.mean()

#%% [markdown]
# Let's plot the result:

#%%
temp_series_freq_2H.plot(kind="bar")
plt.show();

#%% [markdown]
# Note how the values have automatically been aggregated into 2-hour periods. If we look at the 6-8pm period, for example, we had a value of `5.1` at 6:30pm, and `6.1` at 7:30pm. After resampling, we just have one value of `5.6`, which is the mean of `5.1` and `6.1`. Rather than computing the mean, we could have used any other aggregation function, for example we can decide to keep the minimum value of each period.

#%%
temp_series_freq_2H = temp_series.resample("2H").min()
temp_series_freq_2H

#%% [markdown]
# Or, equivalently, we could use the `apply()` method instead.

#%%
temp_series_freq_2H = temp_series.resample("2H").apply(np.min)
temp_series_freq_2H

#%% [markdown]
# ### Upsampling and interpolation
# This was an example of downsampling. We can also upsample (ie. increase the frequency), but this creates holes in our data.

#%%
temp_series_freq_15min = temp_series.resample("15Min").mean()
temp_series_freq_15min.head(n=10) # `head` displays the top n values

#%% [markdown]
# One solution is to fill the gaps by interpolating. We just call the `interpolate()` method. The default is to use linear interpolation, but we can also select another method, such as cubic interpolation. In order to call interpolate(), first we need to import `scipy`.

#%%
import scipy

temp_series_freq_15min = temp_series.resample("15Min").interpolate(method="cubic")
temp_series_freq_15min.head(n=10)


#%%
temp_series.plot(label="Period: 1 hour")
temp_series_freq_15min.plot(label="Period: 15 minutes")
plt.legend()
plt.show();

#%% [markdown]
# ### Timezones
# By default datetimes are *naive*: they are not aware of timezones, so 2016-10-30 02:30 might mean October 30th 2016 at 2:30am in Paris or in New York. We can make datetimes timezone *aware* by calling the `tz_localize()` method.

#%%
temp_series_ny = temp_series.tz_localize("America/New_York")
temp_series_ny

#%% [markdown]
# Note that `-04:00` is now appended to all the datetimes. This means that these datetimes refer to [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time) - 4 hours.
# 
# We can convert these datetimes to Paris time like this:

#%%
temp_series_paris = temp_series_ny.tz_convert("Europe/Paris")
temp_series_paris

#%% [markdown]
# You may have noticed that the UTC offset changes from `+02:00` to `+01:00`: this is because France switches to winter time at 3am that particular night (time goes back to 2am). Notice that 2:30am occurs twice! Let's go back to a naive representation (if you log some data hourly using local time, without storing the timezone, you might get something like this):

#%%
temp_series_paris_naive = temp_series_paris.tz_localize(None)
temp_series_paris_naive

#%% [markdown]
# Now `02:30` is really ambiguous. If we try to localize these naive datetimes to the Paris timezone, we get an error.

#%%
try:
    temp_series_paris_naive.tz_localize("Europe/Paris")
except Exception as e:
    print(type(e))
    print(e)

#%% [markdown]
# Fortunately using the `ambiguous` argument we can tell `pandas` to infer the right DST (Daylight Saving Time) based on the order of the ambiguous timestamps.

#%%
temp_series_paris_naive.tz_localize("Europe/Paris", ambiguous="infer")

#%% [markdown]
# ### Periods
# The `pd.period_range()` function returns a `PeriodIndex` instead of a `DatetimeIndex`. For example, let's get all quarters in 2016 and 2017:

#%%
quarters = pd.period_range('2016Q1', periods=8, freq='Q')
quarters

#%% [markdown]
# Adding a number `N` to a `PeriodIndex` shifts the periods by `N` times the `PeriodIndex`'s frequency.

#%%
quarters + 3

#%% [markdown]
# The `asfreq()` method lets us change the frequency of the `PeriodIndex`. All periods are lengthened or shortened accordingly. For example, let's convert all the quarterly periods to monthly periods (zooming in):

#%%
quarters.asfreq("M")

#%% [markdown]
# By default, the `asfreq` zooms on the end of each period. We can tell it to zoom on the start of each period instead.

#%%
quarters.asfreq("M", how="start")

#%% [markdown]
# And we can zoom out.

#%%
quarters.asfreq("A")

#%% [markdown]
# Of course we can create a `Series` with a `PeriodIndex`.

#%%
quarterly_revenue = pd.Series([300, 320, 290, 390, 320, 360, 310, 410], index = quarters)
quarterly_revenue


#%%
quarterly_revenue.plot(kind="line")
plt.show();

#%% [markdown]
# We can convert periods to timestamps by calling `to_timestamp`. By default this will give us the first day of each period, but by setting `how` and `freq`, we can get the last hour of each period.

#%%
last_hours = quarterly_revenue.to_timestamp(how="end", freq="H")
last_hours

#%% [markdown]
# And back to periods by calling `to_period`.

#%%
last_hours.to_period()

#%% [markdown]
# `pandas` also provides many other time-related functions that we recommend you check out in the [documentation](http://pandas.pydata.org/pandas-docs/stable/timeseries.html). To whet your appetite, here is one way to get the last business day of each month in 2016, at 9am:

#%%
months_2016 = pd.period_range("2016", periods=12, freq="M")
one_day_after_last_days = months_2016.asfreq("D") + 1
last_bdays = one_day_after_last_days.to_timestamp() - pd.tseries.offsets.BDay()
last_bdays.to_period("H") + 9

#%% [markdown]
# ## Exercises
#%% [markdown]
# 1. Create a Series using the following number: `3.14`, `2.718`, `1.618` with the following labels "`pi`", "`euler's number`", "`golden ratio`". Then filter values that are only greater than 2.
#%% [markdown]
# 2. Create the following DataFrame (But use `name` as the index):
# 
# | name | age | state | num_children | num_pets |
# |----|---|----|---|----|
# | john  | 23 | iowa | 2 | 0 |
# | mary  | 78 | dc | 2 | 4 |
# | peter  | 22 | california | 0 | 0 |
# | jeff  | 19 | texas | 1 | 5 |
# | bill  | 45 | washington | 2 | 0 |
# | lisa  | 33 | dc | 1 | 0 |
# 
# Then, create a bar plot that shows `age` for each person in `name`.
#%% [markdown]
# 3. Add another person as a new row to the previous DataFrame with the following values (**HINT**: use `pd.concat`):
# 
# name: `mike`, age: `0`, state: `new york`, num_children: `1`, num_pets: `0`.
# 
# Since this new person has a child, his age cannot be zero. Replace it with the median age of all other people in the DataFrame.
#%% [markdown]
# 4. Create a time series that contains one datetime per week for 14 weeks starting on March 4th 2019 at 6:30 pm for each Monday. **HINT**: use `pd.date_range`.
#%% [markdown]
# ### Possible solutions
#%% [markdown]
# 1. Indexing and selecting in Series
# 
# ```python
# s = pd.Series([3.14, 2.718, 1.618], index = ["pi", "euler's number", "golden ratio"])
# 
# s[s > 2]
# ```
# 
# 2. Creating and plotting a DataFrame
# 
# ```python
# df1 = pd.DataFrame(data={'age':[23,78,22,19,45,33],'state':['iowa','dc','california','texas','washington','dc'],'num_children':[2,2,0,1,2,1],'num_pets':[0,4,0,5,0,0]},index=['john','mary','peter','jeff','bill','lisa'])
# 
# df1.plot(kind = "bar", y = "age")
# ```
# 
# 3. Adding new row and handling missing data
# 
# ```python
# df2 = pd.DataFrame(data={'age':[0],'state':['new york'],'num_children':[1],'num_pets':[0]},index=['mike'])
# df3 = pd.concat([df1,df2]) 
# df2['age'] = df1['age'].median() # Calculate and add the median age of all other people to 'mike'
# df3 = pd.concat([df1,df2]) # Update the DataFrame
# ```
# 
# 4. Time series
# ```python
# ts = pd.date_range('2019/03/04 6:30pm', periods=14, freq='W-MON')
# ```
#%% [markdown]
# ## References
#%% [markdown]
# * [Machine Learning Notebooks](https://github.com/ageron/handson-ml2/blob/master/tools_pandas.ipynb)
# * [Python for Data Analysis](https://www.oreilly.com/library/view/python-for-data/9781491957653/)
#%% [markdown]
# ***
# 
# Machine Learning @ RMIT University

