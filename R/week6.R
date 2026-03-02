# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(stringi)
# library(potential one)
# library(potential one)

# Data Import
citations <- stri_read_lines("../data/cites.txt", encoding = "Windows-1252")
citations_txt <- str_subset(citations, pattern = "\\S")
str_c("The number of blank lines eliminated was ", length(citations) - length(citations_txt))
str_c("The average number of characters/citation was", mean(str_length(citations_txt)))

# Data Cleaning
citations_tbl %>%
  slice_sample(n = 20)
citations_tbl <- tibble(line = seq_along(citations_txt), cite = citations_txt) %>%