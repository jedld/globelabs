[![Circle CI](https://circleci.com/gh/jedld/globelabs/tree/master.svg?style=svg)](https://circleci.com/gh/jedld/globelabs/tree/master)

# Globelabs
The unofficial ruby gem that does everything you need to do with the globelabs API.

visit Globe Telecom's developer site here [https://developer.globelabs.com.ph](https://developer.globelabs.com.ph)

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'globelabs'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install globelabs
```

## Usage
initialize the client

```ruby
@globe_client = Globelabs::Client.new('some_app_id','some_app_secret')
```

Get an access token coming from the consent workflow

```ruby
access_token = @globe_client.access_token('the_access_code_that_was_obtained_from_the_consent_workflow')
```

## Development
After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing
Bug reports and pull requests are welcome on GitHub at [https://github.com/[USERNAME]/globelabs](https://github.com/[USERNAME]/globelabs). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
