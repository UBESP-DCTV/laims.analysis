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

test_that("`%||%` works", {
  # setup
  something <- 1
  nothing <- NULL

  # execution
  res_ok <- something %||% 2
  res_ko <- nothing %||% 2

  # expectation
  expect_equal(res_ok, 1)
  expect_equal(res_ko, 2)
})
