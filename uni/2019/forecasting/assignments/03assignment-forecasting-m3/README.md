# Notes in class:

### Slides:
- Title + name
- Intro
- Multiple plots on same page
- Captions
- Include a table of the results

# Final Project - Competitive

## Description:
You can work on this assignment independently or as teams (composed of at most five students per team). In short, the challenge is to find the best fitting model to the given MC3 series.

International Institute of Forecasters (IIF) runs a competition, called M - Competitions, which is led by forecasting researcher Spyros Makridakis (Links to an external site.). The aim of the competition is to evaluate and compare the accuracy of forecasting methods over a massive collection of 3003 data series with different characteristics. It started with M – Competition in 1982 and continued M2 and M3 in 1993 and 2000, respectively. In June 2017, another M3 Competition took place in Cairns, Australia. You can refer to the website of IIF (Links to an external site.) for more details. Organizers published the results, conclusions and implications of the competition in the International Journal of Forecasting (Links to an external site.) after the first M3 Competition in 2000. In this competitive final assignment, we will use a slightly different approach for the competition than the original M3 Competition.

The original dataset is reduced to 1000 series including yearly, quarterly, and monthly micro-economic, macro-economic, industrial, financial, and demographic time series data. The dataset you will focus on is given by the file M3C_reduced_2019.xlsx.

You can work on this assignment independently or as teams (composed of at most four students per team).

## Your tasks are to:

- fit the suitable models among the ones covered in MATH1307 Forecasting course in this semester to the 95% (round up to get an integer number of observations) of each of the given 1000 series and obtain the model that gives the minimum MASE value for each series. By this way, you will choose your best model for each series. Then, you will calculate the mean minimum MASE for each of yearly, quarterly, and monthly periods. So, you will have three overall mean minimum MASE values for yearly, quarterly, and monthly periods.
- use the remaining 5% of each series to check the quality of your forecasts. For this, you will use your best models found in Task 1 to calculate MASE values over the forecasts for 6, 8, and 18 times-ahead forecasts for yearly, quarterly, and monthly periods, respectively. Then you will find the overall average of MASE values for each of yearly, quarterly, and monthly periods.

The final scoring of the groups will be done according to the following rules:

- The group that finds the minimum mean MASE for each period type gets 10 points. The total number of nonnormal standardized residuals out of 1000 according to the Shapiro-Wilks test and the total number of standardized residuals with significant serial correlations out of 1000 at 5% level of significance will be counted and multiplied by 0.015 points as the penalty value. Then, the overall average of fits and forecasts will be penalized by the penalty value.
- The groups that come as close as 3%, 5%, and 15% to the top group will 8, 6, and 3 points, respectively. The penalty points for these groups will be as shown in the following table.
MATH1307_FinalComp_marks.png
- The final score of each group will directly be added to the final mark of the students in each group before the calculation of final grades.

Please note that:

- Obviously, time series regression methods covered in Modules 3 and 4 are outside the methods that can be applied for this competition.
- All the submitted reports will be accepted as the final project report and presented by the team members during final project presentations.
- You will have the option of submitting a video presentation instead of giving a class presentation.
- As in other data science competitions, e.g. Datathon (Links to an external site.), this task will be like a real data science consulting task. So, I will not answer specific questions about data analysis or reporting. Instead, it is expected that you ask yourself what are the elements of a suitable and successful data analysis, and how you might go about presenting your results in a written report format and as an oral presentation. I’m happy to talk on general questions on this task.

- The timeline for both competitive and regular final projects is as follows:

timetable.png

Presentations:
You can either go for a Video presentation of Class presentation.

## Here are the rules for the class presentations:

- Each presentation is limited to 2 minutes maximum. This would increase based on the final number of class presentations.
- You can use 7 slides maximum including the cover slide.
- For example, you can arrange your presentation such that
  - 2 slides for data description and visual analysis,
  - 1 slide for model specification,
  - 1 slide for parameter estimation,
  - 1 slide for residual analysis, and
  - 1 or 2 slides for model selection and forecasts.
- Animations or sounds on slides are not allowed.
- The class presentations will take place on 16/10/2019 between 05:30 - 08:30 pm in 80.10.17.

As for the video presentations, we have the following rules:

- Each presentation is limited to 7 minutes maximum.
- You can use maximum 20 slides including the cover slide.
- You do not need to do a class presentation if you submit a video presentation. If you do a class presentation, you cannot submit a video presentation.
- I’ll share the presentations with the class if you want me to do so.
- Your presentation must be in a common video format that I can open it. Please see this - site before preparing your video presentation.
- You can upload your presentation to a platform like YouTube obeying the academic - integrity rules and share the link with me.
- Please email your video or the associated link to me by 4:00 pm on 16th of October 2019.
 

## Marking Rubric:
<!-- TODO: You can download the rubric here. -->


---

<!-- Final Project - Regular
Description:
You can work on this assignment independently or as teams (composed of at most four students per team).

In this assignment, you will find a time series dataset, preferably a public one, and analyse the data by using the analysis methods covered in MATH1307 Forecasting course in this semester, accurately predict the series for the next 10 units of time, and prepare a comprehensive analysis report including descriptive analysis, proper visualisation, model specification, model fitting and selection, and diagnostic checking.

The quality of data will be assessed in terms of originality of study and difficulty of modeling. Therefore, the length and characteristics of the time series you will choose for the final project are just up to you.

All final project reports submitted will be presented by the team members during final project presentations.

As in other data science competitions, e.g. Datathon (Links to an external site.), this task will be like a real data science consulting task. So, I will not answer specific questions about data analysis or reporting. Instead, it is expected that you ask yourself what are the elements of a suitable and successful data analysis, and how you might go about presenting your results in a written report format and as an oral presentation. I’m happy to talk on general questions on this task.

Submission Instructions:
All reports must be submitted via the Turnitin link.
Your submission should be uploaded as a PDF or Microsoft Word file.
Your report should meet with English language requirements.
Late submissions will be marked in accordance with the late submission policy explained under “Assessment” title of the course information sheet.
Presentations:
You can either go for a Video presentation of Class presentation.

Here are the rules for the class presentations:

Each presentation is limited to 2 minutes maximum. This would increase based on the final number of class presentations.
You can use 7 slides maximum including the cover slide.
For example, you can arrange your presentation such that
2 slides for data description and visual analysis,
1 slide for model specification,
1 slide for parameter estimation,
1 slide for residual analysis, and
1 or 2 slides for model selection and forecasts.
Animations or sounds on slides are not allowed.
The class presentations will take place on 16/10/2019 between 05:30 - 08:30 pm in 80.10.17.
The order of class presentations will be randomised.
This will be a good experience of explaining your analysis results within a limited time frame since you probably won’t have a manager/supervisor who can listen to you more than a couple of minutes in the outside world.

As for the video presentations, we have the following rules:

Each presentation is limited to 7 minutes maximum.
You can use maximum 20 slides including the cover slide.
You do not need to do a class presentation if you submit a video presentation. If you do a class presentation, you cannot submit a video presentation.
I’ll share the presentations with the class if you want me to do so.
Your presentation must be in a common video format that I can open it. Please see this site before preparing your video presentation.
You can upload your presentation to a platform like YouTube obeying the academic integrity rules and share the link with me.
Please email your video or the associated link to me by 4:00 pm on 16th of October 2019.
 

Collaboration vs. Collusion and Plagiarism:
You are free to discuss the main aspects of the assignment with your classmates. However, keep in mind that this is an individual assignment and you should demonstrate your own effort and understanding. Because assignments will be submitted through Turnitin, all the material you submitted will be checked for plagiarism. If plagiarism is detected, both the copier and the student copied from will be responsible. Therefore, it is your responsibility to ensure you do not copy or do not allow other classmates to copy your work. You should ensure you understand your responsibilities by reading the RMIT University website on academic integrity (Links to an external site.).

Marking Rubric:
The following rubric can be downloaded from here. -->

03assignment
==============================

forecasting m3

Project Organization
------------

    ├── LICENSE
    ├── Makefile           <- Makefile with commands like `make data` or `make train`
    ├── README.md          <- The top-level README for developers using this project.
    ├── data
    │   ├── external       <- Data from third party sources.
    │   ├── interim        <- Intermediate data that has been transformed.
    │   ├── processed      <- The final, canonical data sets for modeling.
    │   └── raw            <- The original, immutable data dump.
    │
    ├── docs               <- A default Sphinx project; see sphinx-doc.org for details
    │
    ├── models             <- Trained and serialized models, model predictions, or model summaries
    │
    ├── notebooks          <- Jupyter notebooks. Naming convention is a number (for ordering),
    │                         the creator's initials, and a short `-` delimited description, e.g.
    │                         `1.0-jqp-initial-data-exploration`.
    │
    ├── references         <- Data dictionaries, manuals, and all other explanatory materials.
    │
    ├── reports            <- Generated analysis as HTML, PDF, LaTeX, etc.
    │   └── figures        <- Generated graphics and figures to be used in reporting
    │
    ├── requirements.txt   <- The requirements file for reproducing the analysis environment, e.g.
    │                         generated with `pip freeze > requirements.txt`
    │
    ├── setup.py           <- makes project pip installable (pip install -e .) so src can be imported
    ├── src                <- Source code for use in this project.
    │   ├── __init__.py    <- Makes src a Python module
    │   │
    │   ├── data           <- Scripts to download or generate data
    │   │   └── make_dataset.py
    │   │
    │   ├── features       <- Scripts to turn raw data into features for modeling
    │   │   └── build_features.py
    │   │
    │   ├── models         <- Scripts to train models and then use trained models to make
    │   │   │                 predictions
    │   │   ├── predict_model.py
    │   │   └── train_model.py
    │   │
    │   └── visualization  <- Scripts to create exploratory and results oriented visualizations
    │       └── visualize.py
    │
    └── tox.ini            <- tox file with settings for running tox; see tox.testrun.org


--------

<p><small>Project based on the <a target="_blank" href="https://drivendata.github.io/cookiecutter-data-science/">cookiecutter data science project template</a>. #cookiecutterdatascience</small></p>
