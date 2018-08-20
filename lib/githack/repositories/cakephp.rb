require 'githack/repository'

module Githack
  module Repositories
    module CakePHP
      class V3 < Githack::Repository
        DATABASE_PATHS = [
          File.join('config', 'app.php')
        ].freeze

        # SECRET_PATH = ['config', 'secrets.yml']
      end

      class V2 < Githack::Repository
        DATABASE_PATHS = [
          File.join('app', 'Config', 'database.php')
        ].freeze

        # SECRET_PATH = ['config', 'secrets.yml']
      end
    end
  end
end
