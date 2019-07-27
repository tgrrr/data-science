# 1 Data Preprocessing Intro

## Data Analysis Steps

- **Defining Problem Statement:** This is the first step of data analysis. In this step, the problem statement is identified by the organisations/researchers. The data analyst should thoroughly understand the problem and the domain of the problem.
- **Planning and Collecting Data:** In this step, the appropriate tools for data collection related to the problem statement will be identified. This step may include designing a survey for data collection, scraping data from web or accessing an Excel/a database file.
- **Data Preprocessing:** The objective of this step is to make the data ready for the further statistical analysis. This step is considered to be one of the important phases in data analysis. The accuracy of the statistical analysis depends on the quality of the data gained in this step. A number of operations such as importing data, reshaping data from long to wide format, filtering data, cleaning data, identifying outliers, and transforming variables can be applied to the data to make ready for the statistical analysis.
- **Exploring Data via Descriptive Statistics/Visualisations:** The objective of this step is to understand the main characteristics of the data. Exploratory analyses are generally done using descriptive statistics (i.e. mean, median, standard deviation, frequencies, percentages etc.) and visualisation tools (i.e. scatter plots, box-plots, histograms, interactive data visualisations etc.). Exploratory analysis will show you the things that you didn’t expect, or raise new questions about the data.
- **Analysing/Modelling Data:** The statistical analysis/modelling step can include a broad range of techniques like statistical hypothesis testing, statistical modelling, and machine learning algorithms. Generally, the type of the variables in the data set and the purpose of the investigation will determine the appropriate analysis technique.
- **Interpretation and Reporting:** The last step of the data analysis is the reporting and the interpretation of the results. This step is also critical as if you cannot understand and communicate your results to others, it doesn’t matter how well you conducted your analysis.

## Preprocessing Steps

- **Get**: A data set can be stored in a computer or can be online in different file formats. We need to get the data set into R by importing it from other data sources (i.e., .txt, .xls, .csv files and databases) or scraping from web. R provides many useful commands to import (and also export) data sets in different file formats.
- **Understand**: We cannot perform any type of data preprocessing without understanding what we have in hand. In this step, we will check the data volume (i.e., the dimensions of the data) and structure, understand the variables/attributes in the data set, and understand the meaning of each level/value for the variables.
- **Tidy** & Manipulate: In this step, we will apply several important tasks to tidy up messy data sets. We will follow Hadley Wickham’s “Tidy Data” principles (Wickham and others (2014)):
  - Each variable should form a column.
  - Each observation should form a row.
  - Each type of observational unit should form a table.
  - We may also need to manipulate, i.e. filter, arrange, select, subset/split data, or generate new variables from the data set.
- **Scan**: This step will include
  - checking for plausibility of values,
  - cleaning data for obvious errors,
  - identifying and handling outliers,
  - and dealing with missing values.
- **Transform**: Some statistical analysis methods are sensitive to the scale of the variables and it may be necessary to apply transformations before using them. In this step we will introduce well-known
- data transformations,
- data scaling,
- centering,
- standardising and
- normalising methods.
