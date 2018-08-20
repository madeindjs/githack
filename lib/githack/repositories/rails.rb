require 'githack/repository'

module Githack
  module Repositories
    class Rails < Githack::Repository
      # Get all changements for config/secrets.yml file (who contains some API keys)
      def secrets
        results = []

        absolute_file_path = File.join @path, 'config', 'secrets.yml'

        checkout_on_yaml_file_change(absolute_file_path) do |secrets|
          results << secrets
        end

        results.uniq
      end

      # Get all changements for config/database.yml file (who contains database configuration for Ruby on Rails Framework)
      def databases
        results = []

        absolute_file_path = File.join @path, 'config', 'database.yml'

        checkout_on_yaml_file_change(absolute_file_path) do |configs|
          configs.each do |config|
            config_data = config[1]
            next if config_data['adapter'] == 'sqlite3'
            results << config_data
          end
        end

        results.uniq
      end
    end
  end
end
