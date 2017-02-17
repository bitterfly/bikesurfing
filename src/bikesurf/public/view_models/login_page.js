(function() {
    App.LoginPageViewModel = function(params) {
        var self = this;

        self.username = ko.observable();
        self.password = ko.observable();
        self.busy = ko.observable(false);
        self.me = App.me;


        self.login = function() {
            self.busy(true);
            App.request('login', {
                    username: self.username(),
                    password: self.password()
                },
                function(response) {
                    docCookies.setItem('session_id', response.session_id);
                    self.me(response.user);
                    self.busy(false);
                    window.location.hash = '/';
                }
            )
        };
    };
})();
