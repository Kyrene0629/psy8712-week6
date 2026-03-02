# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(stringi)
# library(potential one)
# library(potential one)

# Data Import
citations <- stri_read_lines("../data/cites.txt", encoding = "Windows-1252")