  # Model stores Categories data
class Category < ActiveRecord::Base
  attr_accessible :description, :name

  # search engine available fields
  acts_as_indexed :fields => [:name]

  # Association definition. M:N relation with Book model, through bookscategories model
  has_many :books_categories
  has_many :books, :through => :books_categories
  accepts_nested_attributes_for :books
end
