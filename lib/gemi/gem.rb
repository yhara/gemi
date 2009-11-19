module Gemi
  class Gem

    class OptionNotSupported < Gemi::Error; end

    # Returns an array of Gem
    def self.from_yaml(yaml)
      return [] unless yaml["gems"]

      yaml["gems"].map{|spec|
        options = {
          :install => spec["install_options"],
          :uninstall => spec["uninstall_options"],
        }
        %w(update_options clean_options).each do |key|
          if spec[key]
            raise OptionNotSupported, "you cannot specify #{key} in YAML file"
          end
        end
        new(spec["name"], spec["version"], options)
      }
    end

    def initialize(name, version=nil, options={})
      @name, @version, @options = name, version, options
    end

    attr_reader :name, :version, :options

    def to_command(type)
      s = @name
      s << " -v #{@version}" if @version
      s << " #{@options[type]}" if @options[type]
      s
    end

  end
end
