require 'githack/repository'

module Githack
  module Repositories
    module Laravel
      class V5 < Githack::Repository
        DATABASE_PATHS = [
          File.join('config', 'database.php')
        ].freeze

        # SECRET_PATH = ['config', 'secrets.yml']
      end

      class V4 < V5
        DATABASE_PATHS = [
          File.join('app', 'config', 'database.php')
        ].freeze

        # SECRET_PATH = ['config', 'secrets.yml']
      end
    end
  end
end
