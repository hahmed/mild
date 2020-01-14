# frozen_string_literal: true

module Mild
  class Configuration
    attr_accessor :github_token, :api_agent

    def initialize
      @github_token =  ENV['MILD_GITHUB_TOKEN']
      @api_agent    = "Mild - makes your pull requests a little easier"
    end
  end
end
