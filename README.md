# projectr

This is slightly modified [jeff-goldsmith/projectr](https://github.com/jeff-goldsmith/projectr), which is itself a stripped-down version of [workflowr](https://github.com/jdblischak/workflowr). Edits by Jeff Goldsmith restructured the default collection of directories; stripped out a lot of the .md files, website structure, and other documentation; included `data` in the `.gitignore` file by default; and added the option for a data directory outside the project directory. The last two options are especially helpful when dealing with PHI. 

### Installation

The package can be installed using:

``` r 
devtools::install_github("julia-wrobel/projectr")
```

### Example

The main use for this package is illustrated below:

``` r
projectr::proj_start(proj_dir = "~/Work/202407_project", 
                     data_dir = "~/Data/202407_data")
```
