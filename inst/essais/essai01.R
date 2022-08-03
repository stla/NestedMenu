detach(package:NestedMenu, unload=TRUE)

library(NestedMenu)
library(shiny)

cities <- list(
  europe = list(
    name = "Europe",
    items = list(
      france = list(
        name = "France",
        icon = "fa-cheese",
        items = list(
          paris = list(name = "Paris"),
          lyon = list(name = "Lyon")
        )
      ),
      italy = list(
        name = "Italy",
        icon = "fa-pizza-slice",
        items = list(
          roma = list(name = "Roma", icon = "glyphicon glyphicon-plus"),
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
		icon = "fa-flag-usa",
            items = list(
              chicago = list(name = "Chicago"),
              newyork = list(name = "New York")
            )
          ),
          canada = list(
            name = "Canada",
            icon = "fa-canadian-maple-leaf",
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
            icon = "fa-lemon",
            items = list(
              brasilia = list(name = "Brasilia"),
              saopolo = list(name = "Sao Polo")
            )
          ),
          mexico = list(
            name = "Mexico",
            icon = "fa-hat-cowboy",
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
      "Cities", items = cities, style = "danger", size = "lg"
    )
  })

  output[["clicked"]] <- renderPrint({
    input[["menu"]]
  })

}

shinyApp(ui, server)
