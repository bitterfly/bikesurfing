(function() {
    "use strict";

    App.IntroPageViewModel = function() {
        var self = this;

        self.dateFrom = ko.observable();
        self.dateTo = ko.observable();
        self.bikeSize = ko.observable("all");

        self.submitReady = function() {
            return self.dateFrom() && self.dateTo();
        };

        self.submit = function(form) {
            console.log(form);
        }

        App.initDatePickers(self, "#dates", "#dateFrom", "#dateTo");
    };

})();