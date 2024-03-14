# Script metadata ---------------------------------------------------------
# Title: Visualizing Iris dataset
# Author: Christopher Maronga
# Date: 2023-03-19
# Contact: christopher.maronga@well.ox.ac.uk

# Loading packages --------------------------------------------------------

if(!require(pacman)) install.packages("pacman")

pacman::p_load(AnVIL,     # cloud computing in Terra
               lubridate, # working with dates
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





















