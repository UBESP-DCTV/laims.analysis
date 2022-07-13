
# Here below put your small tiny supporting functions -------------


view_in_excel <- function(.data) {
  if (interactive()) {
    tmp <- fs::file_temp("excel", ext = "csv")
    readr::write_excel_csv(.data, tmp)
    fs::file_show(tmp)
  }
  invisible(.data)
}


extract_fct_names <- function(path) {
  readr::read_lines(path) |>
    stringr::str_extract_all("^.*(?=`? ?<- ?function)") |>
    unlist() |>
    purrr::compact() |>
    stringr::str_remove_all("[\\s`]+")
}



get_input_data_path <- function() {
  file.path(
    Sys.getenv("PRJ_SHARED_PATH"),
    Sys.getenv("INPUT_DATA_FOLDER")
  )
}

get_output_data_path <- function() {
  file.path(
    Sys.getenv("PRJ_SHARED_PATH"),
    Sys.getenv("OUTPUT_DATA_FOLDER")
  )
}


share_objects <- function(obj_list) {
  file_name <- paste0(names(obj_list), ".rds")

  obj_paths <- file.path(get_output_data_path, file_name) |>
    normalizePath(mustWork = FALSE) |>
    purrr::set_names(names(obj_list))

  # Those must be RDS
  purrr::walk2(obj_list, obj_paths, readr::write_rds)
  obj_paths
}
