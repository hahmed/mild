# frozen_string_literal: true

require_relative "base_command"

module Mild
  class Command::Help < BaseCommand
    def run(args)
      puts <<~EOF
      Welcome to mild, type in any of the commands below;
      `mild latest` - will show all the latest PRs
      `mild reviewed` - will show all PRs reviewed by you
      EOF
    end
  end
end
