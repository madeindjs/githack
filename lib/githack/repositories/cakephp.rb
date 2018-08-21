require 'githack/repository'

module Githack
  module Repositories
    # https://cakephp.org/
    module CakePHP
      # https://book.cakephp.org/3.0/
      class V3 < Githack::Repository
        # https://book.cakephp.org/3.0/en/orm/database-basics.html#database-configuration
        DATABASE_PATHS = [
          File.join('config', 'app.php')
        ].freeze

        # SECRET_PATH = ['config', 'secrets.yml']
      end

      # https://book.cakephp.org/2.0/
      class V2 < Githack::Repository
        # https://book.cakephp.org/2.0/en/development/configuration.html#database-configuration
        DATABASE_PATHS = [
          File.join('app', 'Config', 'database.php')
        ].freeze

        # SECRET_PATH = ['config', 'secrets.yml']
      end

      # https://book.cakephp.org/1.3/
      class V1 < Githack::Repository
        # https://book.cakephp.org/2.0/en/development/configuration.html#database-configuration
        DATABASE_PATHS = [
          File.join('app', 'Config', 'database.php')
        ].freeze

        # SECRET_PATH = ['config', 'secrets.yml']
      end
    end
  end
end
