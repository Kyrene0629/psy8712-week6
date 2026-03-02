# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(stringi)
# library(potential one)
# library(potential one)

# Data Import
citations <- stri_read_lines("../data/cites.txt", encoding = "Windows-1252")
citations_txt <- str_subset(citations, pattern = "\\S")
print(str_c("The number of blank lines eliminated was ", length(citations) - length(citations_txt)))
print(str_c("The average number of characters/citation was", mean(str_length(citations_txt))))

# Data Cleaning
slice_sample(citations_tbl, n = 20) %>%
  View()
citations_tbl <- tibble(line = seq_along(citations_txt), cite = citations_txt) %>%
  mutate(authors = str_extract(cite, pattern = "^\\*?([^(]+)"),
         year = str_extract(cite, pattern = "(?<=\\()\\d{4}[a-z]?(?=\\))"),
         title = str_extract(cite, pattern = "(?<=\\)\\.\\s).+?(?=\\.\\s[A-Z])"),
         journal_title = ifelse(str_detect(cite, pattern = "In "), NA_character_, str_extract(cite, pattern = "(?<=\\.\\s)[^.,]+(?=,\\s*\\d)")), 
         book_title = ifelse(str_detect(cite, pattern = "In "), str_extract(cite, pattern = "(?<=In\\s).+?(?=\\s\\()"), NA_character_),
         journal_page_start = ifelse(str_detect(cite, pattern = "In "), NA_character_, str_extract(cite, pattern = "(?<=[,:]\\s)\\d+(?=\\s*[-–?])")),
         journal_page_end = ifelse(str_detect(cite, pattern = "In "), NA_character_, str_extract(cite, pattern = "(?<=[-–?])\\d+(?=\\.)")),
         book_page_start = ifelse(str_detect(cite, pattern = "In "), str_extract(cite, pattern = "(?<=pp\\.\\s)\\d+(?=\\s*[-–?])"), NA_character_),
         book_page_end = ifelse(str_detect(cite, pattern = "In "), str_extract(cite, pattern = "(?<=[-–?])\\d+(?=\\))"), NA_character_),
         doi = str_extract(cite, pattern = "10\\.\\d{4,}/[-._;()/:A-Za-z0-9]+"),
         perf_ref = str_detect(title, pattern = regex("performance", ignore_case = TRUE)),
         first_author = str_extract(authors, pattern = "^[^,\\s]+,?\\s*[A-Z]\\.?(?:[A-Z]\\.?)*")
  )
# Analysis
citations_tbl %>%
  summarize(
    cites = n(),
    first_authors = sum(!is.na(first_author)),
    articles = sum(!is.na(journal_title)),
    chapters = sum(!is.na(book_title)
                   )
    )
         

citations_tbl %>%
  filter(perf_ref, !is.na(journal_title)) %>%
  count(journal_name = journal_title, name = "frequency", sort = TRUE) %>%
  head(10)



citations_tbl %>%
  count(citation = cite, name = "frequency", sort = TRUE) %>%
  head(10)



