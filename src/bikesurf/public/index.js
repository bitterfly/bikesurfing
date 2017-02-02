$(document).ready(function() {

    Sammy(function() {

        var bikesurfViewModel = new App.BikesurfViewModel();
        var componentManager = new App.ComponentManager(bikesurfViewModel);
        bikesurfViewModel.selectedComponent = componentManager.selectedComponent;

        ko.applyBindings(bikesurfViewModel);


        this.get('/#/bike/:id', function() {
            componentManager.selectComponent('bike_page', {id: this.params['id']})
        });

        this.get('', function() {
            this.redirect('/#/bike/4');
        });
    }).run();
});