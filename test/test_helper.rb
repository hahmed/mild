# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "minitest/autorun"
require "minitest/focus"

require "minitest/reporters"
Minitest::Reporters.use!(Minitest::Reporters::DefaultReporter.new)

require "mild"

def fixtures_path
  File.expand_path("fixtures", __dir__)
end

def fixture(name)
  name = "#{name}.json" unless name.end_with?(".json")
  File.read(File.join(fixtures_path, name))
end

class TestGitHubApi < Mild::GitHubApi
  class << self
    def query(definition, variables = {})
      name = definition.name.underscore.to_s.split("/").last
      result = JSON.parse fixture(name)
      result["data"]
    end
  end
end

Mild::BaseCommand.class_eval do
  alias_method :original_api, :api

  def api
    TestGitHubApi
  end
end