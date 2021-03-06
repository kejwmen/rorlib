# M:N relation buffer model
class AuthorsBook < ActiveRecord::Base
  attr_accessible :author_id, :book_id

  belongs_to :book
  belongs_to :author
end
