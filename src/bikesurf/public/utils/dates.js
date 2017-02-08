(function() {

    App.DATE_FORMAT = "dd/mm/yy";


    App.timestamp_to_moment = function(timestamp) {
        return moment.unix(timestamp);
    };

    App.moment_to_timestamp = function(date) {
        return date.unix();
    };
})();
