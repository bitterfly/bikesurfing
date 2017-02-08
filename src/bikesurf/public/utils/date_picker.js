(function() {
    "use strict";


    App.initDatePickers = function(vm, dates, from, to) {
        var $dates = $(dates);
        var $from = $(from);
        var $to = $(to);

        $dates.datepicker();
    };

})();