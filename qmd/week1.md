---
title: "Week 1"
format: html
editor: visual
---

# Basic Setup

## 1. Environment setup

### 1.1. Install R/RStudio desktop

<https://posit.co/download/rstudio-desktop/>

### 1.2. Set up version control in RStudio

#### a. Install Verstion Control: Git

<https://support.posit.co/hc/en-us/articles/200532077-Version-Control-with-Git-and-SVN>

#### b. Connect RStudio with Github account

To connect RStudio with your GitHub account, you can follow these steps:

1.  Open RStudio and go to Tools \> Global Options.
2.  In the options window, click on Git/SVN.
3.  Click on "Create RSA key..." to generate a new SSH key.
4.  Click on "View public key" and copy the key to your clipboard.
5.  Next, go to your GitHub account, click on your profile icon, then go to Settings \> SSH and GPG keys.
6.  Click on "New SSH key" and paste the key you copied from RStudio.
7.  Save the SSH key on GitHub.

Now, your RStudio should be connected to GitHub. You can test the connection by creating a new project in RStudio and using Git to push your code to a GitHub repository.

Version Control:

We want to create a R project folder that has version control enabled and linked to a github repo for cloud backup.

1.  Create a Github Repo

## 2. Setup a Practice Github Repo

Repo name: 112-2-econDV-practice

### 2.1. Creat a Github Repo

<https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository>

### **2.2. Clone the repository with RStudio**

<https://resources.github.com/github-and-rstudio/> under **Clone the repository with RStudio** section

## 3. Install Course-relevant packages

<https://tpemartin.github.io/economic-data-visualization-2022/index.html#packages>

## 4. Set up .Rprofile

> At the root of a project folder, `.Rpfile` contains codes you want RStudio to run when each time you open the project.

In Console, type

```{r}
# type this in Console:
file.edit(".Rprofile")
```

paste <https://tpemartin.github.io/economic-data-visualization-2022/index.html#setup-environment> codes and save.

Restart your project.

> Some useful commands:
>
> ```{r}
> gg$geom() # take you to geom manuals 
> gg$aes() # take you to aes manuals
> ```
