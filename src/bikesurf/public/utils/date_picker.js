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

        $dates.datepicker(options);

        $dates.datepicker().on('show', function(e) {
            vm.datepickerActive(true);
        });

        $dates.datepicker().on('hide', function(e) {
            vm.datepickerActive(false);
        });
    };

})();