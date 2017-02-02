(function() {

    App.BikePageViewModel = function(params) {
        this.id = ko.observable(params['id']);
        this.bike = ko.observable({});
        ko.computed(function() {
            App.request('bike', { bike_id: this.id() }, this.bike);
        }, this);

        this.bike_pretty_json = ko.pureComputed(function() {
            return JSON.stringify(this.bike(), null, 2);
        }, this);
    }
})();