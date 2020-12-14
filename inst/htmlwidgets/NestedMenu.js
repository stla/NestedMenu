HTMLWidgets.widget({
  name: "NestedMenu",

  type: "output",

  factory: function (el, width, height) {
    // TODO: define shared variables for this instance

    return {
      renderValue: function (x) {
        // TODO: code to render the widget, e.g.
        //el.innerText = x.message;

        $button = $(".NestedMenu span");
        $button.text(x.label);

        $.contextMenu({
          selector: ".NestedMenu span",
          trigger: x.trigger,
          callback: function (key, options) {
            if(HTMLWidgets.shinyMode){
              Shiny.setInputValue(el.id, key, {priority: "event"});
            }
          },
          items: x.items
        });
      },

      resize: function (width, height) {
        // TODO: code to re-render the widget with a new size
      }
    };
  }
});
