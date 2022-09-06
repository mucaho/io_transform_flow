# frozen_string_literal: true

require "rake"

require "bundler/gem_tasks"

require "cucumber/rake/task"
require "rspec/core/rake_task"
require "rubocop/rake_task"

namespace "test" do # rubocop:disable Metrics/BlockLength
  RuboCop::RakeTask.new(:rubocop)

  RSpec::Core::RakeTask.new(:spec)

  desc "Debug app unit tests"
  task :debug_spec do
    sh "rdbg -c -- bundle exec rake test:spec"
  end

  Cucumber::Rake::Task.new(:features)

  desc "Debug app acceptance tests"
  task :debug_features do
    sh "rdbg -c -- bundle exec rake test:features"
  end

  desc "Run solargraph typechecker"
  task :typecheck_yard do
    sh "bundle exec solargraph typecheck --level=typed"
  end

  desc "Run steep typechecker"
  task :typecheck_rbs do
    sh "bundle exec steep validate"
    sh "bundle exec steep check --severity-level=hint"
  end

  desc "Validate YARD documentation"
  task :doc_check do
    sh "bundle exec yard-junk --sanity"
    sh "bundle exec yard-junk"
  end

  desc "Run linter, typecheck, spec, features and doc checks"
  task default: %i[rubocop typecheck_yard typecheck_rbs spec features doc_check]
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

    desc "Serve YARD documentation"
    task :doc_server do
      sh "bundle exec yard server"
    end

    desc "Generated RBS signature from source files"
    task :rbs_gen do
      sh "bundle exec sord --no-regenerate lib/io_transform_flow.rbs"
    end

    desc "Move SORD's generated signature file to sig/ folder (OVERWRITES EXISTING SIG FILE!)"
    task :rbs_mv do
      sh "ruby " \
         "-e 'require \"fileutils\"' " \
         "-e 'FileUtils.move \"./lib/io_transform_flow.rbs\", \"./sig/io_transform_flow.rbs\", force: true'"
    end

    task all: %w[dev:build:doc dev:build:rbs_gen dev:build:rbs_mv]
  end
end

namespace "example" do
  namespace "custom" do
    desc "Run the customized API example"
    task :run do
      ruby "example/custom_api.rb"
    end

    desc "Debug the customized API example"
    task :debug do
      sh "rdbg example/custom_api.rb"
    end
  end

  namespace "default" do
    desc "Run the default API example"
    task :run do
      ruby "example/default_api.rb"
    end

    desc "Debug the default API example"
    task :debug do
      sh "rdbg example/default_api.rb"
    end
  end
end

desc "Run default tasks (test)"
task default: %w[test:default]
