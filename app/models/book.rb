class Book < ActiveRecord::Base
  attr_accessible :description, :isbn, :title, :year

  has_many :authors_books
  has_many :authors, :through => :authors_books

  has_many :books_categories
  has_many :categories, :through => :books_categories

  accepts_nested_attributes_for :authors
  accepts_nested_attributes_for :categories

  validates_presence_of :title, :isbn, :year
  
  
def self.search(search)
  condition = "%" + search + "%"
  find(:all, :include => [:authors, :categories], :conditions => {:title => condition, :desription => condition, :authors => {:name => condition, :descriptiom => condition}, :categories => {:name => condition, :description => condition}})
  
  end

  
end
