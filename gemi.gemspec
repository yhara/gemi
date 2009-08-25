# -*- encoding: utf-8 -*-


Gem::Specification.new do |s|
  s.name = %q{gemi}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Yutaka HARA"]
  s.date = %q{2009-08-25}
  s.default_executable = %q{gemi}
  s.description = %q{Installing gems for multiple rubys}
  s.email = %q{yutaka.hara/at/gmail.com}
  s.executables = ["gemi"]
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    "README",
     "Rakefile",
     "VERSION",
     "bin/gemi",
     "gemi.gemspec",
     "gemirc.yml"
  ]
  s.homepage = %q{http://github.com/yhara/gemi}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Installing gems for multiple rubys}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
