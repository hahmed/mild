# frozen_string_literal: true

require_relative "github_client"
require "graphql/client"

module Mild
  class GitHubApi
    class << self
      def pull_requests_by_latest(owner, repo, limit)
        data = query(pull_request_by_latest_query, owner: owner, name: repo, limit: limit)

        data["repository"]["pullRequests"]["nodes"].map do |pr|
          {
            id: pr["number"],  
            title: pr["title"],
            body: pr["body"],
            url: pr["url"],
            author: pr["author"]["login"],
            total_files_changed: pr["changedFiles"],
            additions: pr["additions"],
            deletions: pr["deletions"],
            total_changes: pr["additions"].to_i + pr["deletions"].to_i,
            created_at: pr["createdAt"],
            updated_at: pr["updatedAt"],
          }
        end
      end

      private

      def query(definition, variables = {})
        response = client.query(definition, variables: variables)

        if response.errors.any?
          raise Mild::Error::QueryError.new(response.errors[:data].join(", "))
        end

        response.original_hash["data"]
      end

      def pull_request_by_latest_query
        parsed = client.parse <<~GRAPHQL
        query($owner: String!, $name: String!, $limit: Int!) {
          repository(owner: $owner, name: $name) {
            description,
            pullRequests(last: $limit, states: [OPEN]) {
              nodes {
                additions,
                deletions,
                title,
                body,
                number,
                url,
                updatedAt,
                createdAt,
                changedFiles,
                author {
                  login
                }
              },
              totalCount
            }
          }
        }
        GRAPHQL

        const_set(:PullRequestByLatest, parsed)
      end

      def client
        @_client ||= begin
          GraphQL::Client.new(schema: Mild::GitHubClient::Schema, execute: Mild::GitHubClient::HTTPAdapter)
        end
      end
    end
  end
end
