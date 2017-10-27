
# Place everything on the load path.
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

# Determine whether to run tests or to load the app.
require 'loader'
load_regex = ARGV[0] === 'test' ? /test\.rb/ : /plugin\.rb/
OneLine::Loader.load(load_regex)

# Start the app if not running tests.
unless ARGV[0]
  require './console/console_application'
  o = OneLine::ConsoleApplication.new
end

if ARGV[0] === 'server'
  require './server/server'
end
