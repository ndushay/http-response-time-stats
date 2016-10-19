require 'faraday'
require 'json'

class HttpAndParse

  attr_reader :url

  def initialize(url)
    @url = url
  end

  def response
    @response ||= Faraday.get(url)
    abort("bad response code #{@response.status}") unless @response.success?
    @response
  end

  def parse_json
    JSON.parse(response.body)
  rescue JSON::ParserError
    abort("unable to parse JSON")
  end

end
