# Githack

Crawl [Git][git]'s commits of a given repository to find forgotten credentials

Currently support:

- [Ruby on Rails](https://rubyonrails.org)

  - _config/secrets.yml_
  - _config/database.yml_

## Dependencies

You need to install [Git][git]. Exemple for Debian based distributions:

```bash
$ sudo apt install git
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'githack'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install githack

## Usage

### As library

Simply use tis to clone the remote repository in your temporary folder

```ruby
require 'githack'

repository = Repository.new 'https://github.com/RaspberryCook/website'
```

And then you can search on repository like this:

```ruby
repository.search_rails_config_database
# [{"adapter"=>"mysql2", "database"=>"raspberry_cook", "encoding"=>"utf8", "username"=>"raspberry_cook", "password"=>"secret", "host"=>"localhost", "pool"=>5, "timeout"=>5000}])

repository.search_rails_config_secrets
# [{"development"=>{"marmiton_password"=>"20462046"}, "production"=>{"marmiton_password"=>"20462046"}, "test"=>{"marmiton_password"=>"20462046"}}])
```

Theses methods will:

1. Search all commit were file changed
2. Checkout on theses commit to get file content
3. Filter only usefull informations

### As command line tool

Simply use

```bash
$ githack.rb https://github.com/RaspberryCook/website
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/githack. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Githack project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/githack/blob/master/CODE_OF_CONDUCT.md).

[git]: https://git-scm.com/
