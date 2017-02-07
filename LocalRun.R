library('RSelenium')
library('rvest')

remDr <- remoteDriver(remoteServerAddr = "localhost" 
                      , browserName = "firefox"
)
#Launch the browser
remDr$open()

remDr$navigate("http://property.phila.gov/")
remDr$getCurrentUrl()

#Import the addresses
condos <- as.matrix(read.csv("/Users/akshaymalik/Documents/Github Code/Data Wrangling/Seleniumtest/rt03.csv", sep=","))
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
  
  remDr$setImplicitWaitTimeout(2000)
  
  areaselector <- remDr$findElement("css selector", 'div.panel:nth-child(2) > div:nth-child(6) > div:nth-child(2) > strong:nth-child(2)')
  valueselector <- remDr$findElement("css selector", 'table > tbody:nth-child(2) > tr:nth-child(1) > td:nth-child(2) > span:nth-child(2)')
  #error <- "Error : \t Summary: NoSuchElement\n \t Detail: An element could not be located on the page using the given search parameters.\n \t class: org.openqa.selenium.NoSuchElementException\n"
  
  value <- valueselector$getElementText()[[1]]
  area <-areaselector$getElementText()[[1]]
  
  value <- valueselector$getElementText()[[1]]
  area <-areaselector$getElementText()[[1]]
  
  remDr$setImplicitWaitTimeout(1000)
  collection = c(area, value, x, y)
  return(collection)
}

results03 <- mapply(scrapeCondoData, condos[,1],condos[,2] )
results02
tresults01 <- t(results01)
tresults02
tresults
tresults01
row.names(tresults) <- NULL
colnames(tresults) <- heading
scrapedDF <- rbind(scrapedDF, as.data.frame(tresults),as.data.frame(tresults01),as.data.frame(tresults02))
heading <- c("Area", "Value", "Address", "Unit" )
names(scrapedDF) <- heading
(scrapedDF)
price <- gsub('\\$', '',scrapedDF[,2])
(price)
