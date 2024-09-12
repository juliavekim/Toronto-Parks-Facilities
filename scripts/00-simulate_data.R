#### Preamble ####
# Purpose: Simulate and make simulated graphs of Parks & Recreation Facility Projects dataset across Toronto
# Author: Julia Kim 
# Data: 9 January 2023
# Email: juliaym.kim@mail.utoronto.ca
# License: MIT 
# Prerequisites: None 

#### Workspace setup ####
library(tidyverse)
library(ggplot2)

#### Simulate data ####  
## Make a simulated dataset 
# simulate ward number, ward population, ward minority proportion
set.seed(853) # for reproducibility 
ward_num <- c(1:25)
ward_pop <- sample(20000:50000, 25, replace = TRUE)   
ward_minority_prop <- runif(25, min = 0, max = 0.5)

# simulate project types 
project_type <- c("New Park", "New Community Centre", "Facility Improvements",
                  "Master Plan or Study")

# set number of observations and simulate dataset 
num_observations = 200

set.seed(853) # reset seed for reproducibility
sim_facilities_data <- 
  tibble(
    project_num = c(1:num_observations),
    ward = sample(x = ward_num, 
                  size = num_observations, 
                  replace = TRUE),
    type = sample(x = project_type,
                  size = num_observations, 
                  replace = TRUE)
    
  )

## Create summary statistics on basis of the number of projects per ward 
sim_cleaned_facilities_data <- sim_facilities_data |>
  group_by(ward) |>
  count() |>
  rename("num_projects" = "n") |>
  left_join(
    data.frame(ward = unique(sim_facilities_data$ward), 
               population = ward_pop, minority_proportion = ward_minority_prop), 
    by = "ward"
  ) # add ward population and ward minority proportions to dataset 

## Create graphs of simulated datasets for visualisation (not required, just a bonus)
# Create stacked bar graph of number of projects per ward, coloured by
# project type 
ggplot(sim_facilities_data, aes(x = as.factor(ward), fill = type)) +
  geom_bar(position = "stack") +
  labs(title = "Number of Projects per Ward",
       x = "Ward Number",
       y = "Number of Projects",
       fill = "Project Type") +
  scale_x_discrete(labels = seq(1, 25, by = 1)) +
  theme_minimal()

# Create scatter plot of number of projects vs. minority proportion for each 
# ward 
ggplot(sim_cleaned_facilities_data, aes(x = minority_proportion, 
                                        y = num_projects, 
                                        label = ward)) +
  geom_point() +
  geom_text(vjust = -0.5) +  # Adjust the vertical position of labels
  labs(title = "Number of Projects vs. Minority Proportion per Ward",
       x = "Minority Proportion",
       y = "Number of Projects",
       caption = "Ward Number") +
  theme_minimal()

## Data validation
# check that project "type" is exclusively one of these four: "New Park", 
# "New Community Centre", "Facility Improvements", "Master Plan or Study" 
unique(sim_facilities_data$type) == c("New Park", "New Community Centre", 
                                      "Master Plan or Study", "Facility Improvements")

# check there are 25 wards in the area and they run from 1 to 25
all(sort(unique(sim_cleaned_facilities_data$ward)) == 1:25)
# also validate that "ward" is an integer 
sim_cleaned_facilities$ward |> class() == "integer"
  
# check the population for each ward is a value somewhere 
# between 20000 and 50000, and is an integer 
sim_cleaned_facilities_data$population |> min() >= 20000
sim_cleaned_facilities_data$population |> max() <= 50000
sim_cleaned_facilities_data$population |> class() == "integer" 

# check minority proportion for each ward is a value somewhere
# between 0 and 0.5, and is a number 
sim_cleaned_facilities_data$minority_proportion |> min() >= 0
sim_cleaned_facilities_data$minority_proportion |> max() <= 0.5
sim_cleaned_facilities_data$minority_proportion |> class() == "numeric" 
