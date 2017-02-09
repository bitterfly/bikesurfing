(function() {
    "use strict";

    App.IntroPageViewModel = function() {
        var self = this;

        self.dateFrom = ko.observable();
        self.dateTo = ko.observable();
        self.bikeSize = ko.observable("all");

        self.datepickerActive = ko.observable(false);

        self.submitReady = ko.computed(function() {
            return App.isDate(self.dateFrom()) && App.isDate(self.dateTo()) && !self.datepickerActive();
        }, this);

        self.submit = function() {
            console.log(self.dateFrom());
            console.log(self.dateTo());
            console.log(self.bikeSize());
            window.location.hash = '/search?from=' + self.dateFrom() +'&to=' + self.dateTo() + '&size=' + self.bikeSize();
        };

        App.initDatePickers(self, "#dates", "#dateFrom", "#dateTo");
    };

})();