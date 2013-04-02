  # Borrows handling model
class Borrow < ActiveRecord::Base
  attr_accessible :book_id, :date_return, :user_id

  # 1:1 associations with book and user model
  has_one :book
  has_one :user 
end
