require "sinatra"
require "sinatra/reloader" if development?
require_relative "models/Libro"
require_relative "modules/HTTPManagement"
require_relative "constants/constants"

helpers HTTPManagement

get "/" do
  erb :index
end

get "/search" do
  @books = []

  unless params.empty?
    data = get("volumes?q=#{params["query"]}&maxResults=8")
    @books = data["items"]
  end
  
  erb :search
end

get "/books" do

end

post "/books" do

end

before "/books/:id" do
  puts params
  lolo = "lololo"
end

get "/books/:id" do
  puts lolo
end

put "/books/:id/edit" do

end

delete "/books/:id/delete" do

end