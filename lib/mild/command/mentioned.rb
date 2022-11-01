# frozen_string_literal: true
require_relative "base_command"

module Mild
  class Command::Mentioned < BaseCommand
    def run(args)
      owner, repo = Mild::RepoParser.extract_repo(args.shift)

      api.pull_requests_by_mentioned(owner, repo, 25).each do |data|
        puts "#{data[:title]}"
        puts "#{data[:url]}"
        puts "author: #{data[:author]}, total changes: #{data[:total_changes]}\n\n"
      end
    end
  end
end
