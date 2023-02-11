
# Project packages (TO BE UPDATED EVERY NEW PACKAGE USED) ----------
meta_pkgs <- c()  # e.g., tidyverse, tidymodels, ...
renv::install(meta_pkgs)

prj_pkgs <- c("fs", "readr", "stringr", "purrr")
renv::install(prj_pkgs)
purrr::walk(prj_pkgs, usethis::use_package)

gh_prj_pkgs <- c()  # e.g. CorradoLanera/autotestthat
renv::install(gh_prj_pkgs)
purrr::walk(gh_prj_pkgs, ~{
  package_name <- stringr::str_extract(.x, "[\\w\\.]+$")
  usethis::use_dev_package(package_name, remote = .x)
})

dev_pkgs <- c(
  "checkmate", "covr", "devtools", "distill", "fs", "here", "htmltools",
  "igraph", "knitr", "lintr", "purrr", "qs", "rstudioapi", "spelling",
  "stringr", "targets", "tarchetypes", "testthat", "usethis",
  "visNetwork", "withr"
)
renv::install(dev_pkgs)
purrr::walk(dev_pkgs, usethis::use_package, type = "Suggests")

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
