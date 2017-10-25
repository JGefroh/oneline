require 'net/http'
require 'json'
class Requestor
  attr_accessor :protocol
  attr_accessor :domain
  attr_accessor :content_type
  attr_accessor :default_headers

  def initialize(domain, https = true, default_headers)
    @domain = domain || ''
    @protocol = https ? :https : :http
    @default_headers = default_headers
  end

  def query(url = '', params = {}, headers = {})
    uri = URI("#{@protocol}://#{@domain}#{url}")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if @protocol === :https
    req = Net::HTTP::Get.new(uri.request_uri)

    req["Accept"] = "application/json"

    @default_headers.each{ |key, value| req[key] = value}
    headers.each{ |key, value| req[key] = value }

    res = http.request(req)

    return res.body if res.is_a?(Net::HTTPSuccess)
  end

  def query_as_json(url = '', params = {}, headers = {})
    result_text = query(url, params, headers)
    return JSON.parse(result_text)
  end
end
