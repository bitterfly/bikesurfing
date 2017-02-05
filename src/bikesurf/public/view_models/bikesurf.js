(function() {
    "use strict";

    App.BikesurfViewModel = function() {
        var self = this;
        self.asd = ko.observable("asd");


        // ==================================================
        // Menu button functionality

        function menuShow() {
            $('#sidenav').addClass('show');
            $('#page').addClass('menuOpen');
        };

        function menuClose() {
            $('#sidenav').removeClass('show');
            $('#page').removeClass('menuOpen');
        };

        self.toggleMenu = function() {
            if ($('#sidenav').innerWidth() === 0) {
                menuShow();
            } else {
                menuClose();
            }
        };

        self.closeMenu = function() {
            menuClose();
        };

        // ==================================================

    }

})();