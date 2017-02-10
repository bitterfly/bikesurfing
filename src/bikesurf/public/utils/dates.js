(function() {

    App.DATE_FORMAT = "dd.mm.yyyy";

    App.isDate = function(dateString) {
        return /^\d{2}\.\d{2}\.\d{4}$/.test(dateString);
    };

    App.timestamp_to_moment = function(timestamp) {
        return moment.unix(timestamp);
    };

    App.moment_to_timestamp = function(date) {
        return date.unix();
    };

    App.date_to_moment = function(date_string) {
        return moment(date_string, 'DD.MM.YYYY');
    };

    App.date_to_timestamp = function(date_string) {
        return App.moment_to_timestamp(App.date_to_moment(date_string));
    };

    App.pretty_date = function(timestamp) {
        var moment = App.timestamp_to_moment(timestamp);
        return {
            human_readable: moment.calendar(null, {
                sameDay: '[Today] HH:mm',
                nextDay: '[Tomorrow] HH:mm',
                nextWeek: 'dddd',
                lastDay: '[Yesterday] HH:mm',
                lastWeek: '[Last] dddd',
                sameElse: 'YYYY-MM-DD'
            }),
            full: moment.format()
        };
    };
})();
