# frozen_string_literal: true

module Mild
  class Command::Version
    def run(args)
      puts Mild::VERSION
    end
  end
end
