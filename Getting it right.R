library('RSelenium')
remDr <- remoteDriver(remoteServerAddr = "localhost" 
                      , port = 4445L
                      , browserName = "chrome"
)
remDr$open()
remDr$navigate("http://property.phila.gov/")
remDr$getCurrentUrl()

addressField <- remDr$findElement("css selector", "#search-address")
unitField <- remDr$findElement("css selector", '#search-unit')

addr <- "130 S 18th St"
unit <- "1002"

#Type in the search text - "Something" and press enter
addressField$sendKeysToElement(list(addr, '')) 
unitField$sendKeysToElement(list(unit,'')) 
unitField$sendKeysToElement(list(key = 'enter'))

remDr$setImplicitWaitTimeout(5000)