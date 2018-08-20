# Githack

[![Gem Version](https://badge.fury.io/rb/githack.svg)](https://rubygems.org/gems/githack)

Crawl [Git][git]'s commits of a given repository to find forgotten credentials according to given framework.

> [See documentation ](https://www.rubydoc.info/gems/githack/Githack/Repositories) to know which framework is currently supported


## Dependencies

You need to install [Git][git].

Exemple for Debian based distributions:

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

repository = Githack::Repositories::Rails::v4.new 'https://github.com/RaspberryCook/website'
```

And then you can search on repository using `databases` or `secrets` who returns `Array<Githack::Leak>`. `Githack::Leak` contains `sha`, `file` and `content`:

```ruby
repository.databases.each do |leak|
  # <Githack::Leak:Githack::Leak:0x00556db18af998 ...  >,
  puts leak.sha
  # => 566fac779248c345192512423770f14cf4af1435
  puts leak.file
  # => /tmp/https___github_com_madeindjs_fooder/config/database.yml
  puts leak.content
  # "development:\n" +
  # "  adapter: mysql2\n" +
  # "  database: raspberry_cook\n" +
  # "  encoding: utf8\n" +
  # "  username: raspberry_cook\n" +
  # "  password: secret\n" +
  # "  host:  localhost\n" +
end

repository.secrets.each do |leak|
  # ....
end
```

Theses methods will:

1. Search all commit were file changed
2. Checkout on theses commit to get file content
3. Filter only usefull informations

### As command line tool

Simply use

```bash
$ githack.rb --framework=Rails::V4 https://github.com/madeindjs/fooder
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/githack. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Githack project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/githack/blob/master/CODE_OF_CONDUCT.md).

[git]: https://git-scm.com/
