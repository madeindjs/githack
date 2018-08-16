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


  def search_rails_config_database
    results = []

    absolute_file_path = File.join @path, 'config', 'database.yml'

    self.checkout_on_file_change(absolute_file_path) do
      begin
        YAML.load(File.read(absolute_file_path)).each do |config|

          config_name = config[0]
          config_data = config[1]

          next if config_data["adapter"] == "sqlite3"
          results << config_data
        end
      rescue Psych::SyntaxError => e
        # can't parse YAML file
      end
    end

    return results.uniq
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
