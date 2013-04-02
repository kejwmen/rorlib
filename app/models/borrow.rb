class Borrow < ActiveRecord::Base
  attr_accessible :book_id, :date_return, :user_id
  has_one :book
  has_one :user 
end
