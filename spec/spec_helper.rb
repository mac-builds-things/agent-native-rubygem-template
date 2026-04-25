# frozen_string_literal: true

require "my_gem"

RSpec.configure do |config|
  # Use only the `expect` syntax; disable `should` to keep specs clean.
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    expectations.syntax = :expect
  end

  # Prefer the newer message-expectation syntax.
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # Share example groups across spec files using `include_context`.
  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Run specs in a random order to surface order-dependency bugs.
  config.order = :random
  Kernel.srand config.seed

  # Reset gem configuration before each test so tests are fully isolated.
  config.before(:each) do
    MyGem.reset_configuration!
  end

  # Show the slowest examples to help identify performance bottlenecks.
  config.profile_examples = 5 if ENV["PROFILE"]

  # Allow filtering with focus: true / fdescribe / fit.
  config.filter_run_when_matching :focus
end
