module Gemi
  class Command

    def initialize(type, gem_names, yamls)
      @type = type

      @gems = [
        gem_names.map{|s| Gem.new(s)},
        yamls.map{|path| Gem.from_yaml(YAML.load_file(path))}
      ].flatten
    end

    def build(ruby)
      if @gems.any?(&:version)
        cmds = @gems.map{|g| build_command(g.to_command, ruby)}
        cmds.join(" ; ")
      else
        gem_names = @gems.map(&:name).join(" ")
        build_command(gem_names, ruby)
      end
    end

    private

    def build_command(gem_opts, ruby)
      return [
        # gem, gem-1.8, gem-1.9, etc.
        ruby.gem_command,
        # install, update, etc.
        @type.to_s,
        # gem names and a version, if any
        gem_opts,
        # user options specific to installing, uninstalling, etc.
        (ruby.options[@type] || ""),
      ].reject(&:empty?).join(" ")
    end

  end
end
