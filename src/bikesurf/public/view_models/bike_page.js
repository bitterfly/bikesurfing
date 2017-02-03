(function() {
    App.BikePageViewModel = function(params) {
        this.id = ko.observable(params['id']);
        this.bike_info = ko.observable();
        ko.computed(function() {
            this.bike_info(undefined);
            App.request('bike', { bike_id: this.id() }, this.bike_info);
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
            if (this.bike_info()) {
                return App.image_url(this.bike_info().images[this.bike_image_index()]);
            } else {
                return null;
            }
        }, this);

        this.next_image = function() {
            var num_images = this.bike_info().images.length;
            console.log(this.bike_info().images);
            this.bike_image_index((this.bike_image_index() + 1) % num_images);
        };


        this.comments = ko.observable([
            {
                username: 'Devourer',
                user_avatar: 'https://www.heroesofnewerth.com/images/heroes/6/icon_128.jpg',
                timestamp: '2017-02-01 00:52',
                content: "You're mine!"
            },
            {
                username: 'Emerald Warden',
                user_avatar: 'https://www.heroesofnewerth.com/images/heroes/195/icon_128.jpg',
                timestamp: '2017-02-01 00:58',
                content: "Quite astounding speed! Would recommend 10/10."
            },
            {
                username: 'Engineer',
                user_avatar: 'https://www.heroesofnewerth.com/images/heroes/122/icon_128.jpg',
                timestamp: '2017-02-02 13:12',
                content: "Gaaaaaaaaaaaaaay"
            }
        ]);
    }
})();
