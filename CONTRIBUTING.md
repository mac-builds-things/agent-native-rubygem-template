# Contributing

Thank you for your interest in contributing. This document covers everything you need to get started — from setting up your local environment to opening a pull request.

---

## Table of Contents

1. [Development Setup](#development-setup)
2. [Renaming the Gem](#renaming-the-gem)
3. [Coding Conventions](#coding-conventions)
4. [Adding a Feature](#adding-a-feature)
5. [Release Process](#release-process)
6. [Pull Request Process](#pull-request-process)

---

## Development Setup

### Prerequisites

- **Ruby** — see `.ruby-version` for the required version. We recommend managing Ruby with [rbenv](https://github.com/rbenv/rbenv) or [asdf](https://asdf-vm.com/).
- **Bundler** — install with `gem install bundler` if not already present.

### Clone and install dependencies

```bash
git clone https://github.com/your-org/your-gem.git
cd your-gem
bundle install
```

### Run the test suite

```bash
bundle exec rspec
```

All tests should pass on a clean checkout. If anything is red before you make changes, please open an issue.

### Run the linter

```bash
bundle exec rubocop
```

The project ships with a `.rubocop.yml` that defines the house style. Fix any offenses before opening a pull request. You can auto-correct safe offenses with:

```bash
bundle exec rubocop -A
```

---

## Renaming the Gem

This template uses `my_gem` as a placeholder name. Follow the steps below to rename it to match your project.

### 1. Choose your new name

Pick a gem name that follows RubyGems conventions: lowercase letters, digits, and underscores only. We'll use `awesome_tool` as the example throughout.

### 2. Rename the gemspec

```bash
mv my_gem.gemspec awesome_tool.gemspec
```

### 3. Rename the main library file

```bash
mv lib/my_gem.rb lib/awesome_tool.rb
```

### 4. Rename the library directory

```bash
mv lib/my_gem lib/awesome_tool
```

### 5. Update the module name and all internal references

Use `sed` to do a project-wide find-and-replace (macOS/BSD `sed` requires an empty string after `-i`):

```bash
# Replace the Ruby constant (MyGem -> AwesomeTool)
find . -type f \( -name "*.rb" -o -name "*.gemspec" -o -name "*.md" \) \
  -not -path "./.git/*" \
  -exec sed -i '' 's/MyGem/AwesomeTool/g' {} +

# Replace the snake_case identifier (my_gem -> awesome_tool)
find . -type f \( -name "*.rb" -o -name "*.gemspec" -o -name "*.md" \) \
  -not -path "./.git/*" \
  -exec sed -i '' 's/my_gem/awesome_tool/g' {} +
```

On Linux, omit the empty string after `-i`:

```bash
find . -type f \( -name "*.rb" -o -name "*.gemspec" -o -name "*.md" \) \
  -not -path "./.git/*" \
  -exec sed -i 's/MyGem/AwesomeTool/g; s/my_gem/awesome_tool/g' {} +
```

### 6. Verify the rename

```bash
# Spot-check for any remaining occurrences of the old name
grep -r "my_gem\|MyGem" . --include="*.rb" --include="*.gemspec" --include="*.md" \
  --exclude-dir=".git"

bundle exec rspec
bundle exec rubocop
```

Fix any remaining occurrences that the automated replace missed (e.g. inline comments or README prose).

---

## Coding Conventions

### Style

All Ruby code must pass `bundle exec rubocop` without offenses. The `.rubocop.yml` at the project root is the authoritative style guide. When in doubt, keep things simple and consistent with the surrounding code.

### Documentation

Every public method and class must have a [YARD](https://yardoc.org/) doc comment. At a minimum, include:

- A one-line summary.
- `@param` tags for each parameter (with type and description).
- `@return` tag (with type and description).
- `@raise` tags for any documented exceptions.

```ruby
# Computes the checksum of the given data.
#
# @param data [String] the raw bytes to checksum
# @return [String] hexadecimal checksum string
# @raise [ArgumentError] if +data+ is nil
def checksum(data)
  raise ArgumentError, "data must not be nil" if data.nil?
  Digest::SHA256.hexdigest(data)
end
```

### Tests

- All new code must be covered by RSpec examples.
- Prefer unit tests over integration tests where possible.
- Use descriptive `describe` / `context` / `it` blocks so failures are self-explanatory.
- Avoid stubbing internals of the subject under test; test through the public interface.

### No monkey-patching

Do not reopen core Ruby classes (`String`, `Array`, `Integer`, etc.) or classes from third-party gems. If you need additional behaviour, use a module that the caller explicitly includes, or a plain wrapper class.

---

## Adding a Feature

1. **Create a branch** off `main` with a descriptive name:

   ```bash
   git checkout -b feature/add-retry-logic
   ```

2. **Write failing tests first.** Add your RSpec examples and confirm they fail before touching implementation code:

   ```bash
   bundle exec rspec spec/path/to/your_spec.rb
   ```

3. **Implement** the feature until the tests go green.

4. **Run the full test suite** to make sure nothing regressed:

   ```bash
   bundle exec rspec
   ```

5. **Run the linter:**

   ```bash
   bundle exec rubocop
   ```

6. **Commit your changes** with a clear, imperative message:

   ```bash
   git commit -m "Add retry logic with configurable backoff"
   ```

7. **Push your branch** and open a pull request against `main`.

---

## Release Process

Releases are made from `main`. Only maintainers with RubyGems push access should perform a release.

### 1. Bump the version

Edit `lib/my_gem/version.rb` (or the renamed equivalent) and increment the version following [Semantic Versioning](https://semver.org/):

```ruby
module MyGem
  VERSION = "1.2.0"  # was "1.1.0"
end
```

### 2. Update CHANGELOG.md

Add a section for the new version at the top of `CHANGELOG.md`. Follow the [Keep a Changelog](https://keepachangelog.com/) format:

```markdown
## [1.2.0] - 2026-04-24

### Added
- Retry logic with configurable exponential backoff (#42)

### Fixed
- Nil guard in checksum helper (#38)
```

### 3. Commit the version bump

```bash
git add lib/my_gem/version.rb CHANGELOG.md
git commit -m "Release version 1.2.0"
```

### 4. Build and publish

```bash
bundle exec rake release
```

This task (provided by `bundler/gem_tasks`) will:

- Build the `.gem` file.
- Create a git tag (`v1.2.0`).
- Push the tag to the remote.
- Push the gem to [RubyGems.org](https://rubygems.org).

---

## Pull Request Process

- **Description** — briefly explain *what* changed and *why*. Link to any related issues with `Closes #N` or `Refs #N`.
- **Small and focused** — one logical change per PR. Large diffs are hard to review; split unrelated changes into separate PRs.
- **Tests** — all existing and new tests must pass (`bundle exec rspec`).
- **Linter** — the Rubocop check must be clean (`bundle exec rubocop`).
- **Approval** — at least one maintainer approval is required before merging.
- **Merge strategy** — maintainers will squash-merge feature branches to keep the history linear. Make sure your PR title is a good summary of the squashed commit.

If you are unsure whether a change is in scope, open an issue first to discuss the idea before investing time in an implementation.

---

Thank you for helping make this project better.
