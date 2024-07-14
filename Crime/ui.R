#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

#--------------------------------ui.R--------------------------------
library(shiny)
library(shinydashboard)

dashboardPage(
  skin = "purple",
  #------------- Title-----------
  dashboardHeader(
    title = "Crime in UK"
  ),
  
  #-------------- Menu -------------
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "page1", icon = icon("handcuffs")),
      menuItem("Graph", tabName = "page2", icon = icon("chart-simple")),
      menuItem("Data", tabName = "page4", icon = icon("th"))
    )
  ),
  
  #------------- Isi ------------ 
  dashboardBody(
    tabItems(
      #-----------Dashboard ---------------
      tabItem(
        tabName = "page1",
        fluidRow(
          infoBox("Data",
                  value = nrow(base),
                  icon = icon("database"),
                  width = 4,
                  color = "purple"),
          infoBox("Crime",
                  value = length(unique(base4$Crime.type)),
                  icon = icon("handcuffs"),
                  width = 4,
                  color = "purple"),
          infoBox("Location",
                  value = length(unique(base4$Location)),
                  icon = icon("location-crosshairs"),
                  width = 4,
                  color = "purple")
        ),
        fluidRow(
          box(
            width = 12,
            selectInput(
              inputId = "plot1_selector",
              label = "Select Crime Type",
              choices = unique(base4$Crime.type),
              selected = "Violence and sexual offences"
            )
          )
        ),
        fluidRow(
          box(
            width = 12,
            plotlyOutput(outputId = "plot1")
          )
        )
      ),
      
      #-----------menu 1 ---------------
      tabItem(
        tabName = "page2",
        fluidRow(
          # Jika ingin menambahkan selectInput untuk plot2, letakkan di sini
          box(
            width = 12,
            plotlyOutput(outputId = "plot2")
          ),
          box(
            width = 12,
            plotlyOutput(outputId = "plot3")
          ),
          box(
            width = 12,
            plotlyOutput(outputId = "plot4")
          )
        )
      ),
      
      #-------------menu 2-----------
      tabItem(
        tabName = "page4",
        fluidRow(
          box(
            width = 12,
            title = "Dataset Crime Statistical",
            dataTableOutput(outputId = "base4")
          )
        )
      )
    )
  )
)

