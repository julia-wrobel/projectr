#' Onboard a new student
#'
#' \code{onboard_student} creates a directory with the essential files for
#' a PhD student's project. This is the same structure created by
#' \code{\link{proj_start}}, minus the \code{drafts/} folder, plus a
#' \code{weekly_report.qmd} template in \code{analysis/} that the student
#' fills out and sends before each meeting.
#'
#' \code{onboard_student} populates the chosen directory with the
#' following files:
#'
#' \preformatted{|--- .gitignore
#' |--- <directory>.Rproj
#' |--- analysis/
#' |--- analysis/weekly_report.qmd
#' |--- data/
#' |--- literature/
#' |--- results/
#' |--- source/
#' |--- README.md
#' }
#'
#' \code{weekly_report.qmd} has a floating table of contents and code
#' folding turned on, and is pre-populated with a "To Do From Last Week"
#' checklist section (for what was discussed at the last meeting, and how
#' far the student got on each item) followed by a "Results" section with
#' a subsection for each checklist item.
#'
#' By default the project directory is created inside the Downloads folder
#' (named after \code{student_name}), and the whole directory is zipped up
#' after creation so it's easy to hand off.
#'
#' @param student_name character. The student's name, e.g. \code{"Helen
#' Chen"}. Used as-is for the author in the weekly report template, and
#' converted to lower snake_case (e.g. \code{"helen_chen"}) for the project
#' directory name when \code{proj_dir} is not supplied. Defaults to
#' \code{""}, in which case the project directory falls back to being named
#' \code{"new_student"} and the template's author field is left blank.
#' @param proj_dir character. The directory where the new project should
#' be created. Defaults to a folder named after the snake_case version of
#' \code{student_name} (or \code{"new_student"} if \code{student_name} is
#' \code{""}) inside the Downloads folder.
#' @param zip logical. Should the project directory be zipped after it's
#' created? Defaults to \code{TRUE}.
#'
#' @import git2r
#' @export
#'
onboard_student <- function(student_name = "",
                             proj_dir = NULL,
                             zip = TRUE) {
  if (!is.character(student_name) | length(student_name) != 1)
    stop("student_name must be a one element character vector: ", student_name)

  if (is.null(proj_dir)) {
    folder_name <- to_snake_case(student_name)
    if (!nzchar(folder_name)) folder_name <- "new_student"
    proj_dir <- file.path(path.expand("~"), "Downloads", folder_name)
  }

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

  # Use templates defined in R/onboarding_infrastructure.R
  student_templates <- onboarding_templates
  names(student_templates)[which(names(student_templates) == "Rproj")] <-
    glue::glue("{basename(proj_dir)}.Rproj")
  names(student_templates) <- file.path(proj_dir, names(student_templates))
  project_files <- names(student_templates)

  # Create subdirectories (no drafts/)
  dir.create.vectorized <- Vectorize(dir.create, vectorize.args = "path")
  dir.create.vectorized(file.path(proj_dir, c("analysis", "literature", "results",
                                               "source")),
                        showWarnings = FALSE)
  dir.create(file.path(proj_dir, "data"))

  # Configure, initialize, and commit ------------------------------------------

  for (fname in project_files) {
    if (!file.exists(fname)) {
      cat(glue::glue(student_templates[[fname]]), file = fname)
    }
  }

  # Configure Git repository
  git2r::init(proj_dir)
  repo <- git2r::repository(proj_dir)
  git2r::add(repo, project_files, force = TRUE)
  git2r::commit(repo, message = "initial project commit")

  # Zip the project directory ---------------------------------------------------

  if (zip) {
    zip_path <- paste0(proj_dir, ".zip")
    zip::zip(zipfile = zip_path,
              files = basename(proj_dir),
              root = dirname(proj_dir))
    message(glue::glue("Project zipped to {zip_path}"))
  }

  invisible(proj_dir)
}

# Convert a name like "Helen Chen" to lower snake_case, e.g. "helen_chen".
to_snake_case <- function(x) {
  x <- tolower(trimws(x))
  x <- gsub("[^a-z0-9]+", "_", x)
  gsub("^_+|_+$", "", x)
}
