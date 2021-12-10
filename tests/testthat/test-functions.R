test_that("null template returns null", {
  # setup
  x <- 1

  # execution
  res_empty <- null()
  res_x <- null(x)

  # expectations
  expect_null(res_empty)
  expect_null(res_x)
})
