#### Preamble ####
# Purpose: Download dataset on Toronto's Parks & Recreation (P&R) Facility Projects, 
# and the corresponding ward profile data 
# Author: Julia Kim
# Date: 19 January 2023
# Email: juliaym.kim@mail.utoronto.ca
# License: MIT 
# Prerequisites: none
# Datasets:
  # P&R from https://open.toronto.ca/dataset/park-and-recreation-facility-projects/  
  # Ward profile data from https://open.toronto.ca/dataset/ward-profiles-25-ward-model/ 

#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)

#### Retrieve raw data from Open Source Toronto ####
## Load and write Toronto P&R Projects data  
raw_facilities_data <- 
  list_package_resources("park-and-recreation-facility-projects") |>
  filter(id == "f16dbf16-880b-43fd-8d2d-4bc7516c57c7") |>
  get_resource() 

write_csv(raw_facilities_data, 
          file = "inputs/data/raw_facilities_data.csv")

## Load and write Toronto's ward profile data 
raw_ward_profile_data <-
  list_package_resources("6678e1a6-d25f-4dff-b2b7-aa8f042bc2eb") |> 
  filter(id == "16a31e1d-b4d9-4cf0-b5b3-2e3937cb4121") |> 
  get_resource()

write_csv(
  x = as.data.frame(raw_ward_profile_data[1]), # write data for first tab "2021 One Variable"  
  file = "inputs/data/raw_ward_data.csv"
)
