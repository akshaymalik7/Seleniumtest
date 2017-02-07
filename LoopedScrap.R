library('RSelenium')
library(rvest)

#SET UP THE SELENIUM SERVER
#remDr <- ***Your Server Code***
user <- "maaks" # Your Sauce Labs username
pass <- "47f1e26b-bea4-4cc8-9ef9-8c990ef3b35c" # Your Sauce Labs access key 

port <- 80
ip <- paste0(user, ':', pass, "@ondemand.saucelabs.com")
rdBrowser <- "chrome"
version <- "55"
platform <- "Windows 10"
extraCapabilities <- list(name = "RSelenium", username = user
                          , accessKey = pass, tags = list("RSelenium-vignette", "OS/Browsers-vignette"))
remDr <- remoteDriver$new(remoteServerAddr = ip, port = port, browserName = rdBrowser
                          , version = version, platform = platform
                          , extraCapabilities = extraCapabilities)


#Launch the browser
remDr$open()

#remDr$navigate("http://property.phila.gov/")
#remDr$getCurrentUrl()

scrapedDF <- data.frame("Address"= character(), "Unit" = integer(), "Area" = integer(), "Value" = character(), stringsAsFactors=FALSE)  
typeof(scrapedDF)
heading <- c("Address", "Unit", "Area", "Value")

#Import the addresses
condos <- as.matrix(read.csv("/Users/akshaymalik/Documents/Github Code/Data Wrangling/Seleniumtest/rittenhouse-condos.csv", sep=","))
condos

scrapeCondoData <- function(x,y) {
  
  remDr$navigate("http://property.phila.gov/")
  
  remDr$setImplicitWaitTimeout(1000)
  
  addressField <- remDr$findElement("css selector", "#search-address")
  unitField <- remDr$findElement("css selector", '#search-unit')
  
  #Type in the search text - "Something" and press enter
  addressField$sendKeysToElement(list(x, '')) 
  unitField$sendKeysToElement(list(y,'')) 
  unitField$sendKeysToElement(list(key = 'enter'))
  
  remDr$setImplicitWaitTimeout(1000)
  
  areaselector <- remDr$findElement("css selector", '#maincontent > div:nth-child(3) > div.property-side.large-10.columns > div.panel.mbm > div:nth-child(6) > div.medium-14.columns > strong')
  valueselector <- remDr$findElement("css selector", 'table > tbody > tr:nth-child(1) > td:nth-child(2)')
  
  area <-areaselector$getElementText()[[1]]
  value <- valueselector$getElementText()[[1]]
  
  #collection = c("Address" = addr, "Unit" = unit, "Area" = area, "Value" = value)
  
  collection = c("Address" = addr, "Unit" = unit, "Area" = area, "Value" = value)
  return(collection)
  
}

results <- mapply(scrapeCondoData,condos[,1],condos[,2] )
results

scrapedDF <- rbind(scrapedDF, data.frame(t(results),row.names=NULL))

scrapedDF 
