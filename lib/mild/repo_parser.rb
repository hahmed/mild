# frozen_string_literal: true

require_relative 'errors'

module Mild::RepoParser
  def self.extract_repo(repo_name)
    error = Mild::Error::RepoError.new
    raise error unless repo_name

    raise error unless repo_name.start_with?(/[a-zA-Z]/)

    if repo_name.include?("/")
      repo_name.split("/")[0..1]
    else
      [repo_name, repo_name]
    end
  end
end
