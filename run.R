# To view your current pipeline status, and possibly run/update it,
# you can simply source/execute this script
{
  function(proceed = TRUE, save_all = TRUE, targets_only = FALSE) {
    if (interactive()) {
      if (requireNamespace("rstudioapi") && save_all) {
        rstudioapi::documentSaveAll()
      }
      targets::tar_visnetwork(targets_only = target_only) |>
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
      targets::tar_visnetwork(targets_only = targets_only) |>
        print()
    }
  }
}()
