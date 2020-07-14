require 'telegram/bot'
require 'net/http'
require 'json'
require 'uri'

class CovidApi
  attr_reader :uri
  def initialize
    @uri = URI.parse("https://financialmodelingprep.com/api/v3/profile/TSLA?apikey=991a6bc8a2bdcd65a5cbeb076b133b05")
  end

  def get_information
    request = Net::HTTP::Get.new(uri)
    request["Upgrade-Insecure-Requests"] = "1"

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
    end
    
    response.body
    a = response.body.tr('\{[]}', '').split('\n').map {|item| item.chomp.tr('\\"', '')}.map {|item| item.split(/\n/).each {|i| i.delete!(' ').gsub!(':', ' : ')}}.flatten
    b = a.each {|i| puts i.capitalize}
  end
end

#AAPL = CovidApi.new
#AAPL.get_information.class