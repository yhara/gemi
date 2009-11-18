Feature: With gems.yaml

  Scenario Outline: Yaml containing names only
    Given a yaml file named "names.yml" with:
      """
      gems:
        - name: foo
        - name: bar
      """
    When I run gemi with '<args>'
    Then it should execute '<gem_command>'

    Examples:
      | args         | gem_command           | 
      | names.yml    | gem install foo bar   | 
      | -u names.yml | gem uninstall foo bar | 
      | -n names.yml | *ERROR*               | 
      | -c names.yml | *ERROR*               | 

  Scenario Outline: Yaml containing names and versions
    Given a yaml file named "names_and_versions.yml" with:
      """
      gems:
        - name: foo
          version: 0.1
        - name: bar
          version: 0.2
      """
    When I run gemi with '<args>'
    Then it should execute '<gem_command>'

    Examples:
      | args                      | gem_command                                         |
      | names_and_versions.yml    | gem install foo -v 0.1 ; gem install bar -v 0.2     | 
      | -u names_and_versions.yml | gem uninstall foo -v 0.1 ; gem uninstall bar -v 0.2 | 
