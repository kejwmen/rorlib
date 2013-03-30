class Category < ActiveRecord::Base
  attr_accessible :description, :name, :book_ids

  has_many :books, :through => :bookscategories
end
