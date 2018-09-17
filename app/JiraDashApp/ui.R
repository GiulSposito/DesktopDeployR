## ui.R ##
library(shiny)
library(shinydashboard)
library(DT)

dashboardPage(
  
  ### HEADER
  dashboardHeader(title="Jira Dashboard"),
  
  ### SIDEBAR ###############
  dashboardSidebar(
    sidebarMenu(
      menuItem("Importacao", tabName = "settings", icon = icon("cogs")),
      menuItem("Mapa Dependencias", tabName = "dependency", icon = icon("sitemap")),
      menuItem("Tabela de Dependencias", tabName = "tabledep", icon = icon("table"))
    )
  ),
  
  
  ### BODY ###############
  
  dashboardBody(
    tabItems(
      
      # First tab content
      tabItem(
        tabName = "dependency",
        fluidPage(
          fluidRow(
            box(plotOutput("plot1",height = 600), width = 11, height = 640)
          )
        )
        
      ),
      
      # Second tab content
      tabItem(
        tabName = "settings",
        fluidPage(
          title="Configuracoes",
          box(
            title="Autorizacao e Autenticacao no Jira",
            textInput("jira.url", "Jira URL", .settings$jira$baseUrl),
            textInput("project.key", "Project Key", .settings$jira$key),
            textInput("username", "Usuario", .settings$jira$user),
            passwordInput("password", "Senha", .settings$jira$pswd),
            actionButton("login", "Entrar")
          ),
          box(
            title="Status",
            textOutput("login.status"),
            textOutput("project.status")
          )
        )
      ),
      
      tabItem(
        tabName = "tabledep",
        fillPage( title="Tabela de Dependencias",DT::dataTableOutput("dtdep", height = "90%"))
      )

    )
  )
)

