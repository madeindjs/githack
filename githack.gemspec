
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'githack/version'

Gem::Specification.new do |spec|
  spec.name          = 'githack'
  spec.version       = Githack::VERSION
  spec.authors       = ['Rousseau Alexandre']
  spec.email         = ['contact@rousseau-alexandre.Fr']

  spec.summary       = "Crawl git's commits of a given repository to find forgotten credentials"
  spec.description   = "Crawl git's commits of a given repository to find forgotten credentials"
  spec.homepage      = 'https://github.com/madeindjs/githack'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org/'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = ['githack.rb']
  spec.require_paths = ['lib']

  spec.add_dependency 'git', '~> 1.5'
  spec.add_dependency 'tty-spinner', '~> 0.8'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
