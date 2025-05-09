# Load required libraries
library(ggplot2)
library(forecast)
library(tseries)

# 1. Simulate a non-stationary time series (Random Walk)
set.seed(123)
ts_data <- cumsum(rnorm(100))  # Random walk is non-stationary

# 2. Plot the original time series
autoplot(ts(ts_data)) + ggtitle("Original Time Series (Random Walk)")

# 3. ADF Test on original series
cat("ADF Test on Original Series:\n")
print(adf.test(ts_data))

# 4. First-order differencing
ts_diff <- diff(ts_data)

# 5. Plot differenced series
autoplot(ts(ts_diff)) + ggtitle("Differenced Time Series")

# 6. ADF Test after differencing
cat("ADF Test on Differenced Series:\n")
print(adf.test(ts_diff))

# 7. ACF and PACF of differenced series
acf(ts_diff, main="ACF of Differenced Series")
pacf(ts_diff, main="PACF of Differenced Series")