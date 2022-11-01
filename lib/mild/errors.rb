# frozen_string_literal: true

module Mild::Error
  # define base class for errors
  class MildError < StandardError
  end

  class QueryError < StandardError
  end

  class RepoError < MildError
    attr_accessor :repo_name

    def message
      if repo_name
        "Error accessing #{repo_name}"
      else
        "Error accessing repo, or the name is an invalid format. Try `rails/rails` or `rails`"
      end
    end
  end
end
