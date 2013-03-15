class Book < ActiveRecord::Base
  attr_accessible :description, :isbn, :title, :year, :author_ids, :category_ids
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :authors
  accepts_nested_attributes_for :categories
  validates_presence_of :title, :isbn, :year
end
