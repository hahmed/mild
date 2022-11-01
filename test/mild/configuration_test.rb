# frozen_string_literal: true

require "test_helper"
require 'mild/configuration'

class Mild::ConfigurationTest < Minitest::Test
  def setup
    Mild.configure do |config|
      config.github_token = "123456789"
    end
  end

  def reset
    Mild.configuration.reset
  end

  def test_that_it_has_github_token
    Mild.configure { |config| config.github_token = '1234567' }
    assert_equal "1234567", Mild.configuration.github_token
  end
end
