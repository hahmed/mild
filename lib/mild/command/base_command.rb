# frozen_string_literal: true

require "stringio"

module Mild
  class BaseCommand
    def api
      Mild::GitHubApi
    end
  end
end
