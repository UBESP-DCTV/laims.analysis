
# Here below put your main project's functions ---------------------


#' Null function
#'
#' Use this as template for your first function, and delete it!
#'
#' @note You can add all this documentation infrastructure pressing
#'   `CTRL + SHIFT + ALT + R` from anywhere inside the function's body.
#'
#' @param x (default, NULL)
#'
#' @return NULL
#'
#' @examples
#' \dontrun{
#'   null()
#'   null(1)
#' }
null <- function(x = NULL) {
  if (!is.null(x)) NULL else x
}


import_data <- function(.dir_path) {
  file.path(.dir_path, "db.csv") |>
    normalizePath() |>
    readr::read_csv()
}


relevant_computation <- function(db) {
  2 * length(db) + 1
}
