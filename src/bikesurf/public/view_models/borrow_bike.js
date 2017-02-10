(function() {
    "use strict";

    App.BorrowBikeViewModel = function(params) {
        var self = this;

        var bike_id = parseInt(params['bike']);

        self.bike_info = ko.observable({ bike: { id: bike_id } });

        ko.computed(function() {
            App.request('bike', { bike_id: bike_id }, self.bike_info);
        }, self);

        self.agreed = ko.observable(false);
        self.comment = ko.observable("");

        self.send_allowed = ko.pureComputed(function() {
            return (self.agreed() && self.valid_dates() && !self.sending());
        }, self);

        self.sending = ko.observable(false);

        self.send = function() {
            if (!self.send_allowed()) {
                return;
            }
            self.sending(true);

            App.request('reservation/create', {
                from: App.date_to_timestamp(self.dateFrom()),
                to: App.date_to_timestamp(self.dateTo()),
                bike_id: self.bike_info().bike.id,
                comment: self.comment()
            }, function(reservation) {
                App.last_reservation_update(new Date());
                window.location.hash = '/reservation/' + reservation.id;
            });
        };

        self.dateFrom = ko.observable(params['from']);
        self.dateTo = ko.observable(params['to']);

        self.datepickerActive = ko.observable(false);

        self.valid_dates = ko.computed(function() {
            return App.isDate(self.dateFrom()) && App.isDate(self.dateTo()) && !self.datepickerActive();
        }, self);

        App.initDatePickers(self, "#dates", "#dateFrom", "#dateTo");
    }

})();
