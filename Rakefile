# frozen_string_literal: true

require "rake"

# ── RSpec ─────────────────────────────────────────────────────────────────────
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern    = "spec/**/*_spec.rb"
  t.rspec_opts = "--format documentation --color"
end

# ── Rubocop ───────────────────────────────────────────────────────────────────
require "rubocop/rake_task"

RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = ["--display-cop-names"]
end

RuboCop::RakeTask.new("rubocop:auto_correct") do |t|
  t.options = ["--autocorrect"]
end

# ── YARD docs ─────────────────────────────────────────────────────────────────
begin
  require "yard"
  YARD::Rake::YardocTask.new(:yard) do |t|
    t.files   = ["lib/**/*.rb"]
    t.options = ["--output-dir", "doc/api", "--markup", "markdown"]
  end
rescue LoadError
  desc "Generate YARD docs (yard gem not available)"
  task :yard do
    warn "Install the yard gem to generate documentation"
  end
end

# ── Defaults ─────────────────────────────────────────────────────────────────
desc "Run specs and Rubocop (default CI task)"
task default: %i[spec rubocop]

desc "Run specs only"
task test: :spec

desc "Run full CI suite: specs + lint + docs"
task ci: %i[spec rubocop yard]
