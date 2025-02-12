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

# Start Selenium server on port 4444 (integer value)
sel <- selenium(port = 4444)

#============================================
rs_driver_object <- rsDriver(browser ="chrome",
                             chromever = "114.0.5735.90",
                             verbose =F,
                             port= free_port())







#-------------------------------------------------

binman::list_versions("chromedriver")

opera_path <- "C:/Users/Moetez/AppData/Local/Programs/Opera GX/opera.exe"

# Set the path to OperaDriver (update this to your path)
operadriver_path <- "C:/Users/Moetez/Desktop/R Projects/R-Data-Projects/Web Scaping Dynamic Tables in R/Opera GX Driver/operadriver_win64/operadriver.exe"

# Set up custom capabilities for Opera GX
caps <- list(
  "browserName" = "chrome",  # Opera is Chromium-based, so we use "chrome"
  "chromeOptions" = list(
    binary = opera_path  # Path to Opera GX executable
  ),
  "webdriver.chrome.driver" = operadriver_path  # Path to OperaDriver
)

# Start Selenium server with Opera GX
remDr <- remoteDriver(
  remoteServerAddr = "localhost",
  port = free_port(),  # Default port, change if needed
  browserName = "chrome",  # Opera is Chromium-based
  extraCapabilities = caps
)

# Open the browser
remDr$open()

# Verify by navigating to a website
remDr$navigate("https://www.google.com")


#--------------------------------------------------------
opera_binary_path <- "C:/Users/Moetez/AppData/Local/Programs/Opera GX/opera.exe"
operadriver_path <- "C:/Users/Moetez/Desktop/R Projects/R-Data-Projects/Web Scaping Dynamic Tables in R/Opera GX Driver/operadriver_win64/operadriver.exe"

# Start Selenium with Opera GX using RSelenium
rs_driver_object <- rsDriver(
  browser = "chrome",  # Opera is Chromium-based, use "chrome"
  chromever = NULL,   # No need to specify Chrome version here
  extraCapabilities = list(
    "browserName" = "chrome",  # Opera is based on Chrome, so we use "chrome"
    "chromeOptions" = list(
      binary = opera_binary_path,  # Path to Opera GX executable
      args = list("--disable-extensions", "--disable-gpu")  # Optional arguments
    ),
    "webdriver.chrome.driver" = operadriver_path  # Path to OperaDriver
  ),
  verbose = TRUE,  # Set to TRUE for debugging
  port = free_port()  # Automatically select a free port
)

# Access the remote driver object
remote_driver <- rs_driver_object$client

remote_driver$getStatus()


# Example: Open a webpage
url <- "https://www.google.com"
remote_driver$navigate(url)

# Print the page title
print(remote_driver$getTitle())

# Close the session
remote_driver$close()

# Stop the Selenium server
rs_driver_object$server$stop()



#================================================
opera_binary_path <- "C:/Users/Moetez/AppData/Local/Programs/Opera GX/opera.exe"
operadriver_path <- "C:/Users/Moetez/Desktop/R Projects/R-Data-Projects/Web Scaping Dynamic Tables in R/Opera GX Driver/operadriver_win64/operadriver.exe"

# Check if the OperaDriver path exists
if (!file.exists(operadriver_path)) {
  stop("OperaDriver not found at the specified path.")
}

# Start Selenium with Opera GX
rs_driver_object <- rsDriver(
  browser = "chrome",  # Opera is Chromium-based
  chromever = "latest",
  extraCapabilities = list(
    "browserName" = "chrome",  
    "chromeOptions" = list(
      binary = opera_binary_path  # Path to Opera GX executable
    ),
    "webdriver.chrome.driver" = operadriver_path  # Path to OperaDriver
  ),
  verbose = TRUE,
  port = 4444L  # Automatically select a free port
)

# Access the remote driver object
remote_driver <- rs_driver_object$client

# Example: Open a webpage
remote_driver$navigate("https://www.google.com")

# Print the page title
print(remote_driver$getTitle())

# Close the session
remote_driver$close()

# Stop the server
rs_driver_object$server$stop()


#==========================================
selCommand=wdman::selenium(jvmargs = c("Dwebdriver.chrome.verboseLogging=true"), retcommand = TRUE)
cat(selCommand)


rD=rsDriver(browser = c("chrome"))
remDr=remoteDriver(remoteServerAddr = "localhost", port = 4567L, browserName = "chrome")
remDr=rD$client