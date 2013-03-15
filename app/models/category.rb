class Category < ActiveRecord::Base
  attr_accessible :description, :name, :book_ids

  has_and_belongs_to_many :books
end
