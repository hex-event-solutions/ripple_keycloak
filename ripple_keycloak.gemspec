# frozen_string_literal: true

require_relative 'lib/ripple_keycloak/version'

Gem::Specification.new do |spec|
  spec.name          = 'ripple_keycloak'
  spec.version       = RippleKeycloak::VERSION
  spec.authors       = ['Hex Event Solutions Limited']
  spec.email         = ['ruby@hexes.co.uk']

  spec.summary       = "Ruby interface to Keycloak's admin API"
  spec.homepage      = 'https://rubygems.org/gems/ripple_keycloak'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/hex-event-solutions/ripple_keycloak'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency('activesupport', '6.0.3.1')
  spec.add_dependency('httparty', '0.18.1')

  spec.add_development_dependency('rspec', '3.9.0')
  spec.add_development_dependency('rubocop', '0.85.1')
end
