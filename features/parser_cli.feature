Feature: Use the parser CLI

  I want to parse webserver logs,
  and I want to use the provided parser CLI for it.

  Scenario: Get a help message to orient myself
    Given an executable named "bin/parser" with:
    """
    #!/usr/bin/env ruby
    require_relative "../../../exe/parser.rb"
    """
    And I look for executables in "bin" within the current directory
    When I successfully run `parser --help`
    Then the output should contain:
    """
    Usage: parser
    """

  Scenario: Get the current version
    Given an executable named "bin/parser" with:
    """
    #!/usr/bin/env ruby
    require_relative "../../../exe/parser.rb"
    """
    And I look for executables in "bin" within the current directory
    When I successfully run `parser --version`
    Then the output should contain exactly:
    """
    0.1.0
    """

  Scenario: Sort URLs from a log file by how often they were acessed
    Given a file named "webserver.log" with:
    """
    /home
    /about
    /home
    /about
    /help
    /index
    /help
    /about
    """
    And an executable named "bin/parser" with:
    """
    #!/usr/bin/env ruby
    require_relative "../../../exe/parser.rb"
    """
    And I look for executables in "bin" within the current directory
    When I successfully run `parser webserver.log`
    Then the output should contain exactly:
    """
    /about 3
    /home 2
    /help 2
    /index 1
    """

  Scenario: Sort URLs from multiple log files by how often they were acessed
    Given a file named "webserver1.log" with:
    """
    /home
    /about
    /home
    /about
    /about
    """
    And a file named "webserver2.log" with:
    """
    /help
    /about
    """
    And a file named "webserver3.log" with:
    """
    /index
    """
    And an executable named "bin/parser" with:
    """
    #!/usr/bin/env ruby
    require_relative "../../../exe/parser.rb"
    """
    And I look for executables in "bin" within the current directory
    When I successfully run `parser webserver2.log webserver1.log webserver3.log`
    Then the output should contain exactly:
    """
    /about 4
    /home 2
    /index 1
    /help 1
    """

  Scenario: Sort URLs from STDIN by how often they were acessed
    Given an executable named "bin/parser" with:
    """
    #!/usr/bin/env ruby
    require_relative "../../../exe/parser.rb"
    """
    And I look for executables in "bin" within the current directory
    When I run `parser` interactively
    And I type "/home"
    And I type "/about"
    And I type "/about"
    And I close the stdin stream
    Then the output should contain exactly:
    """
    /about 2
    /home 1
    """

  Scenario: Sort piped-in URLs by how often they were acessed
    Given a file named "webserver.log" with:
    """
    /home
    /about
    /about
    """
    And an executable named "bin/parser" with:
    """
    #!/usr/bin/env ruby
    require_relative "../../../exe/parser.rb"
    """
    And I look for executables in "bin" within the current directory
    When I run `parser` interactively
    And I pipe in the file "webserver.log"
    Then the output should contain exactly:
    """
    /about 2
    /home 1
    """

  Scenario: Sort URLs by how often they were acessed and write them to an output file
    Given a file named "webserver.log" with:
    """
    /home
    /about
    /about
    """
    And an executable named "bin/parser" with:
    """
    #!/usr/bin/env ruby
    require_relative "../../../exe/parser.rb"
    """
    And I look for executables in "bin" within the current directory
    When I successfully run `parser webserver.log -o sorted.log`
    Then the file "sorted.log" should contain exactly:
    """
    /about 2
    /home 1
    """
