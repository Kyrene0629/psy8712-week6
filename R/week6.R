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
citations_tbl %>%
  slice_sample(n = 20) %>% View()
citations_tbl <- tibble(line = seq_along(citations_txt), cite = citations_txt) %>%
  mutate(authors = str_extract(cite, pattern = "^\\*?([^(]+)"),
         year = str_extract(cite, pattern = "(?<=\\()\\d{4}[a-z]?(?=\\))"),
         title = str_extract(cite, pattern = "(?<=\\)\\.\\s)(?!In\\s+[A-Z]).+?(?=(?:\\sIn\\s+[A-Z](?:\\.|,|$)|\\.\\s[A-Z][a-z]|\\?\\s[A-Z][a-z]|!\\s[A-Z][a-z]|$))"),
         journal_title = ifelse(str_detect(cite, pattern = "In "), NA_character_, str_extract(cite, pattern = "(?<=\\.\\s)[^.,]+(?=,\\s*\\d)")), 
         book_title = ifelse(str_detect(cite, pattern = "In "), str_extract(cite, pattern = "(?<=In\\s).+?(?=\\s\\()"), NA_character_),
         
         
         
         doi = str_extract(cite, pattern = "10\\.[0-9]{4,}/[-._;()/:A-Za-z0-9]+")
         
         
         