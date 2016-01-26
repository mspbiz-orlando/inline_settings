$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "inline_settings/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "inline_settings"
  s.version     = InlineSettings::VERSION
  s.authors     = ["John Doe"]
  s.email       = ["johndoe@outlook.com"]
  s.homepage    = "http://www.google.com"
  s.summary     = "saves settings in a serialized db field"
  s.description = "saves settings in a serialized db field."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2"

  s.add_development_dependency "sqlite3"
end
