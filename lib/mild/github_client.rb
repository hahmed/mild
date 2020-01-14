# frozen_string_literal: true

require "graphql/client"
require "graphql/client/http"
require "mild"

module Mild
  class GitHubClient
    def pull_requests_by_latest(owner, repo, limit)
      pull_request_to_hash query(Query::PullRequestByLatest, owner: owner, name: repo, limit: limit)
    end

    private

    HTTPAdapter = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
      def headers(context)
        { "User-Agent": Mild.configuration.api_agent, "Authorization": "Bearer #{Mild.configuration.github_token}" }
      end
    end
    Schema = GraphQL::Client.load_schema("github/schema.json")
    Client = GraphQL::Client.new(schema: Schema, execute: HTTPAdapter)

    def query(definition, variables = {})
     response = Client.query(definition, variables: variables)

     if response.errors.any?
       # TODO: raising an error here is cruel
       raise "error" #response.errors[:data].join(", "))
     else
       # NOTE: graphql should have parsed this response
       response.original_hash["data"]["repository"]
     end
    end

    def pull_request_to_hash(graphql_response)
      graphql_response["pullRequests"]["nodes"].each.map do |pr|
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

    module Query
      PullRequestByLatest = Client.parse <<-GRAPHQL
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
    end
  end
end
