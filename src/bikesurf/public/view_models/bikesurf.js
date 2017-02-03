(function() {
    "use strict";

    App.BikesurfViewModel = function() {
        var self = this;
        self.asd = ko.observable("asd");

        self.openMenu = function() {
            $('.sidenav').css({'width': '250px'})
            $('#page').css({'margin-left': '250px'})
        }

        self.closeMenu = function() {
            $('.sidenav').css({'width': '0'})
            $('#page').css({'margin-left': '0'})
        };
    }

})();