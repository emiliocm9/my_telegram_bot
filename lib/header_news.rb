require 'net/http'
require 'uri'

uri = URI.parse("https://financialmodelingprep.com/api/v3/profile/MSFT?apikey=991a6bc8a2bdcd65a5cbeb076b133b05")
request = Net::HTTP::Get.new(uri)
request["Upgrade-Insecure-Requests"] = "1"

req_options = {
  use_ssl: uri.scheme == "https",
}

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

response.code
response.body