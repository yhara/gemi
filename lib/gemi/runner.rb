module Gemi
  class Runner

    class ConfNotFound < Gemi::Error; end

    def initialize(argv)
      @argv = argv.dup
    end

    def run
      begin
        main
      rescue => e
        $stderr.puts "Error: #{e.message}"
      end
    end

    def main
      @opt = Options.parse(@argv)

      if @opt.empty?
        usage
        return
      end

      conf = load_conf
      execute_commands(conf)
    end

    def load_conf
      if !File.exist?(@opt.confpath)
        if @opt.confpath == GEMIRC and @opt.yamls.empty?
          create_conf
          return
        else
          raise ConfNotFound, "config file not found in #{@opt.confpath}"
          return
        end
      end
      Conf.new(@opt.confpath)
    end

    def execute_commands(conf)
      conf.rubys.each do |ruby|
        puts "------- installing for #{ruby[:name]} ..."
        cmd = Command.new(@opt.type, @opt.gem_names, @opt.yamls).build(ruby)
        execute(cmd)
      end
    end

    def execute(cmd)
      puts cmd
      system cmd
    end

    private

    def usage
      $stderr.puts [
        "Usage: gemi -unc GEM1 GEM2 YAML1.yml",
        "Options:",
        "  -u, --uninstall : gem uninstall",
        "  -n, --update    : gem update",
        "  -c, --clean     : gem clean",
        "  --              : pass the arguments to gem commands",
        "  -r PATH         : specify the path of gemirc",
      ].join("\n")
    end

    def create_conf
      $stderr.puts "Error: config file not found in #{GEMIRC}"
      $stderr.print "May I create a new one? [Y/n]"
      ans = gets.chomp
      $stderr.puts

      if ["Y", "YES", ""].include?(ans.upcase)
        Conf.create
        $stderr.puts "Done. Please edit #{GEMIRC} for your environment."
      end
    end

  end
end
