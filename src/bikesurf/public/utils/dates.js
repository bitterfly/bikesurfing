(function() {

    App.DATE_FORMAT = "dd/mm/yyyy";

    App.isDate = function(dateString) {
        return /^\d{2}\/\d{2}\/\d{4}$/.test(dateString);
    };

    App.timestamp_to_moment = function(timestamp) {
        return moment.unix(timestamp);
    };

    App.moment_to_timestamp = function(date) {
        return date.unix();
    };

})();
