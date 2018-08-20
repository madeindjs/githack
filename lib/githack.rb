require 'githack/version'
require 'githack/repositories/cakephp'
require 'githack/repositories/laravel'
require 'githack/repositories/rails'
require 'githack/repositories/symfony'
require 'githack/leak'

module Githack
  # Represent frameworks available to parse leaked data
  module Repositories
    # Get all class available as repository
    #
    # @return [Array<Class>]
    def self.get_availables_frameworks_versions
      available = []

      frameworks = Githack::Repositories.constants.select do |c|
        Githack::Repositories.const_get(c).is_a? Module
      end

      frameworks.each do |framework|
        framework_module = Githack::Repositories.const_get(framework)

        Githack::Repositories.const_get(framework).constants.each do |v|
          v_class = framework_module.const_get(v)
          available << v_class if v_class.is_a? Class
        end
      end

      available
    end

    # Get all class available as repository as pretty string
    #
    # @return [Array<String>]
    def self.get_availables_frameworks_versions_pretty
      Repositories.get_availables_frameworks_versions.map do |framework|
        framework.to_s.gsub('Githack::Repositories::', '')
      end.sort
    end
  end
end
