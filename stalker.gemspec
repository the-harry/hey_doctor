require_relative "lib/stalker/version"

Gem::Specification.new do |spec|
  spec.name        = "stalker"
  spec.version     = Stalker::VERSION
  spec.authors     = ["Matheus A Martins"]
  spec.email       = ["matheus.martins@deliverycenter.com"]
  spec.homepage    = "https://github.com/deliverycenter"
  spec.summary     = "A health check gem."
  spec.description = "It mounts a endpoint to check the stack health."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/deliverycenter"
  spec.metadata["changelog_uri"] = "https://github.com/deliverycenter"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  spec.test_files = Dir["spec/**/*"]

  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'dotenv-rails'
  spec.add_development_dependency 'redis'

  spec.add_dependency "rails", "~> 6.1.1"
end
