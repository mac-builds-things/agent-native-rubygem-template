# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial gem scaffold: `MyGem::Configuration`, `MyGem::Base`, `MyGem::Error` hierarchy
- Global `MyGem.configure` / `MyGem.reset_configuration!` API
- RSpec test suite with isolated per-test configuration resets
- Rubocop configuration (rubocop-rspec, rubocop-rake extensions)
- YARD documentation for all public classes and methods
- `Rakefile` with `spec`, `rubocop`, `yard`, and `ci` tasks
- `CONTRIBUTING.md` covering dev setup, coding conventions, and release process
- `CHANGELOG.md` (this file) following Keep a Changelog format

---

<!-- next release entry goes here — copy the template below -->

<!--
## [X.Y.Z] — YYYY-MM-DD

### Added
- …

### Changed
- …

### Deprecated
- …

### Removed
- …

### Fixed
- …

### Security
- …
-->

[Unreleased]: https://github.com/your-org/my_gem/compare/HEAD...HEAD
