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

        self.submit = function(form) {
            console.log(form);
            console.log(self.dateFrom());
            console.log(self.dateTo());
            console.log(self.bikeSize());
        }

        App.initDatePickers(self, "#dates", "#dateFrom", "#dateTo");
    };

})();