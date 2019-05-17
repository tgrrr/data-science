#%%
import pandas as pd
msg = "Hello World"
print(msg)
#%%
msg = "Hello again"
print(msg)

#%%
import matplotlib.pyplot as plt
import matplotlib as mpl
import numpy as np

x = np.linspace(0, 20, 100)
plt.plot(x, np.sin(x))
plt.show()

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #

# CONTENTS - AKA Rubric

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #

# Phase 1

  ## Source and Description - Rubric 3/20
    # NOTE: (Detailed descriptive statistical analysis of the data)
    # NOTE: categorical or regression (numerical), not time-series
    
  ## Goals and Objectives - Rubric 3/20
    # NOTE: clear statement of your goals and objectives

  ## Data Preprocessing - Rubric 5/20
    # NOTE: (dealing with missing values, outliers, data transformation, data aggregation, etc.)
    # NOTE: **Data preprocessing ** is more than just filling in missing values or removing outliers. I suggest you have a look at the sample project phase 1 report for some examples. You should also take a look at Chapter 3 in the textbook that talks about data preprocessing.
    # NOTE: If your dataset is completely preprocessed, that's OK, but in this case we will expect that you spend some more effort on the descriptive statistics / initial data analysis tasks.
    ### 2.1. Preliminaries - demoReport
    ### 2.2 Data Cleaning

  ## Data Analysis - Rubric 5/20
    ### 3.1 Univariate Visualisation
      ### 3.1.1 Numerical Features
      ### 3.1.2 Categorical Features
    ### 3.2 Multvariate Visualisation
      ### 3.2.1. Scatterplot Matrix
      ### 3.2.2 Others

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #

# Later:
# Phase 2

  ## Complete overview of methodology - Rubric 4/30
    # NOTE: three different ML algorithms
  ## Algorithm fine-tuning and performance analysis - Rubric 10/30
  ## Performance comparison - Rubric 4/30
    # NOTE:  present performance comparisons to indicate which method seems to work best
  ## A critique of your approach - Rubric 4/30
  ## Summary and conclusions - Rubric 4/30

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #

# TODOLATER:

# - text: between 3 to 10 pages for each phase
# - total: between 3 to 10 pages for each phase
# - Table of contents
# - Clearly identify your dependent variable
# - each step needs to be clearly articulated
# - Your analyses should be ** tied to your goals and objectives ** rather than being just random.
# - Present a good **real-world understanding**


## Data sources


# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #

# print("Hello, World!")

# Packages
# import matplotlib
# import pandas as pd
# import numpy as np

# from IPython.core.interactiveshell import InteractiveShell
# InteractiveShell.ast_node_interactivity = "all"

# arr1 = np.array([2, 10.2, 5.4, 80, 0])
# arr1
