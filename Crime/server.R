#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

#----------------------------------Server.R-----------------------------
function(input, output, session) {
  
  #--------------------Agg plot1---------- 
  output$plot1 <- renderPlotly({
    
    # Filter data antara 2020-01-01 dan 2022-06-01
    outcome_count <- base4 %>%
      filter(Crime.type == input$plot1_selector) %>%  # Filter berdasarkan input Crime.type
      group_by(Last.outcome.category) %>% 
      summarise(count = n()) %>% 
      ungroup() %>% 
      arrange(-count)
    
    # Tambahkan label
    outcome_count <- outcome_count %>% 
      mutate(labeling = glue("Category: {Last.outcome.category}<br>Count: {count}"))
    
    plot1 <- ggplot(outcome_count, aes(x = count, y = reorder(Last.outcome.category, count), fill = count, text = labeling)) +
      geom_bar(stat = "identity", position = "dodge") +
      scale_fill_gradient2(low = "#5E3C99", mid = "#807DBA", high = "#DD3497") +
      labs(title = paste("Crime Outcomes for", input$plot1_selector),#6A00C9 #00736E
           x = NULL,
           y = NULL) +
      theme_minimal() +
      theme(legend.position = "none")
    
    ggplotly(plot1, tooltip = "text")
  })
  
  #--------------------Agg plot2----------
  output$plot2 <- renderPlotly({
    
    crime_count <- base4 %>% 
      group_by(Crime.type) %>% 
      summarise(count = n()) %>% 
      ungroup() %>% 
      arrange(desc(count)) %>% 
      head(10)
    
    crime_count <- crime_count %>% 
      mutate(labeling = glue("Category: {Crime.type}<br>Count: {count}"))
    
    plot2 <- ggplot(crime_count, aes(x = count, y = reorder(Crime.type, count), fill = count, text = labeling)) +
      geom_col() +
      scale_fill_gradient2(low = "#5E3C99", mid = "#807DBA", high = "#DD3497") +
      labs(title = "Top 10 Crime Types in UK",
           x = NULL,
           y = NULL) +
      theme_classic() +
      theme(legend.position = "none")
    
    ggplotly(plot2, tooltip = "text")
  })
  
  #--------------------Agg plot3----------
  output$plot3 <- renderPlotly({
    
    crime_pivot <- base4 %>% 
      pivot_longer(cols = c(Crime.type, Last.outcome.category),
                   names_to = "variable",
                   values_to = "values")
    
    crime_count1 <- crime_pivot %>% 
      count(Month, variable, values)
    
    crime_count1 <- crime_count1 %>% 
      mutate(labeling1 = glue ("Category : {values}
                          Count : {n}"))
    crime_count1
    plot3 <- ggplot(crime_count1, aes(x = Month, y = n, fill = values, group = values, text = labeling1)) +
      geom_area(alpha = 0.4, position = 'identity') +
      scale_fill_viridis(discrete = TRUE, guide = FALSE, option = "C")+
      facet_wrap(~ variable) +
      labs(title = "Crime and Outcome Comparasion",
           x = NULL,
           y = NULL) +
      theme_light() +
      theme(legend.position = "none")
    ggplotly(plot3, tooltip = "text")
  })
  
  #--------------------Agg plot4----------
  output$plot4 <- renderPlotly({
    
    loc_count <- base4 %>%
      group_by(Location, Month) %>% 
      summarise(count = n()) %>% 
      ungroup() %>% 
      arrange(-count) %>% 
      head(10)
    
    loc_count <- loc_count %>% 
      mutate(labeling = glue("Location: {Location}<br>Count: {count}"))
    
    plot4 <- ggplot(loc_count, aes(x = Month, y = count, size = count, fill = Location, text = labeling)) +
      geom_point(alpha = 0.5, shape = 21, color = "black") +
      scale_size(range = c(1, 10), name = "Count") +
      scale_fill_viridis(discrete = TRUE, guide = FALSE, option = "C") +
      theme_light() +
      theme(legend.position = "none") +
      ylab("Count") +
      xlab(NULL) +
      labs(title = "Crime Location")
    
    ggplotly(plot4, tooltip = "text")
  })
  
  #--------------------Data Table ----------
  output$base4 <- renderDataTable(
    base4,
    options = list(scrollX = TRUE,
                   scrollY = TRUE)
  )
  
}

