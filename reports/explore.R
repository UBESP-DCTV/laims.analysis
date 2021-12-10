## Use this script to run exploratory code maybe before to put it into
## the pipeline

# setup -----------------------------------------------------------

library(targets)  # use tar_read(target_name) to load a target anywhere

# load all your custom functions
list.files(here("R"), pattern = "\\.R$", full.names = TRUE) |>
  lapply(source) |> invisible()



# Code here below -------------------------------------------------


