
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'us_passport_tracker/version'

Gem::Specification.new do |spec|
  spec.name          = 'us_passport_tracker'
  spec.version       = USPassportTracker::VERSION
  spec.authors       = ['Alfred Rowe']
  spec.email         = ['luvlyrowe@gmail.com']

  spec.summary       = 'USA VISA Readiness Status'
  spec.description   = 'Use this tool to check the status of your VISA & Passport collection after approval'
  spec.homepage      = 'https://github.com/nukturnal/us_passport_tracker'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.16'

  spec.add_runtime_dependency 'chromedriver-helper', '~> 1.2'
  spec.add_runtime_dependency 'selenium-webdriver', '~> 3.10'
  spec.add_runtime_dependency 'tty-font', '~> 0.2'
  spec.add_runtime_dependency 'tty-prompt', '~> 0.16'
  spec.add_runtime_dependency 'tty-spinner', '~> 0.8'
end
