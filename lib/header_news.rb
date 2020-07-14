require 'news-api'
require 'uri'

uri = URI.parse("https://financialmodelingprep.com/api/v3/profile/AAPL?apikey=991a6bc8a2bdcd65a5cbeb076b133b05")
request = Net::HTTP::Get.new(uri)
request["Upgrade-Insecure-Requests"] = "1"

req_options = {
  use_ssl: uri.scheme == "https",
}

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

# response.code
# response.body

class NewsApi

  # attr_reader :top_headlines

  def initialize
    newsapi = News.new('bb3ba6f0ed7f48689708122da76ecdcc')
  end

  def top_headlines
    newsapi.get_top_headlines(q: 'bitcoin',
    sources: 'bbc-news,the-verge',
    category: 'business',
    language: 'en',
    country: 'us')
  end
  
end