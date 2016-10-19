require 'report_times'
require 'active_support/core_ext/object/to_query.rb'

# benchmark vufind.pl response times
class VufindTimes < ReportTimes
  attr_reader :ckey, :count

  def initialize(ckey, count)
    @ckey = ckey
    @count = count
  end

  def benchmark
    p "vufind.pl called for ckey: #{ckey}"
    super
  end

  private

  def query_str
    @query_str ||= static_params.merge(id: ckey).to_query
  end

  def base_url
    @@base_url ||= 'http://bodoni.stanford.edu/cgi-bin/vufind.pl'
  end

  def static_params
    @@static_params ||= {
      search: 'holdings'
    }
  end
end
