library(streamR)
library(ROAuth)

access_token <- "3279854082-UYtOWuYVCGvhsUqUOPnI1NuNgBGouK8pBTZcgDy"
access_secret <-"vJE64P2gWguCnef9GxMStqxFc4DQAnh7uauxXV0WPh9Kg"
consumer_key <- "hp0xT6I7xJ599glgqdcM3gHsW"
consumer_secret <- "g8AE1LhanWJC3R1nmfqKneSrMsucbAaWbjDqsP5fjySDsoQyPn"

oathfunction <- function(consumerKey, consumerSecret, accessToken, accessTokenSecret){
  my_oauth <- ROAuth::OAuthFactory$new(consumerKey=consumerKey,
                                       consumerSecret=consumerSecret,
                                       oauthKey=accessToken,
                                       oauthSecret=accessTokenSecret,
                                       needsVerifier=FALSE, handshakeComplete=TRUE,
                                       verifier="1",
                                       requestURL="https://api.twitter.com/oauth/request_token",
                                       authURL="https://api.twitter.com/oauth/authorize",
                                       accessURL="https://api.twitter.com/oauth/access_token",
                                       signMethod="HMAC")
  return(my_oauth)
}

my_oauth <- oathfunction(consumer_key, consumer_secret, access_token, access_secret)

file = "twittertest6.json"       #The data will be saved to this file as long as the stream is running
track = c("#maga")                 #"Search" by keyword(s)
follow = NULL                           #"Search" by Twitter user(s)
loc = NULL #c(-179, -70, 179, 70)             #Geographical bounding box -- (min longitute,min latitude,max longitute,max latitude)
lang = NULL                             #Filter by language
timeout = NULL #1000                          #Maximum time (in miliseconds)
tweets = 100 #1000                      #Maximum tweets (not exact)

filterStream(file.name = file, 
             track = track,
             follow = follow, 
             locations = loc, 
             language = lang,
             #timeout = timeout, 
             tweets = tweets, 
             oauth = my_oauth,
             verbose = TRUE)




tweetsdf <- parseTweets(file, verbose = FALSE)
tweetsdf$text <- iconv(tweetsdf$text, from = "UTF-8", to = "ASCII", sub="")


View(tweetsdf)
nrow(tweetsdf)