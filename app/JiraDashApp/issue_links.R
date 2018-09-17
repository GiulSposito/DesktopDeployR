library(tidyverse)
library(lubridate)
library(igraph)    # manipulacao de grafos
library(tidygraph) # visualizacoes de redes
library(ggraph)    # visualizacoes de redes
source("./browseIssues.R")
source("./jira_fields.R")

# extra a lista de dependencias (inward)
extractDependency <- function(page) {
  page$issues %>% 
    select( key, fields.issuelinks) %>% 
    mutate( issuelinks.size = map(fields.issuelinks, length)) %>% 
    filter( issuelinks.size > 0 ) %>% 
    mutate( links = map(fields.issuelinks, as.tibble) ) %>% 
    unnest( links ) %>%
    filter( type.name %in% c("Blocks","Relate","Require","Issue split")) %>% 
    select( 1:9, dplyr::starts_with("inward") ) %>% 
    filter( !is.na(inwardIssue.key) ) %>% 
    as.tibble() %>% 
    return()
}

# extrai issue e issue types
extractIssueTypes <- function(page){
  page$issues %>% 
    select(key, fields.issuetype.name) %>% 
    as.tibble() %>% 
    return()
}

getIssueLinks <- function(url, key, user, pswd) {

  # stories terminadas 
  jql <- paste0("project=",key," and resolution = Unresolved and issuetype in standardIssueTypes()")
  us.json <- searchIssues(url, jql, c(.jirafields$risk,"issuelinks"),
                          userAuth = getUserAuth(user,pswd))
}

# # percorre as issues extraindo e concatenando as dependencias
# links <- lapply(us.json, extractDependency) %>% 
#   bind_rows() %>% 
#   distinct()
# 
# issue.types <- lapply(us.json, extractIssueTypes) %>% 
#   bind_rows() %>% 
#   distinct()
# 
# # cria "from","to"
# links %>% 
#   select( 
#     from = key,
#     to = inwardIssue.key
#   ) %>%
#   bind_cols(links) %>% # mantem "atributos" do link nos edges
#   as_tbl_graph() %>% 
#   activate(nodes) %>% 
#   left_join(issue.types, by=c("name"="key")) -> dependencies # convert para um grafo
# 
# # plot
# dependencies %>% 
#   ggraph(layout = "kk") + 
#   geom_edge_fan(aes(color=type.inward),
#                 edge_width=1,
#                 arrow = arrow(type = "closed", angle = 10, length = unit(5,units="mm"))) +
#   geom_node_point(aes(color=fields.issuetype.name),alpha=0.3, size=8) +
#   geom_node_text(aes(label=name)) +
#   theme_void()
# 
