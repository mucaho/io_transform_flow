# frozen_string_literal: true

require "steep"

target :lib do
  signature "sig"

  check "lib"
  check "spec"
  check "example"
  check "Gemfile"
  check "Rakefile"
  check "Steepfile"

  library "optparse"

  configure_code_diagnostics(Steep::Diagnostic::Ruby.strict)
end
