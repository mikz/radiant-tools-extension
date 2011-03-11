# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "radiant_tools"


Gem::Specification.new do |s|
  s.name        = 'radiant-tools-extension'
  s.version     = RadiantTools::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["mikz"]
  s.email       = ["mikz@o2h.cz"]
  s.homepage    = 'http://github.com/mikz/radiant-tools-extension'
  s.summary     = %q{Various tools (method, tags) for Radiant projects}
#  s.description = %q{}
  s.require_paths = ['lib']

  #s.rubyforge_project = "radiant_tools"
  s.add_dependency 'rack-rewrite', '~> 1.1.0'
  s.add_dependency 'radiant', '~> 0.9.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
