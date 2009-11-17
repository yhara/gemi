module Gemi
  GEMIRC = File.expand_path("~/.gemirc")
  REXP_YAML = /.ya?ml\z/i

  class Error < StandardError; end
end

require 'gemi/commands.rb'
require 'gemi/conf.rb'
require 'gemi/gem.rb'
require 'gemi/options.rb'
require 'gemi/ruby.rb'
require 'gemi/runner.rb'

