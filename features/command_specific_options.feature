Feature: Command specific options
  Background:
    Given I have the config file with:
      """
      rubys:
        - name: MRI 1.8
          command: 'gem'
          install_options: --foo
          uninstall_options: --bar
          update_options: --baz
          clean_options: --quux
      """
      # Note: these options are just example.
      # The real gem command does not have such options!

  Scenario Outline:
    When I run gemi with '<args>'
    Then it should execute '<gem_command>'

    Examples:
      | args   | gem_command             | 
      | a b    | gem install a b --foo   | 
      | -u a b | gem uninstall a b --bar | 
      | -n a b | gem update a b --baz    | 
      | -c a b | gem clean a b --quux    | 
