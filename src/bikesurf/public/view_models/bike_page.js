(function() {
    App.BikePageViewModel = function(params) {
        var self = this;

        self.me = App.me;

        this.avatar_url = App.avatar_url;

        this.comment_timestamp = App.pretty_date;

        this.image_operations_busy = ko.observable(false);

        this.add_image = function(image) {
            var images = this.bike_images();
            images.push(image);

            this.add_slick_image(image);
            this.slick_goto(images.length - 1);

            this.bike_images(images);
        };

        this.delete_image = function(index) {
            var images = this.bike_images();
            images.splice(index, 1);
            
            this.slick_delete(index);

            this.bike_images(images);
        };

        this.upload_image = function(image) {
            self.image_operations_busy(true);

            reader = new FileReader();

            reader.addEventListener('load', function() {
                var data = reader.result.split(',')[1];

                App.request('bike/image/new', {
                        bike_id: self.id(),
                        image: data
                    },
                    function(response) {
                        self.image_operations_busy(false);
                        self.add_image(response.image);
                    }
                );
            });

            reader.readAsDataURL(image);
        };

        this.trigger_upload_image = function() {
            $('#bike_image_upload').trigger('click');
        };
         

        this.remove_image = function() {
            self.image_operations_busy(true);
            var image_index = self.current_image();
            App.request('bike/image/delete', {
                    image_id: self.bike_images()[image_index].id
                },
                function(response) {
                    self.image_operations_busy(false);
                    self.delete_image(image_index);
                }
            );
        };

        this.id = ko.observable(parseInt(params['id']));
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

        self.get_comments = function() {
            App.request('bike/comments', { bike_id: this.id() }, this.comments);
        };

        ko.computed(function() {
            self.get_comments();
        }, self);

        self.my_comment = ko.observable();

        self.post_comment = function() {
            App.request('bike/comment/create', {
                    bike_id: self.id(),
                    comment: self.my_comment()
                },
                function(comment) {
                    self.get_comments();
                }
            );
            self.my_comment('');
        };

        this.bike = ko.pureComputed(function() {
            if (this.bike_info()) {
                return this.bike_info().bike
            } else {
                return null;
            }
        }, this);

        this.owner = ko.pureComputed(function() {
            if (this.bike_info()) {
                return this.bike_info().owner
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

        this.add_slick_image = function(image, at) {
            $('.slick_images').slick(
                'slickAdd',
                '<div><img src="' + App.image_url(image) + '" /></div>',
                at
            );
        };

        this.slick_goto = function(at) {
            $('.slick_images').slick('slickGoTo', at);
        };

        this.slick_delete = function(at) {
            $('.slick_images').slick('slickRemove', at);
        };

        this.bike_images.subscribe(function(images) {
            if (this.slick) {
                return;
            }
            $('.slick_images').slick({
                slidesToShow: 1,
                centerMode: true,
                dots: true,
                variableWidth: true
            });
            this.slick = $('.slick_images');

            for (var i = 0; i < images.length; i++) {
                self.add_slick_image(images[i]);
            }
            $('.slick_images').slick('slickGoTo', 0);
        });

        this.current_image = function() {
            return $('.slick_images').slick('slickCurrentSlide')
        };

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

        var bool_stat = function(value) {
            if (value) {
                return '<i class="fa fa-check bool_stat_true" title="yes"></i>';
            } else {
                return '<i class="fa fa-times bool_stat_false" title="no"></i>';
            }
        };

        var light_stat = function(value) {
            if (value[0] == 'n') {
                return bool_stat(false);
            } else if (value[1] == 'b') {
                return bool_stat(true) + ' (battery)';
            } else if (value[1] == 'd') {
                return bool_stat(true) + ' (dynamo)';
            } else {
                return bool_stat(true);
            }
        };

        self.bike_stats = ko.pureComputed(function() {
            // todo: escaping
            return [
                {
                    title: 'Frame',
                    text: self.bike().frame
                },
                {
                    title: 'Crossbar',
                    text: self.bike().crossbar
                },
                {
                    title: 'Size',
                    text: self.bike().size
                },
                {
                    title: 'Front lights',
                    text: light_stat(self.bike().front_lights)
                },
                {
                    title: 'Back lights',
                    text: light_stat(self.bike().back_lights)
                },
                {
                    title: 'Backpedal breaking system',
                    text: bool_stat(self.bike().backpedal_breaking_system)
                },
                {
                    title: 'Quick release saddle',
                    text: bool_stat(self.bike().quick_release_saddle)
                },
                {
                    title: 'Gears',
                    text: self.bike().gears_number
                }
            ];
        }, this);

        self.dateFrom = ko.observable(params['from']);
        self.dateTo = ko.observable(params['to']);

        self.datepickerActive = ko.observable(false);

        self.borrow_allowed = ko.computed(function() {
            return App.isDate(self.dateFrom()) && App.isDate(self.dateTo()) && !self.datepickerActive();
        }, this);

        self.borrow = function() {
            window.location.hash = "#/borrow?bike=" + self.bike().id + "&from=" + self.dateFrom() + "&to=" + self.dateTo();
        };

        App.initDatePickers(self, "#dates", "#dateFrom", "#dateTo");
    }
})();
