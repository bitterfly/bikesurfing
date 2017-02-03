(function() {
    "use strict";

    var components = {
        bike_page: {viewModel: 'BikePageViewModel', loaded: false},
        main_page: {viewModel: 'MainPageViewModel', loaded: false}
    }

    App.ComponentManager = function() {
        this.selectedComponent = ko.observable();
    }

    App.ComponentManager.prototype.selectComponent = function(component, params) {
        var self = this;
        var comp = components[component];
        if (comp['loaded']) {
            self.selectedComponent({name: component, params: params});
        }
        else {
            var url = '../templates/' + component + '.html';
            $.get(url, function(template) {
                $('body').append("<script type='text/template' id='" + component + "'>" + template + "</script>");
                ko.components.register(component, {
                    template: {element: component},
                    viewModel: App[comp['viewModel']]
                });
                comp['loaded'] = true;
                self.selectedComponent({name: component, params: params});
            });
        }
    }
})();