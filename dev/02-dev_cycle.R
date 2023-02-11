
# Project packages (TO BE UPDATED EVERY NEW PACKAGE USED) ----------

prj_pkgs <- c("fs", "readr", "stringr", "purrr")
gh_prj_pkgs <- c()
meta_pkgs <- c("tidyverse")

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

# Functions definitions -------------------------------------------

## if you need more structure respect to include your functions inside
## `R/functions.R`, you can create other couple of test/function-script
## by running the following lines of code as needed.

# usethis::use_test("<my_fun>")
# usethis::use_r(<"my_fun">)
