library(shiny)
library(DT)
source("./issue_links.R")



server <- function(input, output, session) {
  set.seed(42) # the life, the universe and everything else
  histdata <- rnorm(500)
  print("server")
  
  num.imported <- 0
  project.status <- "Nenhum projeto importado"
  
  loadIssues <- reactive(
    getIssueLinks(input$jira.url, input$project.key,  
                  input$username, input$password)
  )
  
  # action do botao
  observeEvent(input$login,{
    print(paste0("login: ", input$login))

    issues <- loadIssues()
    
    if(length(issues)>0){
      num.imported <- issues$page.0$total
      project.status <- paste0("Projeto '",input$project.key,"' importado!")
      output$plot1 <- renderPlot(plotDependency(issues))
      output$dtdep <- DT::renderDataTable(tableDependency(issues))
    } 
    
    output$login.status   <- renderText(paste0("issues importadas: ", num.imported))
    output$project.status <- renderText(project.status)
  })

  output$login.status   <- renderText(paste0("issues importadas: ", num.imported))
  output$project.status <- renderText(project.status)

}
