(function() {
    "use strict";

    App.BorrowBikeViewModel = function() {
        var self = this;

        self.dateFrom = ko.observable();
        self.dateTo = ko.observable();

        self.datepickerActive = ko.observable(false);

        self.submitReady = ko.computed(function() {
            return App.isDate(self.dateFrom()) && App.isDate(self.dateTo()) && !self.datepickerActive();
        }, this);

        App.initDatePickers(self, "#dates", "#dateFrom", "#dateTo");
    }

})();
