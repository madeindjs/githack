require 'githack/repository'

module Githack
  module Repositories
    module Symfony
      class V1 < Githack::Repository
        # SECRET_PATH = ['config', 'secrets.yml']
        DATABASE_PATH = ['config', 'databases.php'].freeze
      end
    end
  end
end
