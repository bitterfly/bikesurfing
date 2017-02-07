(function() {
    "use strict";

    App.IntroPageViewModel = function() {
        var self = this;

        self.dateFrom = ko.observable();
        self.dateTo = ko.observable();
        self.bikeSize = ko.observable();

        function submit() {

        }

        App.initDatePickers(self, "dateFrom", "dateTo");
    };

})();