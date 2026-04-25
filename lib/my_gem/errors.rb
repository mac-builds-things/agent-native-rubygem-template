# frozen_string_literal: true

module MyGem
  # Base error class for all MyGem exceptions.
  # Rescue this to catch any gem-specific error.
  #
  # @example Rescuing all gem errors
  #   begin
  #     MyGem.do_something_risky
  #   rescue MyGem::Error => e
  #     puts "MyGem failed: #{e.message}"
  #   end
  class Error < StandardError; end

  # Raised when the gem is misconfigured.
  #
  # @example
  #   raise MyGem::ConfigurationError, "api_key is required"
  class ConfigurationError < Error; end

  # Raised when a requested resource cannot be found.
  #
  # @example
  #   raise MyGem::NotFoundError, "record with id=42 not found"
  class NotFoundError < Error; end
end
