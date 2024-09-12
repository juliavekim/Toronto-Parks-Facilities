#### Preamble ####
# Purpose: Clean Parks & Recreation facilities projects and ward profile data, 
# and validate these cleaned datasets using basic tests 
# Author: Julia Kim 
# Data: 19 January 2023
# Contact: juliaym.kim@mail.utoronto.ca
# License: MIT 
# Pre-requisites: 
 # 01-download_data.R
 # 03-helper_functions.R 

#### Workspace setup ####
library(tidyverse)
library(janitor)
source("scripts/03-helper_functions.R")

#### Read in raw data ####
raw_facilities_data <- 
  read_csv(
    file = "inputs/data/raw_facilities_data.csv", 
    show_col_types = FALSE
  )

raw_ward_profile_data <- 
  read_csv(
    file = "inputs/data/raw_ward_profile_data.csv",
    show_col_types = FALSE
  )

#### Data cleaning ####
## Facilities data ## 
# clean names, select variables of interest and change their names for legibility   
cleaned_facilities_data <- 
  raw_facilities_data |>
  clean_names() |> 
  select(
    ward_name,
    ward_number,
    project_type
  ) |> 
  mutate(
    project_type = case_when(
      project_type == "Master Plan or Study" ~ "Master Plan",
      project_type == "New Community Recreation Centre" ~ "New Rec. Centre",
      project_type %in% c("Playground Improvements", "Park or Facility Improvements") ~ "Facility Upgrade",
      TRUE ~ project_type
    )
  )

## Ward profile data ## 
## extract ward total population, minority population, low income population 
# initialize a list to store results
ward_population_lst <- list()
# loop through rows 18 (total population),  1285 (total minority), 
# 1400 (total in low income private household earners)
for (row_index in c(18, 1285, 1400)) {
  ward_population_lst[[as.character(row_index)]] <- 
    calculate_population(row_index, raw_ward_profile_data)
}

# make dataset 
cleaned_ward_profile_data <- tibble(
  ward_number = c(1:25),
  population = ward_population_lst[["18"]],
  minority_population = ward_population_lst[["1285"]],
  low_income_population = ward_population_lst[["1400"]],
)

#### Data Validation ####
### cleaned_facilities_data 
## check data types 
class(cleaned_facilities_data$ward_number) == "numeric"
class(cleaned_facilities_data$ward_name) == "character"

## check data values
# check "project "type" is exclusively one of five 
cleaned_facilities_data$project_type |>
  unique() == c("New Park", "Master Plan or Study", 
                "Park or Facility Improvements",  "Playground Improvements",
                "New Community Recreation Centre")
# check there are 25 wards in the area and they run from 1 to 25
all(sort(unique(cleaned_facilities_data$ward)) == 1:25)

### cleaned_ward_profile_data 
# check data types 
class(cleaned_ward_profile_data$ward_number) == "integer"
class(cleaned_ward_profile_data$population) ==  "numeric"
class(cleaned_ward_profile_data$minority_population) == "numeric"
class(cleaned_ward_profile_data$low_income_population) == "numeric"

## check data values 
length(unique(cleaned_ward_profile_data$ward_number)) == 25  
min(cleaned_ward_profile_data$population) > 0  
min(cleaned_ward_profile_data$minority_population) > 0
min(cleaned_ward_profile_data$low_income_population) > 0
max(cleaned_ward_profile_data$population) < 200000
max(cleaned_ward_profile_data$minority_population) < 200000
max(cleaned_ward_profile_data$low_income_population) < 200000

#### Write cleaned dataset to file ####
write_csv(
  x = cleaned_facilities_data,
  file = "outputs/data/cleaned_facilities_data.csv"
)

write_csv(
  x = cleaned_ward_profile_data,
  file = "outputs/data/cleaned_ward_profile_data.csv"
)
