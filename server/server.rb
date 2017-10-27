require 'sinatra'
require './core/loader'
require 'json'
before do
  if request.request_method != 'OPTIONS' && request.request_method != 'GET'
    @request_payload = request.body.read.to_s
    @request_payload = JSON.parse(@request_payload)
  end
end

get '/' do
  'Hello world!'
end

options '/*' do
  response.headers["Allow"] = "HEAD,GET,PUT,DELETE,OPTIONS"
  response['Access-Control-Allow-Origin'] = '*'
  response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"

  halt 200
end

post '/messages' do
  response["Access-Control-Allow-Headers"] = "origin, x-requested-with, content-type"
  response['Access-Control-Allow-Origin'] = '*'

  responses = []
  OneLine::Store.plugins.each { |key, plugin|
    begin
      plugin_response = plugin.call(@request_payload['message'], {owner_id: @request_payload['owner_id']})
      responses << plugin_response if plugin_response
    rescue Exception => e
      puts e
    end
  }

  result_objects = []
  responses.each{|plugin_response|
    result_objects.push(*plugin_response.messages.map{|message|
      {message: message}
    })
  }
  return JSON.generate(result_objects)
end

post '/sms' do
  OneLine::Store.plugins.each { |key, plugin|
    begin
      plugin_response = plugin.call(@request_payload['message'], {owner_id: @request_payload['owner_id']})
      responses << plugin_response if plugin_response
    rescue Exception => e
      puts e
    end
  }
  result_objects = []
  plivo = Plivo::RestAPI.new(ENV['PLIVO_AUTH_ID'], ENV['PLIVO_AUTH_TOKEN'])
  responses.each{|plugin_response|
    result_objects.push(*plugin_response.messages.map{|message|
      {message: message}
    })
  }

  result_objects.each{|obj|
    puts request
    plivo.send_message({
      src: ENV['PLIVO_SOURCE_NUMBER'],
      dst: @request_payload['from'],
      text: obj[:message]
    })
  }
end

load_regex = ARGV[0] === 'test' ? /test\.rb/ : /plugin\.rb/
OneLine::Loader.load(load_regex)
