#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("United States County Maps"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("region", "Choose a region:",
                  unique(map_data("state")$region)
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <-function(input, output) {
  
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
  
}

# Run the application 
shinyApp(ui = ui, server = server)

