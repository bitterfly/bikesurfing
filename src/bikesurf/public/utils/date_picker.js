(function() {
    "use strict";

    App.initDatePickers = function(vm, dates, from, to) {
        var $dates = $(dates);
        var $from = $(from);
        var $to = $(to);

        var options = {
            clearBtn: true,
            format: App.DATE_FORMAT,
            startDate: Date(),
            todayHighlight: true,
            templates: {
                leftArrow: '<i class="fa fa-arrow-left"></i>',
                rightArrow: '<i class="fa fa-arrow-right"></i>'
            },
            toggleActive: true,
            weekStart: 1
        };

        $dates.datepicker(options).on('changeDate', function(e) {
            var from = $from.datepicker('getDate');
            var to = $to.datepicker('getDate');
            vm.dateFrom(from);
            vm.dateTo(to);
        });
    };

})();