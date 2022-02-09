# the following code is running at the beginning of every tests.
library(checkmate)

.tar_updated <- targets::tar_manifest(fields = "name")[["name"]] |>
  setdiff(targets::tar_outdated(targets_only = TRUE))

tar_read_if_valid <- function(name) {
  if (name %in% .tar_updated) {
    return(targets::tar_read_raw(name))
  }
  usethis::ui_warn("target {name} is outdated, it won't be loaded.")
  invisible(NULL)
}
