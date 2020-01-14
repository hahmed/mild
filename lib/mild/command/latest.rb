# frozen_string_literal: true

require_relative '../github_client'

module Mild
  class Command::Latest
    def run(args)
      owner, repo = Mild::RepoParser.extract_repo(args.shift)

      service = Mild::GitHubClient.new

      service.pull_requests_by_latest(owner, repo, 25).each do |issue|
        puts "#{issue[:title]}"
        puts "authored_by: #{issue[:author]}, #{issue[:url]}"
        puts "files changed: #{issue[:total_files_changed]}, total changes: #{issue[:total_changes]}\n\n"
      end
    end
  end
end
