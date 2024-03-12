# Interactive Analysis on Terra

This repository and associated files is meant for a toy demo for Interactive Analysis on Terra.Bio cloud platform.

NOTE: It DOES NOT cover nor teach how to methodically perform an analysis, but it acts as "cookbook" of best practices to ease your pain while working interactively on Terra; specifically:-

- Files/code organization.
- Data handling and organization.
- Associated output handling and archiving/storage.
- Version control and collaboration.

# Contents

1. [Create a VM](#create-a-vm)
2. [Bring in your code from GitHub](#bring-in-your-code-from-github)
3. [Bring in your data from Terra Workspace](#bring-in-your-data-from-terra-workspace)
4. [Perform your Analysis](#perform-your-analysis)
5. [Export your output to Terra Workspace](#export-your-output-to-terra-workspace)
6. [Push your code and scripts to GitHub](#push-your-code-and-scripts-to-github")
7. [Shut down the VM](#shut-down-the-vm)



## Create a VM

Create a Virtual Machine (VM) to start your interactive analysis. Follow [these](https://support.terra.bio/hc/en-us/articles/360038125912-Your-interactive-analysis-VM-Cloud-Environment#h_01EWE22VY089T7SVA9J403CD48) instructions to get you there.

You can select one of the following common cloud environments:-

- [Jupyter:](https://support.terra.bio/hc/en-us/articles/5075814468379-Starting-and-customizing-your-Jupyter-app) For analysis in Python programming language.
- [Rstudio:](https://support.terra.bio/hc/en-us/articles/5075722115227) For analysis in R statistical software.

They both come with a `terminal` for writing bash commands.

## Bring in your code from GitHub

NOTE: For a first time, it's recommended that you create a repository via [GitHub](https://github.com/), with a bare minimum of two files, the `README.md` and `.gitignore`. These are easily included once you enable the check-boxes during creation process.

Once you have your repository ready or if using an existing repository, `clone` the repository into your cloud environment in the VM. For Rstudio, instructions on how to do this can be found in this [confluence](https://oxgskimcm.atlassian.net/wiki/spaces/TerraBio/pages/45514753/Working+with+Git+GitHub+on+terra) page or in this [blog post](https://nceas.github.io/oss-lessons/version-control/4-getting-started-with-git-in-RStudio.html)


Generally, to clone your repository into Jupyter VM:-

- Go to your GitHub repo, click on the green button labelled "Code", copy the `HTTPS` link.
- In the terminal, run the command `git clone https_link`

```bash
# clone your code repository into the CE
git clone https://github.com/IMCM-OX/interactive-analysis-terra.git

```

This pulls all your code and files from the remote repository into Terra CE and you can start editing/working on them immediately.

## Bring in your data from Terra Workspace

Once you have all codes/scripts in the C.E, next is to bring your data for analysis from a Terra workspace. For a better and reproducible structure, we recommend you create two sub-folders in your clone github folder directory:-

- **data:** This is the destination your raw data that you shall copy from a workspace
- **output:** This is the destination of any output (plot, pdf, processed data etc) emanating from your data analysis efforts.

In R, this can be done dynamically like so in an R script:-

```bash
# create `data` folder if doesn't exist <in the current working directory>
if (!file.exists(xfun::relative_path("data"))){
  dir.create(xfun::relative_path("data"),
             recursive = TRUE)}

# create `output` folder if doesn't exist <in the current working directory>
if (!file.exists(xfun::relative_path("output"))){
  dir.create(xfun::relative_path("output"),
             recursive = TRUE)}

```

In Jupyter CE, you can do this via terminal


```bash
# create `data` folder if doesn't exist <in the current working directory>
mkdir data

# create `output` folder if doesn't exist <in the current working directory>
mkdir output

```

### `.gitignore`

Once you have the two subfolders, make sure you exclude them from your future GitHub commits by editing the `.gitigonre` file and specifying that they be excluded from `commit`s and `pushe`s. You DO NOT want to commit/push data into GitHub; and this prevents that.

```bash
# put this lines in .gitignore file
data/
output/

```


### `copy data from workspace`

Use `gsutil` command line tools to copy the data from your working directory into the `data` sub-directory. 

```bash
# copy raw data into `data` subdirectory
gsutil cp `gs://path_to_terra_workspace` data/         # using comand line

# From an R script
system(command = "gsutil cp `gs://path_to_terra_workspace` data/")

```

## Perform your Analysis

Now you have your raw data inside `data` subfolder, it's time to import it into your software (python or R) and begin your analysis. All your data import commands shall point to `data/some_file.ext` or `data/data_sub_folder/some_file.ext`.

This is important in 3 ways:-

- Keeps your file paths consistent across all your scripts.
- Your whole analysis is reproducible in another VM/CE with the same set up; i.e. `data` subfolder for storing raw data
- Above all, collaboration becomes easy, no need to change file paths back and forth in the same script.

**`output`** subfolder:
Any analysis effort, processed data or plots and documents should be deposited in this folder. You can have expand the organization inside this folder to include further sub-folders as needed.


## Export your output to Terra Workspace

Once done with your analysis effort, it's time to start doing housekeeping. First, if created files or products of an analysis inside the `output` folder that you want fed back to a Terra workspace for storage, this is the time. The process is almost similar to copying raw data into `data` subfolder using `gsutil` command line tools.

```bash
# copy files/products from `output` subdirectory to Terra workspace
gsutil cp  output/some_file(s)  `gs://path_to_terra_workspace/sub_folder/`       # using comand line

# From an R script
system(command = "gsutil cp  output/some_file(s)  `gs://path_to_terra_workspace/sub_folder/`")

```

This ensure that the files or data generated from an analysis that needs to be re-used later is safely stored in a respective Terra workspace and are not lost in the event we shut down the VM and delete the PD.

## Push your code and scripts to GitHub

Your analysis output is safe in a Terra workspace, now it's time to give our `upadted` analysis code/script a safe home as well 🙂.

Do the following (usual git versioning workflow):

```bash
# stage the edited codes
git add .                                      # to stage all the edited scripts
git add R/script_name.R||python/script_name.py # to stage a specific script

# commit
git commit -m"descriptive_commit_message"     # commit the staged scripts

# push to github
git psh                                       # push to GitHub your "new scripts"

```

## Shut down the VM

Now, it's end of an analysis task. Your `output`s are safe in a Terra workspace and your codes are version-ed and pushed into GitHub, it's highly recommended you shut down your VM to avoid incurring costs.

While shutting down the VM, you can either:-

- Delete the VM and the PD (all generated files are lost, but good thing we had stored them already)
- Delete the VM and spare the PD (You loose the CE configuration, but you get to keep all the files in the PD)





