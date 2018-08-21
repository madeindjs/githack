require 'githack/repository'

module Githack
  module Repositories
    # https://www.codeigniter.com/
    module Codeigniter
      # https://www.codeigniter.com/userguide3/
      class V3 < Githack::Repository
        # https://www.codeigniter.com/userguide3/database/configuration.html
        DATABASE_PATHS = [
          File.join('application', 'config', 'database.php'),
          File.join('application', 'config', 'production', 'database.php')
        ].freeze
        # SECRET_PATHS = [].freeze
      end

      # https://www.codeigniter.com/userguide2/
      class V2 < V3
      end
    end
  end
end
