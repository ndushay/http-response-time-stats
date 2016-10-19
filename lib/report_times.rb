require 'benchmark'
include Benchmark  # need the CAPTION and FORMAT constants

require 'http_and_parse'

# benchmark http response times
class ReportTimes

  attr_reader :url, :count

  def initialize(url, count)
    @url = url
    @count = count
  end

  def benchmark
    p "will benchmark: #{url}"
    Benchmark.benchmark(CAPTION, 7, FORMAT, ">avg resp:") do |x|
      total_resp = Benchmark::Tms.new
      count.times.each { |i|
        hp = HttpAndParse.new(url)
        resp_t = x.report("response #{i}:") { hp.response }
        total_resp += resp_t
      }
      p '-----------------'
      [total_resp/count]
    end
    nil
  end

  def benchmark_w_json
    p "will benchmark: #{url}"
    Benchmark.benchmark(CAPTION, 7, FORMAT, ">avg resp:", ">avg parse:") do |x|
      total_resp = Benchmark::Tms.new
      total_parse = Benchmark::Tms.new
      count.times.each { |i|
        hp = HttpAndParse.new(url)
        resp_t = x.report("response #{i}:") { hp.response }
        parse_t = x.report("parse #{i}:") { hp.parse_json }
        total_resp += resp_t
        total_parse += parse_t
      }
      p '-----------------'
      [total_resp/count, total_parse/count]
    end
    nil
  end

  private

  def url
    @url ||= "#{base_url}?#{query_str}"
  end

end
