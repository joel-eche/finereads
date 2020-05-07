require "sinatra"
require "sinatra/reloader" if development?
require_relative "models/Libro"
require_relative "modules/HTTPManagement"

helpers HTTPManagement

get "/" do
  erb :index
end

get "/search" do
  "search"
end

get "/search/:query?" do

end

get "/books" do

end

post "/books" do

end

get "/books/:id" do

end

put "/books/:id/edit" do

end

delete "/books/:id/delete" do

end