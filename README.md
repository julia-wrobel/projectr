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

To set up a project folder for a new PhD student, use `onboard_student()`.
It creates the same structure as `proj_start()` (minus `drafts/`, and with
`data/` always created as a plain subdirectory rather than a symbolic
link), adds a `weekly_report.qmd` template to `analysis/` for pre-meeting
check-ins, and zips the result. By default it's created in `~/Downloads`,
named after the snake_case version of `student_name`:

``` r
projectr::onboard_student(student_name = "Jane Doe")
```

Or specify a location:

``` r
projectr::onboard_student(student_name = "Jane Doe",
                          proj_dir = "~/Work/jane_doe")
```
