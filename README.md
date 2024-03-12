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
5. [Export your output(s) to Terra Workspace](#export-your-output(s)-to-terra-workspace)
6. [Push your code/scripts to GitHub](#push-your-code/scripts-to-github")
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
if (!file.exists(xfun::relative_path(here::here("data")))){
  dir.create(xfun::relative_path(here::here("data")),
             recursive = TRUE)}

# create `output` folder if doesn't exist <in the current working directory>
if (!file.exists(xfun::relative_path(here::here("output")))){
  dir.create(xfun::relative_path(here::here("output")),
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






## Perform your Analysis



## Export your output(s) to Terra Workspace



## Push your code/scripts to GitHub




## Shut down the VM






