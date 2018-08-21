require 'githack/repository'

module Githack
  module Repositories
    # https://sailsjs.com/
    module SailJS
      class V1 < Githack::Repository
        # https://sailsjs.com/documentation/anatomy/config/datastores.js
        DATABASE_PATHS = [
          File.join('config', 'datastores.js'),
          File.join('config', 'env', 'production.js')
        ].freeze
        # SECRET_PATHS = [].freeze
      end
    end
  end
end
