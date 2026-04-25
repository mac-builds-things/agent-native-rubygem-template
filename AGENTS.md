# AGENTS.md

## Purpose

This is a **template gem** — the first step in any new project is renaming it. See **CLAUDE.md → How to rename this gem** for the complete renaming procedure before adding any functionality.

## Setup

```
bundle install        # Install all dependencies
bundle exec rspec     # Run the test suite
```

All tests must pass before any PR is opened.

## Linting

```
bundle exec rubocop       # Check for offenses
bundle exec rubocop -a    # Auto-fix safe offenses
```

Every file must pass Rubocop with zero offenses before a PR is opened. Check `.rubocop.yml` for the active cops and any project-specific overrides.

## Gem structure

| File | Role |
|------|------|
| `lib/my_gem.rb` | Entry point — requires sub-files, exposes top-level API |
| `lib/my_gem/version.rb` | `VERSION` constant |
| `lib/my_gem/base.rb` | Core base class |
| `lib/my_gem/configuration.rb` | `MyGem::Configuration` — all user-facing settings live here |
| `lib/my_gem/errors.rb` | Custom error hierarchy rooted at `MyGem::Error` |

## Conventions

- **YARD docs** on all public API methods — no exceptions.
- **Tests mirror lib**: `lib/my_gem/foo.rb` → `spec/my_gem/foo_spec.rb`.
- **Custom errors** inherit from `MyGem::Error`, not `StandardError` directly.
- **Configuration** is accessed via `MyGem.configuration` — never a global or class variable.

## Where to look

- **CONTRIBUTING.md** — full development workflow, branching strategy, and release process.
- **CLAUDE.md** — rename procedure, command reference, and agent-specific guidance.
- **.rubocop.yml** — style rules; read before creating new files.

## Invariants

- `VERSION` in `lib/my_gem/version.rb` is the **single source of truth** for the gem version. Never hardcode version strings anywhere else.
- The gemspec reads `VERSION` from `version.rb` — keep that require in place.
