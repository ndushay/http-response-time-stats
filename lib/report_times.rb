require 'benchmark'
include Benchmark  # need the CAPTION and FORMAT constants

require 'http_and_parse'

class ReportTimes

  attr_reader :url, :count

  def initialize(url, count)
    @url = url
    @count = count
  end

  def benchmark
    Benchmark.benchmark(CAPTION, 7, FORMAT, ">avg resp (real):", ">avg parse (real):") do |x|
      total_resp = Benchmark::Tms.new
      total_parse = Benchmark::Tms.new
      count.times.each { |i|
        hp = HttpAndParse.new(url)
        resp_t = x.report("resp #{i}:") { hp.response }
        parse_t = x.report("parse #{i}:") { hp.parse_json }
        total_resp += resp_t
        total_parse += parse_t
      }
      [total_resp/count, total_parse/count]
    end
  end

end
