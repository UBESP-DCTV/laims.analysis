source("renv/activate.R")


options(
  tidyverse.quiet = TRUE
)

stopifnot(
  `env var "PROJ_TITLE" must be set` = Sys.getenv("PROJ_TITLE") != "",
  `env var "PROJ_DESCRIPTION" must be set` =
    Sys.getenv("PROJ_DESCRIPTION") != "",
  `env var "PROJ_URL" must be set` = Sys.getenv("PROJ_URL") != ""
)

if (interactive()) {
  suppressPackageStartupMessages(suppressWarnings({
    library(devtools)
    library(usethis)
    library(checkmate)
    library(testthat)
    library(targets)
  }))
}


if (Sys.getenv("PRJ_SHARED_PATH") == "") {

  usethis::ui_warn("
  Environmental variable {usethis::ui_field('PRJ_SHARED_PATH')} is not set.
  ")

  usethis::ui_info("
  You can set it to a shared path for the project.
  You can set it in the {usethis::ui_value('.Renviron')} file.
  You can open the project {usethis::ui_value('.Renviron')} file calling
  {usethis::ui_code('usethis::edit_r_environ(\"project\")')}.
  ")

  usethis::ui_todo("
  Default path is now set to the current project folder (i.e. `_targets/` folder is not shared)
  ")

  Sys.setenv(PRJ_SHARED_PATH = normalizePath(here::here()))
}


if (!(fs::is_dir(Sys.getenv("PRJ_SHARED_PATH")))) {
  usethis::ui_stop("
  Environmental variable {usethis::ui_field('PRJ_SHARED_PATH')} is set to
  {usethis::ui_value(Sys.getenv('PRJ_SHARED_PATH'))}.

  That path is not a valid folder.
  You must provide a valid folder in {usethis::ui_field('PRJ_SHARED_PATH')}.
  ")
}


.get_prj_shared_path <- function() Sys.getenv('PRJ_SHARED_PATH')

targets::tar_config_set(
  store = file.path(.get_prj_shared_path(), "_targets")
)

targets::tar_config_set(
  script = here::here("_targets.R"),
  store = file.path(.get_prj_shared_path(), "_targets"),
  config = "tests/testthat/_targets.yaml"
)

targets::tar_config_set(
  script = here::here("_targets.R"),
  store = file.path(.get_prj_shared_path(), "_targets"),
  config = "reports/_targets.yaml"
)
