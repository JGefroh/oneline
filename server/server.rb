require 'sinatra'
require './core/loader'

get '/' do
  'Hello world!'
end


get '/s' do
  responses = []
  OneLine::Store.plugins.each { |key, plugin|
    begin
      responses << plugin.call(params[:text])
    rescue Exception => e
      puts e
    end
  }

  result_text = []
  responses.each{|response| result_text = result_text.join(response.messages)}
  return result_text
end
load_regex = ARGV[0] === 'test' ? /test\.rb/ : /plugin\.rb/
OneLine::Loader.load(load_regex)
