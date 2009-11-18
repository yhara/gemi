Feature: Multiple Rubys
  Background:
    Given I have the config file with:
      """
      rubys:
        - name: MRI 1.8
          command: 'gem'
        - name: MRI 1.9
          command: 'gem-1.9'
      """

  Scenario Outline:
    When I run gemi with '<args>'
    Then it should execute the commands '<gem_commands>'

    Examples:
      | args   | gem_commands                              | 
      | a b    | gem install a b , gem-1.9 install a b     | 
      | -u a b | gem uninstall a b , gem-1.9 uninstall a b | 
      | -n a b | gem update a b , gem-1.9 update a b       | 
      | -c a b | gem clean a b , gem-1.9 clean a b         | 
