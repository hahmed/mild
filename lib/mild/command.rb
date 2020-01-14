# frozen_string_literal: true

require 'optparse'


module Mild
  class Command
    def self.run(args)
      args = args.dup

      if args.empty?
        puts <<~EOF
        Mild does not have a default command. Please run `mild help`
        EOF
      else
        command = args.shift.downcase.capitalize!
        if Mild::Command.const_defined?(command, false)
          klass = Mild::Command.const_get(command, false).new
          klass.run(args)
        else
          puts "Command not found, try `mild help`"
        end
      end
    rescue TypeError
      puts "Command not found, try `mild help`"
    rescue Mild::Error::MildError => e
      puts e.message
    end
  end
end

require_relative "command/help"
require_relative "command/latest"
require_relative "command/reviewed"
require_relative "command/version"
