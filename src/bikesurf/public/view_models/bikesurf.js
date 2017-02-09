(function() {
    "use strict";

    App.BikesurfViewModel = function() {
        var self = this;

        App.menuActive = ko.observable(false);

        // ==================================================
        // Login functionality

        self.avatar_url = App.avatar_url;
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
                window.location.hash = '/';
            });
        };

        // ==================================================
        // Reservation menu functionality
        self.image_url = App.image_url;
        self.reservation_menu_active = ko.observable(false);
        self.reservation_menu_toggle = function() {
            self.reservation_menu_active(!self.reservation_menu_active());
        };

        self.reservations = ko.observable([]);
        ko.computed(function() {
            if (!self.me()) {
                return;
            }
            App.request('user/reservations', {}, self.reservations);
        });
        

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
