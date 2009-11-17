module Gemi
  class Gem
    # Returns an array of Gem
    def self.from_yaml(yaml)
      return [] unless yaml["gems"]

      yaml["gems"].map{|spec|
        new(spec["name"], spec["version"], spec["native"])
      }
    end

    def initialize(name, version=nil, native=false)
      @name, @version, @native = name, version, native
    end

    attr_reader :name, :version

    def native?
      @native
    end

    def to_command
      if @version
        "#{@name} -v #{@version}"
      else
        "#{@name}"
      end
    end

  end
end
