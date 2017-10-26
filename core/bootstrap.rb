
# Place everything on the load path.
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

# Determine whether to run tests or to load the app.
require 'loader'
load_regex = ARGV[0] === 'test' ? /test\.rb/ : /plugin\.rb/
OneLine::Loader.load(load_regex)

# Start the app if not running tests.
require_relative './application' unless ARGV[0]
require './server/server' if ARGV[0] === 'server'
