PROJECT_NAME = "gemi"

begin
  require 'jeweler'
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

Jeweler::Tasks.new do |gemspec|
  gemspec.name = "#{PROJECT_NAME}"
  gemspec.summary = "gem command for multiple rubys"
  gemspec.email = "yutaka.hara/at/gmail.com"
  gemspec.homepage = "http://github.com/yhara/#{PROJECT_NAME}"
  gemspec.description = <<-EOD
  gemi runs 'gem install' for each your rubys.
  Example:
    without gemi:
    $ gem install foo bar
    $ gem-1.9 install foo bar
    with gemi:
    $ gemi foo bar
  EOD
  gemspec.authors = ["Yutaka HARA"]
  gemspec.add_development_dependency('cucumber', '>= 0.4.2')
  gemspec.add_development_dependency('kagemusha')
  gemspec.post_install_message = <<-EOD
    Thank you for installing gemi!
    The format of ~/.gemirc is changed in gemi 0.1.0.
    If you have been using gemi 0.0.x,
    please modify it (see gemirc.yml)
  EOD
end
