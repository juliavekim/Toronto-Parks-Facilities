# Analysis of Parks and Recreation Facilities across Toronto Wards 

## Overview

This repo contains the data and code for the analysis of the distribution of Toronto's Parks and Recreation Facilities (PRF) Projects across the 25 municipal wards in Toronto. Using the Parks and Facilities Project and the 2021 Census data, pulled from the City of Toronto Open Data Portal, it investigates the relationship between the number of projects with the proportions of visible minorities and of low-income private households per ward. There is a moderately negative, significant correlation between the number of projects and proportion of visible minorities, but no significant correlation discovered between number of projects and proportion of low-income private households. This finding supports the hypothesis of racial disparities in access to sustainable urban development initiatives across Toronto.

## File Structure

The repo is structured as follows:

-   `input/data` contains the data sources used in analysis including the raw and cleaned data. 
-   `input/llm` contains the entire chat history with LLM CHATGPT-3.5 
-   `input/sketches` contains brief sketches of potential datasets and tables used in the planning stage of this report. 
-   `outputs/paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate (`00-simulate_data.R`), download (`01-download_data.R`) and clean data (`02-data_cleaning.R`). Helper functions (`03-helper_functions.R`) used in these scripts is also included. 

## LLM Usage  

No auto-complete tools such as co-pilot were used in the course of this project. CHATGPT-3.5 was used briefly on a single occasion, on January 20, 2024, in order to determine an appropriate title for this report and a more brief way to retitle a subsection header. However, CHATGPT-3.5 failed to give an adequate title on both occasions, so revised titles were chosen by the author without further aid. 
