require 'find'

# Place everything on the load path.
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

# Determine whether to run tests or to load the app.
load_regex = ARGV[0] === 'test' ? /test\.rb/ : /plugin\.rb/

# Dynamically load all plugins.
Find.find('./') do |path|
  if path =~ load_regex
    if path != File.expand_path(File.dirname(__FILE__))
      require "#{path}"
    end
  end
end

# Start the app if not running tests.
require_relative './application' if ARGV[0] != 'test'
