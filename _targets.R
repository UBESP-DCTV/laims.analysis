library(targets)
library(tarchetypes)
# This is an example _targets.R file. Every
# {targets} pipeline needs one.
# Use tar_script() to create _targets.R and tar_edit()
# to open it again for editing.
# Then, run tar_make() to run the pipeline
# and tar_read(result) to view the results.

# Define custom functions and other global objects.
# This is where you write source(\"R/functions.R\")
# if you keep your functions in external scripts.
list.files(here::here("R"), pattern = "\\.R$", full.names = TRUE) |>
  lapply(source) |> invisible()

# Set target-specific options such as packages.
tar_option_set(
  packages = c("readr"),
  error = "continue"
)

# End this file with a list of target objects.
list(

  # Import your file from custom (shared) location, and preprocess them
  tar_target(
    db_raw_path,
    file.path(get_input_data_path(), "db_raw.csv"),
    format = "file"
  ),

  # Use {qs} in {targets} to save space and time in save/load objects
  tar_target(db_raw, import_data(db_raw_path), format = "qs"),
  tar_target(db, preprocess(db_raw), format = "qs"),


  # Call your custom functions as needed.
  tar_target(irrelevantResult, null(1), format = "qs"),
  tar_target(relevantResults, relevant_computation(db), format = "qs"),

  # compile yor report
  tar_render(report, here::here("reports/report.Rmd")),


  # Decide what to share with other, and do it in a standard RDS format
  tar_target(
    objectToShare,
    list(
      relevant_result = relevantResults
    )
  ),
  tar_target(
    shareOutput,
    share_objects(objectToShare),
    format = "file",
    pattern = map(objectToShare)
  )
)
