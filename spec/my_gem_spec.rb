# frozen_string_literal: true

require "spec_helper"

RSpec.describe MyGem do
  describe "::VERSION" do
    it "is a non-empty string" do
      expect(MyGem::VERSION).to be_a(String).and match(/\A\d+\.\d+\.\d+/)
    end
  end

  describe "::configuration" do
    it "returns a Configuration instance" do
      expect(MyGem.configuration).to be_a(MyGem::Configuration)
    end

    it "returns the same instance on repeated calls (memoised)" do
      expect(MyGem.configuration).to be(MyGem.configuration)
    end
  end

  describe "::configure" do
    it "yields the configuration object" do
      expect { |b| MyGem.configure(&b) }.to yield_with_args(MyGem::Configuration)
    end

    it "persists changes made in the block" do
      MyGem.configure { |c| c.timeout = 99 }
      expect(MyGem.configuration.timeout).to eq(99)
    end

    it "returns the configuration object" do
      result = MyGem.configure { |c| c.timeout = 1 }
      expect(result).to be_a(MyGem::Configuration)
    end
  end

  describe "::reset_configuration!" do
    it "returns a fresh Configuration with default values" do
      MyGem.configure { |c| c.timeout = 999 }
      MyGem.reset_configuration!
      expect(MyGem.configuration.timeout).to eq(10)
    end

    it "creates a new object (not the same reference)" do
      original = MyGem.configuration
      MyGem.reset_configuration!
      expect(MyGem.configuration).not_to be(original)
    end
  end
end
