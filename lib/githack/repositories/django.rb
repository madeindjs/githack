require 'githack/repository'

module Githack
  module Repositories
    # The web framework for perfectionists with deadlines.
    module Django
      class V2 < Githack::Repository
        # https://docs.djangoproject.com/fr/2.1/topics/settings/#default-settings
        DATABASE_PATHS = [
          File.join('django', 'conf', 'global_settings.py')
        ].freeze
        # SECRET_PATHS = [].freeze
      end
    end
  end
end
