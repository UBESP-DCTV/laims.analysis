test_that("%||% works", {
  # setup
  x <- NULL
  y <- 1

  # execution
  res_null <- x %||% 7
  res_full <- y %||% 7

  # expectation
  expect_equal(res_null, 7)
  expect_equal(res_full, 1)
})


test_that("extract_fct_names works", {
  # setup
  funs <- "
  a <- function() {}
  b <- 2
  c<- function() {}
  d <-function() {}
  `%||%` <- function() {}
  "
  withr::local_file("funs.R")
  fs::file_exists("funs.R")
  readr::write_lines(funs, "funs.R")
  readr::read_lines("funs.R")
  # execution
  res <- extract_fct_names("funs.R")

  # expectation
  expect_equal(res, c("a", "c", "d", "%||%"))
})
