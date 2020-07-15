require 'telegram/bot'
require 'net/http'
require 'json'
require 'uri'

class FinStatus
  attr_reader :uri_fin, :b_fin
  attr_accessor :symbol_fin

  def initialize
    @b_fin = b_fin
    @uri_fin = uri_fin
    @symbol_fin = symbol_fin
  end

  def get_finance(symbol_fin)
    urilink = "https://financialmodelingprep.com/api/v3/financials/income-statement/#{symbol_fin}?apikey=991a6bc8a2bdcd65a5cbeb076b133b05"
    uri_fin = URI.parse(urilink)
    request = Net::HTTP::Get.new(uri_fin)
    request['Upgrade-Insecure-Requests'] = '1'

    req_options = {
      use_ssl: uri_fin.scheme == 'https'
    }

    response = Net::HTTP.start(uri_fin.hostname, uri_fin.port, req_options) do |http|
      http.request(request)
    end
    x = (response.body).index('{')
    y = (response.body).index('}')
    a = response.body[x..y].tr('{}', '')
    a
  end
end
