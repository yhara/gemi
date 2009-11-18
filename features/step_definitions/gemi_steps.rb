require 'kagemusha'

Given /^I have the config file with:$/ do |string|
  File.open(GemiWorld::GEMIRC_TMP, "wb"){|f|
    f.write string
  }
end

Given /^a yaml file named "([^\"]*)" with:$/ do |filename, content|
  File.open(File.join(GemiWorld::TMP_DIR, filename), "wb"){|f|
    f.write content
  }
end

When /^I run gemi with (.*)$/ do |args_str|
  argv = args_str.split.map{|arg|
    if arg =~ /.ya?ml\z/
      File.join(GemiWorld::TMP_DIR, arg)
    else
      arg
    end
  }

  cmds = []
  Kagemusha.new(Gemi::Runner).def(:execute){|cmd|
    cmds << cmd
  }.swap {
    begin
      Gemi::Runner.new(argv).main
    rescue Gemi::Error
      cmds << "*ERROR*"
    end
  }
  @cmds = cmds
end

Then /^it should execute the commands (.*)$/ do |cmds|
  @cmds.should == cmds.split(/\s*,\s*/)
end

Then /^it should execute the (?!commands )(.*)$/ do |cmd|
  @cmds.first.rstrip.should == cmd
end


