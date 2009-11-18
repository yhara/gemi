Feature: Basic commands
  Background:
    Given I have the config file with:
      """
      rubys:
        - name: MRI 1.8
          command: 'gem'
      """

  Scenario Outline: Simple cases
    When I run gemi with '<args>'
    Then it should execute '<gem_command>'

    Examples:
      | args                | gem_command           | 
      | foo bar             | gem install foo bar   | 
      | -u foo bar          | gem uninstall foo bar | 
      | --uninstall foo bar | gem uninstall foo bar | 
      | -n foo bar          | gem update foo bar    | 
      | --update foo bar    | gem update foo bar    | 
      | -c foo bar          | gem clean foo bar     | 
      | --clean foo bar     | gem clean foo bar     | 

  Scenario Outline: With options for gem command
    When I run gemi with '<args>'
    Then it should execute '<gem_command>'

    Examples:
      | args                  | gem_command                      | 
      | foo bar -n ~/bin      | gem install foo bar -n ~/bin     | 
      | -u foo --user-install | gem uninstall foo --user-install | 

  Scenario Outline: With verbatim args
    When I run gemi with '<args>'
    Then it should execute '<gem_command>'

    Examples:
      | args             | gem_command | 
      | -- stale         | gem stale   | 
      | -- list -l       | gem list -l | 
