require "sinatra"
require "sinatra/reloader" if development?
require_relative "models/Libro"
require_relative "modules/HTTPManagement"
require_relative "constants/constants"

helpers HTTPManagement

get "/" do
  erb :index, :layout => false
end

get "/search" do
  @books = []

  unless params.empty?
    data = get_api("volumes?q=#{params["query"].gsub(" ", "+")}&maxResults=8")
    @books = data["items"]
  end
  
  erb :search
end

get "/books" do

end

post "/books" do

end

get "/books/:id" do
  book = get_api("volumes/#{params["id"]}")
  erb :book, locals:{book: book}
end

put "/books/:id/edit" do

end

delete "/books/:id/delete" do

end