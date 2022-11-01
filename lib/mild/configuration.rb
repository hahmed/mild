# frozen_string_literal: true

module Mild
  class Configuration
    attr_accessor :github_token

    def initialize
      @github_token =  ENV['MILD_GITHUB_TOKEN']
    end
  end
end
