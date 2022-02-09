stop("00-setup.R is not intended to be re-run/sourced.", call. = FALSE)

# Development packages ---------------------------------------------

dev_pkgs <- c(
  "blogdown", "checkmate", "devtools", "depigner", "distill", "fs",
  "gitcreds", "here", "htmltools", "igraph", "janitor", "knitr",
  "lintr", "magick", "markdown", "mice", "miniUI", "naniar", "purrr",
  "rms", "shiny", "spelling","stringr", "testthat", "unheadr",
  "usethis", "visNetwork", "webshot", "withr", "xaringan"
)
gh_dev_pkgs <- c(
  "ropensci/tarchetypes",
  "gadenbuie/xaringanthemer",
  "gadenbuie/metathis",
  "gadenbuie/xaringanExtra",
  "hadley/emo",
  "CorradoLanera/autotestthat"
)
renv::install(c(dev_pkgs, gh_dev_pkgs))


usethis::use_description(check_name = FALSE)
usethis::use_proprietary_license("UBEP")


purrr::walk(dev_pkgs, usethis::use_package, type = "Suggests")
purrr::walk(gh_dev_pkgs, ~{
  package_name <- stringr::str_extract(.x, "[\\w\\.]+$")
  usethis::use_dev_package(package_name, type = "Suggests", remote = .x)
})
usethis::use_tidy_description()


# Start-up settings ------------------------------------------------

usethis::edit_r_profile("project")
usethis::edit_r_environ("project")


# Documentation ---------------------------------------------------

usethis::use_roxygen_md()
usethis::use_readme_rmd()
usethis::use_code_of_conduct("corrado.lanera@ubep.unipd.it")
usethis::use_lifecycle_badge("experimental")
usethis::use_logo("man/img/LAIMS.png")

# Checks ----------------------------------------------------------

usethis::use_spell_check()
usethis::use_testthat()
# add # library(checkmate)
fs::file_create(here::here("tests/testthat/setup.R"))
usethis::use_test("setup")

# Data infrastructure ---------------------------------------------

usethis::use_data_raw()


# Basic functions' infrastructure ---------------------------------

usethis::use_r("utils")
usethis::use_test("utils")
usethis::use_r("functions")
usethis::use_test("functions")


# Pipeline --------------------------------------------------------

targets::tar_script()
targets::tar_renv(extras = character(0))



# Isolation -------------------------------------------------------

usethis::git_vaccinate()
usethis::use_tidy_description()
renv::upgrade()
renv::update()
renv::status()
renv::snapshot()
