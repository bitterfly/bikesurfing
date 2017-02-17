(function() {
    "use strict";

    App.BikesurfViewModel = function() {
        var self = this;

        // ==================================================
        // Global states

        App.stopReload = ko.observable(false);
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

        self.lender_menu_active = ko.observable(false);
        self.lender_menu_toggle = function() {
            self.lender_menu_active(!self.lender_menu_active());
        };

        App.last_reservation_update = ko.observable(new Date());
        self.reservations = ko.observable([]);
        ko.computed(function() {
            App.last_reservation_update();
            if (!self.me()) {
                return;
            }
            App.request('user/reservations', {}, self.reservations);
        });

        var lender_me = function(reservation) {
            if (!self.me()) {
                return false;
            };

            return (reservation.lender.id == self.me().id);
        };

        self.filter_lender_me = function(reservations) {
            return reservations.filter(lender_me);
        };

        self.filter_lender_not_me = function(reservations) {
            return reservations.filter(function(reservation) {
                return !lender_me(reservation);
            });
        };

        self.format_date = function(timestamp) {
            var moment = App.timestamp_to_moment(timestamp);
            return moment.calendar(null, {
                sameDay: '[Today]',
                nextDay: '[Tomorrow]',
                nextWeek: 'dddd',
                lastDay: '[Yesterday]',
                lastWeek: '[Last] dddd',
                sameElse: 'YYYY-MM-DD'
            });
        }


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
