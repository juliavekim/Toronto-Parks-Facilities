#### Preamble ####
# Purpose: Collection of helper functions
# Author: Julia Kim 
# Date: 19 January 2023
# Email: juliaym.kim@mail.utoronto.ca
# Prerequisites: none
# License: MIT 

## Function to calculate the population 
# referenced code from https://github.com/christina-wei/INF3104-1-Covid-Clinics/blob/main/scripts/01-data_cleaning.R 
calculate_population <- function(row_index, raw_data) {
  # extract minority population data from the specified row
  population <- transpose(raw_data[row_index, ])[[1]] |> as.numeric()
  # keep entries of interest
  population <- population[3:length(population)]
  return(population)
}
