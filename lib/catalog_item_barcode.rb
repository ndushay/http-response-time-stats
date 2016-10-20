require 'report_times'
require 'active_support/core_ext/object/to_query.rb'

# benchmark symphony web services catalog/item/barcode response times
class CatalogItemBarcode < ReportTimes
  attr_reader :barcode, :count

  def initialize(barcode, count)
    @barcode = barcode
    @count = count
  end

  def benchmark
    p "symws catalog/item/barcode called for: #{barcode}"
    super
  end

  private

  def query_str
    @@query_str ||= {includeFields: 'currentLocation'}.to_query
  end

  def base_url
    @base_url ||= "https://libwebprod1.stanford.edu/symws/v1/catalog/item/barcode/#{barcode}"
  end
end
