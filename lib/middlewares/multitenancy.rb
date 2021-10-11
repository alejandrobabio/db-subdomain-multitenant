# frozen_string_literal: true

require_relative '../constraints/subdomain.rb'

module Middlewares
  class Multitenancy
    def initialize(app)
      @app = app
    end

    def call(env)
      subdomain = ActionDispatch::Request.new(env).subdomain

      return @app.call(env) unless subdomain =~ Constraints::Subdomain.new.to_regexp

      ApplicationRecord.connected_to(role: :writing, shard: subdomain.to_sym) do
        @app.call(env)
      end
    end
  end
end
