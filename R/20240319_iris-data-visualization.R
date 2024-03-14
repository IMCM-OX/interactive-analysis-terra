# Script metadata ---------------------------------------------------------
# Title: Visualizing Iris dataset
# Author: Christopher Maronga
# Date: 2023-03-19
# Contact: christopher.maronga@well.ox.ac.uk


# Install and load packages -----------------------------------------------

if(!require(pacman)) install.packages("pacman")

pacman::p_load(AnVIL,     # cloud computing in Terra
               lubridate, # working with dates
               rio,       # data import/export
               here,      # manage file paths
               tidyverse) # data wrangling and visualization


# create `data` and `output` folders --------------------------------------
# make sure you exclude these in git commits, etc .gitignore

## create `data` folder ------
if (!file.exists(xfun::relative_path("data"))){
  dir.create(xfun::relative_path("data"),
             recursive = TRUE)}

## create `output` folder -----
if (!file.exists(xfun::relative_path("output"))){
  dir.create(xfun::relative_path("output"),
             recursive = TRUE)}


# Bring/copy data from Terra workspace ------------------------------------
# Currently on Data Management Guild
# maps the conteds of "2023_imcm-workshop" into data subfolder

system(command = "gsutil cp -r gs://fc-7b54d968-83e6-494a-b4a7-73c1b91a18a2/data/2023_imcm-workshop data/")


# Import datasets into R --------------------------------------------------
iris_raw <- import(here("data", "2023_imcm-workshop", "2024_iris-sample.csv"))      # sample iris data
mtcars_raw <- import(here("data", "2023_imcm-workshop", "2024_mtcars-sample.csv"))  # sample mtcars



# Wrangling/analysis ------------------------------------------------------






# Export data back to workspace -------------------------------------------
















