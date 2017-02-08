(function() {
    App.LoginPageViewModel = function(params) {
        this.username = ko.observable();
        this.password = ko.observable();

        this.login = function() {
            App.request('login', {
                    username: this.username(),
                    password: this.password()
                },
                function(response) {
                    docCookies.setItem('session_id', response.session_id);
                    alert('success!');
                }
            )
        };
    };
})();
