require_relative "lib/bullet_train/audit_logs/version"

Gem::Specification.new do |spec|
  spec.name = "bullet_train-audit_logs"
  spec.version = BulletTrain::AuditLogs::VERSION
  spec.authors = ["Andrew Culver", "Adam Pallozzi"]
  spec.email = ["andrew.culver@gmail.com", "adampallozzi@gmail.com"]
  spec.homepage = "https://github.com/andrewculver/bullet_train-audit_logs"
  spec.summary = "Bullet Train Audit Logs"
  spec.description = spec.summary
  spec.license = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 6.0"
  spec.add_dependency "paper_trail", ">= 14.0"
  spec.add_dependency "diffy", "~> 3.4"
end
