require 'tmpdir'
require 'yaml'
require 'git'
require 'githack/leak'

module Githack
  class Repository
    attr_reader :git, :remote, :name, :path

    # Represent the path to secrets files
    SECRET_PATH = [].freeze
    # Represent the path to database configuration files
    DATABASE_PATH = [].freeze

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
      files = self.class::SECRET_PATHS.map { |f| File.join(@path, f) }

      get_leaks(*files).each do |leak|
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
      files = self.class::DATABASE_PATHS.map { |f| File.join(@path, f) }

      get_leaks(*files).each do |leak|
        leaks << leak
        yield lead if block_given?
      end
      leaks
    end

    protected

    # Checkout on all file changes
    #
    # @yield [Githack::Leak]
    def get_leaks(*files)
      leaks = []
      @git.checkout 'master'

      files.each do |file|
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
      end

      leaks
    end
  end
end
