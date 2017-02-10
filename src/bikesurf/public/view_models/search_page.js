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

        function isTrue(val) {
            return (val === true) ? true : null;
        }

        self.submitReady = ko.computed(function() {
            return App.isDate(self.dateFrom()) && App.isDate(self.dateTo()) && !self.datepickerActive();
        }, this);

        self.submit = function() {
            window.location.hash = '/search?from=' + self.dateFrom() +'&to=' + self.dateTo() + '&size=' + self.bikeSize() +
                '&gears=' + self.gears() + '&front_lights=' + self.frontLights() + '&back_lights=' + self.backLights() +
                '&backpedal_brake=' + self.backpedalBrake() + '&quick_release_saddle=' + self.quickReleaseSaddle();
            var bike_request = {
                from: App.date_to_timestamp(self.dateFrom()),
                to: App.date_to_timestamp(self.dateTo()),
                size: (self.bikeSize() === 'all') ? null : self.bikeSize(),
                min_gears: (self.gears() === undefined) ? null : self.gears(),
                front_lights: isTrue(self.frontLights()),
                back_lights: isTrue(self.backLights()),
                backpedal_brake: isTrue(self.backpedalBrake()),
                quick_release_saddle: isTrue(self.quickReleaseSaddle()),
            };
            console.log(bike_request);

            App.request('bikes/search', bike_request , function(data) {
                $('#gallery').html(JSON.stringify(data));
            });
        };

        App.initDatePickers(self, "#dates", "#dateFrom", "#dateTo");
    };

})();