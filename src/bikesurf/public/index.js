$(document).ready(function() {
    Sammy(function() {
        this.get("#/", function() {});

        this.get('', function() {
            this.redirect('#/');
        });
    }).run();
});