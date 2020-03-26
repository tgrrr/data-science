#%% Change working directory from the workspace root to the ipynb file location. Turn this addition off with the DataScience.changeDirOnImportExport setting
import os
try:
	os.chdir(os.path.join(os.getcwd(), 'python_tuts'))
	print(os.getcwd())
except:
	pass
#%% [markdown]
# # Introduction to Python
#%% [markdown]
# There are many introductory Python tutorials out there. So, what does this introductory Jupypter notebook offer? This notebook is for students who wish to have their first hands-on experience with Python specifically for the purposes of data analysis and machine learning.
# 
# Before you proceed, please make sure you have installed Python 3 and Jupyter Notebook on your computer. We highyly recommend Anaconda distribution for easy installation and setup from a single download. For the installation instructions, you may visit YouTube video links shared under Python Resources on Canvas.
# 
# Throughout this course, we stick with Python 3. We shall not discuss Python versions, but please keep in mind Python 2 and 3 are not compatible. For more details, please refer to the [Python wiki page](https://wiki.python.org/moin/Python2orPython3).
#%% [markdown]
# ## Table of Contents
#   * [Working with Files](#Working-with-Files)
#   * [Modules/Names Imports](#Modules/Names-Imports)
#   * [Variables Assignment](#Variables-Assignment)
#   * [Base Types and Conversions](#Base-Types-and-Conversions)
#   * [Maths](#Maths)
#   * [Boolean Logic](#Boolean-Logic)
#   * [Container Types](#Container-Types)
#     + [Lists](#Lists)
#     + [Operations on Lists](#Operations-on-Lists)
#     + [Dictionary](#Dictionary)
#     + [Operations on Dictionaries](#Operations-on-Dictionaries)
#     + [Generic Operations on Containers](#Generic-Operations-on-Containers)
#   * [Strings](#Strings)
#     + [Operations on Strings](#Operations-on-Strings)
#   * [Conditional Statements](#Conditional-Statements)
#     + [If](#If)
#     + [If-else](#If-else)
#     + [If-elif](#If-elif)
#     + [Nested if](#Nested-if)
#   * [Conditional Loop Statement](#Conditional-Loop-Statement)
#     + [While](#While)
#   * [Iterative Loop Statement](#Iterative-Loop-Statement)
#     + [For](#For)
#   * [Loop Control](#Loop-Control)
#     + [Break](#Break)
#     + [Continue](#Continue)
#   * [Functions](#Functions)
#     + [Object Introspection](#Object-Introspection)
#   * [List Comprehension](#List-Comprehension)  
#   * [Exercises](#Exercises)
#     + [Possible solutions](#Possible-solutions)

#%%
# first set this so that jupyter notebook prints all output from a cell, 
# not just the most recent one
from IPython.core.interactiveshell import InteractiveShell
InteractiveShell.ast_node_interactivity = "all"

#%% [markdown]
# ## "Hello, World!"

#%%
print("Hello, World!")

#%% [markdown]
# ## Working with Files
#%% [markdown]
# How to open a file named "file.txt" and overwrite the content if not empty - the output shall be the number of characters written to the file:

#%%
f = open("file.txt", "w") 
f.write("Hello world! ")

#%% [markdown]
# Open the file "file.txt" and append content to the end of the file:

#%%
f = open("file.txt", "a")
f.write("Hello ML class!")

#%% [markdown]
# Open the file "file.txt" and read the content:

#%%
f = open("file.txt", "r", encoding = "utf8")
print(f.read())

#%% [markdown]
# We shall cover how to read and write `csv` files when we discuss the Pandas module.
#%% [markdown]
# ## Modules/Names Imports
#%% [markdown]
# A module is just a code library: a file containing a set of functions and variables you can include in your code. You can write your own modules, or just use other people's modules!

#%%
import numpy as np

np.zeros((3,4))

#%% [markdown]
# ## Variables Assignment
#%% [markdown]
# In Python, you can define a variable of one type, and then redefine it in some other type.

#%%
x = 3
print(x)
x = 'Hello'
print(x)


#%%
# Assignment to same value
y = z = 20
print(y)
print(z)


#%%
# Multiple assignments
a, b, c = 2, 5, 12
print(a, b, c)


#%%
# Values swap
a, b = b, a
print(a, b)


#%%
x = y = 5

# increment
x += 3  # x = x + 3

# decrement
y -= 2  # y = y - 2

print(x)
print(y)


#%%
# you can remove any variable from the memory using the del command
del x

#%% [markdown]
# ## Base Types and Conversions
#%% [markdown]
# | Base Types | Description |
# |----|---|
# | int  | Integer |
# | float  | Real |
# | bool  | Boolean (True or False) |
# | str  | String |
#%% [markdown]
# `int()`  - constructs an integer number from an integer literal, a float literal (by rounding down to the nearest whole number), or a compatible string literal.

#%%
x = int("1")
print(x)
type(x)


#%%
y = int(15.99)
print(y)
# watch out: this will not work: y = int("15.99")

#%% [markdown]
# In base Python, floats are 64-bit, but you can define floats and integers with other precision using Numpy. However, in base Python, integers have no limit! They can be arbirarily large.

#%%
x = 123**45
print(x)

#%% [markdown]
# `float()` - constructs a float number from an integer literal, a float literal, or a compatible string literal.

#%%
z = float("12.084")
print(z)
type(z)

#%% [markdown]
# ` str() ` - constructs a string from other compatible data types.

#%%
x = str("Hello")
print(x)
type(x)


#%%
y = str(3.45)
print(y)
type(y)

#%% [markdown]
# ## Maths
#%% [markdown]
# | Symbol | Task Performed |
# |----|---|
# | +  | Addition |
# | -  | Subtraction |
# | /  | division |
# | %  | mod |
# | *  | multiplication |
# | //  | floor division |
# | **  | to the power of |
# 

#%%
# Both / and // division always result in a float, even if the result is actually an integer
print(4/3)
x = 4/2
print(x)
type(x)


#%%
13%10


#%%
3.9//2


#%%
round(3.57, 1)

#%% [markdown]
# Expect to see some strange behaviour with rounding() - for instance, rounding to an integer is done to the nearest even number! Unlike what you might expect, rounding is a very tricky business and it has even caused [fatalities](https://en.wikipedia.org/wiki/Round-off_error). For a detailed explanation for rounding in Python, please see [this](https://realpython.com/python-rounding/).
#     

#%%
round(3.5, 0)
round(4.5, 0)


#%%
abs(-5.6)


#%%
pow(5,3)

#%% [markdown]
# ## Boolean Logic
# | Symbol | Task Performed |
# |----|---|
# | == | True, if it is equal |
# | !=  | True, if not equal to |
# | < | less than |
# | > | greater than |
# | <=  | less than or equal to |
# | >=  | greater than or equal to |
# | and | True, if both statements are true |
# | or  | True, if one of statements is true |
# | not | False, if the result is true|

#%%
a = 13
print(a)
a == 13


#%%
a == 33

#%% [markdown]
# Pay attention to equality vs. two variables being the same.

#%%
x = y = [1, 2, 3]
z = [1, 2, 3]
x == y
z == y
x is y  # this is True
z is y  # this is False!


#%%
a != 33


#%%
a > 12


#%%
a <= 14


#%%
x = 6
print(x > 5 and x < 10)


#%%
y = 2
print(y > 8 or y < 4)


#%%
z = 4
print(not(z > 2 and z < 10))

#%% [markdown]
# ## Container Types
#%% [markdown]
# ### Lists
#%% [markdown]
# List is an ordered sequence of elements that is enclosed in square brackets and separated by a comma. Each of these elements can be accessed by calling it's index value. 
# You can put any combination of data types into a list.
# Lists are declared by just equating a variable to `[ ]` or `list()`.

#%%
lst = [1, 1.23, True, "hello", None]
print(lst)


#%%
cars = ["Toyota", "Mercedes", "Ford"]


#%%
print(cars)

#%% [markdown]
# In Python, indexing starts from 0. Thus, for instance, the list ` cars `, which has three elements will have Toyota at 0 index, Mercedes at 1 index, and Ford at 2 index.

#%%
cars[0]

#%% [markdown]
# Indexing can also be done in reverse order. That is the last element can be accessed first. Here, indexing starts from -1. Thus index value -1 will be Ford, index -2 will be Mercedes, and index -3 will be Toyota.

#%%
cars[-1]

#%% [markdown]
# Indexing is limited to accessing a single element, Slicing, on the other hand, is accessing a sequence of elements inside the list. 

#%%
# pay attention to the range() function
# and how we use list() to convert the output to a proper list
num = list(range(0,10))
print(num)


#%%
print(num[0:4])
print(num[4:])


#%%
print(num[-3:])  # get the 3 elements from the end

#%% [markdown]
# It is also possible to slice a parent list with a step length.

#%%
num[:9:3]


#%%
num[:9:5]

#%% [markdown]
# #### Operations on Lists

#%%
lst = [1,2,1,8,7]

#%% [markdown]
# `append()` is used to add a element to the end of the list.

#%%
lst.append(1)
print(lst)

#%% [markdown]
# `extend()` is used to add another list at the end.

#%%
lst.extend([4,5])
print(lst)

#%% [markdown]
# Alternatively, we can use `+` to combine multiple lists (or multiple strings).

#%%
lst = lst + [1, 3]
print(lst)

#%% [markdown]
# ` insert(x,y)` is used to insert an element y at a specified index value x, while ` append()` function can insert the element only at the end.

#%%
lst.insert(5, 'hello')
print(lst)

#%% [markdown]
# `remove()` can be used to remove the first occurance of an element by specifying the element itself using the function.

#%%
lst.remove('hello')
print(lst)

#%% [markdown]
# ` sort()` method arranges the elements in ascending order **in place**. That is, the original list is updated with the new order. You can sort all numerical or all string lists, but not a mix of them.

#%%
lst_num = [3, 5, 1.23]
lst_num.sort()
print(lst_num)


#%%
lst_str = ['hello', 'world']
print(lst_str)
lst_str.sort(reverse=True)
print(lst_str)


#%%
lst_mix = [3, 5, 1.23, 'hello']
# this will not work: lst_mix.sort()

#%% [markdown]
# For reversing a list, use `reverse()`

#%%
lst_mix.reverse()
print(lst_mix)

#%% [markdown]
# If you do not want to modify the original list, use `sorted()` and `reversed()` and set them equal to a new list.

#%%
lst = [3, 5, 1]
lst_new = sorted(lst)
print('original:', lst)
print('sorted:', lst_new)
lst_reversed = reversed(lst)  # this returns an interator, not a list!
print('just reversed:', lst_reversed)
lst_reversed_list = list(lst_reversed)
print('reversed and re-listed:', lst_reversed_list)

#%% [markdown]
# `count()` is used to count the number of a particular element that is present in the list. If there is none, it will simply return 0.

#%%
lst.count(1)

#%% [markdown]
# `index()` is used to find the index of a particular element. Note that if there are multiple elements of the same value then this will return the first index. if there is none, it will throw an error.

#%%
lst


#%%
lst.index(1)

#%% [markdown]
# For other methods that are available for a list (or any other data structure), you can use the **tab completion feature** of Jupyter Notebook. Just define a list, put a dot, and then hit the `tab` button.

#%%
lst.clear()

#%% [markdown]
# If you want your list to be immutable, that is unchangable, use the **tuple** container. You can define a tuple by `()` or `tuple()`.

#%%
tpl = (1,2,3)
# this will not work - you cannot change a tuple: tpl[0] = 3.45

#%% [markdown]
# If you want a set in a mathematical sense, use the **set** container. You can define a set by `set()`. Python has a rich collection of methods for sets such as union, intersection, set difference, etc.

#%%
st = set([1,1,1,2,2,2,2])
print(st)

#%% [markdown]
# We will not use tuple or set very often in this course.
#%% [markdown]
# ### Dictionary
#%% [markdown]
# Dictionaries are like a lookup table. To define a dictionary, equate a variable to `{}` or `dict()`. 

#%%
d0 = {}
d1 = dict()
print(type(d0), type(d1))


#%%
d0 = {}
d0['One'] = 1
d0['Two'] = 2 
print(d0)

#%% [markdown]
# That is how a dictionary looks like. Now you are able to access '1' by the index value set at 'One'.

#%%
print(d0['One'])

#%% [markdown]
# #### Operations on Dictionaries
#%% [markdown]
# `values()` method returns a list with all the assigned values in the dictionary.

#%%
d0.values()

#%% [markdown]
# `keys()` method returns all the keys in the dictionary.

#%%
d0.keys()

#%% [markdown]
# `items()` method returns the key/ value combinations. This method is especially useful inside a for loop.

#%%
d0.items()

#%% [markdown]
# ` update()` inserts the specified items to the dictionary.

#%%
d1 = {"Three":3}
d0.update(d1)
d0

#%% [markdown]
# `clear()` function is used to erase the entire dictionary.

#%%
d0.clear()
print(d0)

#%% [markdown]
# ### Generic Operations on Containers

#%%
num = list(range(10))
num.append(13.45)
print(num)

#%% [markdown]
# To find the length of the list, that is, the number of elements in a list, use the `len()` method.
# 

#%%
len(num)

#%% [markdown]
# If the list consists of all numeric or all string elements, then `min()` and `max()` gives the minimum and maximum value in the list.

#%%
min(num)


#%%
max(num)


#%%
num2 = num + ['hello']
# this won't work because not all elements are numeric: min(num2)
# min() and max() also work with strings:
st = ['one','two', 'three']
min(st)

#%% [markdown]
# How to check if a particular element is in a predefined list or dictionary:

#%%
# list
names = ['Earth','Air','Fire']


#%%
'Tree' in names


#%%
'Air' in names

#%% [markdown]
# For a dictionary, `in` checks the keys, not values.

#%%
d0 = {'One': 1, 'Two': 2, 'Three': 3}


#%%
"One" in d0


#%%
"Four" in d0

#%% [markdown]
# ## Strings
#%% [markdown]
# Strings are immutable containers of characters that are defined by enclosing in the same single/double/triple quotes.

#%%
string0 = 'I love chocolate'
string1 = "I love 'coffee'"
string2 = '''I 
love 
bananas
'''


#%%
print(string0)
print(string1)
print(string2)

#%% [markdown]
# String indexing and slicing are similar to lists.

#%%
print(string0[2])
print(string0[7:])

#%% [markdown]
# You cannot modify a string!

#%%
# This will not work: string0[0] = 'w'

#%% [markdown]
# Starting Python 3.6, f-strings are the best way of putting other variables inside strings.

#%%
name = 'pi'
val = 3.45
print(f'The value of {name} is {val}.')

#%% [markdown]
# ### Operations on Strings
#%% [markdown]
# `find()` function returns the starting index of a given sequence of characters in the string. If not found, it returns -1.

#%%
print(string0.find('I'))
print(string0.find('we'))

#%% [markdown]
# `startswith()` method checks if a string starts with a particular sequence of characters.

#%%
print(string0.startswith('I love'))

#%% [markdown]
# `endswith()` method works similarly.

#%%
print(string0.endswith('a'))

#%% [markdown]
# `count()` method counts the number of occurance of a sequence of characters in the given string.

#%%
print(string1.count('e'))
print(string1.count('ee'))

#%% [markdown]
# `lower()` converts any upper case to lower and `upper()` does vice versa.

#%%
print(string0)
print(string0.lower())
print(string0.upper())

#%% [markdown]
# ` replace()` function replaces the element with another element.

#%%
string0_new = string0.replace('I','We all')
print(string0_new)

#%% [markdown]
# Try tab completion to see the full list of methods for strings.

#%%
st = 'aBc'
st.swapcase()

#%% [markdown]
# ## Conditional Statements
#%% [markdown]
# ### If
#%% [markdown]
# Statement block is executed only if a condition is true.
#%% [markdown]
# ~~~~
#     if logical condition:
#         statements block
# ~~~~
#%% [markdown]
# Make sure you put ":" at the end!!!

#%%
a = 27
b = 300

if b > a:
  print("b is greater than a")

#%% [markdown]
# ### If-else
#%% [markdown]
# ~~~~
#     if logical condition:
#         statements block    
#     else:
#         statements block
# ~~~~

#%%
a = 300
b = 27

if b > a:
  print("b is greater than a")
else:
  print("a is greater than b")

#%% [markdown]
# ### If-elif
#%% [markdown]
# ~~~~
#     if logical condition:
#         statements block  
#     elif logical condition:
#         statements block 
#     else:
#         statements block
# ~~~~

#%%
a = 27
b = 27

if b > a:
  print("b is greater than a")
elif a == b:
  print("a is greater than b")
else:
  print("a and b are equal")

#%% [markdown]
# ### Nested if
#%% [markdown]
# if statement inside a if statement or if-elif or if-else are called as nested if statements.

#%%
a = 25
b = 30

if a > b:
    print("a > b")
elif a < b:
    print("a < b")
    if a == 25:
        print("a = 25")
    else:
        print("invalid")
else:
    print("a = b")

#%% [markdown]
# ## Conditional Loop Statement
#%% [markdown]
# ### While
#%% [markdown]
# ~~~~
#   while some_condition:
#     some code
# ~~~~

#%%
i = 1
while i < 5:
    print(i ** 2)
    i = i + 1
print('Bye')

#%% [markdown]
# ## Iterative Loop Statement
#%% [markdown]
# ### For
#%% [markdown]
# Statements block is executed for each item of a container of iterator.
#%% [markdown]
# ~~~~
#     for variable in something:
#         statements block
# ~~~~
#%% [markdown]
# Note that the indentation is very important.

#%%
for i in range(5):
    print(i)


#%%
for i in [1,5,10,15]:
    print(i*5)


#%%
d0 = {'One': 1, 'Two': 2, 'Three': 3}
for key, value in d0.items():
    print(f'key is {key}, value is {value}.')

#%% [markdown]
# ## Loop Control
#%% [markdown]
# ### Break
#%% [markdown]
# As the name says. It breaks out of a loop when a condition becomes true.

#%%
for i in range(100):
    print(i)
    if i >= 5:
        break

#%% [markdown]
# ### Continue
#%% [markdown]
# This continues the rest of the loop. Sometimes when a condition is satisfied there are chances of the loop getting terminated. This can be avoided using continue statement.

#%%
for i in range(10):
    if i == 5:
        print("Skipping 5")
        continue
    else:
        print(i)

#%% [markdown]
# ## Functions
#%% [markdown]
# A function in Python is defined using the keyword ` def ` , followed by a function name, a signature within parentheses `()` , and a colon `:` . Functions that returns a value use the ` return ` keyword. If there is no return statement, the function implicitly returns `None`.
#%% [markdown]
# ~~~~
#     def function_name(identifier):
#         """ documentation """
#         statements block
#         return
# ~~~~

#%%
def some_function():   
    print("test")


#%%
some_function()


#%%
def i_love(name):
  print("I love " + name)


#%%
i_love("hot chocolate.")


#%%
def five_times(x):
  return 5 * x


#%%
five_times(3)

#%% [markdown]
# It is always a good habit to describe your functions. You can write the description right after declaring the function. For example, say we would like to create a `square` function to return the squared value given any number x.

#%%
def square(x):
    """
    Returns the square of the input.
    """
    return x ** 2


#%%
square(4)

#%% [markdown]
# To return `documentation` of a function, use `.__doc__` method as following.

#%%
square.__doc__

#%% [markdown]
# ## Object Introspection
#%% [markdown]
# For help with variables and functions, add `?` at the beginning.

#%%
# the output will appear in a box at the bottom of your browser.
get_ipython().magic('pinfo print')


#%%
get_ipython().magic('pinfo string0')


#%%
get_ipython().magic('pinfo square')

#%% [markdown]
# With functions, add `??` at the beginning to see the source code, if available.

#%%
get_ipython().magic('pinfo2 square')

#%% [markdown]
# ## List Comprehension
#%% [markdown]
# We can create a list with a for-loop as below. This is called list comprehension and it is a very commonly used Python feature.
# 
# ```python
# [dosomethingwithx for x in sequence]
# ```
#%% [markdown]
# For example, say we would like create a list of numbers ranging from 0 to 9.

#%%
[z for z in range(10)]

#%% [markdown]
# How to convert the above numbers to strings and then combine them:

#%%
st_lst = [str(z) for z in range(10)]
print(st_lst)
'-'.join(st_lst)

#%% [markdown]
# * List comprehension is very flexible as you can have conditional statements.
#   ```python
#   [dosomethingwithx for x in sequence if x somecondition]
#   [dosomethingwithx for x in sequence if somecondition else dosomethingelsewithx]
# 
#   ```
#%% [markdown]
# For example, how to return a list of even numbers ranging from 0 to 10:

#%%
[z for z in range(11) if z % 2 == 0]

#%% [markdown]
# ## Exercises
#%% [markdown]
# ### 1. List Comprehension
# Return a list of number ranging between 0 to 50 divisible by 3 and 5.
#%% [markdown]
# ### 2. Dictionaries
# 
# * Suppose we have the following dictionary.
# 

#%%
course_names = {'MATH2319': 'Machine learning', 'MATH2350': 'Intro to Analytics'}

#%% [markdown]
# * Add a new course named "Categorical Data Analysis" with course code MATH1298.
#%% [markdown]
# ### 3. Conditional statements and function
# 
# * Given a value `x`, write a function which can check if `x` is a number and return its squared value. If `x` is not a number, return none. Hint: use `isinstance(2.4, (int, float))`.
#%% [markdown]
# ### Possible solutions
# 
# 1.  List comprehension
# ```python 
# [z for z in range(51) if z%3 == 0 and z%5 == 0] 
# ```
# 2. Dictionaries 
# ```python 
# course_names['MATH1298'] = 'Categorical Data Analysis'
# ```
# 3. Conditional statements and function
# ```python
# def square(x):
#     """
#     Return the square of x.
#     """
#     if isinstance(x, (int, float)):
#         return x ** 2
#     else:
#         return None
# ```
#%% [markdown]
# ## References
#%% [markdown]
# * [Python Lectures](https://github.com/rajathkmp/Python-Lectures)
# * [Introduction-to-Python-Programming](https://nbviewer.jupyter.org/github/jrjohansson/scientific-python-lectures/blob/master/Lecture-1-Introduction-to-Python-Programming.ipynb)
# 
#%% [markdown]
# ***
# MATH2319 - Machine Learning @ RMIT University

