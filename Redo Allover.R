require(RSelenium)

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

remDr$open()

remDr$navigate("http://property.phila.gov/")
remDr$getCurrentUrl()


addressField <- remDr$findElement("css selector", "#search-address")
unitField <- remDr$findElement("css selector", '#search-unit')

addr <- "130 S 18th St"
unit <- "1004"

#Type in the search text - "Something" and press enter
addressField$sendKeysToElement(list(addr, '')) 
unitField$sendKeysToElement(list(unit,'')) 
unitField$sendKeysToElement(list(key = 'enter'))

remDr$setImplicitWaitTimeout(20000)


areaselector <- remDr$findElement("css selector", '#maincontent > div:nth-child(3) > div.property-side.large-10.columns > div.panel.mbm > div:nth-child(6) > div.medium-14.columns > strong')
valueselector <- remDr$findElement("css selector", 'table > tbody > tr:nth-child(1) > td:nth-child(2)')


area <-areaselector$getElementText()[[1]]
value <- valueselector$getElementText()[[1]]


scrapedDataFrame <- data.frame("Address"= character(), "Unit" = integer(), "Area" = integer(), "Value" = character(), stringsAsFactors=FALSE)  

collection = c(addr, unit, area, value)
heading <- c("Address", "Unit", "Area", "Value")

names(scrapedDataFrame) <- heading
names(collection) <- heading
collection
#Adding the new data in the next row
scrapedDataFrame <- rbind(scrapedDataFrame, collection  

scrapedDataFrame
