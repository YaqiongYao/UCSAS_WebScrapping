
## Web scraping using RSelenium
require("RSelenium")
rD <- rsDriver(port = 5559L, chromever = "85.0.4183.87")
remDr <- rD$client
remDr$navigate("http://www.google.com")
url <- "http://www.flashscore.com/match/Cj6I5iL9/#match-statistics;0"
remDr$navigate(url)
webElem <- remDr$findElements(using = 'id', "detail")
unlist(lapply(webElem, function(x){x$getElementText()}))[[1]]
remDr$close()
