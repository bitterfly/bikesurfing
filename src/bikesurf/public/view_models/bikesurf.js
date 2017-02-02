(function() {

    App.BikesurfViewModel = function() {
        this.firstName = ko.observable("Weird Al");
        this.lastName = ko.observable("Yankovich");
        this.fullName = ko.pureComputed(function() {
            return this.firstName() + " " + this.lastName();
        }, this);
    }

})();