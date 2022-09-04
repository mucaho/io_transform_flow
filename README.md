<!--
# @markup markdown
# @title IOTransformFlow - Simple transform flows between source and destination IO in Ruby
# @author mucaho
-->

# IOTransformFlow

Simple transform flows between source and destination IO in Ruby.

Exposes an [executable binary](exe/io_transform_flow.rb) and an [API surface](lib/io_transform_flow.rb).
Default implementation takes logs of URL paths and sorts them by their access count.
Can be extended to express custom transformations from source to output files.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'io_transform_flow'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install io_transform_flow

## Usage

### CLI

```sh
$ exe/io_transform_flow.rb -h
Usage: io_transform_flow.rb [options] [file0, [file1, ...]]

If no input file(s) are given, input will be read from STDIN.

Common options:
    -o, --output file                Specify output file. If omitted, prints to STDOUT.
    -h, --help                       Show this message
    -v, --version                    Show version
```

### [API using custom transformation](example/custom_api.rb)

```ruby
require "io_transform_flow/domain"
require "stringio"

source = StringIO.new("Hello\nWorld!\n")
destination = StringIO.new

IOTransformFlow::Domain::Process.process!(source, destination, ->(lines) { lines.map(&:chomp).map(&:reverse) })
puts destination.string
# prints:
# olleH
# !dlroW
```

### [API using default transformation](example/default_api.rb)

```ruby
require "io_transform_flow/domain"
require "io_transform_flow/impl"
require "stringio"

source = StringIO.new("/about\n/home\n/home\n")
destination = StringIO.new

IOTransformFlow::Domain::Process.process!(source, destination, IOTransformFlow::Impl::CountURIsPipe)
puts destination.string
# prints:
# /home 2
# /about 1
```

## Tests

This project is automatically checked by GitHub's continuous integration server.
Example logs can be found in commit statuses.
The CI process executes, in order:

1. [Rubocop](https://github.com/rubocop/rubocop) lints
2. [Solargraph](https://solargraph.org/) typechecking
3. [RSpec](https://rspec.info/) [unit tests](spec/io_transform_flow/impl/count_uris_pipe_spec.rb)
4. [Cucumber](https://cucumber.io/) / [Aruba](https://github.com/cucumber/aruba) [CLI acceptance tests](features/io_transform_flow_cli.feature)
5. [Yard-junk](https://github.com/zverok/yard-junk) documentation lints

## Signatures

This gem ships with a [`RBS` type signature](sig/io_transform_flow.rbs) located in the `sig/` folder.

## Development

After checking out the repo, run `bin/setup` to install dependencies.

Then run `rake -T` to list all available tasks and their descriptions.
For example, run `rake` (the default task) to run the tests.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## IDE support

Users of [VSCode](https://code.visualstudio.com/) will have appropriate extensions auto-suggested when they open this project in their editor, which offer additional code completion suggestions and pallete commands.
[Nix](https://nixos.org/) users can run `$ nix-shell` from this project's root directory to set up a reproducible development environment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mucaho/io_transform_flow. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://bundler.io/conduct.html).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the IOTransformFlow project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://bundler.io/conduct.html).
