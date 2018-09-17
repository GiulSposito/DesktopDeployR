## ui.R ##
library(shiny)
library(shinydashboard)

dashboardPage(
  
  ### HEADER
  dashboardHeader(title="Jira Dashboard"),
  
  ### SIDEBAR ###############
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dependencias", tabName = "dependency", icon = icon("sitemap")),
      menuItem("Configuracoes", tabName = "settings", icon = icon("cogs"))
    )
  ),
  
  
  ### BODY ###############
  
  dashboardBody(
    tabItems(
      
      # First tab content
      tabItem(
        tabName = "dependency",
        fluidRow(box(plotOutput("plot1"), width = 11)),
        fluidRow(box(
          title = "Filtros",
          sliderInput("slider","Numero de observacoes",1,100,50)
        ))
      ),
      
      # Second tab content
      tabItem(
        tabName = "settings",
        fluidPage(
          title="Configuracoes",
          box(
            title="Autorizacao e Autenticacao no Jira",
            textInput("jira.url", "Jira URL", .settings$jira$baseUrl),
            textInput("project.key", "Project Key", "EFCA"),
            textInput("username", "Usuario", .settings$jira$user),
            passwordInput("password", "Senha", .settings$jira$pswd),
            actionButton("login", "Entrar")
          ),
          conditionalPanel(
            condition="session.userData.loggedIn==TRUE",
            box(
              title="Status",
              textOutput("login.status"),
              textOutput("project.status")
            )
          )
        )
      )
      
      
    )
  )
)

