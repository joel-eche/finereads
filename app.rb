require "sinatra"
require "sinatra/reloader" if development?
require "json"
require_relative "models/Book"
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
  data = JSON.parse(params["book-data"])
  book = Book.new(data["id"], data["cover"], data["title"], data["author"], data["status"], Time.now)
  book.save
  redirect url("/books")
end

get "/books/:id" do
  book = get_api("volumes/#{params["id"]}")
  erb :book, locals:{book: book}
end

put "/books/:id/edit" do

end

delete "/books/:id/delete" do

end