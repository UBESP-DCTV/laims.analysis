
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
