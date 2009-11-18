module Gemi
  class Options

    class YamlGivenError < Gemi::Error; end

    def self.parse(argv)
      new(argv)
    end

    def initialize(argv)
      @confpath, @type, @gem_names, @yamls = parse(argv)
    end
    attr_reader :confpath, :type, :gem_names, :yamls

    def empty?
      @yamls.empty? and @gem_names.empty?
    end

    TYPES = {
      "-u"          => :uninstall,
      "--uninstall" => :uninstall,
      "-n"          => :update,
      "--update"    => :update,
      "-c"          => :clean,
      "--clean"     => :clean,
    }

    def parse(argv)
      confpath = GEMIRC

      if %w(-r --rc).include?(argv.first)
        confpath = argv[1]
        if not File.exist?(confpath)
          raise ConfNotFound, "config file not found in #{confpath}"
          exit
        end
        argv.shift
        argv.shift
      end

      case 
      when TYPES.key?(argv.first)
        type = TYPES[argv.first]
        args = argv[1..-1]

      when argv.first == "--"
        type = nil
        args = argv[1..-1]

      else # gem names only
        type = :install
        args = argv
      end

      case type 
      when nil # verbatim(--)
        yamls = []
        gem_names = args
      else
        yamls, gem_names = args.partition{|s| s =~ REXP_YAML}
        if [:update, :clean].include?(type) and not yamls.empty?
          raise YamlGivenError, "You cannot give yaml files with #{argv.first}"
        end
      end

      return confpath, type, gem_names, yamls
    end
  end
end
