(function() {
    "use strict";

    App.BikesurfViewModel = function() {
        var self = this;

        App.menuActive = ko.observable(false);

        // ==================================================
        // Login functionality

        self.me = ko.observable();
        App.me = self.me;

        self.reloadUser = function() {
            App.request('whoami', {}, self.me);
        };
        ko.computed(self.reloadUser, self);

        App.reloadUser = self.reloadUser;

        self.logout = function() {
            App.request('logout', {}, function(_) {
                self.me(null);
                docCookies.removeItem('session_id');
            });
        };

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
            if ($('#sidenav').hasClass('show')) {
                menuClose();
            } else {
                menuShow();
            }
        };

        self.closeMenu = function() {
            menuClose();
        };

        // ==================================================

    }

})();
