$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "documentation/rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "documentation-rails"
  s.version     = DocumentationRails::VERSION
  s.authors     = ["Justin Smestad"]
  s.email       = ["justin.smestad@gmail.com"]
  s.homepage    = "https://github.com/jsmestad/documentation-rails"
  s.summary     = "Summary of DocumentationRails."
  s.description = "Description of DocumentationRails."

  s.files = Dir["{app,config,db,lib,vendor}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 3.1", "< 7.0"
  s.add_dependency "coderay"
  s.add_dependency "tilt"
  s.add_dependency "redcarpet", "~> 2.1.0"

  s.add_development_dependency "jquery-rails"
  s.add_development_dependency "sqlite3"
end
