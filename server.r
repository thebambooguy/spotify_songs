library(shiny)
require(data.table)
require(ggplot2)
require(dplyr)
require(readr)
require(tidyverse)
require(knitr)
rm(list = ls())

data <- read_csv("1000Tracks.csv")

data <- transform(data, duration_min = (duration_ms/1000)/60)
data <- subset(data, select = -c(X1,id, duration_ms))

shinyServer(
  function(input,output){
    
    
    # Compute the forumla text in a reactive expression since it is 
    # shared by the output$caption and output$mpgPlot expressions
    formulaText <- reactive({
      paste("valence ~", input$variable)
    })
    
    # Return the formula text for printing as a caption
    output$caption <- renderText({
      formulaText()
    })
    
    output$myPlot <- renderPlot({
      if(input$variable == "genre") {
        boxplot(as.formula(formulaText()), 
                data = data,
                col="aquamarine",
                main=("Positivity vs music genre"),
                xlab = "Genre")
      } else if(input$variable == "artist") {
    
      
        n <- input$numberArtists
        choosen_genre <- input$genreType
        specific_genre_songs <- filter(data, genre == choosen_genre)
        specific_genre_songs %>% .[order(.$valence,decreasing = TRUE),] -> ordered_specific_genre_songs
        ordered_specific_genre_songs %>% distinct(artist, .keep_all = TRUE) %>% .[1:n,] -> best_n  
        
        ggplot(best_n, aes(x=reorder(artist,valence),y=valence)) + geom_bar(stat="identity", width=.3,  fill="green3")+xlab("Artist") + ylab("Positivity") + ggtitle("Most positive artists")+ theme(plot.title = element_text(size = 30, face = "bold"))
        
        
      } else if(input$variable == "album") {
        
        n <- input$numberAlbums
        choosen_genre <- input$genreAlbum
        specific_genre_songs <- filter(data, genre == choosen_genre)
        specific_genre_songs %>% .[order(.$valence,decreasing = TRUE),] -> ordered_specific_genre_songs
        ordered_specific_genre_songs %>% distinct(artist, .keep_all = TRUE) %>% .[1:n,] -> best_n  
        
        ggplot(best_n, aes(x=reorder(album,valence),y=valence)) + geom_bar(stat="identity", width=.3,  fill="green3")+xlab("Album") + ylab("Positivity") + ggtitle("Most positive albums")+ theme(plot.title = element_text(size = 30, face = "bold"))
      } 
      
      
    })
    
    output$factorsPlot <- renderPlot({
      
      ggplot(data, aes(x=get(input$factor),y=valence, color=genre)) + geom_point()+xlab(input$factor) + ylab("Positivity") + ggtitle(input$factor, "vs Positivity")
      
          })
  
  
})