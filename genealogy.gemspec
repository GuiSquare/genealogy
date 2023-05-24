# frozen_string_literal: true

require_relative "lib/genealogy/version"

Gem::Specification.new do |spec|
  spec.name = "genealogy"
  spec.version = Genealogy::VERSION
  spec.authors = ["masciugo","kjakub"]
  spec.email = ["masciugo@gmail.com", "jakub.kuchar@hotmail.com"]

  spec.homepage      = "https://github.com/masciugo/genealogy"
  spec.summary       = "Make ActiveRecord model act as a pedigree"
  spec.description   = "Genealogy is a ruby gem library which extends ActiveRecord models in order to make its instances act as relatives so that you can build and query genealogies"

  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/masciugo/genealogy"
  spec.metadata["changelog_uri"] = "https://github.com/masciugo/genealogy"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  #spec.bindir = "exe"
  #spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  #spec.require_paths = ["lib"]

  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'debug'
  spec.add_development_dependency 'mysql2'
  spec.add_development_dependency 'pg'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'redcarpet'
  spec.add_development_dependency 'github-markup'
  spec.add_development_dependency 'gem-release'
  spec.add_development_dependency 'appraisal'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end