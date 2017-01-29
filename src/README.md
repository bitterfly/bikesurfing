# Installation and running
First, go to the `bikesurf` subfolder (the actual backend code)

## Install all of the gem's dependencies
1. `$ gem install bundler`
2. `$ bundle install --path ~/.gem` or wherever your gem instalation folder is

## Run checking tools like rubocop
Code checking tools (currently rubocop, in the future unit tests as well) are
combined in a default rake task. Just run

    `$ rake`

and you'll get a glorious list of errors :)

## How to run the server:
1. create the database and set up .env file with environmental variables (see next section)
3. `rackup -p 1234`

## How to manage database
1. `psql -d database_name`
2. add 'DATABASE_URN="postgres://localhost/database_name"' to .env
3. `cd path_to_project/src/bikesurf`
	
	### How to create empty database or delete rows from tables 
	4.1 `rake database:migrate`

	### How to fill database with dummy data
	4.2 `rake database:fill_dummy`
