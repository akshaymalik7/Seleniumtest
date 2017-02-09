
library('RSelenium')
library(rvest)

#SET UP THE SELENIUM SERVER
#remDr <- ***Your Server Code***

#Launch the browser
remDr$open()

#Import the addresses
condos <- as.matrix(read.csv("/Users/akshaymalik/Documents/Github Code/Data Wrangling/Seleniumtest/rittenhouse-condos.csv", sep=","))

scrapeCondoData <- function(addr,unit) {
  
  remDr$navigate("http://www.property.phila.gov/")
  
  #Select stuff
  addressField <- remDr$findElement("css selector", '#search-address')
  unitField <- remDr$findElement("css selector", '#search-unit')
  
  #addr <- "130 S 18th St"
  #unit <- "1001"
  
  #Type in the search text - "Something" and press enter
  addressField$sendKeysToElements(list(addr,'')) 
  unitField$sendKeysToElements(list(unit,'')) 
  unitField$sendKeysToElements(list(key = 'enter'))
  
  areaselector <- remDr$findElement("css selector", 'maincontent > div:nth-child(3) > div.property-side.large-10.columns > div.panel.mbm > div:nth-child(6) > div.medium-14.columns > strong')
  valueselector <- remDr$findElement("css selector", 'table > tbody > tr:nth-child(1) > td:nth-child(2)')
  
  area <-areaselector$getElementText()[[1]]
  value <- valueselector$getElementText()[[1]]
  
  #REPLACE WITH YOUR SCRAPING CODE
  scrapedData <- paste("Scraped data for ",addr,", unit ", unit, sep="")
  
  return (scrapedData)
  
}

results <- mapply(scrapeCondoData, condos[,1],condos[,2] )