# frozen_string_literal: true

require_relative "github_client"
require "graphql/client"

module Mild
  class GitHubApi
    class << self
      def pull_requests_by_reviewed(owner, repo, limit)
        query = "type:pr state:open review-requested:$viewer repo:#{owner}/#{name}"
        data = query(pull_request_by_reviewed_query, query: query, limit: limit)

        map_data(data)
      end

      def pull_requests_by_mentioned(owner, repo, limit)
        query = "type:pr state:open mentioned:$viewer repo:#{owner}/#{name}"
        data = query(pull_requests_by_mentioned_query, query: query, limit: limit)

        map_data(data)
      end

      private

      def query(definition, variables = {})
        response = client.query(definition, variables: variables)

        if response.errors.any?
          raise Mild::Error::QueryError.new(response.errors[:data].join(", "))
        end

        response.original_hash["data"]
      end

      def graphql_base_query
        <<~GRAPHQL
        query($query: String!, $limit: Int!) {
          search(query: $query, type: ISSUE, first: $limit) {
            issueCount
            edges {
              node {
                ... on PullRequest {
                  title
                  url
                  createdAt
                  updatedAt
                  additions
                  deletions
                  author {
                    login
                  }
                }
              }
            }
          }
        }
        GRAPHQL
      end

      def pull_request_by_reviewed_query
        parsed = client.parse graphql_base_query

        const_set(:PullRequestsByReviewed, parsed)
      end

      def pull_requests_by_mentioned_query
        parsed = client.parse graphql_base_query

        const_set(:PullRequestsByMentioned, parsed)
      end

      def map_data(data)
        data["repository"]["pullRequests"]["nodes"].map do |pr|
          {
            title: pr["title"],
            url: pr["url"],
            author: pr["author"]["login"],
            total_changes: pr["additions"].to_i + pr["deletions"].to_i,
            created_at: pr["createdAt"],
            updated_at: pr["updatedAt"],
          }
        end
      end

      def client
        @_client ||= begin
          GraphQL::Client.new(schema: Mild::GitHubClient::Schema, execute: Mild::GitHubClient::HTTPAdapter)
        end
      end
    end
  end
end
