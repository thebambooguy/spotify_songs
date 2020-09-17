shinyUI(
  
  navbarPage("Spotify",
             tabPanel(
               "Find positivity",
               
  #pageWithSidebar(
    headerPanel("Most positive Spotify songs"),
  
    sidebarPanel(
      
      selectInput("variable", "Variable:",
                  list("Genre" = "genre", 
                       "Artist" = "artist", 
                       "Album" = "album")),
      
      conditionalPanel(condition = "input.variable == 'artist'",
                       sliderInput("numberArtists", "Please Select Number of Artists:",
                                   min=5, max=15, value=5, step=1),
                       selectInput("genreType", "Please Select genre:",
                                   list("Rap" = "Rap",
                                        "Pop" = "Pop",
                                        "Country" = "Country",
                                        "Metal" = "Metal",
                                        "Acoustic" = "Acoustic",
                                        "EDM" = "EDM"))),
      
      conditionalPanel(condition = "input.variable == 'album'",
                       sliderInput("numberAlbums", "Please Select Number of Albums:",
                                   min=5, max=15, value=5, step=1),
                      selectInput("genreAlbum", "Please Select genre:",
                                 list("Rap" = "Rap",
                                 "Pop" = "Pop",
                                 "Country" = "Country",
                                 "Metal" = "Metal",
                                 "Acoustic" = "Acoustic",
                                 "EDM" = "EDM"))),
      
      h3("Positivity (valence) description"),
      helpText("A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track.")
      
    ),    
  
    mainPanel(
      #h3(textOutput("caption")),
      
      
      plotOutput("myPlot")
    )
  ),
  tabPanel("Positivity factors",
           headerPanel("Impact of different parameters on the positivity of the song"),
           sidebarPanel(
             selectInput("factor", "Please select factor:",
                         list("Energy" = "energy", 
                              "Danceability" = "danceability",
                              "Loudness" = "loudness",
                              "Tempo" = "tempo",
                              "Duration (s)" = "duration_min",
                              "Liveness" = "liveness")),
             h3("Factor description"),
             helpText("Energy - is a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity.",
                      br(),
"Danceability"," - describes how suitable a track is for dancing based on a combination of musical elements including tempo.",
br(),

"Loudness - the overall loudness of a track in decibels (dB).",
br(),

"Tempo - The overall estimated tempo of a track in beats per minute (BPM).",
br(),

"Duration - the duration of the track in minutes.",
br(),

"Liveness - detects the presence of an audience in the recording.")
          
           ),
           
           mainPanel(
             plotOutput("factorsPlot")
             
           )
           
           )
)
)


