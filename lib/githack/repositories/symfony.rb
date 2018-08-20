require 'githack/repository'

module Githack
  module Repositories
    module Symfony
      class V4 < Githack::Repository
        SECRET_PATHS = ['.env'].freeze

        # https://symfony.com/doc/4.1/doctrine.html
        DATABASE_PATHS = [
          File.join('config', 'packages', 'doctrine.yaml'),
          File.join('config', 'packages', 'doctrine.xml'),
          File.join('config', 'packages', 'doctrine.php')
        ].freeze
      end

      class V3 < Githack::Repository
        SECRET_PATHS = ['.env'].freeze

        # https://symfony.com/doc/3.3/doctrine.html
        DATABASE_PATHS = [
          File.join('app', 'config', 'parameters.xml'),
          File.join('app', 'config', 'parameters.yml'),
          File.join('app', 'config', 'parameters.php')
        ].freeze
      end

      class V2 < Githack::Repository
        SECRET_PATHS = ['.env'].freeze

        # https://symfony.com/doc/2.8/doctrine.html
        DATABASE_PATHS = [
          File.join('app', 'config', 'config.xml'),
          File.join('app', 'config', 'config.yml'),
          File.join('app', 'config', 'config.php')
        ].freeze
      end

      class V1 < Githack::Repository
        SECRET_PATHS = [].freeze

        # https://symfony.com/legacy/doc/reference/1_4/en/07-Databases
        DATABASE_PATHS = [
          File.join('config', 'databases.yml')
        ].freeze
      end
    end
  end
end
