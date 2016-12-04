# Server side
We need a simple back end that provides reusable REST API. It will be written entirely in ruby.

## Database
We need an open source DB. After discussing MariaDB and Postgres, Postgres whould be our choice because it gives greater flexibility on how data is stored.

## ORM
[Datamapper](http://datamapper.org/docs/find.html) is lightweigted and functional.

## HTTP
[Sinatra](http://www.sinatrarb.com/) is lightweigted framework build on top of [rack](https://rack.github.io/) which can take care of routing and handle web serving nicely.

# Client side
Will take JSONS and take care of visoalisation using(the usual stack)

* HTML
* JS (research Knockout, Ember and Angular and maybe use one of those)
* JQuery
* SASS preprocessor for CSS

# External APIs
* [OpenStreetMap](http://wiki.openstreetmap.org/wiki/API) (needs some more research)
* [MailChimp](https://apidocs.mailchimp.com/) could be used to sync email activity

