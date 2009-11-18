module Gemi
  Ruby = Struct.new(:name, :gem_command, :gem_home, :options)

  Ruby::Default = Ruby.new("Ruby", "gem", nil, {})
end
