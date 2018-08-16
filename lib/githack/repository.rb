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

    @git.checkout 'master'

    absolute_file_path = File.join @path, 'config', 'database.yml'


    @git.log.object(absolute_file_path).each do |commit|
      @git.checkout commit
      next unless File.exists? absolute_file_path

      begin
        YAML.load(File.read(absolute_file_path)).each do |config|

          config_name = config[0]
          config_data = config[1]

          next if config_data["adapter"] == "sqlite3"
          results << config_data
        end
      rescue Psych::SyntaxError => e
        
      end

    end

    return results.uniq
  end


end
