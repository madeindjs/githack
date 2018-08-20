require 'githack/repository'

module Githack
  module Repositories
    class Rails < Githack::Repository

      SECRET_PATH = ['config', 'secrets.yml']
      DATABASE_PATH = ['config', 'database.yml']
      
    end
  end
end
