Feature: Use the io_transform_flow CLI

  I want to parse webserver logs,
  and I want to use the provided io_transform_flow CLI for it.

  Scenario: Get a help message to orient myself
    Given an executable named "bin/io_transform_flow" with:
    """
    #!/usr/bin/env ruby
    require_relative "../../../exe/io_transform_flow.rb"
    """
    And I look for executables in "bin" within the current directory
    When I successfully run `io_transform_flow --help`
    Then the output should contain:
    """
    Usage: io_transform_flow
    """

  Scenario: Get the current version
    Given an executable named "bin/io_transform_flow" with:
    """
    #!/usr/bin/env ruby
    require_relative "../../../exe/io_transform_flow.rb"
    """
    And I look for executables in "bin" within the current directory
    When I successfully run `io_transform_flow --version`
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
    And an executable named "bin/io_transform_flow" with:
    """
    #!/usr/bin/env ruby
    require_relative "../../../exe/io_transform_flow.rb"
    """
    And I look for executables in "bin" within the current directory
    When I successfully run `io_transform_flow webserver.log`
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
    And an executable named "bin/io_transform_flow" with:
    """
    #!/usr/bin/env ruby
    require_relative "../../../exe/io_transform_flow.rb"
    """
    And I look for executables in "bin" within the current directory
    When I successfully run `io_transform_flow webserver2.log webserver1.log webserver3.log`
    Then the output should contain exactly:
    """
    /about 4
    /home 2
    /index 1
    /help 1
    """

  Scenario: Sort URLs from STDIN by how often they were acessed
    Given an executable named "bin/io_transform_flow" with:
    """
    #!/usr/bin/env ruby
    require_relative "../../../exe/io_transform_flow.rb"
    """
    And I look for executables in "bin" within the current directory
    When I run `io_transform_flow` interactively
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
    And an executable named "bin/io_transform_flow" with:
    """
    #!/usr/bin/env ruby
    require_relative "../../../exe/io_transform_flow.rb"
    """
    And I look for executables in "bin" within the current directory
    When I run `io_transform_flow` interactively
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
    And an executable named "bin/io_transform_flow" with:
    """
    #!/usr/bin/env ruby
    require_relative "../../../exe/io_transform_flow.rb"
    """
    And I look for executables in "bin" within the current directory
    When I successfully run `io_transform_flow webserver.log -o sorted.log`
    Then the file "sorted.log" should contain exactly:
    """
    /about 2
    /home 1
    """
