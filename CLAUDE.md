# CLAUDE.md

## Project

Ruby gem template (currently named `my_gem`). Rename it before building anything real — see **How to rename this gem** below.

Structure:

```
lib/my_gem.rb                  # Entry point — requires all sub-files, exposes top-level API
lib/my_gem/version.rb          # VERSION constant — single source of truth
lib/my_gem/base.rb             # Base class for the gem's core logic
lib/my_gem/configuration.rb    # Configuration class (MyGem::Configuration)
lib/my_gem/errors.rb           # Custom error hierarchy rooted at MyGem::Error
spec/                          # RSpec test suite mirroring lib/ structure
my_gem.gemspec                 # Gem specification
.rubocop.yml                   # Rubocop configuration
```

## Commands

```
bundle install            # Install dependencies
bundle exec rspec         # Run tests
bundle exec rubocop       # Run linter
bundle exec rubocop -a    # Auto-fix offenses
bundle exec rake          # Run default task (tests + lint)
```

## How to rename this gem

1. Find all files that need changes:
   ```
   grep -r "my_gem\|MyGem" --include="*.rb" --include="*.gemspec" -l
   ```
2. Rename: `my_gem.gemspec` → `your_gem.gemspec`
3. Rename: `lib/my_gem.rb` → `lib/your_gem.rb`, `lib/my_gem/` → `lib/your_gem/`
4. Rename: `spec/my_gem_spec.rb` → `spec/your_gem_spec.rb`, `spec/my_gem/` → `spec/your_gem/`
5. Global replace: `MyGem` → `YourGem`, `my_gem` → `your_gem`
6. Update gemspec: `name`, `summary`, `description`, `homepage`
7. Run `bundle exec rspec` to confirm everything passes

## Conventions

- All public methods must have YARD doc comments
- Use `module_function` or `attr_accessor` only for things that need to be public
- Custom errors inherit from `MyGem::Error`
- Configuration is always accessed via `MyGem.configuration` — never a global variable
- Test file mirrors lib file: `lib/my_gem/foo.rb` → `spec/my_gem/foo_spec.rb`

## Agent notes

- When adding new functionality, always add a test first.
- `MyGem::Configuration` is the canonical place to add configurable settings.
- If adding a new error type, add it to `lib/my_gem/errors.rb` and test it.
- Check `.rubocop.yml` before adding any new file — the cops define what's acceptable.
