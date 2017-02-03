$(document).ready(function() {

    Sammy(function() {

        var bikesurfViewModel = new App.BikesurfViewModel();
        var componentManager = new App.ComponentManager();
        bikesurfViewModel.selectedComponent = componentManager.selectedComponent;

        ko.applyBindings(bikesurfViewModel);


        this.get('#/bike/:id', function() {
            componentManager.selectComponent('bike_page', {id: this.params['id']});
        });

        this.get('#/', function() {
            componentManager.selectComponent('main_page');
        });

        this.get('', function() {
            this.redirect('#/');
        });

    }).run('#/');
});