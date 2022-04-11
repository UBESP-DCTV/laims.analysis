library(targets)
library(tarchetypes)
library(here)
# This is an example _targets.R file. Every
# {targets} pipeline needs one.
# Use tar_script() to create _targets.R and tar_edit()
# to open it again for editing.
# Then, run tar_make() to run the pipeline
# and tar_read(result) to view the results.

# Define custom functions and other global objects.
# This is where you write source(\"R/functions.R\")
# if you keep your functions in external scripts.
list.files(here("R"), pattern = "\\.R$", full.names = TRUE) |>
  lapply(source) |> invisible()

# Set target-specific options such as packages.
tar_option_set(
  packages = c("readr"),
  error = "continue"
)

# End this file with a list of target objects.
list(
  tar_target(
    db_raw_path,
    here::here("data-raw/<db_raw.csv>"),
    format = "file"
  ),
  tar_target(db_raw, readr::read_csv2(db_raw_path)),
  tar_target(db, preprocess(db_raw)),


  # Call your custom functions as needed.
  tar_target(result, null(1)),

  # compile the report
  tar_render(report, here("reports/report.Rmd"))
)
