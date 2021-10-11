class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  keys = Rails.application.config.database_configuration[Rails.env].keys
  db_configs = keys.each_with_object({}) do |key, configs|
    db_key = key.gsub('_replica', '')
    role = key.eql?(db_key) ? :writing : :reading

    db_key = db_key.to_sym
    configs[db_key] ||= {}

    configs[db_key][role] = key.to_sym
  end

  connects_to shards: db_configs
end
