## Books

- [R for Data Science - Garrett Grolemund & Hadley Wickham](http://r4ds.had.co.nz/)
- [Boehmke, B. C. (2016). Data Wrangling with R. Springer](https://ebookcentral.proquest.com/lib/RMIT/reader.action?ppg=1&docID=4745483&tm=1519623637648)
- [bookmark for me at ProQuest](https://ebookcentral.proquest.com/lib/RMIT/detail.action?docID=4745483#goto_toc)


## Install

[Download R](https://cran.r-project.org/)

[R Studio](https://www.rstudio.com/products/rstudio/download/#download)

[awesome R](https://project-awesome.org/qinwf/awesome-R)

- [DataCamp](https://www.datacamp.com/)

[Cheatsheets for R](https://www.rstudio.com/resources/cheatsheets/)


## Course:

[Machine learning by Stanford](https://www.coursera.org/learn/machine-learning) ~$100 when I checked

## For Jupyter Notbook

https://github.com/IRkernel/IRkernel


## Hydrogen For Atom

[Hydrogen to Combine Jupyter with Atom](https://medium.com/@boolean/hydrogen-add-jupyter-functionality-to-atom-the-hackable-text-editor-8f84b305eda0) - Simple howto

1. [Install Hydrogen](https://nteract.gitbooks.io/hydrogen/docs/Installation.html)

`apm install hydrogen`

[plugin:](https://github.com/lgeiger/hydrogen-launcher)
tldr: `apm install hydrogen-launcher`

Why? Hydrogen atoms make up 90% of Jupiter by volume.

2. Install MobX

`apm install atom-mobx`

2. [Setup Kernels](https://irkernel.github.io/installation/)

in iTerm3 (in R console (not in R Studio)
)
1. `R`
2.
```{R}
install.packages(c('repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest'))
devtools::install_github('IRkernel/IRkernel')
```

3. Don't forget:
`IRkernel::installspec(user = FALSE)`

4. [Testing it works in R Terminal](https://github.com/IRkernel/IRkernel/issues/486):

`system('jupyter kernelspec --version')`

5. Get the directory:

`R.home()`

6. Start the notebook

1. `>Jupyter notebook`
2. click new
3. click R

OR [Start IRkernel ](https://irkernel.github.io/running/) `> jupyter qtconsole --kernel=ir`



## For Dash




### Troubleshooting:
https://stackoverflow.com/questions/44336345/running-r-from-mac-osx-terminal

https://stackoverflow.com/questions/44336345/running-r-from-mac-osx-terminal
https://github.com/IRkernel/IRkernel/issues/513




## Getting Started


https://stackoverflow.com/questions/44336345/running-r-from-mac-osx-terminal


## Bonus:

https://github.com/nteract/nteract
Quick and dirty (manual)
`npm run app:desktop`

## Uni links

http://rare-phoenix-161610.appspot.com/secured/index.html (open incognito)
