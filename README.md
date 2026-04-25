# agent-native-rubygem-template

![Ruby](https://img.shields.io/badge/ruby-%3E%3D_3.1-red) ![RSpec](https://img.shields.io/badge/tested_with-rspec-green) ![License](https://img.shields.io/badge/license-MIT-blue)

A minimal, production-ready Ruby gem scaffold with RSpec, RuboCop, and YARD wired up.

## Renaming the gem

Clone the repo, then replace every occurrence of the template name with your gem name:

```bash
GEM=your_gem_name

# Rename files and directories
find . -depth -name '*agent_native_rubygem_template*' \
  | sort -r \
  | while read f; do
      mv "$f" "$(echo "$f" | sed "s/agent_native_rubygem_template/${GEM}/g")"
    done

# Replace content references
find . -type f \( -name '*.rb' -o -name '*.gemspec' -o -name '*.md' -o -name 'Rakefile' \) \
  | xargs sed -i '' "s/agent_native_rubygem_template/${GEM}/g"
find . -type f \( -name '*.rb' -o -name '*.gemspec' -o -name '*.md' -o -name 'Rakefile' \) \
  | xargs sed -i '' "s/AgentNativeRubygemTemplate/$(echo $GEM | sed 's/_\([a-z]\)/\U\1/g;s/^\([a-z]\)/\U\1/g')/g"
```

Then update `lib/your_gem_name/version.rb` and the gemspec `authors`, `email`, and `summary` fields.

## Setup

```bash
bundle install
bundle exec rspec          # run tests
bundle exec rubocop        # lint
bundle exec rake yard      # generate docs
```

## Structure

```
.
├── lib/
│   └── agent_native_rubygem_template/
│       ├── version.rb          # gem version constant
│       └── ...                 # your source files
├── spec/
│   ├── spec_helper.rb          # RSpec + SimpleCov config
│   └── agent_native_rubygem_template/
│       └── ...                 # mirrors lib/ layout
├── agent_native_rubygem_template.gemspec
└── Rakefile                    # default task runs RSpec + RuboCop
```

## Extending

- **Add a feature** — drop a new file under `lib/agent_native_rubygem_template/` and `require` it in `lib/agent_native_rubygem_template.rb`.
- **Add a test** — mirror the lib path under `spec/` and inherit from the project's shared contexts in `spec/spec_helper.rb`.
- **Document it** — annotate with YARD tags (`@param`, `@return`, `@example`) and run `bundle exec rake yard` to regenerate.

## Releasing

1. Bump `VERSION` in `lib/agent_native_rubygem_template/version.rb`.
2. Update `CHANGELOG.md` with the new version and release date.
3. `bundle exec rake release` — tags the commit, builds the gem, and pushes to RubyGems.

---

MIT License
