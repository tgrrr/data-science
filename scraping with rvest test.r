
# https://www.asial.com.au/members-directory/search/?command=getresults&LocationRadius=20&Filter::StatesInWhichALicenceIsHeld::SelectMany=ACT

url <- "https://www.asial.com.au/members-directory/search/?command=getresults&LocationRadius=20&Filter::StatesInWhichALicenceIsHeld::SelectMany=ACT"
# doc <- "https://www.asial.com.au/members-directory/"

GetContact <- function(url) {
  suppressPackageStartupMessages(library(plyr))
  suppressPackageStartupMessages(library(dplyr))
  suppressPackageStartupMessages(library(stringr))
  suppressPackageStartupMessages(library(rvest))
  suppressPackageStartupMessages(library(httr))
  suppressPackageStartupMessages(library(methods))
  ps <- read_html(url)
  company_name_html <- html_nodes(ps, ".searchResults h3 a")
  company_name <- html_text(company_name_html)
  details <- html_nodes(ps, ".searchResults p")
  output <- html_text(details)
  head(company_name)
  head(output)
}

GetContact(url)
help(html_text)

title <- html_node(search_results, "strong")
#title

  html_nodes("body")  %>%
  html_node("div.searchResults")
head(asial)

?stringr

??rvest
