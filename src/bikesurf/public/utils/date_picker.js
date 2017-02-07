(function() {
    "use strict";

    var DATE_FORMAT = "dd/mm/yy";

    App.initDatePickers = function(vm, dateFrom, dateTo) {
        var from = $("#" + dateFrom);
        var to = $("#" + dateTo);

        from.datepicker();
        to.datepicker();
    };

})();