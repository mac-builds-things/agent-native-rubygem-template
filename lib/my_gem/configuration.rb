# frozen_string_literal: true

module MyGem
  # Holds global configuration for the gem.
  #
  # Configure via the {MyGem.configure} block:
  #
  #   MyGem.configure do |config|
  #     config.timeout     = 30
  #     config.retry_count = 3
  #     config.logger      = Rails.logger
  #   end
  #
  # All options have sensible defaults so the gem works out of the box.
  class Configuration
    # @return [Integer] HTTP / operation timeout in seconds (default: 10)
    attr_accessor :timeout

    # @return [Integer] Number of retries on transient failures (default: 2)
    attr_accessor :retry_count

    # @return [Logger, nil] Logger instance; defaults to a standard STDOUT logger
    attr_accessor :logger

    # @return [Symbol] Log level — :debug, :info, :warn, :error (default: :info)
    attr_accessor :log_level

    # @return [Boolean] Whether to raise on non-fatal errors (default: false)
    attr_accessor :strict_mode

    # Initialise configuration with default values.
    def initialize
      @timeout     = 10
      @retry_count = 2
      @logger      = default_logger
      @log_level   = :info
      @strict_mode = false
    end

    # Reset all options to their original defaults.
    # Useful in test teardown.
    #
    # @return [self]
    def reset!
      initialize
      self
    end

    # Human-readable representation of current configuration.
    #
    # @return [String]
    def inspect
      "#<#{self.class.name} timeout=#{timeout} retry_count=#{retry_count} " \
        "log_level=#{log_level} strict_mode=#{strict_mode}>"
    end

    private

    def default_logger
      require "logger"
      logger = Logger.new($stdout)
      logger.progname = "MyGem"
      logger
    end
  end
end
