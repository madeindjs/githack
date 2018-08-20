require 'githack/repository'

module Githack
  module Repositories
    module Rails
      class V5 < Githack::Repository
        SECRET_PATHS = [
          File.join('config', 'secrets.yml')
        ].freeze

        DATABASE_PATHS = [
          File.join('config', 'database.yml')
        ].freeze
      end

      class V4 < V5
      end

      class V3 < V5
      end
    end
  end
end
