# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'json'
require_relative 'models/Book'
require_relative 'modules/HTTPManagement'
require_relative 'modules/BookManagement'
require_relative 'constants/constants'

helpers HTTPManagement, BookManagement

get '/' do
  erb :index, layout: false
end

get '/search' do
  books = []
  message = ""

  unless params.empty?
    data = get_api("volumes?q=#{params['query'].gsub(' ', '+')}&maxResults=8")

    if data['items'].nil?
      message ="No results found"
    else
      books = data['items']
    end
  end

  erb :search, locals: {books: books, message: message}
end

get '/books' do
  erb :reading_list
end

post '/books' do
  data = JSON.parse(params['book-data'])
  if Book.find(data['id']).nil?
    book = Book.new(data['id'], data['cover'], data['title'], data['author'], data['status'], Time.now)
    book.save
  end
  redirect url('/books')
end

get '/books/:id' do
  book = get_api("volumes/#{params['id']}")
  erb :book, locals: { book: book }
end

post '/books/:id/edit' do
  book = Book.find(params['id'])
  p params
  book.status = params['status']
  book.note = params['note']
  book.save
  redirect url('/books')
end

get '/books/:id/edit' do
  book = Book.find(params['id'])
  erb :book_edit, locals: { book: book }
end

post '/books/:id/delete' do
  Book.delete(params['id'])
  redirect url('/books')
end
