# Stalker

This is a simple stack health check for rails based applications, it mounts a endpoint with the current status of database, application and redis.

## Usage

After installing this gem it will mount a endpoint in `/_ah/health`, this will bring a response like this:

`curl localhost:8000/_ah/health`

```json
{
   "app":{
      "message":"Application is running",
      "success":true
   },
   "database":{
      "message":"Database is connected",
      "success":true
   },
   "redis":{
      "message":"Redis is connected",
      "success":true
   }
}
```

## Installation

If you have a redis instance in you application add the following initializer to create a `Redis.current`, so it don't need to use global vars, or create a new connection each request:

```ruby
# config/initializers/redis.rb

Redis.current ||= Redis.new(url: ENV['REDIS_URL'])
```

Add this line to your application's Gemfile:

```ruby
gem 'stalker'
```

And then execute:
```bash
bundle install
```

After installing the gem just mount the route:

```ruby
# config/routes.rb

Rails.application.routes.draw do
  mount Stalker::Engine => "/_ah/health"

  ...
end
```

## Developing

```bash
docker-compose build && docker-compose up

docker-compose exec web bash

rails db:setup

rubocop -A && rspec
```

Minimum coverage is set to 95%.

## Contributing

Fell free to send a PR.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
