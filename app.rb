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
  message = ''
  param_query = ''
  param_search_filter = ''
  param_order_by = 'relevance'
  total_items = 0
  max_results = params['maxResults']
  has_more_button = false

  unless params.empty?
    param_query = params['query']
    param_search_filter = params['search-filter']
    param_order_by = params['order-by']

    query = "#{params['search-filter']}#{params['query'].gsub(' ', '+')}"
    data = get_api("volumes?q=#{query}&maxResults=8&orderBy=#{params["order-by"]}")
    
    total_items = data['totalItems']

    if data['items'].nil?
      message = 'No results found'
    else
      books = data['items']
      
      if max_results == "40"
        books.push(*get_api("volumes?q=#{query}&maxResults=#{max_results}&startIndex=9&orderBy=#{params["order-by"]}")['items'])
      end

      has_more_button = total_items > 8 && books.length == 8
    end
  end

  erb :search, locals: { books: books, message: message, param_query: param_query, param_search_filter: param_search_filter, param_order_by: param_order_by, has_more_button: has_more_button }
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
