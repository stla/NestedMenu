#' @title 'Nested menu' widget
#'
#' @description 'Nested menu' HTML widget.
#' 
#' @param label the label of the root button
#' @param items list of items for the nested menu; see the
#'   \link[=NestedMenu-shiny]{Shiny example}
#' @param trigger the way the menu is triggered: \code{"left"} to trigger
#'   on a left-click, \code{"right"} to trigger on a right-click,
#'   \code{"hover"} to trigger on hover
#' @param elementId a HTML id; this is usually useless
#'
#' @importFrom htmlwidgets createWidget
#' @importFrom htmltools htmlDependency
#' @importFrom fontawesome fa_html_dependency
#' @importFrom shiny bootstrapLib
#' @importFrom jquerylib jquery_core
#'
#' @export
NestedMenu <- function(
  label, items, trigger = "left", elementId = NULL
) {

  # forward options using x
  x <- list(
    label = label,
    trigger = match.arg(trigger, c("left", "right", "hover")),
    items = items
  )

  # create widget
  createWidget(
    name = "NestedMenu",
    x,
    width = NULL,
    height = NULL,
    package = "NestedMenu",
    elementId = elementId,
    dependencies = list(
      jquery_core(major_version = 3, minified = TRUE),
      bootstrapLib(theme = NULL),
      fa_html_dependency()
    )
  )
}

#' Custom widget
#' @importFrom htmltools tags tagList
#' @noRd
widget_html.NestedMenu <- function(id, style, class, ...){
  tagList(
    tags$style("
      li.context-menu-icon.fa span {font-weight: normal}
    "),
    tags$div(
      id = id, class = class, style = style,
      tags$span(class = "btn btn-primary")
    )
  )
}

#' @title Shiny bindings for 'NestedMenu'
#'
#' @description Output and render functions for using 'NestedMenu' 
#'   within Shiny applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height dimensions; must be valid CSS measurements
#'   (like \code{"100\%"}, \code{"400px"}, \code{"auto"})
#' @param expr an expression that generates a nested menu
#'   (with \code{\link{NestedMenu}})
#' @param env the environment in which to evaluate \code{expr}.
#' @param quoted Boolean, whether \code{expr} is a quoted expression
#'
#' @return \code{NestedMenuOutput} returns an output element that can be
#'   included in a Shiny UI definition, and \code{renderNestedMenu} returns
#'   a \code{shiny.render.function} object that can be included in a Shiny
#'   server definition.
#'
#' @section Shiny value:
#'   If the \code{outputId} is called \code{"ID"} for example, then the
#'   value of the clicked leaf item is available in the Shiny server in
#'   the reactive variable \code{input[["ID"]]}.
#'
#' @name NestedMenu-shiny
#'
#' @importFrom htmlwidgets shinyWidgetOutput shinyRenderWidget
#'
#' @export
#'
#' @examples
#' library(NestedMenu)
#' library(shiny)
#'
#' cities <- list(
#'   europe = list(
#'     name = "Europe",
#'     items = list(
#'       france = list(
#'         name = "France",
#'         icon = "fa-cheese",
#'         items = list(
#'           paris = list(name = "Paris"),
#'           lyon = list(name = "Lyon")
#'         )
#'       ),
#'       italy = list(
#'         name = "Italy",
#'         icon = "fa-pizza-slice",
#'         items = list(
#'           roma = list(name = "Roma"),
#'           milano = list(name = "Milano")
#'         )
#'       )
#'     )
#'   ),
#'   america = list(
#'     name = "America",
#'     items = list(
#'       namerica = list(
#'         name = "North America",
#'         items = list(
#'           usa = list(
#'             name = "USA",
#' 		   icon = "fa-flag-usa",
#'             items = list(
#'               chicago = list(name = "Chicago"),
#'               newyork = list(name = "New York")
#'             )
#'           ),
#'           canada = list(
#'             name = "Canada",
#'             icon = "fa-canadian-maple-leaf",
#'             items = list(
#'               ottawa = list(name = "Ottawa"),
#'               toronto = list(name = "Toronto")
#'             )
#'           )
#'         )
#'       ),
#'       samerica = list(
#'         name = "South America",
#'         items = list(
#'           brazil = list(
#'             name = "Brazil",
#'             icon = "fa-lemon",
#'             items = list(
#'               brasilia = list(name = "Brasilia"),
#'               saopolo = list(name = "Sao Polo")
#'             )
#'           ),
#'           mexico = list(
#'             name = "Mexico",
#'             icon = "fa-hat-cowboy",
#'             items = list(
#'               mexicocity = list(name = "Mexico City"),
#'               tijuana = list(name = "Tijuana")
#'             )
#'           )
#'         )
#'       )
#'     )
#'   )
#' )
#'
#' ui <- fluidPage(
#'   br(),
#'   NestedMenuOutput("menu", height = "auto"),
#'   br(),
#'   verbatimTextOutput("clicked")
#' )
#'
#' server <- function(input, output, session){
#'
#'   output[["menu"]] <- renderNestedMenu({
#'     NestedMenu(
#'       "Cities", items = cities
#'     )
#'   })
#'
#'   output[["clicked"]] <- renderPrint({
#'     input[["menu"]]
#'   })
#'
#' }
#'
#' if(interactive()){
#'   shinyApp(ui, server)
#' }
NestedMenuOutput <- function(outputId, width = "100%", height = "auto"){
  shinyWidgetOutput(
    outputId, 'NestedMenu', width, height, package = "NestedMenu"
  )
}

#' @rdname NestedMenu-shiny
#' @export
renderNestedMenu <- function(expr, env = parent.frame(), quoted = FALSE){
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, NestedMenuOutput, env, quoted = TRUE)
}
