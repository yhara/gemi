Feature: Basic commands
  Background:
    Given I have the config file with:
      """
      rubys:
        - name: MRI 1.8
          command: 'gem'
      """

  Scenario Outline: Simple cases
    When I run gemi with <args>
    Then it should execute the <gem_command>

    Examples:
      | args                | gem_command           | 
      | foo bar             | gem install foo bar   | 
      | -u foo bar          | gem uninstall foo bar | 
      | --uninstall foo bar | gem uninstall foo bar | 
      | -n foo bar          | gem update foo bar    | 
      | --update foo bar    | gem update foo bar    | 
      | -c foo bar          | gem clean foo bar     | 
      | --clean foo bar     | gem clean foo bar     | 

  Scenario Outline: With a yaml
    Given a yaml file named "names.yml" with:
      """
      gems:
        - name: foo
        - name: bar
      """
    And a yaml file named "names_and_versions.yml" with:
      """
      gems:
        - name: foo
          version: 0.1
        - name: bar
          version: 0.2
      """
    When I run gemi with <args>
    Then it should execute the <gem_command>

    Examples:
      | args                      | gem_command                                       |
      | names.yml                 | gem install foo bar |
      | names_and_versions.yml    | gem install foo -v 0.1 ; gem install bar -v 0.2   | 
      | -u names.yml              | gem uninstall foo bar                             | 
      | -u names_and_versions.yml | gem uninstall foo -v 0.1 ; gem uninstall bar -v 0.2 | 
      | -n names.yml              | *ERROR*                                           | 
      | -c names.yml              | *ERROR*                                           | 

  Scenario Outline: With options for gem command
    When I run gemi with <args>
    Then it should execute the <gem_command>

    Examples:
      | args                  | gem_command                      | 
      | foo bar -n ~/bin      | gem install foo bar -n ~/bin     | 
      | -u foo --user-install | gem uninstall foo --user-install | 

  Scenario Outline: With verbatim args
    When I run gemi with <args>
    Then it should execute the <gem_command>

    Examples:
      | args             | gem_command | 
      | -- stale         | gem stale   | 
      | -- list -l       | gem list -l | 
