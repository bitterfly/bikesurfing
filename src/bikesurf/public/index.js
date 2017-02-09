$(document).ready(function() {

    Sammy(function() {

        var bikesurfViewModel = new App.BikesurfViewModel();
        var componentManager = new App.ComponentManager();
        bikesurfViewModel.selectedComponent = componentManager.selectedComponent;

        ko.applyBindings(bikesurfViewModel);


        this.get('#/bike/:id', function() {
            componentManager.selectComponent('bike_page', {id: this.params['id']});
        });

        this.get('#/search', function(context) {
            console.log(context.params);
            componentManager.selectComponent('search_page', context.params);
        });

        this.get('#/login', function() {
            componentManager.selectComponent('login_page');
        });

        this.get('#/borrow', function() {
            componentManager.selectComponent('borrow_bike');
        });

        this.get('#/request', function() {
            componentManager.selectComponent('request_bike');
        });

        this.get('#/add-bike', function() {
            componentManager.selectComponent('add_bike');
        });

        this.get('#/', function() {
            componentManager.selectComponent('intro_page');
        });

        this.get('', function() {
            this.redirect('#/');
        });

        // Make Sammy leave the forms alone!
        this._checkFormSubmission = function(form) {
            return false;
        };
    }).run('#/');
});
