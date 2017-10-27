require 'sinatra'
require './core/loader'
require 'json'
require 'plivo'
require_relative './incoming_sms_handler'
require_relative './incoming_web_handler'

settings.public_folder= 'frontend'

get '/' do
  File.read(File.join('frontend', 'index.html'))
end

options '/*' do
  response.headers['Access-Control-Allow-Origin'] = '*'
  response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
  response.headers["Allow"] = "HEAD,GET,PUT,DELETE,OPTIONS"
  halt 200
end

post '/messages' do
  response.headers['Access-Control-Allow-Origin'] = '*'
  response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
  handler = OneLine::Server::IncomingWebHandler.new()
  result_objects = handler.handle(request)
  return JSON.generate(result_objects) if result_objects && !result_objects.empty?
  halt 500 if !result_objects || result_objects.empty?
end

get '/sms' do
  handler = OneLine::Server::IncomingSmsHandler.new()
  successful = handler.handle(request)
  halt 200 if successful
  half 403 unless successful
end

load_regex = ARGV[0] === 'test' ? /test\.rb/ : /plugin\.rb/
OneLine::Loader.load(load_regex)
