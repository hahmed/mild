# frozen_string_literal: true

require "test_helper"

class Mild::GithubClientTest < Minitest::Test
  def setup
    Mild.configure do
      github_token = "123456789"
    end
  end

  def test_pr
    skip

    service = Mild::GitHubClient.new

    def service.query(*args)
      {

      }
    end

    refute_nil service.pull_requests_by_latest("rails", "rails", 10)
  end
end
