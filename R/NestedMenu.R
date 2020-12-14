#' <Add Title>
#'
#' <Add Description>
#'
#' @importFrom htmlwidgets createWidget
#'
#' @export
NestedMenu <- function(
  label, items, trigger = "left",
  width = NULL, height = NULL, elementId = NULL
) {

  # forward options using x
  x = list(
    label = label,
    trigger = match.arg(trigger, c("left", "right", "hover")),
    items = items
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'NestedMenu',
    x,
    width = width,
    height = height,
    package = 'NestedMenu',
    elementId = elementId
  )
}

#' Custom widget
#' @importFrom htmltools tags tagList
#' @noRd
widget_html.NestedMenu <- function(id, style, class, ...){
  tags$div(
    id = id, class = class, style = style,
    tags$span(class = "btn btn-primary")
  )
}

#' Shiny bindings for NestedMenu
#'
#' Output and render functions for using NestedMenu within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a NestedMenu
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name NestedMenu-shiny
#'
#' @importFrom htmlwidgets shinyWidgetOutput shinyRenderWidget
#'
#' @export
NestedMenuOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'NestedMenu', width, height, package = 'NestedMenu')
}

#' @rdname NestedMenu-shiny
#' @export
renderNestedMenu <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, NestedMenuOutput, env, quoted = TRUE)
}
