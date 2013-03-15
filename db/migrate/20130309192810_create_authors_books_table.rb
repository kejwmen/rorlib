class CreateAuthorsBooksTable < ActiveRecord::Migration
  def self.up
    create_table 'authors_books', :id => false do |t|
        t.integer :author_id
        t.integer :book_id
    end
    add_index :authors_books, [:author_id, :book_id]
  end

  def self.down
   drop_table :authors_books
  end
end
