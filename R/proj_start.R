#' Start a new project
#'
#' \code{proj_start} creates a directory with the essential files for
#' a new project. This is basically a stripped-down version of
#' \code{workflowr::wflow_start} with some choices that are tailored
#' to my own preferences.
#'
#' \code{proj_start} populates the chosen directory with the
#' following files:
#'
#' \preformatted{|--- .gitignore
#' |--- <directory>.Rproj
#' |--- analysis/
#' |--- analysis/template.Rmd
#' |--- data/
#' |--- drafts/
#' |--- literature/
#' |--- results/
#' |--- source/
#' |--- README.md
#' }
#'
#' \code{analysis/} is intended to contain all the source R Markdown
#' files that implement the analyses for the project.
#'
#' \code{data/} will either be a symbolic link to an external data
#' directory, or a subdirectory.
#'
#' \code{drafts/} will contain all relevant paper drafts
#'
#' \code{literature/} will contain links to or copies of relevent literature
#'
#' \code{results/} will contain results exported by the analysis files
#'
#' \code{source/} will contain bare scripts (typically containing
#' functions sourced by the full analysis files)
#'
#' By default \code{.gitignore} indicates to Git to ignore files usually
#' ignored in an R Project (\code{.Rhistory}, \code{.Rdata}, ect), as
#' well as the data directory
#'
#' @param proj_dir character. The directory where the new project
#' should exist
#' @param data_dir character. The directory where the raw data exist. If
#' \code{NULL}, the data directory is created as a subdirectory.
#'
#' @import git2r
#' @export
#'
proj_start <- function(proj_dir, data_dir = NULL) {
  if (!is.character(proj_dir) | length(proj_dir) != 1)
    stop("directory must be a one element character vector: ", proj_dir)

  if (dir.exists(proj_dir)) {
    stop("Directory already exists. ")
  }

  # Create directory
  dir.create(proj_dir, recursive = TRUE)

  # Configure name of project
  name <- basename(proj_dir)

  # Add files ------------------------------------------------------------------

  # Use templates defined in R/templates.R
  names(templates)[which(names(templates) == "Rproj")] <-
    glue::glue("{basename(proj_dir)}.Rproj")
  names(templates) <- file.path(proj_dir, names(templates))
  project_files <- names(templates)

  # Create subdirectories
  dir.create.vectorized <- Vectorize(dir.create, vectorize.args = "path")
  dir.create.vectorized(file.path(proj_dir, c("analysis",  "drafts", "literature", "results",
                                               "source")),
                        showWarnings = FALSE)
  if (is.null(data_dir)) {
    dir.create(file.path(proj_dir, "data"))
  } else {
    dir.create(file.path(data_dir), recursive = TRUE)
    file.symlink(file.path(data_dir), file.path(proj_dir, "data"))
  }

  # Configure, initialize, and commit ------------------------------------------

  for (fname in project_files) {
    if (!file.exists(fname)) {
      cat(glue::glue(templates[[fname]]), file = fname)
    }
  }

  # Configure Git repository
  git2r::init(proj_dir)
  repo <- git2r::repository(proj_dir)
  # Make the first workflowr commit
  git2r::add(repo, project_files, force = TRUE)
  git2r::commit(repo, message = "initial project commit")

}
