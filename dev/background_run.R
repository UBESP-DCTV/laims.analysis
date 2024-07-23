# reporter <- "verbose"
# reporter <- "verbose_positives"
reporter <- "summary"

usethis::ui_info("Start: {tic <- lubridate::now()}")

targets::tar_make(
  reporter = reporter,
  seconds_meta_append = 1.5,
  seconds_reporter = 0.5
)

usethis::ui_info("End: {toc <- lubridate::now()}")
usethis::ui_info(
  "Real-world time: {lubridate::as.duration(round(toc - tic, 2))}"
)

computational_time <- targets::tar_meta(
  targets::tar_manifest()[["name"]],
  fields = c(seconds, warnings, error)
) |>
  dplyr::filter(
    is.na(warnings), is.na(error), !is.na(seconds)
  ) |>
  dplyr::pull(seconds) |>
  sum()

usethis::ui_info(
  "Computational time: {lubridate::as.duration(round(computational_time, 2))}"
)
