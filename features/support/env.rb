$LOAD_PATH.unshift File.expand_path("../../lib", File.dirname(__FILE__))
require 'gemi'

class GemiWorld
  # Path to make Temporary files
  TMP_DIR = File.expand_path("../tmp/", File.dirname(__FILE__))

  # Path of config file to use temporarily
  GEMIRC_TMP = File.join(TMP_DIR, "gemirc")

  def self.init
    # Replace the content of the constant (hack!)
    Gemi::GEMIRC.replace GEMIRC_TMP
  end
end

Before do
  GemiWorld.init
end

World do
  GemiWorld.new
end

After do
end
