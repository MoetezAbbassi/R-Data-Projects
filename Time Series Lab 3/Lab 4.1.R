install.packages("tseries")


library(tseries)

set.seed(123)
deere3 <- arima.sim(n = 57, list(ar = 0.6), sd = 1)
plot(deere3, type = "l", main = "Simulated Stationary AR(1) Series")

adf.test(deere3)

acf(deere3, main = "Autocorrelation Function (ACF)")

pacf(deere3, main = "Partial Autocorrelation Function (PACF)")


# First difference the series
deere3_diff <- diff(deere3)

# Plot differenced series
plot(deere3_diff, type = "l", main = "First-Differenced Series", ylab = "Difference")

# ADF test on differenced series
adf.test(deere3_diff)

# ACF and PACF of differenced series
acf(deere3_diff, main = "ACF of First-Differenced Series")
pacf(deere3_diff, main = "PACF of First-Differenced Series")

# Optional: Fit ARIMA model to differenced data
arima_diff_fit <- arima(deere3, order = c(0, 1, 0))  # ARIMA(0,1,0) = random walk
summary(arima_diff_fit)