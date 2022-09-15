
# FIRST RUN ONLY ---------------------------------------------------

## - [ ] Change the name of `laims.analyses.Rproj` using your main
##       project's directory name accordingly. To do that,
##       simply run the following code
prj_name <- basename(here::here())
fs::file_move(
  here::here("laims.analysis.Rproj"),  # old project's name
  paste0(prj_name, ".Rproj")  # current project's name
)


here::here() |>
  list.files(
    pattern = "\\.([rR]|([rR]?md))$",
    recursive = TRUE,
    all.files = TRUE
  ) |>
  setdiff(c("01-FIRST_RUN.R")) |>
  c("DESCRIPTION", ".Renviron") |>
  purrr::walk(~{
    readLines(.x) |>
      stringr::str_replace_all("laims\\.analysis", prj_name) |>
      writeLines(.x)
  })



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

## [Optional] Finaly, update all your packages in the project's library.
renv::upgrade()
renv::update()
renv::status()
renv::snapshot()


## At your convenience, replace your readme file
{
  usethis::use_readme_rmd()
  usethis::use_lifecycle_badge("experimental")
  usethis::use_github_actions_badge("check-release")
  usethis::use_github_actions_badge("test-coverage")
  usethis::use_github_actions_badge("lint")
}

# put your email here, i.e. usethis::use_code_of_conduct("me@org.com")
usethis::use_code_of_conduct()
devtools::build_readme()

## So you can put this very file in the `dev/` folder, where you can
## find another useful file 02-dev_cycle.R
{
  fs::file_move("01-FIRST_RUN.R", "dev/01-first_run.R")
  rstudioapi::documentClose()
  usethis::ui_done(paste0(
    "{usethis::ui_value('01-FIRST_RUN.R')} moved to",
    "{usethis::ui_value('dev/01-first_run.R')}, and closed."
  ))

  rstudioapi::navigateToFile(here::here("dev/02-dev_cycle.R"))
  usethis::ui_todo(paste0(
    "Use {usethis::ui_value('02-dev_cycle.R')} ",
    "to maintain the project updated during its development."
  ))

  rstudioapi::navigateToFile(here::here("dev/03-run_cycle.R"))
  rstudioapi::navigateToFile(here::here("_targets.R"))
  usethis::ui_todo(
    "Use {usethis::ui_value('_targets.R')} to devine your pipelines."
  )

  rstudioapi::navigateToFile(
    here::here("tests/testthat/test-functions.R")
  )
  rstudioapi::navigateToFile(here::here("R/functions.R"))
  usethis::ui_todo(
    "Use {usethis::ui_value('functions.R')} for your main functions."
  )

  rstudioapi::navigateToFile(
    here::here("tests/testthat/test-utils.R")
  )
  rstudioapi::navigateToFile(here::here("R/utils.R"))
  usethis::ui_todo(
    "Use {usethis::ui_value('utils.R')} for your wrappers."
  )

  rstudioapi::navigateToFile(here::here("dev/03-run_cycle.R"))
  usethis::ui_todo(paste0(
    "Use {usethis::ui_value('03-run_cycle.R')} ",
    "to check and execute the pipeline at each iteration."
  ))
}
