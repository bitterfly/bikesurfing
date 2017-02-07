(function() {
    "use strict";

    var DATE_FORMAT = "dd/mm/yy";

    App.initDatePickers = function(vm, dates) {
        var $dates = $(dates);

        $dates.datepicker();
    };

})();