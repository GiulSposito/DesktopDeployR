library(shiny)
source("./issue_links.R")

server <- function(input, output, session) {
  set.seed(42) # the life, the universe and everything else
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data, col="red")
  })
  
  # action do botao
  myjson <- eventReactive(input$login,{
    print(paste0("login: ", input$login))
    issues <- getIssueLinks(input$jira.url, input$project.key,  
                            input$username, input$password)
    # output$login.status = renderText( paste0("Issues Importated: ", length(issues) ) )
    # issues
  })

  json <- myjson()
}
