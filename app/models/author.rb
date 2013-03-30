class Author < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :authors_books
  has_many :books, :through => :authors_books
end
