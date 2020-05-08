require "http"
require "json"

module HTTPManagement

  # GET general
  def get(path)
    response = HTTP.headers(:accept => HEADER_JSON).get(path)
    response.parse
  end

  # customized for api
  def get_api(path)
    path = "#{API_URL_BASE}#{path}"
    get(path)
  end
end