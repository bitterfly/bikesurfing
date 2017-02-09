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
            // window.location = '/#/search?from=1&to=2&size=all';
            console.log(App.selfSammy);
            App.selfSammy.redirect('#/search?from=1&to=2&size=all');
        }

        App.initDatePickers(self, "#dates", "#dateFrom", "#dateTo");
    };

})();