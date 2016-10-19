require 'report_times'
require 'active_support/core_ext/object/to_query.rb'

# benchmark requests.pl response times
class RequestsPlTimes < ReportTimes
  attr_reader :ckey, :library, :count

  def initialize(ckey, library, count)
    @ckey = ckey
    @library = library
    @count = count
  end

  def benchmark
    p "requests.pl called for ckey: #{ckey}"
    super
  end

  private

  def query_str
    @query_str ||= {id: ckey, lib: library}.to_query
  end

  def base_url
    @@base_url ||= 'http://bodoni.stanford.edu/cgi-bin/requests.pl'
  end
end
