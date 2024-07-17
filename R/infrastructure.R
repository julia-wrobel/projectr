# Infrastructure for workflowr projects.

# These templates are used by proj_start().

templates <- list(
  `.gitignore` = '
## RStudio files
.Rproj.user

## History
.Rhistory

## data directories and files
data
.DS_Store
analysis/*_cache/
drafts/*_cache/
.RData
.Ruserdata
',
  `analysis/.gitkeep` = '',
  `drafts/.gitkeep` = '',
  `literature/.gitkeep` = '',
  `results/.gitkeep` = '',
  `source/.gitkeep` = '',
  README.md = '
# {name}

## Generic Project Directory

This is a generic project template. It might help to add a brief description.

When the project has been created, I recommend running

```usethis::use_github(private = TRUE, protocol = "https")```

to create a private remote repo corresponding to this project. If this project
is edited across multiple machines, it may be necessary to add symbolic links
to data directories using

```ln -s PATH/TO/DATA data```

## Structure

* `analysis/` is intended to contain all the source R Markdown files that
implement the analyses for the project.
* `data/` will either be a symbolic link to an external data directory, or
a subdirectory
* `drafts/` will contain relevant paper drafts
* `literature/` will contain all references
* `results/` will contain results exported by the analysis files
* `source/` will contain bare scripts (typically containing functions sourced
by the full analysis files)

project structured using the [projectr](https://github.com/julia-wrobel/projectr) package.
',
  "Rproj" = '
Version: 1.0

RestoreWorkspace: No
SaveWorkspace: No
AlwaysSaveHistory: Default

EnableCodeIndexing: Yes
UseSpacesForTab: Yes
NumSpacesForTab: 2
Encoding: UTF-8

RnwWeave: Sweave
LaTeX: pdfLaTeX

AutoAppendNewline: Yes
StripTrailingWhitespace: Yes

',
  `analysis/template.Rmd` = '
---
title: "title"
author: "author"
date: "date"
output:
  html_document:
    code_folding: hide
    toc: true
    toc_float: true
hitheme: tomorrow
highlighter: highlight.js
---

NOTE: please change the chunk below to an R chunk!

```
library(tidyverse)
library(patchwork)

knitr::opts_chunk$set(echo = TRUE,
  warning = FALSE,
  message = FALSE,
  fig.width = 9,
  fig.height = 4,
  fig.path = "../figures/"
)

theme_set(theme_bw() + theme(legend.position = "bottom"))
```


'

)
