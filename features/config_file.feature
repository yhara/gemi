Feature: Config file

  Scenario: Load from default path
    # Note: this is tested in basic_commands.feature

  Scenario: Create config if none
    
  Scenario Outline: Specifying alternative config file path
    Given a yaml file named "myconf.yml" with:
      """
      rubys:
        - name: myruby
          command: mygem
          install_options: --myoption
      """
    When I run gemi with '<args>'
    Then it should execute '<gem_command>'

    Examples:
      | args                  | gem_command                      | 
      | -r myconf.yml foo bar | mygem install foo bar --myoption | 

  Scenario: Use default settings if yaml is given
    # Note: this is tested in gems_yaml.feature

