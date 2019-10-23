Module 7: Tasks
Nonlinear and Heteroscedastic Innovations State-Space Models
The aims of the tasks given here are to

improve R skills in the application of state-space models,
practice choosing the most suitable state-space model among the available state space and exponential smoothing models,
observe the effect of treating the error terms additively or multiplicatively, and
improve the ability to draw inferences from the results of state-space models.
Working individually or in small groups, please complete the following task.

In this task, we will revisit the monthly unemployment rate data of Austria between January 1995 and May 2017. Recall that in this series the pattern of seasonality was changing in 2005. The unemployment series is available in the file Austria_Unemployment.csvPreview the document. Please load the data series from into the workspace of R and do the following tasks using both exponential smoothing and state-space models:
Display the series using suitable descriptive plots and draw inferences about the mechanism behind the series.
Considering the structure of seasonality is changing in the observation period, fit suitable state-space models to this data.
Select the best model for this series considering the goodness-of-fit measures and the results of diagnostic checks.
Run the ets() function in the auto selection mode and compare the model suggested by this function with the one you selected.
Eliminate seasonal serial correlation in the series and fit state-space models.
Find the best model that captures the serial correlation in the series as much as possible.
Plot original series, forecasts and limits of 95% forecast interval over the original series.
 

