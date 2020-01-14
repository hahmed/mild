# frozen_string_literal: true

require "test_helper"
require 'mild/repo_parser'
require 'mild/errors'

class Mild::RepoParserTest < Minitest::Test
  def test_invalid_name_throws
    assert_raises Mild::Error::RepoError do
      Mild::RepoParser.extract_repo(nil)
    end
  end

  def test_non_word_start_char_throws
    assert_raises Mild::Error::RepoError do
      Mild::RepoParser.extract_repo("--help")
    end
  end

  def test_rails_expands_to_rails_rails
    assert_equal ["rails", "rails"], Mild::RepoParser.extract_repo("rails")
  end

  def test_repo_and_owner_parses_correctly
    assert_equal ["rails", "webpacker"], Mild::RepoParser.extract_repo("rails/webpacker")
  end
end
