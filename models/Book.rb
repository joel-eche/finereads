<<<<<<< HEAD:models/Book.rb
require "lazyrecord"
require_relative "../constants/constants"


class Book < LazyRecord
  attr_accessor :id, :cover, :title, :author, :status, :date

  def initialize(id, cover, title, author, status, date, note="")
    @id = id
    @cover = cover
    @title = title
    @author = author
    @status = status
    @date = date
    @note = note
  end
  
end