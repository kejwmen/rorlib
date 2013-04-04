# Authors model, stores Authors data
class Author < ActiveRecord::Base
  attr_accessible :description, :name

  # search engine available fields
  acts_as_indexed :fields => [:name]

  # Association definition. M:N relation with books model, through authorsbooks model
  has_many :authors_books
  has_many :books, :through => :authors_books
  accepts_nested_attributes_for :books
end
