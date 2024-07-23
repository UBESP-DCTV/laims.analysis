source("renv/activate.R")

options(tidyverse.quiet = TRUE)

stopifnot(
  `env var "PROJ_TITLE" must be set` = Sys.getenv("PROJ_TITLE") != "",
  `env var "PROJ_DESCRIPTION" must be set` =
    Sys.getenv("PROJ_DESCRIPTION") != "",
  `env var "PROJ_URL" must be set` = Sys.getenv("PROJ_URL") != ""
)

if (interactive()) {
  if (as.logical(Sys.getenv("ATTACH_STARTUP_PKGS"))) {
    usethis::ui_todo("Attaching development supporting packages...")
    suppressPackageStartupMessages(suppressWarnings({
      library(usethis)
      ui_done("Library {ui_value('usethis')} attached.")
      library(checkmate)
      ui_done("Library {ui_value('checkmate')} attached.")
      library(devtools)
      ui_done("Library {ui_value('devtools')} attached.")
      library(targets)
      ui_done("Library {ui_value('targets')} attached.")
      library(testthat)
      ui_done("Library {ui_value('testthat')} attached.")
    }))
  }

  if (
    requireNamespace("rstudioapi") &&
    fs::file_exists("01-FIRST_RUN.R")
  ) {
    # https://github.com/rstudio/rstudioapi/issues/100
    setHook(
      "rstudio.sessionInit",
      function(newSession) {
        if (newSession) {
          rstudioapi::navigateToFile("01-FIRST_RUN.R")
        }
      },
      action = "append"
    )
  }


  if (Sys.getenv("PRJ_SHARED_PATH") == "") {

    usethis::ui_info(paste0(
      "Environmental variable {usethis::ui_field('PRJ_SHARED_PATH')} ",
      "is not set."
    ))

    usethis::ui_info(paste0(
      "You can set it to a shared path for the project.\n",
      "You can set it in the {usethis::ui_value('.Renviron')} file.\n",
      "Open {usethis::ui_value('.Renviron')} by ",
      "{usethis::ui_code('usethis::edit_r_environ(\"project\")')}."
    ))

    Sys.setenv(PRJ_SHARED_PATH = normalizePath(here::here()))
    readLines(here::here(".Renviron")) |>
      stringr::str_replace(
        'PRJ_SHARED_PATH=""',
        paste0(
          'PRJ_SHARED_PATH="',
          normalizePath(here::here()) |>
            stringr::str_replace_all("\\\\", "\\\\\\\\"),
          '"'
        )
      ) |>
      writeLines(here::here(".Renviron"))
    usethis::ui_todo(paste0(
      "Default path is set to the current project folder; ",
      "i.e., the {usethis::ui_value('_targets/')} folder is not shared."
    ))
    usethis::ui_info("This message is shown this time only.")
  }

  Sys.setenv(
    "PRJ_SHARED_PATH" = path.expand(Sys.getenv("PRJ_SHARED_PATH"))
  )

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

  .get_prj_shared_path <- function() {
    Sys.getenv('PRJ_SHARED_PATH') |>
      normalizePath(winslash = "/", mustWork = FALSE)
  }

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

  .run <- function(...) {
    source(here::here("dev/run.R")) # check and make pipeline.
    .run(...)
  }
  ui_info("Exexute {ui_code('.run()')} to make the pipeline.")

  .background_run <- function(...) {
    stopifnot(requireNamespace("rstudioapi"))
    rstudioapi::jobRunScript(
      here::here("dev/background_run.R"),
      workingDir = here::here()
    )
  }
  ui_info(paste0(
    "Exexute {ui_code('.background_run()')} to make the pipeline ",
    "as a background job in RStudio."
  ))
}
