require 'githack/repository'

module Githack
  module Repositories
    module CakePHP
      class V3 < Githack::Repository
        # SECRET_PATH = ['config', 'secrets.yml']
        DATABASE_PATH = ['config', 'app.php'].freeze
      end

      class V2 < Githack::Repository
        # SECRET_PATH = ['config', 'secrets.yml']
        DATABASE_PATH = ['app', 'Config', 'database.php'].freeze
      end
    end
  end
end
