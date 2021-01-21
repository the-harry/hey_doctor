# frozen_string_literal: true

require_relative 'lib/stalker/version'

Gem::Specification.new do |spec|
  spec.name        = 'stalker'
  spec.version     = Stalker::VERSION
  spec.authors     = ['Matheus Acosta', 'Erick Nascimento']
  spec.email       = ['matheus.martins@deliverycenter.com',
                      'erick.nascimento@deliverycenter.com']
  spec.homepage    = 'https://github.com/deliverycenter/stalker'
  spec.summary     = 'A health check gem implementation in ruby.'
  spec.description = 'It mounts a endpoint to check the stack health.'
  spec.license     = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/deliverycenter/stalker'
  spec.metadata['changelog_uri'] = 'https://github.com/deliverycenter/stalker'

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile',
                   'README.md']
  spec.test_files = Dir['spec/**/*']

  spec.add_development_dependency 'dotenv-rails'
  spec.add_development_dependency 'redis'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'rubocop-rails'
  spec.add_development_dependency 'simplecov'

  spec.required_ruby_version = '>= 2.5.3'
  spec.add_dependency 'rails', '>= 4.2.10'
end
