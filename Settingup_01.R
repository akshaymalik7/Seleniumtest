require(RSelenium)
user <- "markas" # Your Sauce Labs username
pass <- "5f8761a6-9991-46dd-8064-d548846ff890" # Your Sauce Labs access key 
port <- 80
ip <- paste0(user, ':', pass, "@ondemand.saucelabs.com")
rdBrowser <- "chrome"
version <- ""
platform <- "OS X 10.12"
extraCapabilities <- list(name = "RSelenium OS/Browsers vignette first example", username = user
                          , accessKey = pass, tags = list("RSelenium-vignette", "OS/Browsers-vignette"))
remDr <- remoteDriver$new(remoteServerAddr = ip, port = port, browserName = rdBrowser
                          , version = version, platform = platform
                          , extraCapabilities = extraCapabilities)
remDr$open()

remDr$navigate("http://www.property.phila.gov/")

remDr$getCurrentUrl()

#Select stuff
addressField <- remDr$findElement("css selector", "#search-address")
unitField <- remDr$findElement("css selector","#search-unit" )

Addr <- "130 S 18th St"
unit <- "1001"

#Type in the search text - "Something" and press enter
addressField$sendKeysToElements(list(Addr,'')) 
unitField$sendKeysToElements(list(unit,'')) 
unitField$sendKeysToElements(list(key = 'enter'))

areaselector <- remDr$findElement("css selector", 'maincontent > div:nth-child(3) > div.property-side.large-10.columns > div.panel.mbm > div:nth-child(6) > div.medium-14.columns > strong')
valueselector <- remDr$findElement("css selector", 'table > tbody > tr:nth-child(1) > td:nth-child(2)')

area <-areaselector$getElementText()[[1]]
value <- valueselector$getElementText()[[1]]


