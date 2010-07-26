require File.expand_path(File.join(File.dirname(__FILE__), 'lib', 'anybase', 'version'))

Gem::Specification.new do |s|
  s.name = "anybase"
  s.version = Anybase::Version

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Joshua Hull"]
  s.date = "2010-07-26"
  s.description = %q{Numbers from anybase to anybase}
  s.email = %q{joshbuddy@gmail.com}
  s.extra_rdoc_files = ['README.rdoc']
  s.files = `git ls-files`.split("\n")
  s.homepage = %q{http://github.com/joshbuddy/anybase}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Numbers from anybase to anybase}
  s.test_files = `git ls-files`.split("\n").select{|f| f[/^spec/]}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

