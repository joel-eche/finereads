require "http"
require "json"

module HTTPManagement
  def get(url)
    data = HTTP.get("#{API_URL_BASE}#{url}")
    JSON.parse(data)
  end
  
end

def("volumes/?q=algo")