HTMLWidgets.widget({
  name: "NestedMenu",

  type: "output",

  factory: function (el, width, height) {

    return {
      renderValue: function (x) {

        var selector = ".NestedMenu span.NM-" + el.id;
        var $button = $(selector);
        $button.addClass("btn-" + x.style);
        if(x.size !== null){
          $button.addClass("btn-" + x.size);
        }
        $button.text(x.label);

        $.contextMenu({
          selector: selector,
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
