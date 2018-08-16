require 'tmpdir'
require 'yaml'
require 'git'


class Repository

  SENSIBLES_FILES = [
    File.join('config', 'database.yml')
  ]

  attr_reader :git, :remote, :name, :path

  def initialize remote
    @remote = remote
    @name = remote.gsub /[^0-9A-Z]/i, '_'
    @path = File.join(Dir.tmpdir, self.name)

    if File.directory? @path
      @git = Git.open @path
    else
      @git = Git.clone @remote, @name, path: Dir.tmpdir
    end
  end

  # Get all changements for config/secrets.yml file (who contains some API keys)
  def search_rails_config_secrets
    results = []

    absolute_file_path = File.join @path, 'config', 'secrets.yml'

    self.checkout_on_yaml_file_change(absolute_file_path) do |secrets|

      puts secrets.inspect
      results << secrets

    end

    return results.uniq
  end


  # Get all changements for config/database.yml file (who contains database configuration for Ruby on Rails Framework)
  def search_rails_config_database
    results = []

    absolute_file_path = File.join @path, 'config', 'database.yml'

    self.checkout_on_yaml_file_change(absolute_file_path) do |configs|

      configs.each do |config|
        config_data = config[1]
        next if config_data["adapter"] == "sqlite3"
        results << config_data
      end

    end

    return results.uniq
  end

  # Checkout on all file changes
  #
  # @param file <String> absolute filepath
  # @yield <Hash> YAML file parsed
  def checkout_on_yaml_file_change file
    self.checkout_on_file_change(file) do
      begin
        data = YAML.load(File.read(file))
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
  def checkout_on_file_change file
    @git.checkout 'master'
    @git.log.object(file).each do |commit|
      @git.checkout commit
      next unless File.exists? file

      yield commit
    end
    @git.checkout 'master'
  end


end
