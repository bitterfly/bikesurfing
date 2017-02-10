(function() {
    "use strict";

    App.ReservationPageViewModel = function(params) {
        var self = this;
        self.id = ko.observable(parseInt(params.id));
        self.reservation_info = ko.observable();

        ko.computed(function() {
            App.request('reservation', { reservation_id: self.id() }, self.reservation_info);
        }, this);

        self.reservation_info.subscribe(function(r) {
            console.log(r);
        });

        self.image_url = App.image_url;

        self.pretty_date = App.pretty_date;
    };

})();
