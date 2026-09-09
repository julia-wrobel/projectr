# Infrastructure for student onboarding projects.

# These templates are used by onboard_student(). Same idea as
# infrastructure.R's `templates`, but with no drafts/ folder and with a
# weekly_report.qmd template added to analysis/.

onboarding_templates <- list(
  `.gitignore` = '
## RStudio files
.Rproj.user

## History
.Rhistory

## data directories and files
data
.DS_Store
analysis/*_cache/
.RData
.Ruserdata
',
  `literature/.gitkeep` = '',
  `results/.gitkeep` = '',
  `source/.gitkeep` = '',
  README.md = '
# {name}

## Overview

This project folder was created for {student_name} using `onboard_student()`
from the [projectr](https://github.com/julia-wrobel/projectr) package.

When the project has been created, I recommend running

```usethis::use_github(private = TRUE, protocol = "https")```

to create a private remote repo corresponding to this project. If this project
is edited across multiple machines, it may be necessary to add symbolic links
to data directories using

```ln -s PATH/TO/DATA data```

## Structure

* `analysis/` contains the source files that implement the analyses for the
project, including `weekly_report.qmd`, the template used for weekly
pre-meeting check-ins.
* `data/` is a subdirectory for your raw data
* `literature/` will contain all references
* `results/` will contain results exported by the analysis files, such as figures
* `source/` will contain bare scripts (typically containing functions sourced
by the full analysis files)

## Expectations

A few things I expect from students working with me:

* **Meeting notes -> to-do list -> weekly report.** Each time we meet, take
notes and put together a clear to-do list from what we discussed. Carry that
list into `analysis/weekly_report.qmd` under "To Do From Last Week," and
send it to me before our next meeting -- with enough lead time that I can
actually read it beforehand.
* **Give reasonable notice if you need to cancel a meeting.**
* **Persistence pays off.** Try things multiple ways before giving up.
Research is rarely linear.
* **Message me on Slack when you are stuck.**
* **Write organized, readable, documented code** that someone else could
pick up and run, with clear names. If you are not sure what that looks
like, see the [tidyverse style guide](https://style.tidyverse.org/) and
Jenny Bryan\'s [how to name files](https://speakerdeck.com/jennybc/how-to-name-files).
* **Keep workflows reproducible**, including clear data-processing steps and
documentation of analytical decisions along the way. Jenny Bryan\'s
[project-oriented workflow](https://www.tidyverse.org/blog/2017/12/workflow-vs-script/)
post and the [here package](https://here.r-lib.org/) (use it instead of
`setwd()`) are good places to start.
* **Ask questions.** And feel free to disagree with me or push back on my
suggestions. I want your feedback too!
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
  `analysis/weekly_report.qmd` = '
---
title: "Weekly Report"
author: "{student_name}"
date: today
format:
  html:
    toc: true
    code-fold: true
---

> **About this document (delete this note once filled in):** This is a
> weekly check-in to send me *before* our meeting. It should (1) remind me
> what we discussed and what you planned to do at our last meeting, (2) show
> me how far you got on each of those items, and (3) walk through the
> results/progress you made this week. Fill in the checklist below, then add
> a subsection under "Results" for each item. Add, remove, or rename items
> as needed to match what was actually discussed.

```{{r setup, include=FALSE}}
library(tidyverse)

knitr::opts_chunk$set(
  echo = TRUE,
  warning = FALSE,
  message = FALSE,
  fig.width = 9,
  fig.height = 4,
  fig.path = "../results/"
)

theme_set(theme_bw() + theme(legend.position = "bottom"))
```

## To Do From Last Week

- [ ] **Item 1:** *(what was discussed/assigned at the last meeting)*
  - Level completed: *(not started / partially done / fully done)*
- [ ] **Item 2:** *(what was discussed/assigned at the last meeting)*
  - Level completed: *(not started / partially done / fully done)*
- [ ] **Item 3:** *(what was discussed/assigned at the last meeting)*
  - Level completed: *(not started / partially done / fully done)*

## Big Picture

*(A few sentences on how this weeks work fits into the overall project -- what question it is answering, and what is next.)*

## Results

### Item 1

### Item 2

### Item 3
'
)
