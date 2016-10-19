require 'faraday'

class HttpAndParse

  attr_reader :url

  def initialize(url)
    @url = url
  end

  def response
    @response ||= begin
      Faraday.get(url)
    rescue Faraday::Error::ConnectionFailed
      NullResponse.new
    end
  end

  def parse_json
    return unless response.success?
    JSON.parse(response.body)
  rescue JSON::ParserError
  end

end
