require 'githack/repository'

module Githack
  module Repositories
    module Laravel
      class V5 < Githack::Repository
        # SECRET_PATH = ['config', 'secrets.yml']
        DATABASE_PATH = ['config', 'database.php'].freeze
      end

      class V4 < V5
        # SECRET_PATH = ['config', 'secrets.yml']
        DATABASE_PATH = ['app', 'config', 'database.php'].freeze
      end
    end
  end
end
