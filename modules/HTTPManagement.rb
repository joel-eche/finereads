require "http"
require "json"

module HTTPManagement

  def get(path)
    url = "#{API_URL_BASE}#{path}"
    response = HTTP.headers(:accept => HEADER_JSON).get(url)
    response.parse
  end
end