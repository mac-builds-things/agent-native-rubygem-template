# frozen_string_literal: true

require "spec_helper"

RSpec.describe MyGem::Configuration do
  subject(:config) { described_class.new }

  describe "defaults" do
    it "sets timeout to 10" do
      expect(config.timeout).to eq(10)
    end

    it "sets retry_count to 2" do
      expect(config.retry_count).to eq(2)
    end

    it "sets log_level to :info" do
      expect(config.log_level).to eq(:info)
    end

    it "sets strict_mode to false" do
      expect(config.strict_mode).to be(false)
    end

    it "provides a Logger for logger" do
      expect(config.logger).to be_a(Logger)
    end
  end

  describe "#timeout=" do
    it "accepts a new integer value" do
      config.timeout = 30
      expect(config.timeout).to eq(30)
    end
  end

  describe "#retry_count=" do
    it "accepts a new integer value" do
      config.retry_count = 5
      expect(config.retry_count).to eq(5)
    end
  end

  describe "#log_level=" do
    it "accepts a symbol" do
      config.log_level = :debug
      expect(config.log_level).to eq(:debug)
    end
  end

  describe "#strict_mode=" do
    it "can be toggled to true" do
      config.strict_mode = true
      expect(config.strict_mode).to be(true)
    end
  end

  describe "#logger=" do
    it "accepts a custom logger" do
      custom = Logger.new(File::NULL)
      config.logger = custom
      expect(config.logger).to be(custom)
    end
  end

  describe "#reset!" do
    it "restores all values to defaults" do
      config.timeout     = 999
      config.retry_count = 99
      config.log_level   = :error
      config.strict_mode = true

      config.reset!

      aggregate_failures do
        expect(config.timeout).to eq(10)
        expect(config.retry_count).to eq(2)
        expect(config.log_level).to eq(:info)
        expect(config.strict_mode).to be(false)
      end
    end

    it "returns self for chaining" do
      expect(config.reset!).to be(config)
    end
  end

  describe "#inspect" do
    it "includes the class name and key attributes" do
      result = config.inspect
      expect(result).to include("MyGem::Configuration")
        .and include("timeout=")
        .and include("retry_count=")
        .and include("strict_mode=")
    end
  end
end
