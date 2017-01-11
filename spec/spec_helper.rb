# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "todo_lint"
require "timecop"

require 'simplecov'
SimpleCov.start

Dir["spec/support/**/*.rb"].each { |f| load f }

# Disable colorful output in specs
# This makes it easier to test and compare strings
Rainbow.enabled = false

RSpec.configure do |config|
  config.raise_errors_for_deprecations!
  config.disable_monkey_patching!
  config.order = :random
end
