# 1. Load required libraries
library(forecast)
library(ggplot2)

# 2. Create a simple time series (no seasonality)
data_values <- ts(c(100, 102, 104, 107, 110, 113, 115, 118, 120, 123, 125, 128))

# 3. Fit an ARIMA model automatically
model <- auto.arima(data_values)

# 4. Forecast the next 12 periods
forecast_values <- forecast(model, h = 12)

# 5. Plot the forecast
autoplot(forecast_values) + ggtitle("Simple ARIMA Forecast")

# 6. Print the forecasted values
print(forecast_values)