# To view your current pipeline status, and possibly run/update it,
# you can simply source/execute this script (maybe using the
# `dev/03-run_cycle.R` script)
{
  function(proceed = TRUE, save_all = TRUE) {
    if (interactive()) {
      if (
        requireNamespace("rstudioapi") &&
        rstudioapi::isAvailable() &&
        save_all
      ) {
        rstudioapi::documentSaveAll()
      }

      targets::tar_visnetwork() |>
        print()

      proceed <- usethis::ui_yeah(
        "Do you want to proceed with {usethis::ui_code('tar_make')}?"
      )
    }

    if (proceed) {
      withr::with_envvar(
        list(RSTUDIO_VERSION = "2021.09.0"), {
          # devtools::test(stop_on_failure = TRUE)
          targets::tar_make()
        }
      )
      targets::tar_visnetwork(targets_only = TRUE) |>
        print()
    }
  }
}()

