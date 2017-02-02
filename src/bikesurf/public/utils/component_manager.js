(function() {
    "use strict";

    var components = {
        bike_page: {viewModel: 'BikePageViewModel', loaded: false}
    }

    App.ComponentManager = function(viewModel) {
        this.viewModel = viewModel;
        this.selectedComponent = {}
    }

    App.ComponentManager.prototype.selectComponent = function(component, params) {
        var comp = components[component];
        if (comp[loaded]) {
            this.selectedComponent = {name: component, params: params};
        }
        else {
            var url = '../templates/' + component;
            $.get(url, function(template) {
                $('body').append("<script id='" + component + "'>" + template + "</script>");
                ko.components.register(component, {
                    template: {element: component},
                    viewModel: comp[viewModel]
                });
                comp[loaded] = true;
            });
        }
    }

})();