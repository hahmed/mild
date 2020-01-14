# frozen_string_literal: true

require "test_helper"
require 'mild/configuration'

class Mild::ConfigurationTest < Minitest::Test
  def test_that_it_has_api_agent
    assert_equal "Mild - makes your pull requests a little easier", Mild::Configuration.new.api_agent
  end

  def test_that_it_has_github_token
    Mild.configure { |config| config.github_token = '1234567' }
    assert_equal "1234567", Mild.configuration.github_token
  end
end
