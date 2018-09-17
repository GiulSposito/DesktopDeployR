library(RCurl)
library(httr)
library(jsonlite)

.MAXRESULTS <- 1000000

# user direct authentication
getUserAuth <- function(user, pswd){
  require(RCurl)
  
  # enconde user and password
  base64Encode(paste0(user,":",pswd))
}

# search issue api
searchIssues <- function(base.url, jql, fields=NULL, userAuth=getUserAuth(),
                         transitions=FALSE, changelog=FALSE){
  
  # parametros de query por pagina
  maxResults <- 1000
  startAt    <- 0
  total      <- 100000
  jsonPages  <- list()
  
  # tratamento multipage
  while( startAt < total  ){
  
    # escape da query
    url <- paste0(base.url, "/rest/api/2/search?jql=", curlEscape(jql),
                  ifelse(!is.null(fields), paste0("&fields=", paste(fields,collapse=",")), ""),
                  "&maxResults=",maxResults,
                  "&startAt=",startAt)
    
    # deve colocar transitions ou changelog ?
    if( transitions | changelog )
      url <- paste0(url, "&expand=", 
                    ifelse(transitions, "transitions,",""),
                    ifelse(changelog, "changelog",""))
    
    # request
    resp <- httr::GET(url=url, 
                      httr::add_headers( Authorization = paste0("Basic ",userAuth[1]) ),
                      httr::config( ssl_verifypeer = 0L, timeout = 240 ),
                      httr::timeout(240))
    
    # retorna erro caso tenha ocorrido
    if (resp$status_code!=200) {
      print(paste0("api https error: ",resp$status_code," GET: ",url))
      stop(resp$status_code)
    }
    
    # get reply
    txt  <- httr::content(resp, as = "text") # body
    json <- fromJSON(txt, flatten = T) # convert json
    
    # review page position
    jsonPages[[paste0("page.",startAt)]] <- json
    total <- as.integer( json$total )
    startAt <- startAt + as.integer( json$maxResults )
  }
  
  # retorna paginas
  return(jsonPages)
}

# basic naming cleaning up
cleanUpJson <- function(json, fieldTranslations=.customfields){
  dfm <- json$issues %>% as.tibble()
  names(dfm) <- gsub("fields\\.","",names(dfm))
  names(dfm)[names(dfm) %in% fieldTranslations] <- names(fieldTranslations)
  return(dfm)
  
}

