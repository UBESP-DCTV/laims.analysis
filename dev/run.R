# To view your current pipeline status, and possibly run/update it,
# you can simply source/execute this script (maybe using the
# `dev/03-run_cycle.R` script)
(\() if (interactive()) {
  if (
    requireNamespace("rstudioapi") &&
    rstudioapi::isAvailable()
  ) {
    usethis::ui_done("All scripts saved.")
    rstudioapi::documentSaveAll()
  }

  usethis::ui_todo("Check your pipeline.")
  targets::tar_visnetwork() |>
    print()

  usethis::ui_todo("Make your pipeline.")
  if (usethis::ui_yeah("Do you want to make your pipeline?")) {
    targets::tar_make()
    usethis::ui_todo("Review the updated status.")
    targets::tar_visnetwork(targets_only = TRUE, outdated = FALSE) |>
      print()
  }
})()



