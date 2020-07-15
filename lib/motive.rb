require 'telegram/bot'
require 'net/http'
require 'json'
require 'uri'

class KeyStats
  attr_reader :uri, :b
  attr_accessor :symbol

  def initialize
    @b = b
    @uri = uri
    @symbol = symbol
  end

  def get_information(symbol)
    urilink = "https://financialmodelingprep.com/api/v3/profile/#{symbol}?apikey=991a6bc8a2bdcd65a5cbeb076b133b05"
    uri = URI.parse(urilink)
    request = Net::HTTP::Get.new(uri)
    request['Upgrade-Insecure-Requests'] = '1'

    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    ab = (response.body).tr('{}[]', '')
    if ab == " "
      return 'Error: please type the STOCK symbol again.'
    else
      return ab
    end
  end
end
