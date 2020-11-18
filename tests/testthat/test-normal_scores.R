test_that("Return error or warning for unsupported circumstances", {
  expect_error(normal_scores(numeric(0)))
  expect_warning(normal_scores(rnorm(30), ties = "avg"))
})

test_that("Check the output formmat is data.frame", {
  expect_true(is.data.frame(normal_scores(rnorm(30))))
})

test_that("length > 10, using a = 0.5 in normal_score formula", {
  data<-rnorm(30)
  expect_equal(normal_scores(data)$normal_score,
               qnorm((rank(data) - 0.5)/30))
  expect_equal(normal_scores(data)$standard_score,
               (data - mean(data))/stats::sd(data))
})

test_that("length <= 10, using different a in normal_score, a = 0.375", {
  data<-rnorm(10)
  expect_equal(normal_scores(data)$normal_score,
               qnorm((rank(data) - 0.375)/(10 + 0.25)))
  expect_equal(normal_scores(data)$standard_score,
               (data - mean(data))/stats::sd(data))
})

test_that("ties only affects normal_score", {
  data<-rnorm(20)
  data[5] = data[6] # Making ties
  result_average <- normal_scores(data, ties = "average")
  result_first <- normal_scores(data, ties = "first")
  #Normal score are not same
  expect_true(result_average$normal_score[5] != result_first$normal_score[5])
  #Standard scores are same
  expect_equal(result_average$standard_score, result_first$standard_score)
})

