# frozen_string_literal: true

require_relative "lib/my_gem/version"

Gem::Specification.new do |spec|
  spec.name    = "my_gem"
  spec.version = MyGem::VERSION
  spec.authors = ["Your Name"]
  spec.email   = ["you@example.com"]

  spec.summary     = "A polished Ruby gem template with idiomatic structure and agent-friendly organisation."
  spec.description = <<~DESC
    my_gem is a template Ruby gem demonstrating idiomatic structure, YARD documentation,
    RSpec tests, Rubocop enforcement, and an agent-readable layout. Clone it, rename it,
    and ship.
  DESC
  spec.homepage = "https://github.com/your-org/my_gem"
  spec.license  = "MIT"

  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata = {
    "bug_tracker_uri"   => "#{spec.homepage}/issues",
    "changelog_uri"     => "#{spec.homepage}/blob/main/CHANGELOG.md",
    "documentation_uri" => "https://rubydoc.info/gems/my_gem",
    "homepage_uri"      => spec.homepage,
    "source_code_uri"   => spec.homepage,
    "rubygems_mfa_required" => "true"
  }

  # Automatically include all tracked files, excluding test/dev artefacts.
  spec.files = Dir.glob(%w[
    lib/**/*.rb
    *.md
    *.gemspec
    LICENSE.txt
  ]).reject { |f| f.match?(%r{^(test|spec|features)/}) }

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # ── Runtime dependencies ──────────────────────────────────────────────────
  # Add your actual runtime dependencies here, for example:
  # spec.add_dependency "faraday", "~> 2.0"

  # ── Development dependencies ──────────────────────────────────────────────
  spec.add_development_dependency "rake",    "~> 13.0"
  spec.add_development_dependency "rspec",   "~> 3.13"
  spec.add_development_dependency "rubocop", "~> 1.60"
  spec.add_development_dependency "rubocop-rspec", "~> 2.28"
  spec.add_development_dependency "rubocop-rake",  "~> 0.6"
  spec.add_development_dependency "yard",    "~> 0.9"
  spec.add_development_dependency "simplecov", "~> 0.22"
end
