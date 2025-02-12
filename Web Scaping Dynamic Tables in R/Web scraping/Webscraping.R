install.packages("tidyverse")
install.packages("RSelenium")
install.packages("rvest")
install.packages("netstat")
install.packages("data.table")
install.packages("wdman")
#loading packages:

library(tidyverse) #data wrangling
library(RSelenium) #activate Selenimu server
library(rvest) # web scrape tables
library(netstat) # find unused port
library(data.table) #rbindlist function
library(wdman)


#==========================================================


opera_binary_path <- "C:/Users/Moetez/AppData/Local/Programs/Opera GX/opera.exe"
operadriver_path <- "C:/Users/Moetez/Desktop/R Projects/R-Data-Projects/Web Scaping Dynamic Tables in R/Opera GX Driver/operadriver_win64/operadriver.exe"

# Start Selenium with Opera GX, treating it as Chrome
rs_driver_object <- rsDriver(
  browser = "chrome",  # Use "chrome" since Opera GX is Chromium-based
  chromever = NULL,  
  extraCapabilities = list(
    "browserName" = "chrome",
    "chromeOptions" = list(
      binary = opera_binary_path,
      args = list("--disable-extensions", "--disable-gpu")
    )
  ),
  verbose = TRUE,
  port = 58532L  # Ensure this matches the OperaDriver log
)

# Access the remote driver
remote_driver <- rs_driver_object$client

# Check connection
remote_driver$getStatus()

# Open Google
url <- "https://www.google.com"
remote_driver$navigate(url)

# Print the page title
print(remote_driver$getTitle())

# Close session
remote_driver$close()

# Stop Selenium server
rs_driver_object$server$stop()
