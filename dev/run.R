# To view your current pipeline status, and possibly run/update it,
# you can simply source/execute this script (maybe using the
# `dev/03-run_cycle.R` script)
.run <- function(
    reporter = c("balanced", "verbose"),
    check = TRUE,
    check_targets_only = TRUE,
    save_all = TRUE,
    seconds_meta_append = 1.5,
    force = !check
) {
  if (interactive() || force) {
    reporter <- match.arg(reporter)

    if (
      requireNamespace("rstudioapi") &&
      rstudioapi::isAvailable() &&
      save_all
    ) {
      usethis::ui_done("All scripts saved.")
      rstudioapi::documentSaveAll()
    }

    if (check) {
      usethis::ui_todo("Check your pipeline.")
      targets::tar_visnetwork(
        targets_only = check_targets_only
      ) |>
        print()
    }

    if (
      force ||
      usethis::ui_yeah("Do you want to make your pipeline?")
    ) {
      usethis::ui_todo("Make your pipeline.")
      usethis::ui_info("Start: {tic <- lubridate::now()}")
      targets::tar_make(
        reporter = reporter,
        seconds_meta_append = seconds_meta_append
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

      usethis::ui_todo("Review the updated status.")
      targets::tar_visnetwork(targets_only = TRUE, outdated = FALSE) |>
        print()
    }
  }
}

