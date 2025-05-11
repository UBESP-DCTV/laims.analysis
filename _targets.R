library(targets)
library(tarchetypes)
library(crew)  # parallel computing

controller <- crew::crew_controller_local(
  name = "laims.analysis_controller",
  workers = 1
)

# Set target-specific options such as packages.
tar_option_set(
  # error handling
  error = "abridge", # "continue" (do other), "null" (NULL if error)
  workspace_on_error = TRUE,
  # fast data formats
  format = "qs",
  # parallel computing
  storage = "worker",
  retrieval = "worker",
  controller = controller
)

# Define custom functions and other global objects.
# This is where you write source(\"R/functions.R\")
# if you keep your functions in external scripts.
tar_source()


# End this file with a list of target objects.
list(

  # Import your file from custom (shared) location, and preprocess them
  tar_files_input(
    db_raw_path,
    # get_input_data_path("db_raw.csv"), # single
    get_input_data_path() |>
      list.files(pattern = "\\.csv$", full.names = TRUE) # multiple
  ),

  tar_target(db_raw, import_data(db_raw_path)),
  tar_target(db, preprocess(db_raw)),


  # Call your custom functions as needed.
  tar_target(relevantResult, relevant_computation(db)),

  # compile yor report
  tar_quarto(report, here::here("reports/report.qmd")),


  # Decide what to share with other, and do it in a standard RDS format
  tar_target(
    objectToShare,
    list(
      relevant_result = relevantResult
    )
  ),
  tar_target(
    shareOutput,
    share_objects(objectToShare),
    format = "file",
    pattern = map(objectToShare)
  ),


  tar_target(JustDontCareLastComma, NULL)
)
