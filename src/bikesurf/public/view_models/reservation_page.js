(function() {
    "use strict";

    App.ReservationPageViewModel = function(params) {
        var self = this;
        self.id = ko.observable(parseInt(params.id));
        self.reservation_info = ko.observable();

        self.me = App.me;

        ko.computed(function() {
            App.request('reservation', { reservation_id: self.id() }, self.reservation_info);
        }, self);

        self.user = ko.pureComputed(function() {
            var info = self.reservation_info();
            if (!App.me() || info.reservor.id == App.me().id) {
                return info.lender;
            } else {
                return info.reservor;
            }
        }, self);

        self.amILender = function() {
            if (!self.me()) {
                return false;
            }

            var info = self.reservation_info();
            var res = (info.lender.id === self.me().id && info.reservation.status === 'waiting');
            return res;
        };

        self.update_accept = function() {
            App.request('/reservation/status', {
                reservation_id: self.id(),
                status: 'accepted'
            }, function() {
                self.id.valueHasMutated();
                App.last_reservation_update(new Date());
            })
        };

        self.update_decline = function() {
            App.request('/reservation/status', {
                reservation_id: self.id(),
                status: 'declined'
            }, function() {
                self.id.valueHasMutated();
                App.last_reservation_update(new Date());
            })
        };

        self.avatar_url = App.avatar_url;
        self.image_url = App.image_url;

        self.pretty_date = App.pretty_date;
        self.comment_timestamp = App.pretty_date;

        self.comments = ko.observable();

        self.get_comments = function() {
            App.request('reservation/comments', { reservation_id: self.id() }, self.comments);
        };

        ko.computed(function() {
            self.get_comments();
        }, self);

        self.my_comment = ko.observable();

        self.post_comment = function() {
            App.request('reservation/comment/create', {
                    reservation_id: self.id(),
                    comment: self.my_comment()
                },
                function(comment) {
                    self.get_comments();
                }
            );
            self.my_comment('');
        };
    };

})();
