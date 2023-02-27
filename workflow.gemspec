require_relative 'lib/workflow/version'

Gem::Specification.new do |spec|
  spec.name          = 'workflow'
  spec.version       = Workflow::VERSION
  spec.authors       = ['Tomas Landovsky']
  spec.email         = ['landovsky@gmail.com']

  spec.summary       = 'Workflow is a library for building complex business logic in a declarative way.'
  spec.description   = 'Workflow is a library for building complex business logic in a declarative way.'
  spec.homepage      = 'https://github.com/landovsky/workflow'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.add_dependency 'dry-schema', '1.10.2'
  spec.add_dependency 'dry-validation', '1.8.1'
  spec.add_dependency 'interactor', '~> 3.0'

  spec.add_development_dependency 'pry'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/landovsky/workflow'
  spec.metadata['changelog_uri'] = 'https://github.com/landovsky/workflow/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
