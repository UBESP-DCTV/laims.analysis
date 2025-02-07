
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



get_input_data_path <- function(x = "") {
  file.path(
    Sys.getenv("PRJ_SHARED_PATH"),
    Sys.getenv("INPUT_DATA_FOLDER"),
    x
  ) |>
    normalizePath()
}

get_output_data_path <- function(x = "") {
  file.path(
    Sys.getenv("PRJ_SHARED_PATH"),
    Sys.getenv("OUTPUT_DATA_FOLDER"),
    x
  ) |>
    normalizePath(mustWork = FALSE)
}


share_objects <- function(obj_list) {
  now <- lubridate::now() |>
    stringr::str_remove_all("\\W+") |>
    stringr::str_sub(1, 12)

  file_name_now <- stringr::str_c(
    names(obj_list), "-", now, ".rds"
  )

  file_name_latest <- stringr::str_c(
    names(obj_list), "-", "latest", ".rds"
  )

  obj_paths_now <- get_output_data_path(file_name_now) |>
    normalizePath(mustWork = FALSE) |>
    purrr::set_names(names(obj_list))

  obj_paths_latest <- get_output_data_path(file_name_latest) |>
    normalizePath(mustWork = FALSE) |>
    purrr::set_names(names(obj_list))

  # Those must be RDS
  obj_list |>
    purrr::walk2(obj_paths_now, readr::write_rds)
  obj_list |>
    purrr::walk2(obj_paths_latest, readr::write_rds)

  obj_paths_latest
}
