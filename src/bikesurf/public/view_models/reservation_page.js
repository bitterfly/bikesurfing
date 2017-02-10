(function() {
    "use strict";

    App.ReservationPageViewModel = function(params) {
        var self = this;
        self.id = ko.observable(parseInt(params.id));
    };

})();
