# frozen_string_literal: true
require_relative "base_command"

module Mild
  class Command::Latest < BaseCommand
    def run(args)
      owner, repo = Mild::RepoParser.extract_repo(args.shift)

      api.pull_requests_by_latest(owner, repo, 25).each do |issue|
        puts "#{issue[:title]}"
        puts "authored_by: #{issue[:author]}, #{issue[:url]}"
        puts "files changed: #{issue[:total_files_changed]}, total changes: #{issue[:total_changes]}\n\n"
      end
    end
  end
end
