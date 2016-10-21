require 'report_times'
require 'active_support/core_ext/object/to_query.rb'

# benchmark symphony web services lookupTitleInfo response times
class SymwsTimes < ReportTimes
  attr_reader :ckey, :barcode, :library, :count

  def initialize(id, library, count)
    id = id.to_s if id.is_a?Fixnum
    if id.match(barcode_pattern)
      @barcode = id
    else
      @ckey = id
    end
    @library = library
    @count = count
  end

  def benchmark
    p "symws lookupTitleInfo called for ckey/barcode: #{ckey}#{barcode}, library #{library}"
    super
  end

  def benchmark_no_library
    p "symws lookupTitleInfo called for ckey/barcode: #{ckey}#{barcode}"
    my_query_str = query_str.sub!("libraryFilter=#{library}", '')
    my_url = "#{base_url}?#{my_query_str}"
    rt = ReportTimes.new(my_url, count)
    rt.benchmark
  end

  def benchmark_w_json
    p "symws lookupTitleInfo called for ckey/barcode: #{ckey}#{barcode}, library #{library}"
    super
  end

  private

  def url
    @url ||= "#{base_url}?#{query_str}"
  end

  def query_str
    moar = {
      libraryFilter: library
    }
    if barcode
      moar.merge!(itemID: barcode)
    elsif ckey
      moar.merge!(titleID: ckey)
    end
    static_params.merge(moar).to_query
  end

  def base_url
    @@base_url ||= 'https://libwebprod1.stanford.edu/symws/rest/standard/lookupTitleInfo'
  end

  def static_params
    @@static_params ||= {
      clientID: 'DS_CLIENT',
      includeItemInfo: true,
      json: true
    }
  end

  def barcode_pattern
    /^36105\d{9}/
  end
end
