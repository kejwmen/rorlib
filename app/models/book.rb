  # Books model. Stores books data.
class Book < ActiveRecord::Base
  attr_accessible :description, :isbn, :title, :year
  # search engine available fields
  acts_as_indexed :fields => [:title]

  # Association definition. M:N relation with author model, through authorsbooks model
  has_many :authors_books
  has_many :authors, :through => :authors_books

  # Association definition. M:N relation with categories model, through bookscategories model
  has_many :books_categories
  has_many :categories, :through => :books_categories

  accepts_nested_attributes_for :authors
  accepts_nested_attributes_for :categories

  # Data validation. Each entity must contain at least title, isbn and year
  validates_presence_of :title, :isbn, :year
    
end
