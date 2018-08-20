require 'githack/repository'

module Githack
  module Repositories
    class Rails < Githack::Repository
      def secret_path
        File.join @path, 'config', 'secrets.yml'
      end

      def databases_path
        File.join @path, 'config', 'database.yml'
      end
    end
  end
end
