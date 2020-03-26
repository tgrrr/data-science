#%% Change working directory from the workspace root to the ipynb file location. Turn this addition off with the DataScience.changeDirOnImportExport setting
import os
try:
	os.chdir(os.path.join(os.getcwd(), 'python_tuts'))
	print(os.getcwd())
except:
	pass
#%% [markdown]
# # Numpy
#%% [markdown]
# NumPy, short for Numerical Python, is the fundamental library (i.e., module) for numerical computing in Python. NumPy is centered around a powerful n-dimensional array object and it contains useful linear algebra and random number functions. A large portion of NumPy is actually written in the `C` programming language. 
# 
# A NumPy array is similar to Python's `list` data structure. A Python list can contain any combination of element types: integers, floats, strings, functions, objects, etc. A NumPy array, on the other hand, must contain only one element type at a time. This way, NumPy arrays can be much faster and more memory efficient.
# 
# Both the `pandas` module (for data analysis) and the `scikit-learn` module (for machine learning) are built upon the NumPy module. The `matplotlib` module (for plotting) also plays nicely with NumPy. These four modules plus the base Python is practically all you need for basic to intermediate machine learning.
# 
# Two other fundamental Python modules closely related to machine learning are as follows - though we will not cover these in class:
# * `SciPy`: This module is for numerical computing including integration, differentiation, optimization, probability distributions, and parallel programming.
# * `StatsModels`: This module provides classes and functions for the estimation of many different statistical models, as well as for conducting statistical tests, and statistical data exploration.
#%% [markdown]
# ## Table of Contents
#   * [Creating arrays with Numpy](#Creating-arrays-with-Numpy)
#   * [Data types for arrays](#Data-types-for-arrays)
#   * [Arithmetic operations on arrays](#Arithmetic-operations-on-arrays)
#   * [Reshaping arrays](#Reshaping-arrays)
#   * [Adding and removing elements](#Adding-and-removing-elements)
#   * [Copying arrays](#Copying-arrays)
#   * [Broadcasting](#Broadcasting)
#   * [Conditional expressions with arrays](#Conditional-expressions-with-arrays)
#   * [Mathematical and statistical functions](#Mathematical-and-statistical-functions)
#   * [Universal functions](#Universal-functions)
#     + [Binary universal functions](#Binary-universal-functions)
#   * [Array indexing and slicing](#Array-indexing-and-slicing)
#     + [One-dimensional arrays](#One-dimensional-arrays)
#     + [Multi-dimensional arrays](#Multi-dimensional-arrays)
#   * [Transposing arrays](#Transposing-arrays)
#   * [Combining arrays](#Combining-arrays)
#   * [Sorting arrays](#Sorting-arrays)
#   * [Exercises](#Exercises)
#     + [Possible solutions](#Possible-solutions)

#%%
# first set this so that jupyter notebook prints all output from a cell, 
# not just the most recent one
from IPython.core.interactiveshell import InteractiveShell
InteractiveShell.ast_node_interactivity = "all"

#%% [markdown]
# Let's import `numpy`. Most people import it as `np`:

#%%
import numpy as np

#%% [markdown]
# ## Creating arrays with Numpy
#%% [markdown]
# NumPy’s array class is called **ndarray** (the n-dimensional array). It is also known by the alias **array**. Note that **numpy.array** is not the same as the standard Python library class **array.array**, which only handles one-dimensional arrays and offers less functionality. 
# 
# * In a NumPy array, each dimension is called an **axis** and the number of axes is called the **rank**. 
#     * For example, a 3x4 matrix is an array of rank 2 (it is 2-dimensional).
#     * The first axis has length 3, the second has length 4.
# * An array's list of axis lengths is called the **shape** of the array.
#     * For example, a 3x4 matrix's shape is `(3, 4)`.
#     * The rank is equal to the shape's length.
# * The **size** of an array is the total number of elements, which is the product of all axis lengths (eg. 3*4=12)
#%% [markdown]
# ### `np.array`
# The easiest way to create an array is to use the `array` function. This accepts any sequence-like object (including other arrays) and produces a new NumPy array containing the passed data.

#%%
arr1 = np.array([2, 10.2, 5.4, 80, 0])
arr1

#%% [markdown]
# Nested sequences, like a list of equal-length lists, will be converted into a multi-dimensional array:

#%%
data = [[1, 2, 3, 4], [5, 6, 7, 8]]
arr2 = np.array(data)
arr2


#%%
arr2.shape


#%%
arr2.ndim  # equal to len(a.shape)


#%%
arr2.size

#%% [markdown]
# ### Other functions to create arrays
# There are several other convenience NumPy functions to create arrays.
#%% [markdown]
# ### `np.zeros`
# Creates an array containing any number of zeros.

#%%
np.zeros(5)

#%% [markdown]
# It's just as easy to create a 2-D array (ie. a matrix) by providing a tuple with the desired number of rows and columns. For example, here's a 3x4 matrix:

#%%
np.zeros((2, 3))  # notice the double parantheses

#%% [markdown]
# You can also create an n-dimensional array of arbitrary rank. For example, here's a 3-D array (rank=3) with shape `(2,3,4)`:

#%%
np.zeros((2, 3, 2))

#%% [markdown]
# ### `np.ones`
# Produces an array of all ones.

#%%
np.ones((2, 3))

#%% [markdown]
# How to create an array with the same values:

#%%
(np.pi * np.ones((3,4))).round(2)

#%% [markdown]
# ### `np.arange`
# This is similar to Python's built-in `range` function, but much faster.

#%%
np.arange(5)


#%%
np.arange(1, 5)

#%% [markdown]
# It also works with floats:

#%%
np.arange(1.0, 5.0)

#%% [markdown]
# Of course, you can provide a step parameter:

#%%
np.arange(1, 5, step = 0.5)

#%% [markdown]
# ### `np.linspace`
# This is similar to `seq()` in R. Its inputs are (start, stop, number of elements) and it returns evenly-spaced numbers over a specified interval. By default, the stop value is **included**.

#%%
np.linspace(0, 10, 6)

#%% [markdown]
# ### `np.quantile`
# Computes the q-th quantile of its input. It plays nicely with `np.linspace`. 

#%%
a = np.arange(1, 51)
print('a =', a)
quartiles = np.linspace(0, 1, 5)
print('quartiles =', quartiles)


#%%
np.quantile(a, 0.5)  # how to compute the median


#%%
np.quantile(a, quartiles)

#%% [markdown]
# ### `np.rand` and `np.randn`
# A number of functions are available in NumPy's `random` module to create arrays initialized with random values.
# For example, here is a matrix initialized with random floats between 0 and 1 (uniform distribution):

#%%
np.random.rand(2,3).round(3)

#%% [markdown]
# Here's a matrix containing random floats sampled from a univariate [normal distribution](https://en.wikipedia.org/wiki/Normal_distribution) (Gaussian distribution) with mean 0 and variance 1:

#%%
np.random.randn(2,3).round(3)

#%% [markdown]
# ## Data types for arrays
#%% [markdown]
# | Type | Description |
# |----|---|
# | int16  | 16-bit integer types |
# | int32  | 32-bit integer types |
# | int64  | 64-bit integer types |
# | float16  | Half-precision floating point |
# | float32  | Standard single-precision floating point |
# | float64  | Standard double-precision floating point |
# | bool  | Boolean (True or False) |
# | string_  | String |
# | object  | A value can be any Python object |
#%% [markdown]
# ### `np.array.dtype`
# NumPy's arrays are also efficient in part because all their elements must have the same type (usually numbers).
# You can check what the data type is by looking at the `dtype` attribute.

#%%
arr1 = np.array([1, 2, 3], dtype = np.float64)


#%%
print("Data type name:", arr1.dtype.name)


#%%
arr2 = np.array([1, 2, 3], dtype = np.int32)


#%%
print(arr2.dtype, arr2)

#%% [markdown]
# ###  `np.array.astype `
# You can explicitly convert or cast an array from one  `dtype` to another using  `astype` method.

#%%
arr2.dtype


#%%
arr2 = arr2.astype(np.float64)


#%%
arr2.dtype # integers are now cast to floating point

#%% [markdown]
# If you have an array of strings representing numbers, you can use `astype` to convert
# them to numeric form.

#%%
numeric_strings = np.array(['1.25', '-9.6', '42'], dtype = np.string_)
numeric_strings


#%%
numeric_strings.astype(float)  # this will not take effect unless you do set it to a new variable!


#%%
numeric_strings.dtype

#%% [markdown]
# ## Arithmetic operations on arrays
#%% [markdown]
# All the usual arithmetic operators (`+`, `-`, `*`, `/`, `//`, `**`, etc.) can be used with arrays. They apply *element-wise*.

#%%
a = np.array([14, 23, 32, 41])
b = np.array([5,  4,  3,  2])
print("a + b  =", a + b)
print("a - b  =", a - b)
print("a * b  =", a * b)
print("a / b  =", a / b)
print("a // b  =", a // b)
print("a % b  =", a % b)
print("a ** b =", a ** b)

#%% [markdown]
# Note that the multiplication is **not** a matrix multiplication.
# 
# The arrays must have the same shape. If they do not, NumPy will apply the *broadcasting rules*, which is discussed further below.
#%% [markdown]
# ## Reshaping arrays
#%% [markdown]
# In many cases, you can convert an array from one shape to another without copying any data.
#%% [markdown]
# ###  `np.array.shape`
# Changing the shape of an array is as simple as setting its `shape` attribute. However, the array's size must remain the same.

#%%
g = np.arange(12)
print(g)
print("Rank:", g.ndim)


#%%
g.shape = (6, 2)
print(g)
print("Rank:", g.ndim)


#%%
g.shape = (2, 3, 2)
print(g)
print("Rank:", g.ndim)

#%% [markdown]
# ### `np.array.reshape`
# The `reshape` function returns a new array object pointing at the *same* data. This means that modifying one array will also modify the other.

#%%
g2 = g.reshape(4,3)  # you need to set this to a new variable to take effect!
print(g2)
print("Rank:", g2.ndim)

#%% [markdown]
# How about we get lazy and let NumPy figure out the details?

#%%
g2 = g.reshape(4, -1)  
print(g2)

#%% [markdown]
# How to convert a multi-dimensional array back to 1-dimensional (a.k.a ***array flattening***): you can use `reshape` or `flatten`.

#%%
f = np.arange(6).reshape(3,2)
f
f.reshape(-1)
f.flatten()

#%% [markdown]
# Set item at row 1, col 2 to 999 (more about indexing below).

#%%
g2[1, 2] = 999
g2

#%% [markdown]
# The corresponding element in `g` has been modified as well, even though g's shape is (2, 3, 2).

#%%
g

#%% [markdown]
# ### `np.array.resize`
#%% [markdown]
# If you want to repshape an array ***in-place***, that is, change the shape of the original array; you can use `resize()`.

#%%
g = np.arange(6)
g
g.resize(2,3)
# watch out! with resize(), you cannot use negative dimensions.
# so, this will not work: g.resize(2,-1)
g
g[0,0] = 111
g

#%% [markdown]
# ## Adding and removing elements
#%% [markdown]
# ### `np.append` and `np.insert`

#%%
a = np.arange(6)
print('original array:\n', a)

b = np.append(a, 111)
print('appending an element to the end:\n', b)

c = np.insert(a, 0, 111) 
print('inserting an element at a specific position:\n', c)

# watch out: these will NOT work: a.append(111), a.insert(0, 111)

#%% [markdown]
# ### `np.delete`

#%%
a = np.arange(6)
a
c = np.delete(a, [0,1])
print('deleting the first two elements:\n', c)

a.resize(2,3)
print('a after resize():\n', a)

e = np.delete(a, 0, axis=1) # you can delete an entire column by specifying axis=1
print('first column deleted:\n', e)

f = np.delete(a, 0, axis=0) # or you can delete an entire row by specifying axis=0
print('first row deleted:\n', f)

#%% [markdown]
# ## Copying arrays
# 
# NumPy usually does not make copies for efficiency. Most assignments are just views, not copies. If you want a copy, you need to say so.
# 
# You can use either `np.array.copy` or `np.copy`.

#%%
b = a = np.arange(6)
a_copy = a.copy()
# alternatively,
a_copy = np.copy(a)
a
b
a_copy
print(a == a_copy)  # element-wise comparison
print(a is a_copy)  # this is False
print(a is b)  # this is True
a[0] = -111  # changing a has no effect on a_copy
a
a_copy

#%% [markdown]
# ## Broadcasting
#%% [markdown]
# Broadcasting describes how NumPy treats arrays with different shapes during arithmetic operations. Broadcasting can get complicated, so we recommend you avoid it all together if you can and do either one of the two things below:
# * Broadcast only a scalar with an array
# * Broadcast arrays of the same shape

#%%
A = np.arange(6).reshape(3,2)
B = np.arange(6, 12).reshape(3,2)
A
B


#%%
A + B


#%%
3 * A


#%%
(A / 3).round(2)  # float division


#%%
A // 3  # integer division


#%%
11 + A

#%% [markdown]
# Element-wise matrix multiplication is done by `*`.

#%%
A * B

#%% [markdown]
# For usual matrix multiplication, you need to use `np.dot`.

#%%
B_new = B.reshape(2,-1)
B_new
np.dot(A, B_new)

#%% [markdown]
# ## Conditional expressions with arrays

#%%
x = np.array([10,20,30,40,50])
x >= 30


#%%
x[x >= 30]

#%% [markdown]
# ### `np.where`
# Returns the indices of elements in an input array where the given condition is satisfied.

#%%
y = np.arange(10)
print(y)
np.where(y < 5)

#%% [markdown]
# **Extremely useful:** You can use *`where`* for vectorised if-else statements.

#%%
compared_to_5 = list(np.where(y < 5, 'smaller', 'bigger'))
print(compared_to_5)

#%% [markdown]
# ## Mathematical and statistical functions
#%% [markdown]
# A set of mathematical functions that compute statistics about an entire array or about the data along an axis are accessible as methods of the array class.

#%%
a = np.array([[-2.5, 3.1, 7], [10, 11, 12]])
print(a)


#%%
np.max(a)


#%%
np.min(a)


#%%
np.mean(a)


#%%
np.prod(a)


#%%
np.std(a)


#%%
np.var(a)


#%%
np.sum(a)

#%% [markdown]
# These functions accept an optional argument `axis` which lets you ask for the operation to be performed on elements along the given axis. For example:

#%%
b = np.arange(12).reshape(2,-1)
b


#%%
b.sum(axis=0)  # sum across columns


#%%
b.sum(axis=1)  # sum across rows

#%% [markdown]
# ## Universal functions
#%% [markdown]
# A universal function, or **ufunc**, is a function that performs element-wise operations on data in ndarrays. You can think of them as fast vectorized wrappers for simple functions that take one or more scalar values and produce one or more scalar results.
# 
# Many ufuncs are simple element-wise transformations, like sqrt or exp. These are referred to as **unary ufuncs**. 

#%%
z = np.array([[-2.5, 3.1, 7], [10, 11, 12]])

#%% [markdown]
# ### `np.square`
# Element-wise square of the input.

#%%
np.square(z)

#%% [markdown]
# ### `np.exp`
# Calculate the exponential of all elements in the input array.

#%%
np.exp(z)

#%% [markdown]
# ### Binary universal functions
# Others, such as add or maximum, take two arrays (thus, **binary ufuncs**) and return a single array as the result:

#%%
x = np.array([3, 6, 1])
y = np.array([4, 2, 9])
print(x)
print(y)

#%% [markdown]
# ### `np.maximum`
# Element-wise maximum of array elements - do not confuse with `np.max` which finds the max element in the array.

#%%
np.maximum(x,y)

#%% [markdown]
# ### `np.minimum`
# Element-wise minimum of array elements - do not confuse with `np.min` which finds the min element in the array.

#%%
np.minimum(x,y)

#%% [markdown]
# ### `np.power`
# First array elements raised to powers from second array, element-wise.

#%%
np.power(x,y)

#%% [markdown]
# ## Array indexing and slicing
#%% [markdown]
# ###  One-dimensional arrays
# One-dimensional NumPy arrays can be accessed more or less like regular Python arrays:

#%%
a = np.array([1, 5, 3, 19, 13, 7, 3])
a[3]


#%%
a[2:5]


#%%
a[2:-1]


#%%
a[:2]


#%%
a[2::2]


#%%
a[::-1]

#%% [markdown]
# Of course, you can modify elements:

#%%
a[3]=999
a

#%% [markdown]
# You can also modify an array slice:

#%%
a[2:5] = [997, 998, 999]
a

#%% [markdown]
# ### Multi-dimensional arrays
# Multi-dimensional arrays can be accessed in a similar way by providing an index or slice for each axis, separated by commas:

#%%
b = np.arange(48).reshape(4, 12)
b


#%%
b[1, 1]  # row 1, col 2 (recall that Python slices starting at index 0)


#%%
b[1, :]  # row 1, all columns


#%%
b[:, 1]  # all rows, column 1

#%% [markdown]
# **Caution**: Note the subtle difference between these two expressions: 

#%%
b[1, :]


#%%
b[1:2, :]

#%% [markdown]
# The first expression returns row 1 as a 1D array of shape `(12,)`, while the second returns that same row as a 2D array of shape `(1, 12)`.
#%% [markdown]
# ## Transposing arrays
#%% [markdown]
# An array's `transpose` or `T` method transposes the array.

#%%
a = np.arange(10).reshape(5,-1)
a


#%%
a_t = a.transpose()
a_t


#%%
a_t = a.T  # this also works
a_t

#%% [markdown]
# ## Combining arrays
#%% [markdown]
# ### `np.vstack`: stack arrays vertically

#%%
a = 1 + np.arange(3)
b = -1 * a
c = 10 + a
print(a)
print(b)
print(c)
d = np.vstack((a, b, c))  # notice the double parantheses
print('stack vertically:\n', d)

#%% [markdown]
# ### `np.hstack`: stack arrays horizontally

#%%
d = np.hstack((a, b, c))  # notice the double parantheses
print('stack horizontally:\n', d)

#%% [markdown]
# ## Sorting arrays
# You can use an array's `sort` method, but pay attention as sorting is done **in-place**!

#%%
a = np.array([3, 5, -1, 0, 11])
print(a)
sort_output = a.sort()
print('a has been sorted in place:\n', a)
print(sort_output) # tricky: this will print None!

#%% [markdown]
# If you do not want to sort in place, you need to use **`np.sort`**.

#%%
a = np.array([3, 5, -1, 0, 11])
print(a)
b = np.sort(a)
print(b)
print('Notice a is not changed:\n', a)

#%% [markdown]
# If you want reverse sort, you need to do it indirectly as there is no direct option for it inside the `sort` methods.

#%%
a_reverse_sorted = np.sort(a)[::-1]
print(a_reverse_sorted)

#%% [markdown]
# ## Exercises
#%% [markdown]
# 1. Initialize a 5 $\times$ 3 2D array with all numbers divisible by 3 between 3 and 4. **HINT**: `np.arange`'s argument `step`. For example, you can create an array of 0, 2, 4, 6, 8 by calling `np.arange(0, 10, step = 2)`. Then slice the last column of the array.
#%% [markdown]
# 2. Create an array say `a = np.random.uniform(1, 10, 10)`. Find the location or index of the maximum value in `a`. How about the location of the minimum value? **HINT**: use `argmax` and `argmin` methods
#%% [markdown]
# 3. Create the following array and find the maximum values in each row. How about column-wise maximum values? **HINT**: use `np.amax`.
# 
# $$A = \begin{bmatrix} 1 & 3 & 4 \\ 2 & 7 & -1 \end{bmatrix}$$
#%% [markdown]
# 4. Missing values such as `NA` and `nan` are not uncommon in data science (technically, `nan` is not a missing value. It stands for not-a-number.) Create the following matrix which contains one `nan` using `np.nan`.
# 
# $$B = \begin{bmatrix} 1 & 3 & \text{nan} \\ 2 & 7 & -1 \end{bmatrix}$$
#%% [markdown]
# 5. Find the column-wise and the row-wise maximum values in `B` created in the previous question. Does `np.amax` return any value? **HINT**: Try `np.nanmax` method.
#%% [markdown]
# ### Possible solutions
# 
# 1. Initializing and slicing arrays
# 
# ```python
# import numpy as np
# # Create and reshape the array
# myarray = np.arange(3, 48, step = 3)
# myarray.shape = (5, 3)
# 
# # Slice the last column
# myarray[:,2]
# ```
# 
# 2. Indexing the maximum and minimum
# 
# ```python
# import numpy as np
# a = np.random.uniform(1, 10, 10)
# a
# a.argmax() # Find the maximum index
# a.argmin() # Find the minimum index
# ```
# 
# 3. Column-wise and row-wise maximum and minimum values.
# 
# ```python
# import numpy as np
# A = np.array([[1, 3, 4],[2, 7, -1]])
# np.amax(A, axis = 0) # Column-wise
# np.amax(A, axis = 1) # Row-wise
# ```
# 
# 4. Creating `nan` with `numpy`.
# 
# ```python
# import numpy as np
# B = np.array([[1, 3, np.nan],[2, 7, -1]])
# ```
# 
# 5. Column-wise and row-wise maximum and minimum values in the presence of `nan` values.
# 
# ```python
# import numpy as np
# B = np.array([[1, 3, np.nan],[2, 7, -1]])
# np.nanmax(B, axis = 0) # Column-wise
# np.nanmax(B, axis = 1) # Row-wise
# ```
#%% [markdown]
# ## References
#%% [markdown]
# * [Machine Learning Notebooks](https://github.com/ageron/handson-ml2/blob/master/tools_numpy.ipynb)
# * [Python for Data Analysis](https://www.oreilly.com/library/view/python-for-data/9781491957653/)
# * [Python Data Science Handbook](https://jakevdp.github.io/PythonDataScienceHandbook)
#%% [markdown]
# ***
# 
# MATH2319 - Machine Learning © RMIT University

