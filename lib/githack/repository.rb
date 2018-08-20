require 'tmpdir'
require 'yaml'
require 'git'

module Githack
  class Repository
    attr_reader :git, :remote, :name, :path

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
      results = []

      checkout_on_yaml_file_change(secret_path) do |secrets|
        results << secrets
      end

      results.uniq
    end

    # Get all changements for config/database.yml file (who contains database configuration for Ruby on Rails Framework)
    #
    # @return [Array<Githack::Leak>]
    def databases
      results = []

      checkout_on_yaml_file_change(databases_path) do |configs|
        configs.each do |config|
          config_data = config[1]
          next if config_data['adapter'] == 'sqlite3'
          results << config_data
        end
      end

      results.uniq
    end

    protected

    # Checkout on all file changes
    #
    # @param file <String> absolute filepath
    # @yield <Hash> YAML file parsed
    def checkout_on_yaml_file_change(file)
      checkout_on_file_change(file) do
        begin
          data = YAML.safe_load(File.read(file))
          yield data
        rescue Psych::SyntaxError => e
          # can't parse YAML file
        end
      end
    end

    # Checkout on all file changes
    #
    # @param file <String> absolute filepath
    # @yield <Git::Log>
    def checkout_on_file_change(file)
      @git.checkout 'master'
      begin
        @git.log.object(file).each do |commit|
          @git.checkout commit
          next unless File.exist? file

          yield commit
        end
      rescue StandardError
        Psych::BadAlias
      end
      @git.checkout 'master'
    end
  end
end
