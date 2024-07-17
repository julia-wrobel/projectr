# projectr

This is basically a stripped-down version of [workflowr](https://github.com/jdblischak/workflowr). I've restructured the default collection of directories to suit myself; stripped out a lot of the .md files, website structure, and other documentation; included `data` in the `.gitignore` file by default; and added the option for a data directory outside the project directory. The last two options are especially helpful when dealing with PHI. 

### Installation

In case anyone except me ever needs it, the package can be installed using:

``` r 
devtools::install_github("jeff-goldsmith/projectr")
```

### Example

Pretty much the only use for this package is illustrated below:

``` r
projectr::proj_start(proj_dir = "~/Work/201809_project", 
                     data_dir = "~/Data/201809_data")
```
