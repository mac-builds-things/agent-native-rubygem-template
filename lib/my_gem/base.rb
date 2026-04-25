# frozen_string_literal: true

module MyGem
  # Base class that concrete implementations should inherit from.
  #
  # Provides shared lifecycle hooks, configuration access, and a minimal
  # interface contract that subclasses are expected to fulfil.
  #
  # @abstract Subclass and implement {#call} to define behaviour.
  #
  # @example Defining a subclass
  #   class MyGem::Greeter < MyGem::Base
  #     def call(name:)
  #       "Hello, #{name}!"
  #     end
  #   end
  #
  #   greeter = MyGem::Greeter.new
  #   greeter.call(name: "Alice") #=> "Hello, Alice!"
  class Base
    # @return [MyGem::Configuration] the active configuration snapshot
    attr_reader :config

    # Create a new instance, optionally overriding the global configuration.
    #
    # @param config [MyGem::Configuration, nil] explicit config; falls back to
    #   {MyGem.configuration} when nil
    def initialize(config: nil)
      @config = config || MyGem.configuration
    end

    # Execute the primary action of this object.
    #
    # @abstract
    # @raise [NotImplementedError] when the subclass has not implemented this method
    def call(*)
      raise NotImplementedError, "#{self.class}#call is not implemented"
    end

    # Returns a concise string representation useful for debugging.
    #
    # @return [String]
    def inspect
      "#<#{self.class.name}>"
    end

    private

    # Convenience accessor for the configured logger.
    #
    # @return [Logger]
    def logger
      config.logger
    end

    # Log at the configured log level.
    #
    # @param message [String] the message to log
    # @return [void]
    def log(message)
      logger.public_send(config.log_level, message)
    end
  end
end
