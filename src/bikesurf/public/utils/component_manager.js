(function() {
    "use strict";

    var components = {
        bike_page: {viewModel: 'BikePageViewModel', loaded: false},
        intro_page: {viewModel: 'IntroPageViewModel', loaded: false},
        login_page: {viewModel: 'LoginPageViewModel', loaded: false},
        search_page: {viewModel: 'SearchPageViewModel', loaded: false},
        borrow_bike: {viewModel: 'BorrowBikeViewModel', loaded: false},
        add_bike: {viewModel: 'AddBikeViewModel', loaded: false},
        reservation_page: {viewModel: 'ReservationPageViewModel', loaded: false}
    }

    App.ComponentManager = function() {
        this.selectedComponent = ko.observable();
    }

    App.ComponentManager.prototype.selectComponent = function(component, params) {
        var self = this;
        var comp = components[component];
        if (self.selectedComponent() && self.selectedComponent().name === component) {
            return;
        }
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
