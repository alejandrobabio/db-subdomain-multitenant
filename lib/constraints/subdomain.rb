module Constraints
  class Subdomain
    def initialize
      all_databases = Rails.application.config.database_configuration[Rails.env].keys
      @databases_names = all_databases.reject { |db| db =~ /(default|replica)/ }
    end

    def to_regexp
      Regexp.new("\\A(#{@databases_names.join('|')})\\z")
    end
  end
end
