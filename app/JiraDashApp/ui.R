## ui.R ##
library(shiny)
library(shinydashboard)

dashboardPage(
  
  ### HEADER
  dashboardHeader(title="Itau Jira Dashboard"),
  
  ### SIDEBAR ###############
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dependencias", tabName = "dependency", icon = icon("sitemap")),
      menuItem("Widgets", tabName = "settings", icon = icon("cog"))
    )
  ),
  
  
  ### BODY ###############
  
  dashboardBody(
    tabItems(
      
      # First tab content
      tabItem(tabName = "dependency",
        fluidRow(box(plotOutput("plot1"), width = 11)),
        fluidRow(box(
          title = "Filtros",
          sliderInput("slider","Numero de observacoes",1,100,50)
        ))
      ),
      
      # Second tab content
      tabItem(tabName = "settings",
              h2("Widgets tab content")
      )
      
      
    )
  )
)

