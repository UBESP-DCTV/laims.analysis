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

  usethis::ui_warn(paste0(
    "Environmental variable {usethis::ui_field('PRJ_SHARED_PATH')} ",
    "is not set."
  ))

  usethis::ui_info(paste0(
    "If you like, you can set it to a shared path for the project.\n",
    "You can set it in the {usethis::ui_value('.Renviron')} file.\n",
    "Open {usethis::ui_value('.Renviron')} by ",
    "{usethis::ui_code('usethis::edit_r_environ(\"project\")')}."
  ))

  Sys.setenv(PRJ_SHARED_PATH = normalizePath(here::here()))
  usethis::ui_todo(paste0(
    "Default path is set to the current project folder; ",
    "i.e., the {usethis::ui_value('_targets/')} folder is not shared."
  ))
}


if (!(fs::is_dir(Sys.getenv("PRJ_SHARED_PATH")))) {
  usethis::ui_stop(paste0(
    "Environmental variable {usethis::ui_field('PRJ_SHARED_PATH')} ",
    "is currently set to\n",
    "{usethis::ui_value(Sys.getenv('PRJ_SHARED_PATH'))}.\n",
    "That path is not a valid folder (in your current system).\n",
    "You must set/update the filed ",
    "{usethis::ui_field('PRJ_SHARED_PATH')} of ",
    "{usethis::ui_value('.Renviron')} to a valid folder.\n",
    "You can open {usethis::ui_value('.Renviron')} by running ",
    "{usethis::ui_code('usethis::edit_r_environ(\"project\")')}."
  ))
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
