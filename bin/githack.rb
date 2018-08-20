#!/usr/bin/env ruby
require 'githack'
require 'optparse'
require 'tty-spinner'
require 'pp'

url = nil

options = {
  skip_config_secrets: false,
  skip_config_database: false,
  framework: nil
}

optparse = OptionParser.new do |opts|
  opts.banner = 'Usage: githack.rb URL with URL as remote URL of a Git repository (currently works only for Rails project)'

  url = ARGV.pop

  opts.on '-f', '--framework FRAMEWORK', 'Specify repository framework to target to find leaked data', 'use without parameter to get the complete list' do |framework|
    options[:framework] = framework
  end

  opts.on '--skip_config_secrets', 'Not search for config/secrets.yml' do |_o|
    options[:skip_config_secrets] = true
  end

  opts.on '--skip_config_database', 'Not search for config/database.yml' do |_o|
    options[:skip_config_secrets] = true
  end

  opts.on('-h', '--help', 'Display this screen') do
    puts opts
    exit
  end

  unless url
    puts "You must provide a Git remote URL\r\n\r\n"
    puts opts
    exit
  end
end

optparse.parse!

unless Githack::Repositories.get_availables_frameworks_versions_pretty.include?(options[:framework])

  puts "You must specify framework\r\n\r\n"
  Githack::Repositories.get_availables_frameworks_versions_pretty.each do |framework|
    puts format('  - %s', framework)
  end

  exit
end

framework_class = Githack::Repositories.const_get(options[:framework])

spinner = TTY::Spinner.new '[:spinner] Cloning repository ...'
spinner.auto_spin
repository = framework_class.new url
spinner.stop('Done!')

unless options[:skip_config_database]
  spinner = TTY::Spinner.new '[:spinner] Search in config/database.yml (Rails) ...'
  spinner.auto_spin
  result = repository.databases
  spinner.stop('Done!')
  pp result
end

unless options[:skip_config_secrets]
  spinner = TTY::Spinner.new '[:spinner] Search in config/secrets.yml (Rails) ...'
  spinner.auto_spin
  result = repository.secrets
  spinner.stop('Done!')
  pp result
end
