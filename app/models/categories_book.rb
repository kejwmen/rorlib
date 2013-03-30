class CategoriesBook < ActiveRecord::Base
  attr_accessible :category_id, :book_id

  belongs_to :category
  belongs_to :book
end
