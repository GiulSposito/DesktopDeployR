# especificação dos campos do Jira

.jirafields <- list(
  risk = c(
    "project",
    "summary",
    "created",
    "issuetype",
    "status",
    "customfield_10001", # epic link
    "issuelinks",
    "priority",
    "assignee",
    "reporter",
    "resolution",
    "resolutiondate",
    "timeoriginalestimate",
    "timespent",
    "aggregatetimeoriginalestimate",
    "aggregatetimespent",
    "fixVersions",
    "updated",
    "customfield_16605" # business values
  ) 
)

.customfields <- c(
    "epiclink"="customfield_10001",
    "businessvalue"="customfield_16605"
)

