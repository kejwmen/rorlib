class CreateBooksCategoriesTable < ActiveRecord::Migration
  def self.up
    create_table 'books_categories', :id => false do |t|
        t.integer :book_id
        t.integer :category_id
    end
    add_index :books_categories, [:book_id, :category_id]
  end

  def self.down
   drop_table :categories_items
  end
end
