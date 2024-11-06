# Script metadata ---------------------------------------------------------
# Title: Visualizing Iris dataset
# Author: Christopher Maronga
# Date: 2023-03-19
# Contact: christopher.maronga@well.ox.ac.uk


# Install and load packages using a package manager (Pacman) ----------------

if(!require(pacman)) install.packages("pacman")

pacman::p_load(AnVIL,     # cloud computing in Terra
               lubridate, # working with dates
               rio,       # data import/export
               here,      # manage file paths
               tidyverse, # data wrangling and visualization
               glue)      # string manipulation


# STEP 1: Make new folders to store data in your workspace using the command line
# In your application (RStudio) go to the terminal tab and
# create `data` and `output` folders --------------------------------------
if (dir.exists('./data') && dir.exists('./output')) {
  print("SUCCESS. You've created the proper data folders.")
} else {
  stop("FAIL: There are no data or output folders. Please refer to the Github notes or ask for help.")
}
# HINT: run 'mkdir data' and 'mkdir output'


# STEP 2: Bring/copy data from another Terra workspace ------------------------------------
# Currently located in the 'IMCMWorkshop2024' workspace, please bring the data found in this workspace bucket's 
# data/sample_data folder into your workspace's data folder
if (file.exists('./data/sample_data/2024_iris-sample.csv') ) {
  print("SUCCESS. You've imported the proper datasets from the right workspace.")
} else {
  stop("FAIL: The proper data files cannot be found in your data folder. Please refer to the Github notes or ask for help.")
}
# HINT: run 'gsutil cp -r gs://fc-317f434c-fe5c-4f4e-85d3-cf35e7f9dabe/data/sample_data data/' in your terminal

#STEP 3: Run the next lines to play with the datasets and produce some plots. 
# Import datasets into R --------------------------------------------------
iris_raw <- import(here("data", "sample_data", "2024_iris-sample.csv"))      # sample iris data
mtcars_raw <- import(here("data", "sample_data", "2024_mtcars-sample.csv"))  # sample mtcars


# Wrangling/analysis ------------------------------------------------------
# columns is in centimetres, let's convert this to meters

iris_clean <- iris_raw %>% 
  mutate(across(-Species, ~ ./100)) %>%    # measurement of columns is in centimetres, let's convert this to meters
  mutate(Species = str_to_upper(Species))  # convert to upper case values of "Species" column

# scatter plot of sepal length vs petal length
# colour by Species

scatter_plot <- iris_clean %>% 
  ggplot(aes(Sepal.Length, Petal.Length, col = Species)) + 
  geom_point()

scatter_plot

## multi-faceted histograms

histogram_plot <- iris_clean %>% 
  pivot_longer(cols = -Species, 
               names_to = "col_type", 
               values_to = "measurement") %>% 
  ggplot(aes(x = measurement)) + 
  geom_histogram(aes(fill = Species), alpha = 0.3) +
  facet_wrap(~ col_type) +
  theme_bw()

histogram_plot

# STEP 4: Export data and plots back to workspace disk in output folder----------------

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


## STEP 5: Use gsutil to copy contents of the output folder back to the IMCMWorkshop2024 workspace bucket 
## into its 'data/processed_data' folder
if (length(system(paste("gsutil ls", glue("gs://fc-317f434c-fe5c-4f4e-85d3-cf35e7f9dabe/data/processed_data/{Sys.getenv('OWNER_EMAIL')}"), intern = TRUE, ignore.stderr = TRUE))) == 0) {
  stop("FAIL: The outputs were not properly copied into the workspace bucket. Please refer to the Github notes or ask for help.")
} else {
  print("SUCCESS. Congrats you've completed the steps in this workshop. You may now chose to delete your environment.")
}
# Hint: Run 'gsutil cp output/* gs://fc-317f434c-fe5c-4f4e-85d3-cf35e7f9dabe/data/processed_data/$OWNER_EMAIL'
