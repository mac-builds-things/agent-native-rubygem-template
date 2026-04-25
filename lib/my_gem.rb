# frozen_string_literal: true

require_relative "my_gem/version"
require_relative "my_gem/errors"
require_relative "my_gem/configuration"
require_relative "my_gem/base"

# MyGem is a template Ruby gem demonstrating idiomatic structure, YARD docs,
# RSpec tests, and agent-friendly organisation.
#
# == Quick start
#
#   MyGem.configure do |config|
#     config.timeout = 30
#   end
#
#   class MyGem::Greeter < MyGem::Base
#     def call(name:)
#       "Hello, #{name}!"
#     end
#   end
#
#   MyGem::Greeter.new.call(name: "world") #=> "Hello, world!"
#
# @see MyGem::Configuration for all configurable options
# @see MyGem::Base for the abstract base class
module MyGem
  class << self
    # Returns the global {Configuration} instance, initialising it lazily.
    #
    # @return [MyGem::Configuration]
    def configuration
      @configuration ||= Configuration.new
    end

    # Yields the global {Configuration} instance so callers can mutate it.
    #
    # @yieldparam config [MyGem::Configuration]
    # @return [MyGem::Configuration]
    #
    # @example
    #   MyGem.configure do |c|
    #     c.timeout = 60
    #     c.log_level = :debug
    #   end
    def configure
      yield configuration
      configuration
    end

    # Reset configuration to defaults. Primarily useful in test suites.
    #
    # @return [MyGem::Configuration]
    def reset_configuration!
      @configuration = Configuration.new
    end
  end
end
