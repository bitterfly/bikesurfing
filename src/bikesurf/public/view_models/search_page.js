(function() {
    "use strict";

    App.SearchPageViewModel = function(params) {
        var self = this;
        self.me = App.me;
        // ==========================================================

        // form

        self.dateFrom = ko.observable(params.from);
        self.dateTo = ko.observable(params.to);
        self.bikeSize = ko.observable(params.size);
        self.gears = ko.observable(params.gears);
        self.frontLights = ko.observable(params.front_lights);
        self.backLights = ko.observable(params.back_lights);
        self.backpedalBrake = ko.observable(params.backpedal_brake);
        self.quickReleaseSaddle = ko.observable(params.quick_release_saddle);

        // ==========================================================

        // gallery

        self.bikes = ko.observableArray([]);

        self.borrowUrl = function(id) {
           return '#/borrow?bike=' + id + '&from=' + self.dateFrom() + '&to=' + self.dateTo();
        };

        self.parseLights = function(light) {
            switch(light) {
                case 'yd':
                    return 'dynamo';
                case 'yb':
                    return 'battery';
                default:
                    return 'no';
            }
        };

        // ==========================================================

        // submit

        self.datepickerActive = ko.observable(false);

        self.option = [
            {val: "null", text: "any"},
            {val: "true", text: "yes"},
            {val: "false", text: "no"}
        ];

        function convert(val) {
            switch(val) {
                case 'true':
                    return true;
                case 'false':
                    return false;
                default:
                    return null;
            };
        };

        function getNumber(val) {
            if (!val || val === 'undefined')
                return null;
            return val;
        };

        self.submitReady = ko.computed(function() {
            return App.isDate(self.dateFrom()) && App.isDate(self.dateTo()) && !self.datepickerActive();
        }, this);

        // ==========================================================


        self.submit = function() {
            App.stopReload(true);
            window.location.hash = '/search?from=' + self.dateFrom() +'&to=' + self.dateTo() + '&size=' + self.bikeSize() +
                '&gears=' + self.gears() + '&front_lights=' + self.frontLights() + '&back_lights=' + self.backLights() +
                '&backpedal_brake=' + self.backpedalBrake() + '&quick_release_saddle=' + self.quickReleaseSaddle();

            var bike_request = {
                from: App.date_to_timestamp(self.dateFrom()),
                to: App.date_to_timestamp(self.dateTo()),
                size: (self.bikeSize() === 'all') ? null : self.bikeSize(),
                min_gears: getNumber(self.gears()),
                front_lights: convert(self.frontLights()),
                back_lights: convert(self.backLights()),
                backpedal_breaking_system: convert(self.backpedalBrake()),
                quick_release_saddle: convert(self.quickReleaseSaddle()),
            };

            App.request('bikes/search', bike_request , function(data) {
                self.bikes(data);
            });
        };

        App.initDatePickers(self, "#dates", "#dateFrom", "#dateTo");
    };

})();
