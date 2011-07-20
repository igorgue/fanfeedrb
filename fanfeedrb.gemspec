# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "fanfeedrb"
  s.version     = "0.0.2"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matthew Jording"]
  s.email       = ["mjording@opengotham.com"]
  s.homepage    = "http://iequalsi.com"
  s.summary     = %q{Ruby implementation of the FanFeedr api}
  s.description = %q{Ruby implementation of the FanFeedr api}
  s.add_dependency('rake')
  s.add_dependency('crack')
  s.add_dependency('rspec')
  s.add_dependency('fakeweb')
  s.add_dependency('json')
  s.rubyforge_project = "fanfeedrb"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
