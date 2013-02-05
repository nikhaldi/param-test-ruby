Gem::Specification.new do |s|
  s.name        = 'param_test'
  s.version     = '0.0.2'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Nik Haldimann']
  s.email       = ['nhaldimann@gmail.com']
  s.homepage    = 'https://github.com/nikhaldi/param-test-ruby'
  s.summary     = 'Parameterized unit tests for Ruby/ActiveSupport'
  s.description = 'Parameterized unit tests for Ruby/ActiveSupport'

  s.add_runtime_dependency 'activesupport', '~> 3.2'
  s.add_development_dependency 'rake'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
