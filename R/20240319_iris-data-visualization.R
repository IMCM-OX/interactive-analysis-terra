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
# maps the contents of "2023_imcm-workshop" into data sub folder {also possible with terminal}

system(command = "gsutil cp -r gs://fc-317f434c-fe5c-4f4e-85d3-cf35e7f9dabe/data/sample_data data/")

# NOTE: This might take a couple of minutes if your dataset(s) are of big size.


# Import datasets into R --------------------------------------------------
iris_raw <- import(here("data", "sample_data", "2024_iris-sample.csv"))      # sample iris data
mtcars_raw <- import(here("data", "sample_data", "2024_mtcars-sample.csv"))  # sample mtcars


# Wrangling/analysis ------------------------------------------------------
# measurement of columns is in centimetres, let's convert this to meters

iris_clean <- iris_raw %>% 
  mutate(across(-Species, ~ ./100)) %>%    # measurement of columns is in centimetres, let's convert this to meters
  mutate(Species = str_to_upper(Species))  # convert to upper case values of "Species" column

# scatter plot of sepal length vs petal length
# colour by Species

scatter_plot <- iris_clean %>% 
  ggplot(aes(Sepal.Length, Petal.Length, col = Species)) + 
  geom_point()

scatter_plot

## multi-facted histograms

histogram_plot <- iris_clean %>% 
  pivot_longer(cols = -Species, 
               names_to = "col_type", 
               values_to = "measurement") %>% 
  ggplot(aes(x = measurement)) + 
  geom_histogram(aes(fill = Species), alpha = 0.3) +
  facet_wrap(~ col_type) +
  theme_bw()

histogram_plot

# Export data/output back to workspace -------------------------------------------

# Export cleaned iris data
export(iris_clean, "output/iris_clean.csv")

# Export the plots {histogram and scatterplot}

ggsave(
  filename = here(
    "output",
    "scatter_plot.png"
  ),
  plot = scatter_plot
)

ggsave(
  filename = here(
    "output",
    "histogram_plot.png"
  ),
  plot = histogram_plot
)


## use gsutil to copy contents back to the workspace

system(command = "gsutil cp output/* gs://fc-317f434c-fe5c-4f4e-85d3-cf35e7f9dabe/data/processed_data")






