# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'json'
require_relative 'models/Book'
require_relative 'modules/HTTPManagement'
require_relative 'constants/constants'

helpers HTTPManagement

get '/' do
  erb :index, layout: false
end

get '/search' do
  @books = []

  unless params.empty?
    data = get_api("volumes?q=#{params['query'].gsub(' ', '+')}&maxResults=8")
    @books = data['items']
  end

  erb :search
end

get '/books' do
  erb :reading_list
end

post '/books' do
  data = JSON.parse(params['book-data'])
  book = Book.new(data['id'], data['cover'], data['title'], data['author'], data['status'], Time.now)
  book.save
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
  erb :book_note, locals: { book: book }
end

post '/books/:id/delete' do
  Book.delete(params['id'])
  redirect url('/books')
end
