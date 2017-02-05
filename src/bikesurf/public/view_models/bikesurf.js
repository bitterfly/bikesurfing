(function() {
    "use strict";

    App.BikesurfViewModel = function() {
        var self = this;

        App.menuActive = ko.observable(false);

        // ==================================================
        // Menu button functionality

        function menuShow() {
            $('#sidenav').addClass('show');
            $('#page').addClass('menuOpen');
            App.menuActive(true);
        };

        function menuClose() {
            $('#sidenav').removeClass('show');
            $('#page').removeClass('menuOpen');
            App.menuActive(false);
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