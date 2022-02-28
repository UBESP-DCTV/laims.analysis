
# FIRST RUN ONLY ---------------------------------------------------

## - [ ] Change the name of `laims.analyses.Rproj` using your main
##       project's directory name accordingly. To do that,
##       simply run the following code
proj_name <- basename(here::here())
fs::file_move(
  here::here("laims.analysis.Rproj"),  # old project's name
  paste0(proj_name, ".Rproj")  # current project's name
)


list.files(here::here(), pattern = "\\.([rR]|([rR]?md))$") |>
  setdiff("01-FIRST_RUN.R") |>
  c("DESCRIPTION") |>
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
usethis::use_readme_rmd()

# put your email here, i.e. usethis::use_code_of_conduct("me@org.com")
usethis::use_code_of_conduct()
usethis::use_lifecycle_badge("experimental")
rmarkdown::render(here::here("README.Rmd"))


## So you can put this very file in the `dev/` folder, where you can
## find another useful file 02-dev_cycle.R
fs::file_move("01-FIRST_RUN.R", "dev/01-first_run.R")
rstudioapi::navigateToFile(here::here("dev/02-dev_cycle.R"))
