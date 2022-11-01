# frozen_string_literal: true

require_relative "base_command"

module Mild
  class Command::Version < BaseCommand
    def run(args)
      puts Mild::VERSION
    end
  end
end
