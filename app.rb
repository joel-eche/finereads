require "sinatra"
require "sinatra/reloader" if development?
require_relative "models/Libro"

get "/" do
  erb :index
end

get "/search"
  "search"
end

get "/search/:query?"

end

get "/books"

end

post "/books"

end

get "/books/:id" do
  
  erb :_book_detail_page, locals: h
end

put "/books/:id/edit"

end

delete "/books/:id/delete"

end