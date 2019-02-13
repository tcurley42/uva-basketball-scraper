
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "uva_basketball/version"

Gem::Specification.new do |spec|
  spec.name          = "uva_basketball"
  spec.version       = UvaBasketball::VERSION
  spec.authors       = ["Tommy Curley"]
  spec.email         = ["thomas.curley93@gmail.com"]

  spec.summary       = "This is a gem to interact with UVA Basketball"
  spec.description   = "This is a gem to interact with UVA Basketball"
  spec.homepage      = "https://github.com/tcurley42/uva-basketball-scraper"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"

  # Why do we need to add these if they're already required?
  spec.add_dependency "nokogiri"
  spec.add_dependency "colorize"
end
