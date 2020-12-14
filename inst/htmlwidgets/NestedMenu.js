HTMLWidgets.widget({
  name: "NestedMenu",

  type: "output",

  factory: function (el, width, height) {
    // TODO: define shared variables for this instance

    return {
      renderValue: function (x) {
        // TODO: code to render the widget, e.g.
        //el.innerText = x.message;

        $button = $(".NestedMenu button");
        $button.text(x.label);

        $.contextMenu({
          selector: ".NestedMenu button",
          callback: function (key, options) {
            if(HTMLWidgets.shinyMode){
              Shiny.setInputValue(el.id, key, {priority: "event"});
            }
          },
          items: {
            edit: { name: "Edit", icon: "edit" },
            cut: { name: "Cut", icon: "cut" },
            copy: { name: "Copy", icon: "copy" },
            paste: { name: "Paste", icon: "paste" },
            delete: { name: "Delete", icon: "delete" },
            sep1: "---------",
            quit: {
              name: "Quit",
              icon: function () {
                return "context-menu-icon context-menu-icon-quit";
              }
            }
          }
        });
      },

      resize: function (width, height) {
        // TODO: code to re-render the widget with a new size
      }
    };
  }
});
