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
    urilink = "https://financialmodelingprep.com/api/v3/profile/#{symbol}?apikey=dcc02d221c83b6cce393d3b83d87059f"
    uri = URI.parse(urilink)
    request = Net::HTTP::Get.new(uri)
    request['Upgrade-Insecure-Requests'] = '1'

    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    ab = response.body.tr('{}[]', '')
    if ab == ' '
      'Error: please type the STOCK symbol again.'
    else
      ab
    end
  end
end
