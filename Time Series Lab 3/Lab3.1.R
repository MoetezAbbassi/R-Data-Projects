# Simulate AR(1)
ar1_48 <- arima.sim(model = list(ar = 0.7), n = 48)

# 1. First 5 autocorrelations
acf_vals <- acf(ar1_48, plot = FALSE)$acf[2:6]
print("First 5 ACF values:")
print(round(acf_vals, 3))

# 2. First 5 partial autocorrelations
pacf_vals <- pacf(ar1_48, plot = FALSE)$acf[1:5]
print("First 5 PACF values:")
print(round(pacf_vals, 3))

# Simulate AR(1) series with φ = 0.7 and n = 48
set.seed(123)
ar1_48 <- arima.sim(model = list(ar = 0.7), n = 48)

# Plot the time series
ts.plot(ar1_48, main = "Simulated AR(1) Time Series (φ = 0.7)")

# Plot ACF
acf(ar1_48, main = "ACF of AR(1)")

# Plot PACF
pacf(ar1_48, main = "PACF of AR(1)")
