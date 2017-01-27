# Install all of the gem's dependencies
0.1. `gem install bundler`
0.2. `bundle install --path ~/.gem` or wherever your gem instalation folder is

## How to run:
1. create the database and set up .env file with environmental variables
2. `cd bikesurf`
3. `rackup -p 1234`

## How to manage database
1. `psql -d database_name`
2. add 'DATABASE_URN="postgres://localhost/database_name"' to .env
3. `cd path_to_project/src/bikesurf`
	
	### How to create empty database or delete rows from tables 
	4.1 `rake database:migrate`

	### How to fill database with dummy data
	4.2 `rake database:fill_dummy`