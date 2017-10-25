require 'find'

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

if ARGV[0] === 'test'
  require './test'
else
  Find.find('./') do |path|
    if path =~ /plugin\.rb/
      if path != File.expand_path(File.dirname(__FILE__))
        require "#{path}"
      end
    end
  end

  require_relative './application'
end
