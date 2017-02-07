(function() {
    App.BikePageViewModel = function(params) {
        var self = this;

        this.avatar_url = function(image) {
            if (image) {
                return App.image_url(image);
            } else {
                return 'resources/avatar_placeholder.png';
            }
        }

        this.comment_timestamp = function(timestamp) {
            var moment = App.timestamp_to_moment(timestamp);
            return {
                human_readable: moment.calendar(null, {
                    sameDay: '[Today] HH:mm',
                    nextDay: '[Tomorrow] HH:mm',
                    nextWeek: 'dddd',
                    lastDay: '[Yesterday] HH:mm',
                    lastWeek: '[Last] dddd',
                    sameElse: 'YYYY-MM-DD'
                }),
                full: moment.format()
            };
        }

        this.upload_image = function(image) {
            reader = new FileReader();

            reader.addEventListener('load', function() {
                var data = reader.result.split(',')[1];

                App.request('bike/image/new', {
                        bike_id: self.id(),
                        image: data
                    },
                    function(response) {
                        console.log(response);
                        alert('yay!');
                    }
                );
            });

            reader.readAsDataURL(image);
        };

        this.trigger_upload_image = function() {
            $('#bike_image_upload').trigger('click');
        };
         

        this.remove_image = function() {

        };

        this.id = ko.observable(params['id']);
        this.bike_info = ko.observable();
        this.bike_images = ko.observable();
        this.comments = ko.observable();

        ko.computed(function() {
            this.bike_info(undefined);
            App.request('bike', { bike_id: this.id() }, this.bike_info);
        }, this);

        ko.computed(function() {
            this.bike_images(undefined);
            App.request('images/bike', { bike_id: this.id() }, this.bike_images);
        }, this);

        ko.computed(function() {
            this.comments(undefined);
            App.request('comments/bike', { bike_id: this.id() }, this.comments);
        }, this);

        this.bike = ko.pureComputed(function() {
            if (this.bike_info()) {
                return this.bike_info().bike
            } else {
                return null;
            }
        }, this);

        this.bike_pretty_json = ko.pureComputed(function() {
            return JSON.stringify(this.bike(), null, 2);
        }, this);

        this.bike_image_index = ko.observable(0);

        this.bike_image_link = ko.pureComputed(function() {
            if (this.bike_images()) {
                return App.image_url(this.bike_images()[this.bike_image_index()]);
            } else {
                return null;
            }
        }, this);

        this.bike_images.subscribe(function(images) {
            $('.slick_images').slick({
                slidesToShow: 1,
                centerMode: true,
                dots: true,
                variableWidth: true
            });
            for (var i = 0; i < images.length; i++) {
                $('.slick_images').slick('slickAdd', '<div><img src="' + App.image_url(images[i]) + '" /></div>');
            }
            $('.slick_images').slick('slickGoTo', 0);
        });

        App.menuActive.subscribe(function(state) {
            // fixme: refresh it in a better way
            $('.slick_images').slick('slickGoTo', 
                $('.slick_images').slick('slickCurrentSlide')
            );
        });

        this.next_image = function() {
            var num_images = this.bike_images().length;
            this.bike_image_index((this.bike_image_index() + 1) % num_images);
        };
    }
})();
