# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "anybase/version"

Gem::Specification.new do |s|
  s.name        = "anybase"
  s.version     = Anybase::VERSION
  s.authors     = ["Joshual Hull", "Brad Gessler"]
  s.email       = ["joshbuddy@gmail.com", "brad@bradgessler.com"]
  s.homepage    = "http://github.com/joshbuddy/anybase"
  s.summary     = %q{Numbers from anybase to anybase}
  s.description = %q{Numbers from anybase to anybase}

  s.rubyforge_project = "anybase"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
end