library(NestedMenu)
library(shiny)

cities <- list(
  europe = list(
    name = "Europe",
    items = list(
      france = list(
        name = "France",
        items = list(
          paris = list(name = "Paris"),
          lyon = list(name = "Lyon")
        )
      ),
      italy = list(
        name = "Italy",
        items = list(
          roma = list(name = "Roma"),
          milano = list(name = "Milano")
        )
      )
    )
  ),
  america = list(
    name = "America",
    items = list(
      namerica = list(
        name = "North America",
        items = list(
          usa = list(
            name = "USA",
            items = list(
              chicago = list(name = "Chicago"),
              newyork = list(name = "New York")
            )
          ),
          canada = list(
            name = "Canada",
            items = list(
              ottawa = list(name = "Ottawa"),
              toronto = list(name = "Toronto")
            )
          )
        )
      ),
      samerica = list(
        name = "South America",
        items = list(
          brazil = list(
            name = "Brazil",
            items = list(
              brasilia = list(name = "Brasilia"),
              saopolo = list(name = "Sâo Polo")
            )
          ),
          mexico = list(
            name = "Mexico",
            items = list(
              mexicocity = list(name = "Mexico City"),
              tijuana = list(name = "Tijuana")
            )
          )
        )
      )
    )
  )
)

ui <- fluidPage(
  br(),
  NestedMenuOutput("menu", height = "auto"),
  br(),
  verbatimTextOutput("clicked")
)

server <- function(input, output, session){

  output[["menu"]] <- renderNestedMenu({
    NestedMenu(
      "Cities", items = cities
    )
  })

  output[["clicked"]] <- renderPrint({
    input[["menu"]]
  })

}

shinyApp(ui, server)
