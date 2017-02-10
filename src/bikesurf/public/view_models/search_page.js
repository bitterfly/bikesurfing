(function() {
    "use strict";

    App.SearchPageViewModel = function(params) {
        var self = this;

        self.dateFrom = ko.observable(params.from);
        self.dateTo = ko.observable(params.to);
        self.bikeSize = ko.observable(params.size);
        self.gears = ko.observable(params.gears);
        self.frontLights = ko.observable(toBool(params.front_lights));
        self.backLights = ko.observable(toBool(params.back_lights));
        self.backpedalBrake = ko.observable(toBool(params.backpedal_brake));
        self.quickReleaseSaddle = ko.observable(toBool(params.quick_release_saddle));

        self.datepickerActive = ko.observable(false);

        function toBool(val) {
            return (val === 'true');
        }

        self.submitReady = ko.computed(function() {
            return App.isDate(self.dateFrom()) && App.isDate(self.dateTo()) && !self.datepickerActive();
        }, this);

        self.submit = function() {
            window.location.hash = '/search?from=' + self.dateFrom() +'&to=' + self.dateTo() + '&size=' + self.bikeSize() +
                '&gears=' + self.gears() + '&front_lights=' + self.frontLights() + '&back_lights=' + self.backLights() +
                '&backpedal_brake=' + self.backpedalBrake() + '&quick_release_saddle=' + self.quickReleaseSaddle();
            App.request('search_bikes', {
                from: 1486598400,
                to: 1486684800,
                size: 'small',
            }, function(data) {
                $('#gallery').html(JSON.stringify(data));
            });
        };

        App.initDatePickers(self, "#dates", "#dateFrom", "#dateTo");
    };

})();