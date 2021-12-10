
# FIRST RUN ONLY ---------------------------------------------------

## - [ ] Change the name of `laims.analyses.Rproj` with your main
##       project's directory name accordingly
#
# Simply run the following code
fs::file_move(
  here::here("laims.analysis.Rproj"),  # old project's name
  paste0(basename(here::here()), ".Rproj")  # current project's name
)

## - [ ] Fill the DESCRIPTION file
##   > do change `Package:` definition in the first line with your
##     current project's name (i.e. your main folder's name)
usethis::edit_file("DESCRIPTION")

# After that you can produce the basic project's documentation running
# the following code
usethis::use_package_doc(open = FALSE)


## - [ ] Fill the projects' environmental variables inside the
##       project's `.Renviron` which can be opened running the
##       following code.
usethis::edit_r_environ("project")

## Finaly, update all your packages in the project's library.
renv::upgrade()
renv::update()
renv::status()
renv::snapshot()


## At your convenience, replace your readme file
usethis::use_readme_rmd()
usethis::use_code_of_conduct()  # put your email here
usethis::use_lifecycle_badge("experimental")


# Project packages (TO BE UPDATED EVERY NEW PACKAGE USED) ----------

prj_pkgs <- c("fs", "readr")
gh_prj_pkgs <- c()
meta_pkgs <- c("tidymodels", "tidyverse")

renv::install(c(prj_pkgs, gh_prj_pkgs, meta_pkgs))

purrr::walk(prj_pkgs, usethis::use_package)
purrr::walk(gh_prj_pkgs, ~{
  package_name <- stringr::str_extract(.x, "[\\w\\.]+$")
  usethis::use_dev_package(package_name, remote = .x)
})

usethis::use_tidy_description()
devtools::document()
renv::status()
# renv::snapshot()



# Development cycle ------------------------------------------------

spelling::spell_check_package()
## spelling::update_wordlist()
lintr::lint_package()

## CTRL + SHIFT + D: update project documentation
## CTRL + SHIFT + T: run all project's tests
## CTRL + SHIFT + E: run all CRAN tests

source(here::here("02-run_tar.R"))
