require 'tmpdir'
require 'yaml'
require 'git'
require 'githack/leak'

module Githack
  class Repository
    attr_reader :git, :remote, :name, :path

    # Represent the path to secrets file
    SECRET_PATH = []
    # Represent the path to database configuration file
    DATABASE_PATH = []

    def initialize(remote)
      @remote = remote
      @name = remote.gsub /[^0-9A-Z]/i, '_'
      @path = File.join(Dir.tmpdir, name)

      @git = if File.directory? @path
               Git.open @path
             else
               Git.clone @remote, @name, path: Dir.tmpdir
             end
    end


    # Get all changements for config/secrets.yml file (who contains some API keys)
    #
    # @return [Array<Githack::Leak>]
    def secrets
      leaks = []
      get_leaks(File.join(@path, self.class::SECRET_PATH)).each do |leak|
        leaks << leak
        yield lead if block_given?
      end
      leaks
    end

    # Get all changements for config/database.yml file (who contains database configuration for Ruby on Rails Framework)
    #
    # @return [Array<Githack::Leak>]
    def databases
      leaks = []
      get_leaks(File.join(@path, self.class::DATABASE_PATH)).each do |leak|
        leaks << leak
        yield lead if block_given?
      end
      leaks
    end

    protected

    # Checkout on all file changes
    #
    # @param file <String> absolute filepath
    # @yield [Githack::Leak]
    def get_leaks(file)
      leaks = []
      @git.checkout 'master'
      begin
        @git.log.object(file).each do |commit|
          @git.checkout commit
          next unless File.exist? file

          leak = Githack::Leak.new(commit.sha, file)
          leaks << leak

          yield leak if block_given?
        end
      rescue StandardError
        Psych::BadAlias
      end
      @git.checkout 'master'
      leaks
    end
  end
end
