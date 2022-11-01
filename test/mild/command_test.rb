# frozen_string_literal: true

require "test_helper"
require 'mild/command'

class Mild::CommandTest < Minitest::Test
  def test_outputs_default_message_when_no_args
    out, _ = capture_io do
      Mild::Command.run({})
    end
    assert_equal "Mild does not have a default command. Please run `mild help`\n", out
  end

  def test_outputs_no_command_message_when_no_command
    out, _ = capture_io do
      Mild::Command.run(%w[--help])
    end
    assert_equal "Command not found, try `mild help`\n", out
  end

  def test_outputs_no_command_message_when_random_command
    out, _ = capture_io do
      Mild::Command.run(%w[fresh])
    end
    assert_equal "Command not found, try `mild help`\n", out
  end

  def test_version_has_correct_version
    out, _ = capture_io do
      Mild::Command.run(%w[version])
    end
    assert_equal "#{Mild::VERSION}\n", out
  end

  def test_help_output_is_correct
    out, _ = capture_io do
      Mild::Command.run(%w[help])
    end
    assert_equal <<~EOF, out
      Welcome to mild, type in any of the commands below;
      `mild latest` - will show all the latest PRs
      `mild reviewed` - will show all PRs reviewed by you
    EOF
  end

  def test_mentioned_outputs_repo_error_message_when_no_repo_provided
    out, _ = capture_io do
      Mild::Command.run(%w[mentioned])
    end
    assert_equal generic_error_message, out
  end

  def test_mentioned_outputs_repo_error_message_when_repo_name_is_invalid
    out, _ = capture_io do
      Mild::Command.run(%w[mentioned 9rails])
    end
    assert_equal generic_error_message, out
  end

  def test_mentioned_outputs_pull_requests_correctly
    out, _ = capture_io do
      Mild::Command.run(%w[mentioned rails])
    end
    assert_includes out, "Add `ActionMailer.deprecator`"
    assert_includes out, "https://github.com/rails/rails/pull/46381"
  end

  def test_reviewed_outputs_repo_error_message_when_no_repo_provided
    out, _ = capture_io do
      Mild::Command.run(%w[reviewed])
    end
    assert_equal generic_error_message, out
  end

  def test_reviewed_outputs_repo_error_message_when_repo_name_is_invalid
    out, _ = capture_io do
      Mild::Command.run(%w[reviewed 9rails])
    end
    assert_equal generic_error_message, out
  end

  def test_reviewed_outputs_pull_requests_correctly
    out, _ = capture_io do
      Mild::Command.run(%w[reviewed rails])
    end
    assert_includes out, "Add `ActionMailer.deprecator`"
    assert_includes out, "https://github.com/rails/rails/pull/46381"
  end

  private

  def generic_error_message
    "Error accessing repo, or the name is an invalid format. Try `rails/rails` or `rails`\n"
  end
end
