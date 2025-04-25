install.packages("forecast")
library(forecast)

set.seed(123)  # for reproducibility

# a. MA(1) with θ1 = 0.8
ma1 <- arima.sim(model = list(ma = 0.8), n = 100)
ts.plot(ma1, main = "MA(1) with θ1 = 0.8", ylab = "Value")
# b. MA(2) with θ1 = -0.6 and θ2 = 0.1
ma2 <- arima.sim(model = list(ma = c(-0.6, 0.1)), n = 100)
ts.plot(ma2, main = "MA(2) with θ1 = -0.6, θ2 = 0.1", ylab = "Value")
# c. AR(1) with φ1 = 0.4
ar1 <- arima.sim(model = list(ar = 0.4), n = 100)
ts.plot(ar1, main = "AR(1) with φ1 = 0.4", ylab = "Value")

# d. AR(2) with φ1 = 0.9 and φ2 = -0.2
ar2 <- arima.sim(model = list(ar = c(0.9, -0.2)), n = 100)
ts.plot(ar2, main = "AR(2) with φ1 = 0.9, φ2 = -0.2", ylab = "Value")
# e. ARMA(2,2) with φ1 = 0.9, φ2 = -0.2, θ1 = -0.6, θ2 = 0.1
arma22 <- arima.sim(model = list(ar = c(0.9, -0.2), ma = c(-0.6, 0.1)), n = 100)
ts.plot(arma22, main = "ARMA(2,2)", ylab = "Value")
