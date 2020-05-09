require_relative "../models/Book"

module BookManagement
  def exists_book_in_my_list?(book_id)
    not Book.find(book_id).nil?
  end
end