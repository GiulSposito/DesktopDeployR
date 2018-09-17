## ui.R ##
library(shiny)
library(shinydashboard)

dashboardPage(
  
  ### HEADER
  dashboardHeader(title="Itau Jira Dashboard"),
  
  ### SIDEBAR ###############
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Widgets", tabName = "widgets", icon = icon("th"))
    )
  ),
  
  
  ### BODY ###############
  
  dashboardBody(
    tabItems(
      
      # First tab content
      tabItem(tabName = "dashboard",
        fluidRow(box(plotOutput("plot1"), width = 11)),
        fluidRow(box(
          title = "Filtros",
          sliderInput("slider","Numero de observacoes",1,100,50)
        ))
      ),
      
      # Second tab content
      tabItem(tabName = "widgets",
              h2("Widgets tab content")
      )
      
      
    )
  )
)

