# agent-native-rubygem-template

> A polished Ruby gem template with idiomatic structure, RSpec tests, and agent-friendly organization — clone and ship.

---

## Why this exists

Most Ruby gem scaffolds (`bundle gem`) give you the bare minimum: a version file, a skeleton module, and a gemspec stub. That's fine for humans who fill in the blanks from memory — but it's a poor starting point for automated workflows or AI agents that need full, navigable context.

This template is **opinionated and complete**. Every file is present, every connection between files is explicit, and every public API is documented with YARD. An agent (or a human new to the codebase) can read any file, understand the whole picture, and extend the gem confidently without hunting for implicit conventions.

---

## What makes it interesting

| Feature | Details |
|---------|---------|
| **Idiomatic structure** | `lib/my_gem.rb` is the single entry point; sub-files are required explicitly and in dependency order |
| **YARD documentation** | All public classes, methods, and attributes carry `@param`, `@return`, and `@example` tags |
| **RSpec test suite** | Spec files mirror the lib tree; `spec_helper.rb` resets gem config before every example for full isolation |
| **Rubocop** | Configured with `rubocop-rspec` and `rubocop-rake` extensions; sensible relaxations for gem development |
| **Configuration class** | Typed `attr_accessor` fields with defaults and a `reset!` method — the pattern used by most production gems |
| **Error hierarchy** | `Error → ConfigurationError / NotFoundError` — easy to rescue at any granularity |
| **Abstract base class** | `MyGem::Base` with lifecycle hooks and a `#call` contract; ready for the command-pattern idiom |
| **Semantic versioning** | `VERSION` constant in its own file, referenced by the gemspec |
| **Keep a Changelog** | `CHANGELOG.md` with an Unreleased section and a release entry template |
| **Agent-readable layout** | No magic, no meta-programming — every dependency is explicit and grep-able |

---

## Quickstart

### 1 — Clone the template

```bash
git clone https://github.com/your-org/agent-native-rubygem-template my_new_gem
cd my_new_gem
```

### 2 — Rename the gem

Replace every occurrence of `my_gem` / `MyGem` with your gem name. A fast way:

```bash
GEM=awesome_tool
MODULE=AwesomeTool

# Rename files
mv lib/my_gem.rb         lib/${GEM}.rb
mv lib/my_gem            lib/${GEM}
mv my_gem.gemspec        ${GEM}.gemspec
mv spec/my_gem_spec.rb   spec/${GEM}_spec.rb
mv spec/my_gem           spec/${GEM}

# Replace content (macOS sed — remove '' on Linux)
find . -type f \( -name "*.rb" -o -name "*.gemspec" -o -name "*.md" -o -name "Rakefile" \) \
  -not -path "./.git/*" \
  -exec sed -i '' "s/my_gem/${GEM}/g; s/MyGem/${MODULE}/g" {} +
```

> **Tip for agents:** the string `my_gem` appears as a filename, a module name, a `require` argument, and in the gemspec `name` field. All four must be consistent.

### 3 — Install dependencies

```bash
bundle install
```

### 4 — Run tests and lint

```bash
bundle exec rake          # runs spec + rubocop (default task)
bundle exec rake spec     # tests only
bundle exec rake rubocop  # lint only
bundle exec rake ci       # full suite: spec + rubocop + yard docs
```

### 5 — Configure the gem

```ruby
require "my_gem"

MyGem.configure do |config|
  config.timeout     = 30
  config.retry_count = 5
  config.log_level   = :debug
end
```

---

## Example workflow

```ruby
require "my_gem"

# 1 — Configure once at startup
MyGem.configure do |c|
  c.timeout = 60
  c.strict_mode = true
end

# 2 — Subclass Base to implement behaviour
class MyGem::Greeter < MyGem::Base
  def call(name:)
    log "Greeting #{name}"
    "Hello, #{name}!"
  end
end

# 3 — Use it
result = MyGem::Greeter.new.call(name: "world")
puts result  # => "Hello, world!"

# 4 — Handle errors
begin
  MyGem::Greeter.new.call(name: nil)
rescue MyGem::Error => e
  puts "Caught: #{e.message}"
end
```

---

## File map

```
agent-native-rubygem-template/
├── lib/
│   ├── my_gem.rb                  # Entry point — requires everything, defines MyGem module
│   └── my_gem/
│       ├── version.rb             # MyGem::VERSION constant
│       ├── errors.rb              # Error, ConfigurationError, NotFoundError
│       ├── configuration.rb       # MyGem::Configuration with typed fields + defaults
│       └── base.rb                # Abstract MyGem::Base — subclass and implement #call
├── spec/
│   ├── spec_helper.rb             # RSpec config; resets gem state before each example
│   ├── my_gem_spec.rb             # Top-level gem API tests
│   └── my_gem/
│       └── configuration_spec.rb  # Configuration class tests
├── my_gem.gemspec                 # Gem metadata, runtime + dev dependencies
├── Gemfile                        # Points at gemspec; add local-only deps here
├── Rakefile                       # spec, rubocop, yard, ci tasks
├── .rubocop.yml                   # Rubocop config (rubocop-rspec, rubocop-rake)
├── .gitignore                     # Ruby / bundler / editor ignores
├── CHANGELOG.md                   # Keep a Changelog format; Unreleased section ready
├── CONTRIBUTING.md                # Dev setup, conventions, PR and release process
└── README.md                      # This file
```

---

## What this demonstrates

- **Idiomatic Ruby gem structure** following the conventions of gems like `faraday`, `dry-configurable`, and `zeitwerk`
- **Explicit requires** instead of autoload magic — every dependency is visible and grep-able
- **Configuration pattern** that is thread-safe for read-only access and testable via `reset!`
- **Error hierarchy** that lets callers rescue broadly (`MyGem::Error`) or narrowly (`MyGem::NotFoundError`)
- **Abstract base class** using Ruby's `NotImplementedError` convention instead of meta-programming
- **Full test isolation** — configuration is reset before every RSpec example
- **Agent-native organisation** — no hidden state, no surprise constant loading, no dynamic `method_missing` tricks

---

## Status

This is a **template / starting point**, not a published gem. The `my_gem` name is a placeholder. The code compiles and all tests pass, but the business logic is intentionally minimal — the value is in the structure and conventions, not in any particular feature.

To publish a real gem, you will need to:

1. Rename as described in the Quickstart above
2. Implement your actual logic in `lib/`
3. Update `AUTHORS`, `EMAIL`, `HOMEPAGE` in the gemspec
4. Set up `gem push` credentials (`gem signin` or `RUBYGEMS_API_KEY`)
5. Tag a release: `git tag v0.1.0 && git push --tags`
6. Run `gem build my_gem.gemspec && gem push my_gem-0.1.0.gem`

---

## License

Released under the [MIT License](LICENSE.txt). See that file for details.
