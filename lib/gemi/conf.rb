require 'fileutils'

module Gemi
  class Conf

    class GemircError < StandardError
      def initialize(attr)
        super("you must give '#{attr}' in your gemirc")
      end
    end

    def self.create
      unless File.exist?(GEMIRC)
        here = File.dirname(__FILE__)
        template_path = File.expand_path("../../gemirc.yml", here)
        FileUtils.cp(template_path, GEMIRC)
      end
    end

    def initialize(yaml_path)
      if yaml_path
        yaml = YAML.load_file(yaml_path)
        @rubys = parse_rubys(yaml["rubys"])
      else
        @rubys = [Ruby::Default]
      end
    end
    attr_reader :rubys

    private

    def parse_rubys(rubys)
      rubys.map{|ruby|
        name = ruby["name"]
        raise GemircError.new("name") unless name

        command = ruby["command"]
        raise GemircError.new("command") unless command

        gem_home = ruby["gem_home"]

        options = {
          :install => ruby["install_options"],
          :uninstall => ruby["uninstall_options"],
          :update => ruby["update_options"],
          :clean => ruby["clean_options"],
        }

        Ruby.new(name, command, gem_home, options)
      }
    end
  end
end
