# Installation and running
First, go to the `bikesurf` subfolder (the actual backend code)

## Install all of the gem's dependencies
1. `$ gem install bundler`
2. `$ bundle install --path ~/.gem` or wherever your gem instalation folder is

## Run checking tools like rubocop
Code checking tools (currently rubocop, in the future unit tests as well) are
combined in a default rake task. Just run

    $ rake

and you'll get a glorious list of errors :)

## How to run the server:
1. create the database and set up .env file with environmental variables (see next section)
2. `$ rake serve`
NOTE: If there are version mismatches run: `$ bundle exec rake serve`
3. point your browser at http://localhost:1234

## How to manage database
1. `$ psql -d database_name`
2. add 'DATABASE_URN="postgres://user:password@localhost/database_name"' to .env
3. `$ cd path_to_project/src/bikesurf`

### How to create empty database or delete rows from tables
`$ rake database:migrate`

### How to fill database with dummy data
`$ rake database:fill_dummy`
