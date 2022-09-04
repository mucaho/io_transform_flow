# frozen_string_literal: true

require "rake"

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "cucumber/rake/task"

namespace "test" do
  RSpec::Core::RakeTask.new(:spec)

  Cucumber::Rake::Task.new(:features)

  require "rubocop/rake_task"

  RuboCop::RakeTask.new

  desc "Run solargraph typechecking"
  task :typecheck do
    sh "bundle exec solargraph typecheck --level=typed"
  end

  desc "Parse YARD documentation"
  task :doc_parse do
    sh "bundle exec yard-junk --sanity"
  end

  desc "Validate YARD documentation"
  task :doc_check do
    sh "bundle exec yard-junk"
  end

  desc "Run linter, typecheck, spec, features and doc checks"
  task default: %i[rubocop typecheck spec features doc_parse doc_check]
end

namespace "dev" do # rubocop:disable Metrics/BlockLength
  namespace "install" do
    desc "Install RBS files for gems used in development"
    task :gems do
      sh "bundle install"
    end

    desc "Install RBS files for gems used in development"
    task :rbs do
      sh "bundle exec rbs collection clean"
      sh "bundle exec rbs collection install"
    end

    desc "Install YARD docs for gems used in development"
    task :yard do
      sh "bundle exec yard gems --rebuild"
    end

    desc "Install all development dependencies"
    task all: %w[dev:install:gems dev:install:rbs dev:install:yard]
  end

  namespace "build" do
    desc "Generate YARD documentation"
    task :doc do
      sh "ruby " \
         "-e 'require \"fileutils\"' " \
         "-e 'FileUtils.remove_dir \"./doc/\", force: true'"
      sh "bundle exec yard doc"
    end

    desc "Generated RBS signature from source file"
    task :rbs_gen do
      sh "bundle exec sord --no-regenerate lib/io_transform_flow.rbs"
    end

    desc "Move SORD's generated signature file to sig/ folder (OVERWRITES EXISTING SIG FILE!)"
    task :rbs_mv do
      sh "ruby " \
         "-e 'require \"fileutils\"' " \
         "-e 'FileUtils.move \"./lib/io_transform_flow.rbs\", \"./sig/io_transform_flow.rbs\", force: true'"
    end

    # TODO: doc server

    task all: %w[dev:build:doc_parse dev:build:doc_check dev:build:doc dev:build:rbs_gen dev:build:rbs_mv]
  end
end

desc "Run default tasks (test)"
task default: %w[test:default]

# TODO: add generated docs to CI process, as they are needed for typechecks

# TODO: add "run" task
