(function() {
    "use strict";

    App.BorrowBikeViewModel = function() {
        var self = this;
        self.agreed = ko.observable(false);
        self.comment = ko.observable("");

        self.send_allowed = ko.pureComputed(function() {
            return (self.agreed() && self.valid_dates());
        }, self);

        self.send = function() {
            if (!self.send_allowed()) {
                return;
            }
        };

        self.dateFrom = ko.observable();
        self.dateTo = ko.observable();

        self.datepickerActive = ko.observable(false);

        self.valid_dates = ko.computed(function() {
            return App.isDate(self.dateFrom()) && App.isDate(self.dateTo()) && !self.datepickerActive();
        }, self);

        App.initDatePickers(self, "#dates", "#dateFrom", "#dateTo");
    }

})();
