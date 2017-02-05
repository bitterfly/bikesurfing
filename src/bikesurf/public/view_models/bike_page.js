(function() {
    App.BikePageViewModel = function(params) {
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
            $('.slick_images').slick('next')
        });

        this.next_image = function() {
            var num_images = this.bike_images().length;
            this.bike_image_index((this.bike_image_index() + 1) % num_images);
        };
    }
})();
