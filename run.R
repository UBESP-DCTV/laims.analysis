
# Select all and... run it! ---------------------------------------


run <- function(proceed = TRUE) {
  if (interactive()) {
    targets::tar_visnetwork(targets_only = TRUE) |>
      print()

    proceed <- usethis::ui_yeah(
      "Do you want to proceed with {usethis::ui_code('tar_make')}?"
    )
  }

  if (proceed) {
    withr::with_envvar(
      list(RSTUDIO_VERSION = "2021.09.0"),
      targets::tar_make()
    )
  }
}

run()
