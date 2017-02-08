(function() {
    "use strict";

    App.BikesurfViewModel = function() {
        var self = this;

        App.menuActive = ko.observable(false);
        App.lastLogin = ko.observable(new Date());

        // ==================================================
        // Login functionality

        self.me = ko.observable();
        self.userGet = function() {
            App.request('whoami', {}, this.me);
        };

        App.lastLogin.subscribe(self.userGet);

        ko.computed(self.userGet, self);

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
