
## Web scraping using RSelenium
require("RSelenium")
rD <- rsDriver(port = 5533L, chromever = "85.0.4183.87")
remDr <- rD$client
url <- "https://www.flashscore.com/team/connecticut-huskies/8rqVf3Tj/results/#"
remDr$navigate(url)

repeat{
  x <- try(webElemMore <- 
             remDr$findElement(using = 'xpath', 
                               '//*[@id="live-table"]/div[1]/div/div/a'),
           silent=T)
  if (inherits(x, "try-error")) break
  webElemMore$clickElement()
}

webElemTime <- remDr$findElements(using = 'xpath', 
                              '//*[@class="event__time"]')
webElemTime <- 
  unlist(lapply(webElemTime, function(x){x$getElementText()}))
webElemTime <- gsub("\\n", " ", webElemTime)

webElemHome <- 
  remDr$findElements(using = 'class', 
                     'event__participant')
webElemHome <- 
  unlist(lapply(webElemHome, function(x){x$getElementText()}))

webElemScore <- 
  remDr$findElements(using = 'class', 'event__score')
webElemScore <- 
  unlist(lapply(webElemScore, function(x){x$getElementText()}))

webElemResult <- 
  remDr$findElements(using = 'class', 'wld')
webElemResult <- 
  unlist(lapply(webElemResult, function(x){x$getElementText()}))

n <- length(webElemHome)
basketball <- 
  data.frame(time = webElemTime,
             Home = webElemHome[seq(n) %% 2 == 1],
             Away = webElemHome[seq(n) %% 2 == 0],
             HomeS = webElemScore[seq(n) %% 2 == 1],
             AwayS = webElemScore[seq(n) %% 2 == 0],
             Result = webElemResult)

head(basketball)
remDr$close()



