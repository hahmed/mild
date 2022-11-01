# frozen_string_literal: true

require_relative "mild/version"
require_relative "mild/github_api"
require_relative "mild/github_client"
require_relative "mild/configuration"
require_relative "mild/command"
require_relative "mild/errors"

module Mild
  class << self
    def configuration
      @_config ||= Configuration.new
    end

    def reset
      @_config = Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
