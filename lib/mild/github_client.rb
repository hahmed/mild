# frozen_string_literal: true

require "graphql/client"
require "graphql/client/http"

module Mild
  class GitHubClient
    API_ENDPOINT = "https://api.github.com/graphql"
    USER_AGENT   = "Ruby - Mild CLI"
    SCHEMA_PATH  = "data/schema.json"

    HTTPAdapter = GraphQL::Client::HTTP.new(API_ENDPOINT) do
      def headers(context)
        { 
          "User-Agent": USER_AGENT,
          "Authorization": "Bearer #{Mild.configuration.github_token}"
        }
      end
    end
    Schema = GraphQL::Client.load_schema(SCHEMA_PATH)
  end
end
