#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # set the plot data
    baseRegionData <- subset(map_data("state"),region == input$region)
    baseCountyData <- subset(map_data("county"),region == input$region)
    
    # draw the histogram with the specified number of bins
    base_map <- ggplot(data =  baseRegionData, mapping = aes(x = long, y = lat, group = group)) + 
      coord_fixed(1.3) + 
      geom_polygon(color = "black", fill = "gray")
    
    base_map + 
      geom_polygon(data = baseCountyData, fill = NA, color = "white") +
      geom_polygon(color = "black", fill = NA)  # get the state border back on top
    
  })
  
})
