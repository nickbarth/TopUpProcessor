# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "TopUp"
  spec.version = "1.0.0"
  spec.authors = ["Nick Barth"]
  spec.email = ["nickbarth@live.com"]

  spec.summary = "A gem to process user and company data."
  spec.description = "Processes JSON files of users and companies and creates an output.txt."
  spec.homepage = "https://github.com/nickbarth/TopUpProcessor/"
  spec.required_ruby_version = ">= 2.6.0"
  spec.license = "Unlicense"

  spec.files = Dir["lib/**/*.rb"]
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "standard", "~> 1.3"
end
