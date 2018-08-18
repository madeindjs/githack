#!/usr/bin/env ruby
require 'githack'
require 'optparse'
require 'tty-spinner'
require 'pp'

url = nil

options = {
  skip_config_secrets: false,
  skip_config_database: false
}

OptionParser.new do |opts|
  opts.banner = 'Usage: githack.rb URL with URL as remote URL of a Git repository (currently works only for Rails project)'

  url = ARGV.pop

  opts.on '--skip_config_secrets', 'Not search for config/secrets.yml' do |_o|
    options[:skip_config_secrets] = true
  end

  opts.on '--skip_config_database', 'Not search for config/database.yml' do |_o|
    options[:skip_config_secrets] = true
  end

  unless url
    puts "You must provide a Git remote URL\r\n\r\n"
    puts opts
    exit
  end
end.parse!

spinner = TTY::Spinner.new '[:spinner] Cloning repository ...'
spinner.auto_spin
repository = Repository.new url
spinner.stop('Done!')

unless options[:skip_config_database]
  spinner = TTY::Spinner.new '[:spinner] Search in config/database.yml (Rails) ...'
  spinner.auto_spin
  result = repository.search_rails_config_database
  spinner.stop('Done!')
  pp result
end

unless options[:skip_config_secrets]
  spinner = TTY::Spinner.new '[:spinner] Search in config/secrets.yml (Rails) ...'
  spinner.auto_spin
  result = repository.search_rails_config_secrets
  spinner.stop('Done!')
  pp result
end
