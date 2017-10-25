require 'find'

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

load_regex = ARGV[0] === 'test' ? /test\.rb/ : /plugin\.rb/
Find.find('./') do |path|
  if path =~ load_regex
    if path != File.expand_path(File.dirname(__FILE__))
      require "#{path}"
    end
  end
end

require_relative './application' if ARGV[0] != 'test'
