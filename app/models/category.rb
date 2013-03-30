class Category < ActiveRecord::Base
  attr_accessible :description, :name, :book_ids

  has_many :books_categories
  has_many :books, :through => :books_categories
  accepts_nested_attributes_for :books
end
