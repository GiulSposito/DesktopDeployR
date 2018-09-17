library(shiny)

server <- function(input, output) {
  set.seed(42) # the life, the universe and everything else
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data, col="red")
  })
  
  # action do botao
  observeEvent(input$login,{
    print(paste0("login: ", input$login))
    if(input$login==1){
      output$login.status = "Nenhum Usuario Logado"
      output$project.status = "Nenhum Projeto Importado"
    } else {
      
    }
  })
}
