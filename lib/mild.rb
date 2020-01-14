# frozen_string_literal: true

require_relative "mild/version"
require_relative "mild/github_client"
require_relative "mild/configuration"
require_relative "mild/command"
require_relative "mild/errors"

module Mild
  class << self
    attr_accessor :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def reset
      @configuration = Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
