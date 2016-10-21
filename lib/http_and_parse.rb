require 'faraday'
require 'json'

class HttpAndParse

  attr_reader :url

  def initialize(url)
    @url = url
  end

  def response
    @response ||= Faraday.get do |req|
      req.url url
      # need the below for symws catalog/item/barcode
      req.headers['x-sirs-clientID'] = 'DS_CLIENT'
      req.headers['sd-originating-app-id'] = 'response-time-stats'
      req.headers['SD-Preferred-Role'] = 'GUEST'
    end
    abort("bad response code #{@response.status}") unless @response.success?
    @response
  end

  def parse_json
    JSON.parse(response.body)
  rescue JSON::ParserError
    abort("unable to parse JSON")
  end

end
